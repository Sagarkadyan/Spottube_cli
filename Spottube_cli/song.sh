#!/bin/bash

# Ask for search query
read -p "🎵 Enter song or genre: " query

# Exit if input is empty
if [[ -z "$query" ]]; then
    echo "❌ No input given. Exiting."
    exit 1
fi

# Search YouTube, show fzf menu, extract URL, and play with mpv
yt-dlp "ytsearch10:${query}" --print "%(title)s - %(webpage_url)s" 2>/dev/null \
| fzf --ansi --preview='echo {}' \
| sed -E 's/.* - (https?:\/\/.*)/\1/' \
| xargs -r mpv --no-video 2>/dev/null
