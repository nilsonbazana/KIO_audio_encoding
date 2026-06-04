cat << 'EOF' > ~/.local/share/kio/servicemenus/lossywav_encoder.desktop
[Desktop Entry]
Type=Service
MimeType=audio/x-flac;audio/flac;
Actions=lossywavConvert;
X-KDE-Priority=TopLevel
X-KDE-Submenu=Audio Tools

[Desktop Action lossywavConvert]
Name=Compress to lossyWAV + FLAC
Icon=audio-x-generic
Exec=konsole --hold -e bash -c 'ENCODER_DIR="/mnt/shared/THE MUSIC COLLECTION/_CODECS/lossyWAV"; cd "$ENCODER_DIR" || exit; for f in "$@"; do out="${f%.*}.lossy.flac"; flac -d -c "$f" | wine lossyWAV.exe - --quality high --silent --stdout | wine flac.exe - -b 512 -5 -f --ignore-chunk-sizes -o "$out" && metaflac --export-tags-to=- "$f" | metaflac --import-tags-from=- "$out"; done' _ %F
EOF
