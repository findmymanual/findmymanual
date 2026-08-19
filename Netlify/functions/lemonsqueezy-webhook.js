import crypto from "node:crypto";

export default async (req) => {
    if (req.method !== "POST") {
        return new Response(
            JSON.stringify({
                error: "Method not allowed"
            }),
            {
                status: 405,
                headers: {
                    "Content-Type": "application/json"
                }
            }
        );
    }

    try {
        const rawBody = await req.text();
        const signature = req.headers.get("x-signature");
        const secret = process.env.LEMONSQUEEZY_WEBHOOK_SECRET;

        if (!secret) {
            console.error(
                "LEMONSQUEEZY_WEBHOOK_SECRET is not configured."
            );

            return new Response(
                JSON.stringify({
                    error: "Webhook secret not configured"
                }),
                {
                    status: 500,
                    headers: {
                        "Content-Type": "application/json"
                    }
                }
            );
        }

        if (!signature) {
            console.error(
                "Missing Lemon Squeezy X-Signature header."
            );

            return new Response(
                JSON.stringify({
                    error: "Missing signature"
                }),
                {
                    status: 401,
                    headers: {
                        "Content-Type": "application/json"
                    }
                }
            );
        }

        const digest = crypto
            .createHmac("sha256", secret)
            .update(rawBody)
            .digest("hex");

        const digestBuffer = Buffer.from(digest, "utf8");
        const signatureBuffer = Buffer.from(signature, "utf8");

        if (
            digestBuffer.length !== signatureBuffer.length ||
            !crypto.timingSafeEqual(
                digestBuffer,
                signatureBuffer
            )
        ) {
            console.error(
                "Invalid Lemon Squeezy webhook signature."
            );

            return new Response(
                JSON.stringify({
                    error: "Invalid signature"
                }),
                {
                    status: 401,
                    headers: {
                        "Content-Type": "application/json"
                    }
                }
            );
        }

        const payload = JSON.parse(rawBody);

        const eventName =
            payload?.meta?.event_name ||
            req.headers.get("x-event-name") ||
            "unknown";

        console.log(
            "Lemon Squeezy event:",
            eventName
        );

        if (eventName !== "order_created") {
            console.log(
                "Ignoring event:",
                eventName
            );

            return new Response(
                JSON.stringify({
                    received: true,
                    ignored: true,
                    event: eventName
                }),
                {
                    status: 200,
                    headers: {
                        "Content-Type": "application/json"
                    }
                }
            );
        }

        const order =
            payload?.data?.attributes || {};

        const customData =
            payload?.meta?.custom_data || {};

        const lemonOrder = {
            lemon_squeezy_order_id:
                payload?.data?.id || "",

            lemon_squeezy_order_number:
                order?.order_number || "",

            customer_name:
                order?.user_name || "",

            customer_email:
                order?.user_email || "",

            status:
                order?.status || "",

            currency:
                order?.currency || "",

            total:
                order?.total || "",

            total_usd:
                order?.total_usd || "",

            order_number:
                customData?.order_number || "",

            brand:
                customData?.brand || "",

            model:
                customData?.model || "",

            phone:
                customData?.phone || "",

            payment_status:
                order?.status === "paid"
                    ? "PAID"
                    : order?.status || ""
        };

        console.log(
            "ORDER RECEIVED:",
            JSON.stringify(
                lemonOrder,
                null,
                2
            )
        );

        const formspreeEndpoint =
            "https://formspree.io/f/xldpwdpb";

        const formspreeResponse =
            await fetch(formspreeEndpoint, {
                method: "POST",

                headers: {
                    "Content-Type":
                        "application/json",

                    "Accept":
                        "application/json"
                },

                body: JSON.stringify({
                    ...lemonOrder,

                    product:
                        "User Manual PDF",

                    amount:
                        "$14.95",

                    status:
                        "PAID - Lemon Squeezy",

                    payment_processor:
                        "Lemon Squeezy"
                })
            });

        if (!formspreeResponse.ok) {
            console.error(
                "Failed to forward paid order to Formspree.",
                await formspreeResponse.text()
            );
        }

        return new Response(
            JSON.stringify({
                success: true,
                event: eventName,
                order: lemonOrder
            }),
            {
                status: 200,
                headers: {
                    "Content-Type":
                        "application/json"
                }
            }
        );

    } catch (error) {

        console.error(
            "Lemon Squeezy webhook error:",
            error
        );

        return new Response(
            JSON.stringify({
                error:
                    "Webhook processing failed"
            }),
            {
                status: 500,
                headers: {
                    "Content-Type":
                        "application/json"
                }
            }
        );
    }
};