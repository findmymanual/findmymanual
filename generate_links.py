import os
import urllib.parse

# FOLDER containing PDFs
pdf_folder = r"C:\Users\Lenovo\Documents\Web\LGPDF"

# Your website URL
site_url = "https://findmymanual.live/LGPDF"

# Output file for links
links_file = os.path.join(pdf_folder, "pdf_links.txt")

with open(links_file, "w", encoding="utf-8") as f:
    for filename in os.listdir(pdf_folder):
        if filename.lower().endswith(".pdf"):
            # URL encode the filename
            safe_filename = urllib.parse.quote(filename)
            # Build full link
            link = f"{site_url}/{safe_filename}"
            f.write(link + "\n")

print(f"✅ All done! Links saved in: {links_file}")
