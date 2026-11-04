{ pkgs, ... }:
{
  home.packages = [ pkgs.handy ];

  # TODO: Set keyboard_implementation to "none" once nixpkgs Handy supports it.
  programs.niri.settings.spawn-at-startup = [
    {
      command = [
        "handy"
        "--start-hidden"
      ];
    }
  ];
}
