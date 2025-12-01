import os
import urllib.parse

# Folder where your PDFs are located
folder_path = r"C:\Users\Lenovo\Documents\Web\HPpdf"

# Your website domain
base_url = "https://findmymanual.live/hppdf/"

# List all files in folder
files = os.listdir(folder_path)

# Filter only PDF files
pdf_files = [f for f in files if f.lower().endswith(".pdf")]

# Generate full URLs
urls = [base_url + urllib.parse.quote(f) for f in pdf_files]

# Print URLs
for url in urls:
    print(url)

# Optional: save to a file
with open("hppdf_links.txt", "w") as f:
    for url in urls:
        f.write(url + "\n")

print(f"Total {len(urls)} PDF links generated in hppdf_links.txt")
