# 🎵 Spottube_cli

A sleek, interactive command-line tool for searching, queuing, and playing music from YouTube right from your terminal.  
**Spottube_cli** is designed for music enthusiasts who love the power and aesthetics of the command line.

---

## ✨ Features

- 🎶 **Search YouTube by song or genre**  
  Enter your favorite song, artist, or genre and instantly search YouTube.

- 🧭 **fzf-powered Interactive Menu**  
  Browse results and select your song using a fuzzy finder with preview.

- ⏯️ **Queue System**  
  Add multiple tracks to your play queue and enjoy seamless playlist playback.

- 🗑️ **Queue Management**  
  View and remove songs from your current queue.

- 🎧 **MPV Audio Playback**  
  Enjoy high-quality audio playback with the powerful `mpv` player (video disabled).

---

## 🚀 Getting Started

### **Requirements**

- [yt-dlp](https://github.com/yt-dlp/yt-dlp)  
- [fzf](https://github.com/junegunn/fzf)  
- [mpv](https://mpv.io/)  
- Bash-compatible shell (Linux, macOS, or Termux on Android recommended)

> **Tip:** Install requirements via your package manager (e.g., `apt`, `brew`, `pkg`, etc.)

### **Installation**

```bash
git clone https://github.com/Sagarkadyan/Spottube_cli.git
cd Spottube_cli
chmod +x yt-audio-queue-advanced.sh
```

### **Usage**

```bash
./yt-audio-queue-advanced.sh
```

---

## 🖥️ Demo

![CLI Demo](https://user-images.githubusercontent.com/your-demo-gif.gif)

---

## 🛠️ Example Menu

```
=== 🎶 YT Audio Queue Menu ===
1) Add song to queue
2) Show queue
3) Remove song from queue
4) Play queue
5) Exit
Choose an option [1-5]:
```

---

## 📦 File Structure

```
Spottube_cli/
├── yt-audio-queue-advanced.sh    # Main script (queue system)
├── yt-autoplay-loop.sh           # Simple autoplay version
└── README.md                     # This file
```

---

## 🤝 Contributing

Pull requests and suggestions are welcome!  
For major changes, please open an issue first to discuss what you would like to change.

---

## 📄 License

[MIT](LICENSE)

---

## ❤️ Credits

- [yt-dlp](https://github.com/yt-dlp/yt-dlp) for downloading and extracting audio
- [fzf](https://github.com/junegunn/fzf) for interactive selection
- [mpv](https://mpv.io/) for playback

---

> Made with 💙 by [Sagarkadyan](https://github.com/Sagarkadyan)
