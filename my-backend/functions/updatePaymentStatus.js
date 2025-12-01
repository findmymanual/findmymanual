const fetch = require("node-fetch");

exports.handler = async function (event) {
  if (event.httpMethod !== "POST") {
    return { statusCode: 405, body: "Method Not Allowed" };
  }

  try {
    const webhookEvent = JSON.parse(event.body);
    console.log("Webhook received:", webhookEvent);

    const eventType = webhookEvent.event_type;
    const resource = webhookEvent.resource || {};

    // --- Extract PayPal data ---
    const orderNumber = resource.invoice_number || resource.custom || "N/A";
    const payerEmail = resource.payer?.email_address || "N/A";
    const amount = resource.amount?.total || resource.amount?.value || "N/A";
    const status =
      eventType === "PAYMENT.SALE.COMPLETED"
        ? "✅ Payment Successful"
        : eventType === "PAYMENT.SALE.PENDING"
        ? "🕓 Payment Pending"
        : eventType;

    // --- If you included order details in your checkout (via PayPal custom field) ---
    const customerName = resource.custom_fields?.customer_name || "N/A";
    const customerPhone = resource.custom_fields?.customer_phone || "N/A";
    const brandName = resource.custom_fields?.brand_name || "N/A";
    const modelNumber = resource.custom_fields?.model_number || "N/A";

    // --- Send full email via Formspree (to Outlook) ---
    await fetch("https://formspree.io/f/xldpwdpb", {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: new URLSearchParams({
        subject: `New PayPal Order: ${status}`,
        message: `
📦 NEW ORDER DETAILS:

🧾 Order Number: ${orderNumber}
💰 Amount: ${amount}
📅 Status: ${status}

👤 Customer Name: ${customerName}
📧 Email: ${payerEmail}
📱 Phone: ${customerPhone}

🏷️ Brand: ${brandName}
🔢 Serial/Model: ${modelNumber}

🕐 Time: ${new Date().toLocaleString()}
        `,
      }),
    });

    return { statusCode: 200, body: "Email sent successfully" };
  } catch (error) {
    console.error("Webhook error:", error);
    return { statusCode: 500, body: "Internal Server Error" };
  }
};
