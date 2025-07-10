<h1 align="center">Spotifree CLI Music Streamer</h1>
<p align="center">
  <strong>A minimalist YouTube music player for terminal enthusiasts</strong>
</p>

<div align="center">
  <img src="https://img.shields.io/badge/Platform-Linux%20%7C%20macOS%20%7C%20WSL-blue" alt="Platform">
  <img src="https://img.shields.io/badge/Dependencies-yt--dlp%20%7C%20mpv-green" alt="Dependencies">
  <img src="https://img.shields.io/badge/License-MIT-yellow" alt="License">
</div>

## Overview

Spotifree is a lightweight bash script that transforms your terminal into a YouTube music player without ads or distractions. Designed for keyboard-centric users who want instant music without leaving their workflow. 

For a smooth streaming experience, the latest verion of yt-dlp is usually required.

## Preview

![Alt Text](https://github.com/Abstract-AA/Spotifree/blob/ef3fc0156d670a679d79a18e5b7c5295990a29b5/Screenshot%20from%202025-07-10%2016-55-22.png)


## Features

- **Instant Search** - Play any song with a single command
- **Download Audio files** - Any played song can be downloaded
- **Repeat Mode** - Replay tracks without re-searching (cached playback)
- **Playback Controls** - Full MPV controls (pause/seek/volume)
- **Lightweight** - No GUI overhead or resource-heavy apps
- **Simple Setup** - Just bash + 2 dependencies

## 📦 Installation

```bash
# Install dependencies
sudo apt install yt-dlp mpv  # Debian/Ubuntu
sudo dnf install yt-dlp mpv #Fedora and its derivatives
sudo apk update && sudo apk add mpv yt-dlp # Alpine Linux
brew install yt-dlp mpv      # macOS

# Download Spotifree
wget https://github.com/Abstract-AA/Spotifree/blob/6726e6d70c23b7ddaeb604a770b029bdbd62ad4e/spotifree.sh
chmod +x spotifree.sh
./spotifree.sh
