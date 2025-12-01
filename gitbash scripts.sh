1️⃣ Open Git Bash and go to your PDF folder
cd /c/Users/Lenovo/Documents/Web/LGPDF

___________________________________________________________________________________________________________________

2️⃣ Make a new script file to generate links

You can create a simple Bash script called generate_links.sh. For example, in Git Bash:

nano generate_links.sh

___________________________________________________________________________________________________________________

Then paste this inside:

#!/bin/bash

PDF_FOLDER="/c/Users/Lenovo/Documents/Web/Samsungpdf"
SITE_URL="https://findmymanual.live/Samsungpdf"
LINKS_FILE="$PDF_FOLDER/pdf_links.txt"

# Clear previous links file
> "$LINKS_FILE"

# Function to URL encode spaces and special characters
urlencode() {
    local string="$1"
    echo -n "$string" | python -c "import urllib.parse, sys; print(urllib.parse.quote(sys.stdin.read().strip()))"
}

# Loop through PDFs and generate links
for file in "$PDF_FOLDER"/*.pdf; do
    [ -f "$file" ] || continue
    filename=$(basename "$file")
    safe_filename=$(urlencode "$filename")
    echo "$SITE_URL/$safe_filename" >> "$LINKS_FILE"
done

echo "✅ All done! Links saved in: $LINKS_FILE"

___________________________________________________________________________________________________________________

3️⃣ Save and exit

Press CTRL + O → Enter → CTRL + X

___________________________________________________________________________________________________________________

4️⃣ Make the script executable
chmod +x generate_links.sh

___________________________________________________________________________________________________________________

5️⃣ Run the script
./generate_links.sh