#!/bin/sh
rm -r ./tmp
mkdir -p tmp/out
mkdir tmp/rename
mkdir tmp/in
links=(`cat link.txt`)
total=$(cat link.txt | wc -l)
idx=0
for link in "${links[@]}"; do
  yt-dlp --paths "./tmp/rename" -- "$link" >/dev/null 2>&1
  mv ./tmp/rename/* "./tmp/in/$idx.mp4"
  ffmpeg -i "./tmp/in/$idx.mp4" -acodec libmp3lame -aq 4 "./tmp/out/$idx.mp3"
  echo "file './out/$idx.mp3'" >> ./tmp/concat.txt

  idx=$(calc "$idx+1" | tr -d " \t")
  echo $idx out of $total done
done

ffmpeg -f concat -safe 0 -i ./tmp/concat.txt -c copy ./tmp/out/concat.mp3
if [ -d ./out ]; then mv out out.bak; fi
mv tmp/out out
# rm -rf ./tmp
echo "Operation complete."
