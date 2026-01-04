{ pkgs, lib, ... }:
let
  bgImageSection = name: ''
    #${name} {
      background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/${name}.png"));
    }
  '';
in
{
  programs.wlogout = {
    enable = true;

    layout = [
      {
        label = "lock";
        action = "hyprlock";
        keybind = "l";
      }
      {
        label = "logout";
        action = "niri msg version >/dev/null 2>&1 && niri msg action quit -s || hyprctl dispatch exit";
        keybind = "e";
      }
      {
        "label" = "reboot";
        "action" = "reboot";
        "keybind" = "r";
      }
      {
        "label" = "shutdown";
        "action" = "poweroff";
        "keybind" = "s";
      }
    ];

    style = ''
      * {
        background: none;
      }

      window {
        background-color: rgba(200, 200, 220, .2);
      }

      button {
        background: rgba(200, 200, 220, .05);
        border-radius: 8px;
        box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .1), 0 0 rgba(0, 0, 0, .5);
        margin: 1rem;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
      }

      button:focus, button:active, button:hover {
        background-color: rgba(200, 200, 220, 0.2);
        outline-style: none;
      }

      ${lib.concatMapStringsSep "\n" bgImageSection [
        "lock"
        "logout"
        "shutdown"
        "reboot"
      ]}
    '';
  };
}
