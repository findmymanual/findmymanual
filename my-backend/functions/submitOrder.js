const fs = require("fs");
const path = require("path");

const filePath = path.join(__dirname, "orders.json");

exports.handler = async (event) => {
  if (event.httpMethod !== "POST") return { statusCode: 405, body: "Method Not Allowed" };

  try {
    const data = JSON.parse(event.body);
    data.payment_status = "pending"; // default

    let orders = [];
    if (fs.existsSync(filePath)) {
      orders = JSON.parse(fs.readFileSync(filePath, "utf8"));
    }

    orders.push(data);
    fs.writeFileSync(filePath, JSON.stringify(orders, null, 2));

    return { statusCode: 200, body: JSON.stringify({ message: "Order saved", order_number: data.order_number }) };
  } catch (err) {
    console.error(err);
    return { statusCode: 500, body: "Error saving order" };
  }
};
