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

print_header() {
  echo "                            ____           __   _  ___                                       "
  echo "  ____ ____ ____ ____      / __/___  ___  / /_ (_)/ _/____ ___  ___       ____ ____ ____ ____"
  echo " /___//___//___//___/     _\ \ / _ \/ _ \/ __// // _// __// -_)/ -_)     /___//___//___//___/"
  echo "/___//___//___//___/     /___// .__/\___/\__//_//_/ /_/   \__/ \__/     /___//___//___//___/ "
  echo "                             /_/                                                             "
  echo "---------------------------------------------------------------------------------------------"
  echo "                                 Your free CLI Music Streamer                                "
  echo "---------------------------------------------------------------------------------------------"
  echo
}

print_mpv_controls() {
  echo "==========[ PLAYBACK CONTROLS ]=========="
  echo "      Space      : Play/Pause"
  echo "      ←/→        : Seek -/+ 5 seconds"
  echo "      ↓/↑        : Seek -/+ 1 minute"
  echo "      9/0        : Volume down/up"
  echo "      m          : Mute toggle"
  echo "      q          : Quit player"
  echo "========================================="
  echo
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
  print_header	
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

main_loop
