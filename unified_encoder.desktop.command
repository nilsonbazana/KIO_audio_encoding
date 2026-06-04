cat << 'INPUT_EOF' > ~/.local/share/kio/servicemenus/audio_tools_encoder.desktop
[Desktop Entry]
Type=Service
MimeType=audio/x-flac;audio/flac;
Actions=lossywavConvert;qaacConvert;
X-KDE-Priority=TopLevel
X-KDE-Submenu=Audio Tools

[Desktop Action lossywavConvert]
Name=Compress to lossyWAV + FLAC
Icon=audio-x-generic
Exec=konsole -e bash -c 'ENCODER_DIR="/mnt/shared/THE MUSIC COLLECTION/_CODECS/lossyWAV"; cd "$ENCODER_DIR" || exit; for f in "$@"; do [ ! -f "$f" ] && continue; base_dir=$(dirname "$f"); clean_name=$(basename "${f%.*}" | tr -d "[:cntrl:]:\\\\*?\\\"<>|"); artist=$(metaflac --show-tag=ALBUMARTIST "$f" | cut -d= -f2); [ -z "$artist" ] && artist=$(metaflac --show-tag=ARTIST "$f" | cut -d= -f2); date=$(metaflac --show-tag=DATE "$f" | cut -d= -f2); album=$(metaflac --show-tag=ALBUM "$f" | cut -d= -f2); [ -z "$artist" ] && artist="Unknown Artist"; [ -z "$date" ] && date="Unknown Date"; [ -z "$album" ] && album="Unknown Album"; target_dir="$base_dir/$artist/$date-$album"; mkdir -p "$target_dir"; out="$target_dir/${clean_name}.lossy.flac"; echo "Encoding: $(basename "$f")"; flac -d -c "$f" | wine lossyWAV.exe - --quality high --silent --stdout | wine flac.exe - -b 512 -5 -f --silent --ignore-chunk-sizes -o "$out"; metaflac --export-tags-to=- "$f" | metaflac --import-tags-from=- "$out"; if [ $? -eq 0 ] && [ -f "$out" ]; then orig_size=$(stat -c%s "$f"); new_size=$(stat -c%s "$out"); savings_pct=$(( (new_size * 100) / orig_size )); if [ "$savings_pct" -lt 55 ]; then COLOR="$(tput bold; tput setaf 4)"; elif [ "$savings_pct" -ge 55 ] && [ "$savings_pct" -le 60 ]; then COLOR="$(tput bold; tput setaf 2)"; elif [ "$savings_pct" -gt 60 ] && [ "$savings_pct" -le 75 ]; then COLOR="$(tput bold; tput setaf 3)"; elif [ "$savings_pct" -gt 75 ] && [ "$savings_pct" -le 100 ]; then COLOR="$(tput bold; tput setaf 208)"; else COLOR="$(tput bold; tput setaf 1)"; fi; RESET=$(tput sgr0); orig_mb_int=$(( orig_size / 1048576 )); orig_mb_dec=$(( ((orig_size * 100) / 1048576) % 100 )); new_mb_int=$(( new_size / 1048576 )); new_mb_dec=$(( ((new_size * 100) / 1048576) % 100 )); echo "${COLOR}======   Shrinkage   ======="; echo "Original: $orig_mb_int.$orig_mb_dec MB"; echo "Lossy: $new_mb_int.$new_mb_dec MB"; echo "Ratio: ${savings_pct}%${RESET}"; echo ""; echo ""; else echo "$(tput bold; tput setaf 1)ERROR: Encoding failed for $(basename "$f")$(tput sgr0)"; echo ""; fi; done; echo "---------------------------------------"; read -p "Processing complete. Press Enter to close..." temp' _ %F

[Desktop Action qaacConvert]
Name=Compress to QAAC + M4A
Icon=audio-x-generic
Exec=konsole -e bash -c 'ENCODER_DIR="/mnt/shared/THE MUSIC COLLECTION/_CODECS/QAAC - all necessary files"; cd "$ENCODER_DIR" || exit; for f in "$@"; do [ ! -f "$f" ] && continue; base_dir=$(dirname "$f"); clean_name=$(basename "${f%.*}" | tr -d "[:cntrl:]:\\\\*?\\\"<>|"); artist=$(metaflac --show-tag=ALBUMARTIST "$f" | cut -d= -f2); [ -z "$artist" ] && artist=$(metaflac --show-tag=ARTIST "$f" | cut -d= -f2); date=$(metaflac --show-tag=DATE "$f" | cut -d= -f2); album=$(metaflac --show-tag=ALBUM "$f" | cut -d= -f2); [ -z "$artist" ] && artist="Unknown Artist"; [ -z "$date" ] && date="Unknown Date"; [ -z "$album" ] && album="Unknown Album"; target_dir="$base_dir/$artist/$date-$album"; mkdir -p "$target_dir"; out="$target_dir/${clean_name}.m4a"; echo "Encoding to M4A: $(basename "$f")"; flac -d -c "$f" | wine qaac64.exe -V 91 --no-delay --ignorelength -o "$out" -; if [ $? -eq 0 ] && [ -f "$out" ]; then echo "$(tput bold; tput setaf 2)Successfully compressed to M4A: ${clean_name}.m4a$(tput sgr0)"; echo ""; else echo "$(tput bold; tput setaf 1)ERROR: QAAC encoding failed for $(basename "$f")$(tput sgr0)"; echo ""; fi; done; echo "---------------------------------------"; read -p "Processing complete. Press Enter to close..." temp' _ %F
INPUT_EOF

chmod +x ~/.local/share/kio/servicemenus/audio_tools_encoder.desktop
rm -f ~/.local/bin/audio_tools_processor.sh
kbuildsycoca5 --noincremental
