#!/bin/bash

QUEUE="/tmp/yt_audio_queue.txt"
> "$QUEUE"  # Clear the queue at script start

show_queue() {
    if [[ ! -s "$QUEUE" ]]; then
        echo "🕳️  Queue is empty."
        return
    fi
    echo "🔢 Current queue:"
    nl -w2 -s'. ' "$QUEUE"
}

remove_from_queue() {
    show_queue
    read -p "Enter song number to remove (or press Enter to cancel): " num
    if [[ -n "$num" && "$num" =~ ^[0-9]+$ ]]; then
        sed -i "${num}d" "$QUEUE"
        echo "❌ Removed song $num from queue."
    else
        echo "Cancelled."
    fi
}

add_to_queue() {
    local query url
    read -p "🎵 Enter song or genre (or just Enter to play queue): " query
    if [[ -z "$query" ]]; then
        return 1
    fi
    url=$(yt-dlp "ytsearch10:${query}" --print "%(title)s - %(webpage_url)s" 2>/dev/null \
        | fzf --ansi --preview='echo {}' --prompt="Select a song: " \
        | sed -E 's/.* - (https?:\/\/.*)/\1/')
    if [[ -n "$url" ]]; then
        echo "$url" >> "$QUEUE"
        echo "✅ Added to queue."
    fi
    return 0
}

play_queue() {
    while IFS= read -r url; do
        echo "▶️ Now playing: $url"
        mpv --no-video --autofit=30% --quiet --no-terminal "$url"
        # Remove the played song from the queue
        sed -i '1d' "$QUEUE"
    done < "$QUEUE"
}

while true; do
    echo ""
    echo "=== 🎶 YT Audio Queue Menu ==="
    echo "1) Add song to queue"
    echo "2) Show queue"
    echo "3) Remove song from queue"
    echo "4) Play queue"
    echo "5) Exit"
    read -p "Choose an option [1-5]: " choice

    case "$choice" in
        1) add_to_queue ;;
        2) show_queue ;;
        3) remove_from_queue ;;
        4)
            if [[ -s "$QUEUE" ]]; then
                play_queue
                > "$QUEUE"  # Clear queue after playing
            else
                echo "Queue is empty!"
            fi
            ;;
        5) echo "👋 Exiting."; exit 0 ;;
        *) echo "Invalid choice." ;;
    esac
done
