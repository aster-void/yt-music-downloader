#!/bin/sh
mkdir temp
cat link.txt | yt-dlp --paths "./temp" --batch-file - && \
ls $PWD/temp/* | xargs -I {} ffmpeg -i "{}" -acodec libmp3lame -aq 4 "{}.mp3" &&
ls $PWD/temp/* | grep ".mp3" | xargs -I {} mv {} ./out
rm -rf ./temp
echo "Operation complete."
