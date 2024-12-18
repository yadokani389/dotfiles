{ writeShellScriptBin, symlinkJoin, makeWrapper, ps, gnugrep, playerctl, sptlrx }:
let
  show-lyrics = writeShellScriptBin "show-lyrics" ''
    # https://github.com/LanderMoerkerke/dotfiles/blob/976b9184d74592151baa702389fa01c2b885428c/.config/waybar/custom/spotify/show-lyrics.sh

    # Simple script that determines what my polybar music module prints
    # If spotify is playing it prints each lyric, if not then it prints
    # last sources title

    STATUS=$(playerctl status)

    if [ "$STATUS" != "Playing" ]; then
        exit
    fi

    # Check if pipe is running
    if [ -z "$(ps aux | grep -v 'grep' | grep 'sptlrx pipe')" ]; then
        sptlrx pipe >>/tmp/lyrics &
    fi

    echo "$(tail -1 /tmp/lyrics)"
  '';
in symlinkJoin {
  name = "show-lyrics";
  paths = [ show-lyrics ps gnugrep playerctl sptlrx ];
  buildInputs = [ makeWrapper ];
  postBuild = "wrapProgram $out/bin/show-lyrics --prefix PATH : $out/bin";
}
