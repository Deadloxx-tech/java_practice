<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Online Shopping Cart</title>
  <link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Bebas+Neue&display=swap" rel="stylesheet"/>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    :root {
      --bg: #0a0a0f; --surface: #13131c; --border: #1e1e2e;
      --accent: #f7c948; --accent2: #e84393;
      --text: #e8e8f0; --muted: #5a5a7a;
      --font-display: 'Bebas Neue', sans-serif;
      --font-mono: 'Space Mono', monospace;
    }

    body {
      background: var(--bg); color: var(--text);
      font-family: var(--font-mono);
      min-height: 100vh; display: flex;
      align-items: center; justify-content: center;
      overflow: hidden; position: relative;
    }

    body::before {
      content: ''; position: fixed; inset: 0;
      background-image:
        linear-gradient(var(--border) 1px, transparent 1px),
        linear-gradient(90deg, var(--border) 1px, transparent 1px);
      background-size: 48px 48px; opacity: 0.6; z-index: 0;
    }
    body::after {
      content: ''; position: fixed; width: 600px; height: 600px;
      background: radial-gradient(circle, rgba(247,201,72,0.07) 0%, transparent 70%);
      top: -100px; right: -100px; z-index: 0; pointer-events: none;
    }

    .orb2 {
      position: fixed; width: 400px; height: 400px;
      background: radial-gradient(circle, rgba(232,67,147,0.06) 0%, transparent 70%);
      bottom: -80px; left: -80px; z-index: 0; pointer-events: none;
    }

    .floaters { position: fixed; inset: 0; pointer-events: none; z-index: 0; overflow: hidden; }
    .floater {
      position: absolute; font-family: var(--font-display);
      color: rgba(255,255,255,0.015); animation: float linear infinite; user-select: none;
    }
    @keyframes float {
      from { transform: translateY(110vh) rotate(-10deg); }
      to   { transform: translateY(-10vh) rotate(10deg); }
    }

    /* ── Card ── */
    .card {
      position: relative; z-index: 1;
      background: var(--surface); border: 1px solid var(--border);
      width: 540px;
      clip-path: polygon(0 0, calc(100% - 24px) 0, 100% 24px, 100% 100%, 24px 100%, 0 calc(100% - 24px));
      box-shadow: 0 0 0 1px #1e1e2e, 0 32px 80px rgba(0,0,0,0.6), inset 0 1px 0 rgba(255,255,255,0.04);
      animation: slideUp 0.6s cubic-bezier(0.16,1,0.3,1) both;
    }
    @keyframes slideUp {
      from { opacity: 0; transform: translateY(40px); }
      to   { opacity: 1; transform: translateY(0); }
    }
    .corner-deco {
      position: absolute; top: 0; right: 0;
      width: 24px; height: 24px; background: var(--accent);
      clip-path: polygon(0 0, 100% 0, 100% 100%);
    }

    /* ── Header ── */
    .card-header {
      padding: 28px 36px 20px;
      border-bottom: 1px solid var(--border); position: relative;
    }
    .badge {
      display: inline-flex; align-items: center; gap: 6px;
      font-size: 10px; letter-spacing: 0.15em; text-transform: uppercase;
      color: var(--accent); margin-bottom: 10px;
    }
    .badge::before {
      content: ''; display: inline-block; width: 6px; height: 6px;
      background: var(--accent); border-radius: 50%;
      animation: pulse 2s ease-in-out infinite;
    }
    @keyframes pulse {
      0%,100% { opacity:1; transform:scale(1); }
      50%      { opacity:.4; transform:scale(.7); }
    }
    h1 { font-family: var(--font-display); font-size: 48px; letter-spacing: 0.04em; line-height: 0.95; }
    h1 span { color: var(--accent); }

    /* ── Body ── */
    .card-body { padding: 24px 36px 36px; }
    .section-label {
      font-size: 10px; letter-spacing: 0.2em; text-transform: uppercase;
      color: var(--muted); margin-bottom: 14px; display: block;
    }

    /* ── Product Table ── */
    .shop-table { width: 100%; border-collapse: collapse; margin-bottom: 28px; }

    .shop-table thead tr {
      background: var(--bg); border-bottom: 1px solid var(--border);
    }
    .shop-table thead th {
      font-size: 9px; letter-spacing: 0.2em; text-transform: uppercase;
      color: var(--muted); padding: 10px 14px; text-align: left; font-weight: 400;
    }
    .shop-table thead th:last-child { text-align: center; }

    .shop-table tbody tr {
      background: var(--bg); border: 1px solid var(--border);
      transition: border-color 0.15s, background 0.15s;
      animation: rowIn 0.4s cubic-bezier(0.16,1,0.3,1) both;
    }
    .shop-table tbody tr:hover { border-color: var(--accent); background: rgba(247,201,72,0.04); }
    .shop-table tbody tr:nth-child(1) { animation-delay: 40ms; }
    .shop-table tbody tr:nth-child(2) { animation-delay: 80ms; }
    .shop-table tbody tr:nth-child(3) { animation-delay: 120ms; }

    @keyframes rowIn {
      from { opacity: 0; transform: translateX(-12px); }
      to   { opacity: 1; transform: translateX(0); }
    }

    .shop-table tbody td { padding: 14px 14px; font-size: 13px; vertical-align: middle; }

    .product-cell { display: flex; align-items: center; gap: 12px; }
    .product-icon { font-size: 20px; }
    .product-name { color: var(--text); }

    .price-cell {
      font-family: var(--font-display); font-size: 20px;
      letter-spacing: 0.04em; color: var(--accent);
    }
    .price-currency { font-size: 13px; opacity: 0.6; margin-right: 2px; }

    /* ── Qty Input ── */
    .qty-wrapper {
      display: flex; align-items: center; gap: 0;
      justify-content: center;
    }
    .qty-btn {
      width: 32px; height: 38px;
      background: var(--border); border: 1px solid var(--border);
      color: var(--text); font-family: var(--font-display);
      font-size: 18px; cursor: pointer; display: flex;
      align-items: center; justify-content: center;
      transition: background 0.15s, color 0.15s; user-select: none;
      flex-shrink: 0;
    }
    .qty-btn:hover { background: var(--accent); color: var(--bg); border-color: var(--accent); }
    .qty-btn:active { transform: scale(0.92); }

    input[type="number"] {
      width: 54px; height: 38px;
      background: var(--bg); border-top: 1px solid var(--border);
      border-bottom: 1px solid var(--border); border-left: none; border-right: none;
      color: var(--text); font-family: var(--font-mono);
      font-size: 14px; text-align: center; outline: none;
      -moz-appearance: textfield; appearance: textfield;
      transition: border-color 0.2s;
    }
    input[type="number"]::-webkit-inner-spin-button,
    input[type="number"]::-webkit-outer-spin-button { -webkit-appearance: none; }
    input[type="number"]:focus { border-color: var(--accent); }

    /* ── Submit Button ── */
    .btn-submit {
      display: block; width: 100%;
      background: var(--accent); color: #0a0a0f;
      font-family: var(--font-display); font-size: 22px;
      letter-spacing: 0.1em; border: none; padding: 16px 24px;
      cursor: pointer; position: relative; overflow: hidden;
      clip-path: polygon(0 0, calc(100% - 16px) 0, 100% 16px, 100% 100%, 16px 100%, 0 calc(100% - 16px));
      transition: background 0.2s, transform 0.1s;
    }
    .btn-submit::after {
      content: ''; position: absolute; inset: 0;
      background: linear-gradient(120deg, transparent 30%, rgba(255,255,255,0.25) 50%, transparent 70%);
      transform: translateX(-100%); transition: transform 0.5s ease;
    }
    .btn-submit:hover { background: #ffd966; }
    .btn-submit:hover::after { transform: translateX(100%); }
    .btn-submit:active { transform: scale(0.98); }

    .hint {
      margin-top: 16px; font-size: 11px; color: var(--muted);
      display: flex; align-items: center; gap: 8px;
    }
    .hint::before { content: '₹'; font-size: 14px; color: var(--accent2); }
  </style>
</head>
<body>
  <div class="orb2"></div>
  <div class="floaters">
    <span class="floater" style="left:5%;  animation-duration:18s; animation-delay:0s;   font-size:120px;">₹</span>
    <span class="floater" style="left:20%; animation-duration:24s; animation-delay:-6s;  font-size:60px;">$</span>
    <span class="floater" style="left:40%; animation-duration:20s; animation-delay:-12s; font-size:90px;">∑</span>
    <span class="floater" style="left:60%; animation-duration:16s; animation-delay:-3s;  font-size:70px;">₹</span>
    <span class="floater" style="left:75%; animation-duration:22s; animation-delay:-9s;  font-size:100px;">%</span>
    <span class="floater" style="left:88%; animation-duration:19s; animation-delay:-15s; font-size:65px;">$</span>
  </div>

  <div class="card">
    <div class="corner-deco"></div>
    <div class="card-header">
      <div class="badge">Store · Select Items</div>
      <h1>ONLINE<br/><span>CART</span></h1>
    </div>

    <div class="card-body">
      <form action="CartServlet" method="post">
        <span class="section-label">Choose your quantities</span>

        <table class="shop-table">
          <thead>
            <tr>
              <th>Product</th>
              <th>Unit Price</th>
              <th style="text-align:center">Qty</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>
                <div class="product-cell">
                  <span class="product-icon">💻</span>
                  <span class="product-name">Laptop</span>
                </div>
              </td>
              <td class="price-cell"><span class="price-currency">₹</span>50,000</td>
              <td>
                <div class="qty-wrapper">
                  <button type="button" class="qty-btn" onclick="adj('laptop',-1)">−</button>
                  <input type="number" name="laptop" id="laptop" value="0" min="0"/>
                  <button type="button" class="qty-btn" onclick="adj('laptop',1)">+</button>
                </div>
              </td>
            </tr>
            <tr>
              <td>
                <div class="product-cell">
                  <span class="product-icon">📱</span>
                  <span class="product-name">Mobile</span>
                </div>
              </td>
              <td class="price-cell"><span class="price-currency">₹</span>20,000</td>
              <td>
                <div class="qty-wrapper">
                  <button type="button" class="qty-btn" onclick="adj('mobile',-1)">−</button>
                  <input type="number" name="mobile" id="mobile" value="0" min="0"/>
                  <button type="button" class="qty-btn" onclick="adj('mobile',1)">+</button>
                </div>
              </td>
            </tr>
            <tr>
              <td>
                <div class="product-cell">
                  <span class="product-icon">🎧</span>
                  <span class="product-name">Headphone</span>
                </div>
              </td>
              <td class="price-cell"><span class="price-currency">₹</span>2,000</td>
              <td>
                <div class="qty-wrapper">
                  <button type="button" class="qty-btn" onclick="adj('headphone',-1)">−</button>
                  <input type="number" name="headphone" id="headphone" value="0" min="0"/>
                  <button type="button" class="qty-btn" onclick="adj('headphone',1)">+</button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>

        <button type="submit" class="btn-submit">GENERATE BILL</button>
        <p class="hint">Review quantities before submitting</p>
      </form>
    </div>
  </div>

  <script>
    function adj(id, delta) {
      const el = document.getElementById(id);
      el.value = Math.max(0, (parseInt(el.value) || 0) + delta);
    }
  </script>
</body>
</html>