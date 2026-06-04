cat << 'EOF' > README.md
# lossyWAV + FLAC Dolphin Service Menu Integration

This project integrates a custom audio encoding pipeline directly into the Dolphin File Manager context menu for Kubuntu 24.04 LTS running KDE Plasma 5.27.12[cite: 1]. It allows right-clicking one or multiple `.flac` files to convert them to lossyWAV-reduced FLAC files while preserving all original metadata tags.

## Architecture & Requirements
* **Operating System**: Kubuntu 24.04 LTS[cite: 1]
* **Desktop Environment**: KDE Plasma 5.27.12 (using the modern `kio/servicemenus` pathway)[cite: 1]
* **Dependencies**: 
  * `wine` (to execute the Windows binaries `lossyWAV.exe` and `flac.exe`)
  * `flac` (native Linux CLI utility for decoding)
  * `metaflac` (native Linux CLI utility for tag preservation)
  * `konsole` (KDE terminal emulator to host the process visual queue)[cite: 1]

## Step-by-Step Deployment Sequence

### 1. Create the Service Menu Directory
Modern KDE Plasma versions require user-specific context menus to reside in the KIO data path rather than legacy `kservices5` locations.
```bash
mkdir -p ~/.local/share/kio/servicemenus/
