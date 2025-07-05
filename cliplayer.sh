#!/bin/bash

set -e

# Dependencies check
for cmd in yt-dlp mpv; do
  command -v $cmd >/dev/null 2>&1 || { echo "$cmd is required but not installed. Aborting."; exit 1; }
done

TARGET_DIR="$HOME/Music"
TMP_DIR="/tmp/ytmp3"
mkdir -p "$TMP_DIR" "$TARGET_DIR"

loop_play_mode() {
  while true; do
    echo -n "\nEnter song name (or 'q' to quit): "
    read query
    [[ "$query" == "q" ]] && break

    echo "Searching and streaming: $query"
    stream_url=$(yt-dlp -f bestaudio -g "ytsearch1:$query")

    if [ -z "$stream_url" ]; then
      echo "No results found."
      continue
    fi

    mpv --no-video "$stream_url"
  done
}

main_menu() {
  echo "\n== YouTube MP3 CLI Player =="
  loop_play_mode
}

main_menu
