#!/bin/bash

set -e

# Dependencies check
for cmd in yt-dlp mpv; do
  command -v $cmd >/dev/null 2>&1 || { echo "$cmd is required but not installed. Aborting."; exit 1; }
done

TARGET_DIR="$HOME/Music"
TMP_DIR="/tmp/ytmp3"
mkdir -p "$TMP_DIR" "$TARGET_DIR"

# Variables for caching
LAST_STREAM_URL=""
LAST_QUERY=""

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

play_stream() {
  local stream_url="$1"
  print_mpv_controls
  mpv --no-video "$stream_url"
}

search_and_play() {
  local query="$1"
  echo "Searching and streaming: $query"
  stream_url=$(yt-dlp -f bestaudio -g "ytsearch1:$query")
  
  if [ -z "$stream_url" ]; then
    echo "No results found."
    return 1
  fi
  
  # Cache the URL and query
  LAST_STREAM_URL="$stream_url"
  LAST_QUERY="$query"
  
  play_stream "$stream_url"
  return 0
}

main_loop() {
  while true; do
    echo -ne "Enter song name (or 'q' to quit, 'r' to repeat): "
    read -r input
    
    case "$input" in
      q) break ;;
      r)
        if [ -z "$LAST_STREAM_URL" ]; then
          echo "No song to repeat! Please search for a song first."
          continue
        fi
        echo "Repeating: $LAST_QUERY"
        play_stream "$LAST_STREAM_URL"
        ;;
      *)
        search_and_play "$input"
        ;;
    esac
  done
}

echo -e "== Spotifree - CLI Player =="
main_loop
