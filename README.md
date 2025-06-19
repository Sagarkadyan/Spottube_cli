# 🎶 TermTune — Search & Play YouTube Music from Your Terminal

A simple shell script to search YouTube, select results using `fzf`, and play audio using `mpv` — all from your terminal.

## 📦 Features

- 🔍 Search YouTube for songs or genres
- 🎚️ Fuzzy-select from top 10 results with `fzf`
- 🎧 Stream audio via `mpv` (no video)
- ⚡ Fast, minimal, and purely terminal-based

## 📥 Installation

You can quickly install all required dependencies with the provided script.

1. Clone the repo:
   ```bash
    git clone https://github.com/Sagarkadyan/Spottube_cli
    cd Spottube_cli
2. Run the installer:
   ```bash
   chmod +x install.sh
   ./install.sh
4. Make it executable
   ```bash
   chmod +x song.sh  

🚀 How to Use
▶️ Run the script

If you installed it globally:
   ```
  msplay
```
Or run it locally:
   ```
   ./song.sh
```
🎵 What Happens Next

    You'll see a prompt like this:

🎵 Enter song or genre:

Type what you want to listen to — for example:

    lo-fi hip hop

    A list of YouTube search results will appear via fzf.
    Use your arrow keys to browse the list.

    Press Enter on the one you want — and it will start playing using mpv.

    🎧 Audio only, no video.

