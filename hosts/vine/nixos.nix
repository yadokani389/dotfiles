let
  username = "kani";
  hashedPassword = "$6$xzVNYSD7yHJuO./x$5fCLN3.ENzMJDWkgegYazIgw/NkWYC2jMSiTDqma84wjEhbYRgeDPcHb.nc55WPD3qpACqGakvM4kXHZihgly0";
  hostname = "vine";
in
{
  imports = [
    (import ../nixos.nix username hashedPassword hostname)
  ];

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

  system.stateVersion = "26.05";
}
