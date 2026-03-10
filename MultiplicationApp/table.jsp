<%@ page import="java.util.List" %>
<jsp:useBean id="calc" class="com.demo.bean.MultiplicationBean" />
<jsp:setProperty name="calc" property="number" />
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Multiplication Table</title>
  <link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Bebas+Neue&display=swap" rel="stylesheet"/>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    :root {
      --bg: #0a0a0f;
      --surface: #13131c;
      --border: #1e1e2e;
      --accent: #f7c948;
      --accent2: #e84393;
      --text: #e8e8f0;
      --muted: #5a5a7a;
      --font-display: 'Bebas Neue', sans-serif;
      --font-mono: 'Space Mono', monospace;
    }

    body {
      background: var(--bg);
      color: var(--text);
      font-family: var(--font-mono);
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      overflow: hidden;
      position: relative;
    }

    body::before {
      content: '';
      position: fixed;
      inset: 0;
      background-image:
        linear-gradient(var(--border) 1px, transparent 1px),
        linear-gradient(90deg, var(--border) 1px, transparent 1px);
      background-size: 48px 48px;
      opacity: 0.6;
      z-index: 0;
    }

    body::after {
      content: '';
      position: fixed;
      width: 600px; height: 600px;
      background: radial-gradient(circle, rgba(247,201,72,0.07) 0%, transparent 70%);
      top: -100px; right: -100px;
      z-index: 0; pointer-events: none;
    }

    .orb2 {
      position: fixed;
      width: 400px; height: 400px;
      background: radial-gradient(circle, rgba(232,67,147,0.06) 0%, transparent 70%);
      bottom: -80px; left: -80px;
      z-index: 0; pointer-events: none;
    }

    .floaters {
      position: fixed; inset: 0;
      pointer-events: none; z-index: 0; overflow: hidden;
    }
    .floater {
      position: absolute;
      font-family: var(--font-display);
      color: rgba(255,255,255,0.015);
      animation: float linear infinite;
      user-select: none;
    }
    @keyframes float {
      from { transform: translateY(110vh) rotate(-10deg); }
      to   { transform: translateY(-10vh) rotate(10deg); }
    }

    /* ── Card ── */
    .card {
      position: relative; z-index: 1;
      background: var(--surface);
      border: 1px solid var(--border);
      width: 460px;
      clip-path: polygon(0 0, calc(100% - 24px) 0, 100% 24px, 100% 100%, 24px 100%, 0 calc(100% - 24px));
      box-shadow: 0 0 0 1px #1e1e2e, 0 32px 80px rgba(0,0,0,0.6), inset 0 1px 0 rgba(255,255,255,0.04);
      animation: slideUp 0.6s cubic-bezier(0.16, 1, 0.3, 1) both;
    }
    @keyframes slideUp {
      from { opacity: 0; transform: translateY(40px); }
      to   { opacity: 1; transform: translateY(0); }
    }

    .corner-deco {
      position: absolute; top: 0; right: 0;
      width: 24px; height: 24px;
      background: var(--accent);
      clip-path: polygon(0 0, 100% 0, 100% 100%);
    }

    /* ── Header ── */
    .card-header {
      padding: 28px 36px 20px;
      border-bottom: 1px solid var(--border);
      position: relative;
    }

    .badge {
      display: inline-flex; align-items: center; gap: 6px;
      font-size: 10px; letter-spacing: 0.15em;
      text-transform: uppercase; color: var(--accent);
      margin-bottom: 10px;
    }
    .badge::before {
      content: '';
      display: inline-block; width: 6px; height: 6px;
      background: var(--accent); border-radius: 50%;
      animation: pulse 2s ease-in-out infinite;
    }
    @keyframes pulse {
      0%, 100% { opacity: 1; transform: scale(1); }
      50%       { opacity: 0.4; transform: scale(0.7); }
    }

    .header-row {
      display: flex; align-items: flex-end;
      justify-content: space-between; gap: 12px;
    }

    h1 {
      font-family: var(--font-display);
      font-size: 48px; letter-spacing: 0.04em; line-height: 0.95;
    }
    h1 span { color: var(--accent); }

    .number-badge {
      font-family: var(--font-display);
      font-size: 72px; line-height: 1;
      color: var(--accent);
      opacity: 0.15;
      user-select: none;
    }

    /* ── Table ── */
    .card-body { padding: 24px 36px 32px; }

    .section-label {
      font-size: 10px; letter-spacing: 0.2em;
      text-transform: uppercase; color: var(--muted);
      margin-bottom: 14px; display: block;
    }

    .table-grid {
      display: flex; flex-direction: column; gap: 4px;
      margin-bottom: 28px;
      list-style: none;
    }

    .table-grid li {
      display: grid;
      grid-template-columns: 28px 1fr 1fr 1fr;
      align-items: center;
      gap: 0;
      background: var(--bg);
      border: 1px solid var(--border);
      padding: 10px 14px;
      font-size: 13px;
      transition: border-color 0.15s, background 0.15s;
      animation: rowIn 0.4s cubic-bezier(0.16,1,0.3,1) both;
    }
    .table-grid li:hover {
      border-color: var(--accent);
      background: rgba(247,201,72,0.04);
    }

    /* staggered row animation */
    <% for(int i=1;i<=10;i++){%>
    .table-grid li:nth-child(<%=i%>) { animation-delay: <%=(i*40)%>ms; }
    <% } %>

    @keyframes rowIn {
      from { opacity: 0; transform: translateX(-12px); }
      to   { opacity: 1; transform: translateX(0); }
    }

    .row-index {
      font-size: 10px; color: var(--muted);
      font-family: var(--font-mono);
    }
    .row-expr { color: var(--muted); }
    .row-eq   { color: var(--muted); text-align: center; }
    .row-result {
      font-family: var(--font-display);
      font-size: 20px; letter-spacing: 0.05em;
      color: var(--accent); text-align: right;
    }

    /* ── Back button ── */
    .btn-back {
      display: flex; align-items: center; gap: 10px;
      background: transparent;
      border: 1px solid var(--border);
      color: var(--text);
      font-family: var(--font-mono);
      font-size: 12px; letter-spacing: 0.1em;
      text-transform: uppercase;
      text-decoration: none;
      padding: 12px 20px;
      clip-path: polygon(0 0, calc(100% - 10px) 0, 100% 10px, 100% 100%, 10px 100%, 0 calc(100% - 10px));
      transition: border-color 0.2s, color 0.2s, background 0.2s;
    }
    .btn-back:hover {
      border-color: var(--accent);
      color: var(--accent);
      background: rgba(247,201,72,0.06);
    }
    .btn-back svg { transition: transform 0.2s; }
    .btn-back:hover svg { transform: translateX(-3px); }
  </style>
