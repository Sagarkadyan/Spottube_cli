#!/bin/bash

PLAYLIST="/home/sagar/Music/Spottube_cli/yt-playlist.txt"
mkdir -p "/home/sagar/Music/Spottube_cli"

spinner() {
    local pid=$1
    local delay=0.07
    local spinstr='|/-\'
    while kill -0 $pid 2>/dev/null; do
        local temp=${spinstr#?}
        printf " ⏳ Loading... [%c]  " "$spinstr"
        spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\r"
    done
    printf "                        \r"
}

play_playlist() {
    [[ -s "$PLAYLIST" ]] || { echo "❌ Playlist is empty."; return; }
    mapfile -t urls < "$PLAYLIST"
    N=${#urls[@]}
    i=0

    while (( i < N )); do
        clear
        echo "Now playing: $((i+1))/$N"
        echo "${urls[$i]}"
        mpv --no-video --no-terminal "${urls[$i]}" &
        mpv_pid=$!
        echo "Controls: [←] previous  [→] next  [q] quit"
        while kill -0 $mpv_pid 2>/dev/null; do
            read -rsn1 -t 0.1 key
            if [[ $key == $'\x1b' ]]; then
                read -rsn2 -t 0.1 key2
                case "$key2" in
                    '[C')  # Right Arrow
                        kill $mpv_pid 2>/dev/null
                        (( i < N-1 )) && ((i++))
                        break
                        ;;
                    '[D')  # Left Arrow
                        kill $mpv_pid 2>/dev/null
                        (( i > 0 )) && ((i--))
                        break
                        ;;
                esac
            elif [[ $key == "q" || $key == "Q" ]]; then
                kill $mpv_pid 2>/dev/null
                exit 0
            fi
        done
        wait $mpv_pid 2>/dev/null
        (( i++ ))
    done
}

while true; do
    read -p "🎵 Enter song or genre (or type 'playlist' to play all saved songs): " query

    if [[ "$query" == "playlist" ]]; then
        play_playlist
        continue
    fi

    if [[ "$query" == "q" || "$query" == "Q" ]]; then
        exit 0
    fi

    if [[ -z "$query" ]]; then
        echo "❌ No input given. Exiting."
        exit 1
    fi

    tmpfile=$(mktemp)
    (yt-dlp "ytsearch10:${query}" --flat-playlist -q --print "%(title)s - https://youtu.be/%(id)s" > "$tmpfile") &
    ytpid=$!
    spinner $ytpid
    wait $ytpid

    SEARCH_RESULTS=$(cat "$tmpfile")
    rm "$tmpfile"

    if [[ -z "$SEARCH_RESULTS" ]]; then
        echo "❌ No results found."
        continue
    fi

    SELECTED=$(echo "$SEARCH_RESULTS" | fzf --ansi --preview='echo {}')
    if [[ -z "$SELECTED" ]]; then
        echo "❌ No selection made."
        continue
    fi

    URL=$(echo "$SELECTED" | sed -E 's/.* - (https?:\/\/.*)/\1/')
    # Add to playlist immediately if not already present
    grep -qxF "$URL" "$PLAYLIST" || echo "$URL" >> "$PLAYLIST"
    echo "✅ Added to playlist."
    # Play the song immediately
    mpv --no-video "$URL" 2>/dev/null
done
