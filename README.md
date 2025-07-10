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

![Alt Text](https://github.com/Abstract-AA/Spotifree/blob/d72fbbb61e06764d9fdd18b47efd83b3f838c66e/Screenshot%20from%202025-07-10%2017-43-57.png)

![Alt Text](https://github.com/Abstract-AA/Spotifree/blob/d72fbbb61e06764d9fdd18b47efd83b3f838c66e/Screenshot%20from%202025-07-10%2017-46-49.png)


## Features

- **Instant Search** - Play any song with a single command
- **Download Audio files** - Any played song can be downloaded
- **Playlists** - Create playlists by write multiple song names separated by commas
- **Repeat Mode** - Replay tracks without re-searching (cached playback)
- **Playback Controls** - Full MPV controls (pause/seek/volume/loop)
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
wget 
     
chmod +x spotifree.sh

./spotifree.sh

```

## Future plans

I intend to add the possibility of creating playlists, also a more polished interface for download management is being considered.

## Legal Disclaimer & Ethical Use

This project, Spotifree CLI, is provided for **educational and personal use only**. By using this software, you acknowledge and agree to the following:

1. **Content Access**: This tool uses `yt-dlp` to stream audio content from public sources. It does not host, distribute, or modify any copyrighted content.

2. **Fair Use**: Intended for personal, non-commercial use under principles of fair use (Section 107 of the U.S. Copyright Act). Commercial use is strictly prohibited.

3. **Copyright Compliance**: Users are responsible for ensuring they have the right to access any content they stream or download. Respect all applicable copyright laws in your jurisdiction.

4. **No Warranty**: The developer assumes no liability for misuse of this tool or copyright infringement by end users.

**Important**: YouTube/Spotify's Terms of Service prohibit unauthorized access to their content. This tool is not affiliated with or endorsed by YouTube, Spotify, or any content providers.

Consult legal counsel if uncertain about compliance in your region.

Furthermore, by using this software, the user should understand and agree to:
- Support artists through official platforms
- Use this tool only for content you legally own or have rights to access
- Not redistribute downloaded content
