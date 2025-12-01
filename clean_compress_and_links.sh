# === STEP 3: Generate HTTPS download links from cleaned PDFs ===
echo "🔗 Generating HTTPS links..."
echo "---------------------------------------"
for file in "$PDF_FOLDER/cleaned"/*.pdf; do
  [ -f "$file" ] || continue
  filename=$(basename "$file")
  echo "$SITE_URL/LGPDF/$filename"
done > "$PDF_FOLDER/pdf_links.txt"

echo "✅ All done! Links saved in: $PDF_FOLDER/pdf_links.txt"
#!/bin/bash
# clean_compress_and_links.sh
# Cleans metadata, compresses PDFs, and generates HTTPS links

# === CONFIGURATION ===
PDF_FOLDER="$HOME/Documents/Web/HPpdf"  # 📁 Change this to your PDF folder
#!/bin/bash
# clean_compress_and_links.sh
# Cleans metadata, compresses PDFs, and generates HTTPS links

# === CONFIGURATION ===
PDF_FOLDER="$HOME/Documents/Web/LGPDF"  # 📁 Your actual PDF folder
SITE_URL="https://findmymanual.live"    # 🌐 Change if you host under a subfolder
EXIFTOOL="./exiftool.exe"               # Assuming exiftool.exe is in your main Web folder

echo "🚀 Starting PDF cleanup and compression process..."
echo

# === STEP 1: Remove metadata from PDFs ===
echo "🧹 Cleaning metadata from PDFs..."
mkdir -p "$PDF_FOLDER/cleaned"

for file in "$PDF_FOLDER"/*.pdf; do
  [ -f "$file" ] || continue
  filename=$(basename "$file")
  "$EXIFTOOL" -overwrite_original -all= "$file"
  cp "$file" "$PDF_FOLDER/cleaned/$filename"
  echo "✅ Cleaned: $filename"
done

echo

# === STEP 2: Compress large PDFs (using Ghostscript if available) ===
echo "🗜️ Compressing large PDFs (using Ghostscript if available)..."
mkdir -p "$PDF_FOLDER/compressed"

if command -v gswin64c.exe >/dev/null 2>&1; then
  for file in "$PDF_FOLDER/cleaned"/*.pdf; do
    [ -f "$file" ] || continue
    filename=$(basename "$file")
    gswin64c.exe -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer \
      -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$PDF_FOLDER/compressed/$filename" "$file"
    echo "✅ Compressed: $filename"
  done
else
  echo "⚠️ Ghostscript not found (gswin64c.exe). Skipping compression."
fi

echo

# === STEP 3: Generate HTTPS download links ===
echo "🔗 Generating HTTPS links..."
echo "---------------------------------------"
for file in "$PDF_FOLDER/compressed"/*.pdf; do
  [ -f "$file" ] || continue
  filename=$(basename "$file")
  echo "$SITE_URL/$filename"
done > "$PDF_FOLDER/pdf_links.txt"

echo "✅ All done! Links saved in: $PDF_FOLDER/pdf_links.txt"
SITE_URL="https://findmymanual.live"    # 🌐 Change this to your own site
EXIFTOOL="./exiftool.exe"               # Assuming exiftool.exe is in your main folder

echo "🚀 Starting PDF cleanup and compression process..."
echo

# === STEP 1: Remove metadata from PDFs ===
echo "🧹 Cleaning metadata from PDFs..."
mkdir -p "$PDF_FOLDER/cleaned"

for file in "$PDF_FOLDER"/*.pdf; do
  [ -f "$file" ] || continue
  filename=$(basename "$file")
  "$EXIFTOOL" -overwrite_original -all= "$file"
  cp "$file" "$PDF_FOLDER/cleaned/$filename"
  echo "✅ Cleaned: $filename"
done

echo

# === STEP 2: Compress large PDFs (using Ghostscript if available) ===
echo "🗜️ Compressing large PDFs (using Ghostscript if available)..."
mkdir -p "$PDF_FOLDER/compressed"

if command -v gswin64c.exe >/dev/null 2>&1; then
  for file in "$PDF_FOLDER/cleaned"/*.pdf; do
    [ -f "$file" ] || continue
    filename=$(basename "$file")
    gswin64c.exe -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer \
      -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$PDF_FOLDER/compressed/$filename" "$file"
    echo "✅ Compressed: $filename"
  done
else
  echo "⚠️ Ghostscript not found (gswin64c.exe). Skipping compression."
fi

echo

# === STEP 3: Generate HTTPS download links ===
echo "🔗 Generating HTTPS links..."
echo "---------------------------------------"
for file in "$PDF_FOLDER/compressed"/*.pdf; do
  [ -f "$file" ] || continue
  filename=$(basename "$file")
  echo "$SITE_URL/$filename"
done > "$PDF_FOLDER/pdf_links.txt"

echo "✅ All done! Links saved in: $PDF_FOLDER/pdf_links.txt"
Ctrl + O  →  Enter  →  Ctrl + X

