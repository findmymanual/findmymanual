const fs = require("fs");
const path = require("path");

const filePath = path.join(__dirname, "orders.json");

exports.handler = async () => {
  let orders = [];
  if (fs.existsSync(filePath)) {
    orders = JSON.parse(fs.readFileSync(filePath, "utf8"));
  }

  return {
    statusCode: 200,
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(orders),
  };
};
