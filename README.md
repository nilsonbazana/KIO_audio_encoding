# Audio Encoding Pipelines for Dolphin Service Menus

This project integrates custom audio encoding pipelines directly into the Dolphin File Manager context menu, via KDE Service Menus (or KIO Service Menus), for Kubuntu 24.04 LTS running KDE Plasma 5.27.12[cite: 1]. It enables right-click, batch-processing automation to compress `.flac` files into high-efficiency formats (lossyWAV _-high_ or QAAC TVBR Q91) - while automatically generating structured relative directories based on embedded metadata tags (`/%album artist%/%date%-%album%/`).

---

## 🛠️ Architecture & Requirements

* **Operating System:** Kubuntu 24.04 LTS[cite: 1]
* **Desktop Environment:** KDE Plasma 5.27.12 (utilizing the modern `kio/servicemenus` pathway)[cite: 1]
* **Dependencies:**
  * `wine` (to execute Windows binaries `lossyWAV.exe`, `flac.exe`, and `qaac64.exe`)
  * `flac` (native Linux CLI utility for stream decoding)
  * `metaflac` (native Linux CLI utility for metadata tag extraction and injection)
  * `konsole` (KDE terminal emulator utilized for tracking pipeline execution output)[cite: 1]

---

## 📦 Integrated Pipelines

### 1. lossyWAV + FLAC
* **Target Binaries:** `lossyWAV.exe` & `flac.exe` (via Wine)
* **Behavior:** Decodes native FLAC on-the-fly, passes the PCM stream to lossyWAV for pre-bit reduction processing, recompiles the output to standard FLAC format, and clones the original Vorbis comments.

### 2. QAAC (.m4a files)
* **Target Binary:** `qaac64.exe` (via Wine)
* **Behavior:** Decodes native FLAC on-the-fly, pipes the stream into the Apple AAC encoder at True VBR quality (`-V 91`), and exports compliant `.m4a` audio files.

---

## 🚀 Step-by-Step Deployment Sequence

### 1. Create the Service Menu Directory
Modern KDE Plasma environments require user-space context menu configurations to reside in the KIO data path rather than legacy paths.
```bash
mkdir -p ~/.local/share/kio/servicemenus/
```

### 2. Run all the content from the chosen .desktop file in Bash
Modern KDE Plasma environments require user-space context menu configurations to reside in the KIO data path rather than legacy paths.

### 3. Run the configuration cache rebuild command to apply the changes (the creation of the new .desktop file) to Dolphin.
Modern KDE Plasma environments require user-space context menu configurations to reside in the KIO data path rather than legacy paths.
```bash
kbuildsycoca5 --noincremental
```

### 4. Right-click any FLAC file(s) to encode to chose format. 
That will create a subfolder (in the source folder) with the structure /%album artist%/%date%-%album% - ready to copy to, in my own case, my music collection in /mnt/share/THE MUSIC COLLECTION/[folders (grouping files mostly by the Album Artist's initial) /A-D, /E-J, /K-O, /P-S, /T-Z and /z_CLASSICAL or /z_Soundtracks & Original Scores



