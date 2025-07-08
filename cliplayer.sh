#!/bin/bash

set -e

# Dependencies check
for cmd in yt-dlp mpv; do
  command -v $cmd >/dev/null 2>&1 || { echo "$cmd is required but not installed. Aborting."; exit 1; }
done

TARGET_DIR="$HOME/Music"
TMP_DIR="/tmp/ytmp3"
mkdir -p "$TMP_DIR" "$TARGET_DIR"

print_mpv_controls() {
  echo -e "======== CONTROLS ========"
  echo "  Space      : Pause/Play"
  echo "  Left/Right : Seek -/+ 5s"
  echo "  Down/Up    : Skip -/+ 1 min"
  echo "  Volume     : 9 lowers 0 increases"
  echo "  m          : Mute"
  echo "  q          : Quit"
  echo "=============================="
}

loop_play_mode() {
  while true; do
    echo -ne "Enter song name (or 'q' to quit): "
    read -r query
    [[ "$query" == "q" ]] && break

    echo "Searching and streaming: $query"
    stream_url=$(yt-dlp -f bestaudio -g "ytsearch1:$query")

    if [ -z "$stream_url" ]; then
      echo "No results found."
      continue
    fi

    print_mpv_controls
    mpv --no-video "$stream_url"
  done
}

main_menu() {
  echo -e "== Spotifree - CLI Player =="
  loop_play_mode
}

main_menu
