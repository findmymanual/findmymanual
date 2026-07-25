const fs = require("fs");
const path = require("path");

const root = path.resolve(__dirname, "..");

function decodeHtml(value) {
  return value
    .replace(/&amp;/g, "&")
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, "'")
    .replace(/&lt;/g, "<")
    .replace(/&gt;/g, ">");
}

function textBetween(html, expression) {
  const match = html.match(expression);
  return match ? decodeHtml(match[1].replace(/<[^>]*>/g, "").replace(/\s+/g, " ").trim()) : "";
}

function escapeString(value) {
  return JSON.stringify(value);
}

function getManualFiles() {
  return fs.readdirSync(root, { withFileTypes: true })
    .filter((entry) => entry.isDirectory() && entry.name.endsWith("-pdf"))
    .flatMap((directory) => {
      const directoryPath = path.join(root, directory.name);
      return fs.readdirSync(directoryPath, { withFileTypes: true })
        .filter((entry) => entry.isFile() && entry.name.endsWith(".html"))
        .map((entry) => path.join(directory.name, entry.name));
    })
    .sort((left, right) => left.localeCompare(right));
}

const manuals = getManualFiles().map((relativePath) => {
  const html = fs.readFileSync(path.join(root, relativePath), "utf8");
  const filename = path.basename(relativePath, ".html");
  const [brandFromFilename, ...productFromFilename] = filename.split("-");
  const brand = textBetween(html, /<strong>Brand:<\/strong>\s*([^<]+)/i) || brandFromFilename;
  const model = textBetween(html, /<strong>Model:<\/strong>\s*([^<]+)/i) || productFromFilename.at(-1);
  const heading = textBetween(html, /<h1[^>]*>([\s\S]*?)<\/h1>/i);
  const title = (heading || `${brand} ${productFromFilename.join(" ")}`)
    .replace(/\s+User Manual PDF\s*$/i, "")
    .replace(/\s+Manual PDF\s*$/i, "")
    .trim();

  return { brand, model, title, url: relativePath.replace(/\\/g, "/") };
});

const output = `const manuals = [\n${manuals.map((manual) => `\n{\n  brand:${escapeString(manual.brand)},\n  model:${escapeString(manual.model)},\n  title:${escapeString(manual.title)},\n  url:${escapeString(manual.url)}\n}`).join(",\n")}\n\n]\n`;
fs.writeFileSync(path.join(root, "manuals.js"), output, "utf8");
console.log(`Generated ${manuals.length} manual entries in manuals.js.`);
