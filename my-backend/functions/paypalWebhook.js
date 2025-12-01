const fs = require("fs");
const path = require("path");

exports.handler = async function(event, context) {
  if (event.httpMethod !== "POST") {
    return { statusCode: 405, body: "Method Not Allowed" };
  }

  const webhookEvent = JSON.parse(event.body);
  console.log("Webhook received:", webhookEvent);

  const filePath = path.join(__dirname, "orders.json");
  if (!fs.existsSync(filePath)) {
    return { statusCode: 400, body: "No orders found" };
  }

  let orders = JSON.parse(fs.readFileSync(filePath, "utf8"));

  // PayPal sends the order ID or invoice in resource
  const orderNumber = webhookEvent.resource.invoice_number || webhookEvent.resource.custom;

  // Find the matching order
  const index = orders.findIndex(o => o.order_number === orderNumber);

  if (index !== -1) {
    if (webhookEvent.event_type === "PAYMENT.SALE.COMPLETED") {
      orders[index].payment_status = "paid";
    } else if (webhookEvent.event_type === "PAYMENT.SALE.PENDING") {
      orders[index].payment_status = "pending";
    }
    fs.writeFileSync(filePath, JSON.stringify(orders, null, 2));
    return { statusCode: 200, body: "Order updated" };
  }

  return { statusCode: 404, body: "Order not found" };
};