</head>
<body>
  <div class="orb2"></div>

  <div class="floaters">
    <span class="floater" style="left:5%;  animation-duration:18s; animation-delay:0s;   font-size:120px;">×</span>
    <span class="floater" style="left:20%; animation-duration:24s; animation-delay:-6s;  font-size:60px;">÷</span>
    <span class="floater" style="left:40%; animation-duration:20s; animation-delay:-12s; font-size:90px;">∑</span>
    <span class="floater" style="left:60%; animation-duration:16s; animation-delay:-3s;  font-size:70px;">×</span>
    <span class="floater" style="left:75%; animation-duration:22s; animation-delay:-9s;  font-size:100px;">∞</span>
    <span class="floater" style="left:88%; animation-duration:19s; animation-delay:-15s; font-size:65px;">÷</span>
  </div>

  <div class="card">
    <div class="corner-deco"></div>
    <div class="card-header">
      <div class="badge">Result · Table</div>
      <div class="header-row">
        <h1>TIMES<br/><span>TABLE</span></h1>
        <div class="number-badge"><jsp:getProperty name="calc" property="number" /></div>
      </div>
    </div>

    <div class="card-body">
      <span class="section-label">Multiplication sequence</span>
      <ul class="table-grid">
        <%
          List<String> results = calc.getTable();
          int i = 1;
          for (String row : results) {
            // Expected row format: "N × M = R"
            String[] parts = row.split("=");
            String expr = parts[0].trim();
            String result = parts.length > 1 ? parts[1].trim() : "";
        %>
        <li>
          <span class="row-index"><%=String.format("%02d", i++)%></span>
          <span class="row-expr"><%=expr%></span>
          <span class="row-eq">=</span>
          <span class="row-result"><%=result%></span>
        </li>
        <% } %>
      </ul>

      <a href="input.html" class="btn-back">
        <svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M9 2L4 7L9 12" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
        Back to Input
      </a>
    </div>
  </div>
</body>
</html>