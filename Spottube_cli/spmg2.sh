#!/bin/bash

PLAYLIST="/home/sagar/Music/Spottube_cli/yt-playlist.txt"
mkdir -p "/home/sagar/Music/Spottube_cli"

read -p "🎵 Enter song or genre (or type 'playlist' to play all saved songs): " query

if [[ "$query" == "play" ]]; then
    if [[ -s "$PLAYLIST" ]]; then
        echo "▶️ Playing all saved songs..."
        mpv --no-video --playlist="$PLAYLIST" 2>/dev/null
    else
        echo "❌ Playlist is empty."
    fi
    exit 0
fi

if [[ -z "$query" ]]; then
    echo "❌ No input given. Exiting."
    exit 1
fi

# Spinner function
spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " ⏳ Loading... [%c]  " "$spinstr"
        spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\r"
    done
    printf "                        \r"
}

# Use yt-dlp with --flat-playlist for faster search, with spinner
tmpfile=$(mktemp)
(yt-dlp "ytsearch10:${query}" --flat-playlist --print "%(title)s - %(url)s" 2>/dev/null > "$tmpfile") &
ytpid=$!
spinner $ytpid
wait $ytpid

SEARCH_RESULTS=$(cat "$tmpfile")
rm "$tmpfile"

if [[ -z "$SEARCH_RESULTS" ]]; then
    echo "❌ No results found."
    exit 1
fi

# Use fzf for selection
SELECTED=$(echo "$SEARCH_RESULTS" | fzf --ansi --preview='echo {}')

if [[ -z "$SELECTED" ]]; then
    echo "❌ No selection made."
    exit 1
fi

TITLE=$(echo "$SELECTED" | sed -E 's/(.*) - (.*)/\1/')
URL=$(echo "$SELECTED" | sed -E 's/.* - (https?:\/\/.*)/\1/')

# Append URL to playlist (if not already present)
grep -qxF "$URL" "$PLAYLIST" || echo "$URL" >> "$PLAYLIST"

mpv --no-video "$URL" 2>/dev/null
