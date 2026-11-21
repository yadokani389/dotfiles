local M = {}

local context = ya.sync(function()
	local tab = cx.active
	local cwd = tab.current.cwd
	local spec = cwd.spec
	local services = spec.kind == "sftp" and vf.sftp
	local service = services and services[spec.domain]
	if service then
		return cwd, tab.id.value, { host = service.host, user = service.user, port = service.port }
	end
	return cwd, tab.id.value
end)

local jump = ya.sync(function(_, tab_id, cwd, target)
	if cx.active.id.value == tab_id and cx.active.current.cwd == cwd then
		ya.emit("cd", { target, raw = true })
	end
end)

local function warn(message)
	ya.notify { title = "SFTP zoxide", content = message, level = "warn", timeout = 5 }
end

local function candidate_path(line)
	return line:match("^%s*%d+%.?%d* (/.*)$")
end

local function choose(candidates)
	local permit = ui.hide()
	local child, err = Command("fzf")
		:arg({ "--no-sort", "--nth=2..", "--no-multi", "--sync", "--prompt=SFTP zoxide> ", "--layout=reverse" })
		:env("FZF_DEFAULT_OPTS", "")
		:env("FZF_DEFAULT_OPTS_FILE", "")
		:stdin(Command.PIPED)
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:spawn()
	local output
	if child then
		if child:write_all(candidates) then
			child:flush()
		end
		output, err = child:wait_with_output()
	end
	permit:drop()
	if not output then
		return nil, "Could not run fzf: " .. tostring(err)
	elseif output.status.success then
		return candidate_path((output.stdout:gsub("\n$", "")))
	elseif output.status.code ~= 1 and output.status.code ~= 130 then
		return nil, "fzf failed: " .. output.stderr
	end
end

function M:entry()
	local cwd, tab_id, service = context()
	if cwd.spec.kind ~= "sftp" then
		return ya.emit("plugin", { "zoxide" })
	elseif not service then
		return warn("No SSH endpoint for sftp://" .. cwd.spec.domain)
	end

	local output, err = Command("ssh")
		:arg({ "-a", "-T", "-oBatchMode=yes", "-oStrictHostKeyChecking=yes", "-oConnectTimeout=5" })
		:arg({ "-p", tostring(service.port), "-l", service.user, "--", service.host, "zoxide query --list --score" })
		:output()
	if not output then
		return warn("Could not run SSH: " .. tostring(err))
	elseif not output.status.success then
		return warn("Remote zoxide query failed: " .. output.stderr)
	end

	local candidates, current = {}, tostring(cwd.path)
	for line in output.stdout:gmatch("[^\n]+") do
		local path = candidate_path(line)
		if path and path ~= current then
			candidates[#candidates + 1] = line .. "\n"
		end
	end
	if #candidates == 0 then
		return warn("No other directories in this server's zoxide history")
	end

	local path, pick_err = choose(table.concat(candidates))
	if pick_err then
		return warn(pick_err)
	elseif not path then
		return
	end

	local target = cwd:join(path)
	local cha = fs.cha(target, true)
	if not cha or not cha.is_dir then
		return warn("Directory unavailable on this SFTP connection: " .. path)
	end
	jump(tab_id, cwd, target)
end

return M
