{
  buildFHSEnv,
  addons ? [ ],
}:

buildFHSEnv {
  name = "fcitx5";
  targetPkgs = pkgs: [
    (pkgs.fcitx5-with-addons.override { inherit addons; })
    pkgs.fcitx5-hazkey
  ];
  runScript = "fcitx5";
}
