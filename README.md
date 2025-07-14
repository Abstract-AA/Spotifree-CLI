<h1 align="center">Spotifree CLI</h1>
<p align="center">
  <strong>A lightweight minimalist CLI music streaming platform</strong>
</p>

<div align="center">
  <img src="https://img.shields.io/badge/Platform-Linux%20%7C%20macOS%20%7C%20WSL-blue" alt="Platform">
  <img src="https://img.shields.io/badge/Dependencies-yt--dlp%20%7C%20mpv-green" alt="Dependencies">
  <img src="https://img.shields.io/badge/License-MIT-yellow" alt="License">
</div>

## Overview

Spotifree is a bash script that transforms your terminal into a music streaming platform without ads or distractions. Designed for keyboard-centric users who want instant music without leaving their workflow. It can perform a non specific search for songs, so the song name can have typos and parts of the lyrics are also accepted as inputs. 

For a smooth streaming experience, the latest verion of yt-dlp is usually required.


![Alt Text](https://github.com/Abstract-AA/Spotifree-CLI/blob/b0c6636d3e041a518101accd23f9a723707766be/Screenshot%20from%202025-07-14%2015-45-48.png)

![Alt Text](https://github.com/Abstract-AA/Spotifree-CLI/blob/4acb60f0af78cc83d5f2544608c19da82a9702e4/Screenshot%20from%202025-07-11%2019-18-22.png)



## Features

- **Instant Search** - Play any song with a single command
- **Download Audio files** - Any song can be downloaded
- **Playlists** - Create playlists by writing multiple song names separated by commas
- **Local Audio File Support** - A full featured file browser is included, and any local audio files can be played
- **Repeat Mode** - Replay tracks without re-searching (cached playback)
- **Playback Controls** - Full MPV controls (pause/seek/volume/loop)
- **Lightweight** - Less than 1 mb, no GUI overhead or resource-heavy apps
- **Simple Setup** - Just bash + 2 dependencies

## 📦 Installation

First, to install the dependencies run the following in a system with Bash:

```bash
sudo apt install yt-dlp mpv                 # Debian/Ubuntu
sudo dnf install yt-dlp mpv                 # Fedora and its derivatives
sudo apk update && sudo apk add mpv yt-dlp  # Alpine Linux
sudo pacman -S mpv && sudo pacman -S yt-dlp #Arch linux and its derivatives
brew install yt-dlp mpv                     # macOS
```
Then, move on to downloading the main file.

```bash
wget https://raw.githubusercontent.com/Abstract-AA/Spotifree-CLI/refs/heads/main/spotifree
     
chmod +x spotifree

./spotifree

```

Note: Some distributions have older versions of yt-dlp, and this can cause issues when running the app. Therefore, in this case its ideal to download the latest version of yt-dlp in a python enviroment, and then run the script:

```bash
# ====== INSTALL LATEST yt-dlp ON ARCH / FEDORA / DEBIAN/UBUNTU ======

# === 0. PREREQUISITES ===
# Make sure Python and pip are installed

sudo pacman -S python python-pip # Arch

sudo apt install python3 python3-pip # Debian/Ubuntu

sudo dnf install python3 python3-pip # Fedora

# === 1st METHOD: pipx (Recommended) ===

sudo pacman -S pipx # Arch

sudo apt install pipx # Debian/Ubuntu

sudo dnf install pipx # Fedora

pipx install yt-dlp  # Install yt-dlp via pipx

pipx upgrade yt-dlp # (To upgrade later)

# ====== 2nd METHOD: virtualenv (Manual isolation) ======

pip install --user virtualenv # Install virtualenv if needed

python3 -m venv yt-dlp-env
source yt-dlp-env/bin/activate  # Create and activate virtual environment

pip install yt-dlp # Install yt-dlp inside the venv

deactivate # Deactivate environment when done

```

## Future plans

- Add a progress bar that updates as the song plays

- Add audio bars

- Add general interface improvements for the local audio file browser 

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
