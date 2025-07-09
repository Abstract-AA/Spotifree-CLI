#!/bin/bash

set -e

for cmd in yt-dlp mpv; do
  command -v $cmd >/dev/null 2>&1 || { echo "$cmd is required but not installed. Aborting."; exit 1; }
done

TARGET_DIR="$HOME/Music"
TMP_DIR="/tmp/ytmp3"
mkdir -p "$TMP_DIR" "$TARGET_DIR"

# Cache variables
LAST_STREAM_URL=""
LAST_QUERY=""
declare -A SONG_CACHE  # Stores URL and query as key-value pairs
HISTORY=()            # Order of played songs
CACHE_LIMIT=10        # Max number of songs to keep in history

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

add_to_history() {
  local query="$1"
  local url="$2"
  
  # Add to cache if not already present
  if [[ -z "${SONG_CACHE[$query]}" ]]; then
    SONG_CACHE["$query"]="$url"
    HISTORY+=("$query")
    
    # Maintain cache limit
    if [[ ${#HISTORY[@]} -gt $CACHE_LIMIT ]]; then
      local oldest_query="${HISTORY[0]}"
      unset SONG_CACHE["$oldest_query"]
      HISTORY=("${HISTORY[@]:1}") # Remove first element
    fi
  fi
}

show_history() {
  if [[ ${#HISTORY[@]} -eq 0 ]]; then
    echo "No songs in history yet!"
    main_loop
  fi
  
  echo "=====[ Recently Played (Last $CACHE_LIMIT) ]====="
  for i in "${!HISTORY[@]}"; do 
    echo "  $((i+1)). ${HISTORY[$i]}"
  done
  echo "==============================================="
  
  echo -ne "Enter number to replay (or any key to cancel): "
  read -r choice
  if [[ "$choice" =~ ^[0-9]+$ ]] && [[ "$choice" -ge 1 ]] && [[ "$choice" -le ${#HISTORY[@]} ]]; then
    local selected_query="${HISTORY[$((choice-1))]}"
    echo "Replaying: $selected_query"
    LAST_STREAM_URL="${SONG_CACHE[$selected_query]}"
    LAST_QUERY="$selected_query"
    play_stream "${SONG_CACHE[$selected_query]}"
  else
    echo "Cancelled."
  fi
  # Always return to main loop
  return 0
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
  add_to_history "$query" "$stream_url"
  
  play_stream "$stream_url"
  return 0
}

main_loop() {	
  while true; do
    echo -ne "Enter song name (or 'q' to quit, 'r' to repeat, 'h' for history): "
    read -r input
    
    case "$input" in
      q) 
        exit 0
        ;;
      r)
        if [ -z "$LAST_STREAM_URL" ]; then
          echo "No song to repeat! Please search for a song first."
          continue
        fi
        echo "Repeating: $LAST_QUERY"
        play_stream "$LAST_STREAM_URL"
        ;;
      h)
        show_history
        continue  # Ensure we always return to the prompt
        ;;
      *)
        search_and_play "$input"
        ;;
    esac
  done
}

print_header
main_loop
