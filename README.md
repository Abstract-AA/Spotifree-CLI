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

Spotifree is a bash script that transforms your terminal into a fully featured music streaming platform without ads or distractions. Designed for keyboard-centric users who want instant music without leaving their workflow. It can perform a non specific search for songs, so the song name can have typos and parts of the lyrics are also acceptable as inputs. The project aims to integrate streaming with local audio files. 

For a smooth streaming experience, the latest verion of yt-dlp is usually required.

![Alt Text]()

## Features

- **Instant Search** - Play any song with a single command
- **Download Audio files** - Songs can be downloaded in mp3, ogg, aac, OPUS and FLAC. Variable kbps is supported
- **Playlists** - Fully featured playlist system via .txt files
- **File Browser** - Local audio files can also be played
- **Repeat Mode** - Replay tracks without re-searching (cached playback)
- **Playback Controls** - Completely integrated MPV controls (pause/seek/volume/loop)
- **Lightweight** - Less than 1 mb, no GUI overhead or resource-heavy apps
- **Simple Setup** - Just bash 4.0+ and 2 dependencies

## 📦 Installation

First, to install the dependencies run the following in a system with Bash:

```bash
sudo apt install yt-dlp mpv                 # Debian/Ubuntu
sudo dnf install yt-dlp mpv                 # Fedora and its derivatives
sudo apk add mpv yt-dlp                     # Alpine Linux
sudo pacman -S mpv yt-dlp                   #Arch linux and its derivatives
brew install yt-dlp mpv                     # macOS
```

Then, move on to downloading the main file.

```bash
wget https://raw.githubusercontent.com/Abstract-AA/Spotifree-CLI/refs/heads/main/spotifree    

```

Then, make it executable and run.

```bash
wget https://raw.githubusercontent.com/Abstract-AA/Spotifree-CLI/refs/heads/main/spotifree
     
chmod +x spotifree

./spotifree

```

Or, simply move to the directory where the file is located and run it like any other bash script

```bash

cd "Path/to/your/file" && bash spotifree

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

## Playlist system

Being a lightweight app, in Spotifree playlists can be made persistent via .txt files. There are two types of playlists, local and remote. As the names suggest, local playlists are essentially a text file with the file names written sequentially, e.g.:

```bash

Path/to/your/audiofile1.format
Path/to/your/audiofile2.format
Path/to/your/audiofile3.format
Path/to/your/audiofile4.format
Path/to/your/audiofile5.format
Path/to/your/audiofile6.format

```

And so on. As for the remote files, they are also .txt files, but the only diferenthe is that they require the first line to have the word "REMOTE" written in it. This is necessary for the app to recognize the distinciton between playlist types.
After that, it is sufficient to write the names of the songs sequentially one after the other. Ideally the song names should be written with the name of the artist so that the audio file search is more inequivocal. e.g.:

```bash

REMOTE
authorA-song1
authorB-song2

```

The file manager and the main menu have a build in feature to create these text files, but due to their simplicity, they can also be manually written and conveniently shared between users of the app. 

## Future plans

- simplified isntall script

- progress bar that updates as the song plays

- audio bars

- general interface improvements

## Gallery

![Alt Text]()

![Alt Text]()

![Alt Text](https://github.com/Abstract-AA/Spotifree-CLI/blob/d5339c58c37a88eeba9174d9f15d23c9a6ec8de5/Screenshot%20From%202025-09-06%2001-43-39.png)


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
