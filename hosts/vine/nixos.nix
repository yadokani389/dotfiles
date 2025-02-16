{ hostname, username, ... }:
{
  imports = [ ../nixos.nix ];

  console.keyMap = "jp106";

  wsl = {
    enable = true;
    defaultUser = username;
    startMenuLaunchers = true;
    useWindowsDriver = true;
    wslConf = {
      network.hostname = hostname;
      automount.mountFsTab = true;
    };
  };
}
