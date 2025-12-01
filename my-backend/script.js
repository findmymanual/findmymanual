<script>
const orderData = {
    name: "John Doe",
    email: "john@example.com",
    product: "Necklace",
};

fetch("/.netlify/functions/submitOrder", {
    method: "POST",
    headers: {
        "Content-Type": "application/json",
    },
    body: JSON.stringify(orderData),
})
.then(res => res.json())
.then(data => console.log(data))
.catch(err => console.error(err));
</script>
