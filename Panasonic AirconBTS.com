<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Panasonic Air Conditioner Error Codes Guide</title>

<style>
body{
    font-family: Georgia, 'Times New Roman', Times, serif;
    margin:0;
    padding:20px;
    background:#f5f5f5;
    color:#333;
}

.container{
    max-width:1200px;
    margin:auto;
    background:#fff;
    padding:30px;
    border-radius:10px;
    box-shadow:0 2px 10px rgba(0,0,0,0.1);
}

h1{
    text-align:center;
    color:#666;
    margin-bottom:10px;
    background: #1f3b4d;
    color: white;
    padding: 25px;
}

.subtitle{
    text-align:center;
    color:#666;
    margin-bottom:30px;
}

.section-title{
    margin-top:40px;
    font-size:20px;
    font-weight:bold;
    border-left:5px solid #e60012;
    padding-left:10px;
    color:#444;
}

.grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(300px,1fr));
    gap:20px;
    margin-top:20px;
}

.card{
    border:1px solid #4e6e81;
    border-radius:8px;
    padding:20px;
    background:#fafafa;
    transition:0.3s;
}

.card:hover{
    transform:translateY(-4px);
    box-shadow:0 4px 10px rgba(0,0,0,0.1);
}

.code{
    font-size:24px;
    font-weight:bold;
    color:#4e6e81;
    margin-bottom:10px;
}

.title{
    font-size:18px;
    font-weight:bold;
    margin-bottom:12px;
}

.steps{
    padding-left:18px;
    line-height:1.6;
}

.note{
    margin-top:30px;
    background:#fff3cd;
    border:1px solid #ffeeba;
    padding:15px;
    border-radius:6px;
}
</style>
</head>

<body>

<div class="container">

<h1>Panasonic Air Conditioner Error Codes</h1>

<p class="subtitle">
<strong>System Diagnostic & Troubleshooting Guide</strong>
</p>

<!-- ================= COMMUNICATION ================= -->
<div class="section-title">Communication Errors</div>

<div class="grid">

<div class="card">
<div class="code">H11</div>
<div class="title">Indoor/Outdoor Communication Error</div>
<ul class="steps">
<li>Check wiring between indoor and outdoor units.</li>
<li>Inspect PCB connection boards.</li>
<li>Restart power supply to both units.</li>
<li>Replace control board if persistent.</li>
</ul>
</div>

</div>

<!-- ================= SENSOR ================= -->
<div class="section-title">Temperature Sensor Errors</div>

<div class="grid">

<div class="card">
<div class="code">H14</div>
<div class="title">Indoor Temperature Sensor Fault</div>
<ul class="steps">
<li>Check indoor thermistor connection.</li>
<li>Inspect sensor wiring for damage.</li>
<li>Replace faulty temperature sensor.</li>
<li>Reset system after repair.</li>
</ul>
</div>

<div class="card">
<div class="code">H15</div>
<div class="title">Outdoor Temperature Sensor Fault</div>
<ul class="steps">
<li>Inspect outdoor sensor wiring.</li>
<li>Clean sensor housing area.</li>
<li>Replace sensor if readings are abnormal.</li>
<li>Check PCB input signal.</li>
</ul>
</div>

</div>

<!-- ================= ELECTRICAL ================= -->
<div class="section-title">Electrical Protection Errors</div>

<div class="grid">

<div class="card">
<div class="code">H16</div>
<div class="title">Current Overload Protection</div>
<ul class="steps">
<li>Check compressor load condition.</li>
<li>Inspect power supply voltage stability.</li>
<li>Clean condenser coils.</li>
<li>Service compressor if overload persists.</li>
</ul>
</div>

</div>

<!-- ================= FAN ================= -->
<div class="section-title">Fan & Motor Errors</div>

<div class="grid">

<div class="card">
<div class="code">H19</div>
<div class="title">Fan Motor Lock Error</div>
<ul class="steps">
<li>Check fan blades for obstruction.</li>
<li>Inspect motor wiring and capacitor.</li>
<li>Clean dust buildup from fan assembly.</li>
<li>Replace fan motor if seized.</li>
</ul>
</div>

</div>

<!-- ================= HEAT EXCHANGER ================= -->
<div class="section-title">Heat Exchange System Errors</div>

<div class="grid">

<div class="card">
<div class="code">H23</div>
<div class="title">Heat Exchanger Temperature Abnormal</div>
<ul class="steps">
<li>Check refrigerant level.</li>
<li>Inspect heat exchanger coils.</li>
<li>Clean indoor/outdoor coils.</li>
<li>Verify airflow is not blocked.</li>
</ul>
</div>

</div>

<!-- ================= REFRIGERANT ================= -->
<div class="section-title">Refrigerant & Pressure Errors</div>

<div class="grid">

<div class="card">
<div class="code">H27</div>
<div class="title">Outdoor Pressure Abnormal</div>
<ul class="steps">
<li>Check refrigerant pressure levels.</li>
<li>Inspect expansion valve operation.</li>
<li>Look for leaks in piping system.</li>
<li>Service refrigerant system if needed.</li>
</ul>
</div>

<div class="card">
<div class="code">H28</div>
<div class="title">Refrigerant Leakage Detected</div>
<ul class="steps">
<li>Inspect copper piping for leaks.</li>
<li>Check joints and valves for damage.</li>
<li>Recharge refrigerant after repair.</li>
<li>Perform pressure test after servicing.</li>
</ul>
</div>

</div>

<!-- ================= COMPRESSOR ================= -->
<div class="section-title">Compressor Errors</div>

<div class="grid">

<div class="card">
<div class="code">H30</div>
<div class="title">Compressor Overheat Protection</div>
<ul class="steps">
<li>Allow compressor to cool down.</li>
<li>Check condenser fan operation.</li>
<li>Clean condenser coils.</li>
<li>Inspect compressor load condition.</li>
</ul>
</div>

</div>

<!-- ================= INSTALLATION ================= -->
<div class="section-title">Installation Errors</div>

<div class="grid">

<div class="card">
<div class="code">H33</div>
<div class="title">Indoor/Outdoor Miswiring</div>
<ul class="steps">
<li>Check wiring connections between units.</li>
<li>Verify correct terminal matching.</li>
<li>Inspect for loose or reversed wiring.</li>
<li>Correct wiring and restart system.</li>
</ul>
</div>

</div>

<div class="note">
<strong>Note:</strong> Refrigerant and compressor-related faults should be handled by certified HVAC technicians.
</div>

</div>

</body>
</html>