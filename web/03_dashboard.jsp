<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard ? Campus Lost &amp; Found Ledger</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,400;0,9..144,500;0,9..144,600;1,9..144,400&family=Inter:wght@400;500;600&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
<style>
  :root {
    --paper: #f4efe4;
    --paper-deep: #ede6d3;
    --card: #fbf8ef;
    --ink: #181715;
    --ink-2: #4a463f;
    --ink-3: #8a857a;
    --rule: #d6cfbe;
    --rule-2: #c5bca6;
    --accent: #8b2e2a;
    --accent-deep: #6e2421;
    --accent-soft: #b85651;
    --ok-bg: #dbe5c4;  --ok-fg: #2f4419;
    --warn-bg:#eedeb0; --warn-fg:#5a4109;
    --bad-bg: #ebcec8; --bad-fg: #5f1f1b;
    --info-bg:#d2dae3; --info-fg:#1a3349;
  }
  * { box-sizing: border-box; }
  html { scroll-behavior: smooth; }
  html, body { margin: 0; padding: 0; }

  body {
    font-family: 'Inter', system-ui, sans-serif;
    color: var(--ink);
    background:
      radial-gradient(circle at 15% -10%, #ece5d2 0%, transparent 45%),
      radial-gradient(circle at 100% 100%, #e8e0cc 0%, transparent 50%),
      var(--paper);
    background-attachment: fixed;
    line-height: 1.55;
    font-size: 15px;
    -webkit-font-smoothing: antialiased;
    position: relative;
  }

  body::before {
    content: '';
    position: fixed; inset: 0;
    background-image:
      radial-gradient(circle at 20% 30%, rgba(20, 15, 5, 0.012) 0.5px, transparent 1px),
      radial-gradient(circle at 70% 80%, rgba(20, 15, 5, 0.015) 0.5px, transparent 1px);
    background-size: 4px 4px, 6px 6px;
    pointer-events: none;
    z-index: 1;
  }

  .container {
    max-width: 1080px; margin: 0 auto;
    padding: 32px 48px 64px; min-height: 100vh;
    position: relative; z-index: 2;
    animation: fadeUp 0.7s ease-out;
  }

  @keyframes fadeUp {
    from { opacity: 0; transform: translateY(12px); }
    to   { opacity: 1; transform: translateY(0); }
  }

  @keyframes fadeIn {
    from { opacity: 0; }
    to   { opacity: 1; }
  }

  @keyframes slideUp {
    from { opacity: 0; transform: translateY(8px); }
    to   { opacity: 1; transform: translateY(0); }
  }

  .masthead {
    display: flex; align-items: baseline; justify-content: space-between;
    border-bottom: 2px solid var(--ink); padding-bottom: 14px;
  }
  .masthead .title {
    font-family: 'Fraunces', serif; font-weight: 600;
    font-size: 28px; letter-spacing: -0.01em; line-height: 1;
  }
  .masthead .title i {
    font-style: italic; font-weight: 400; color: var(--accent);
    transition: color 0.3s ease;
    display: inline-block;
  }
  .masthead .title:hover i { color: var(--accent-soft); transform: scale(1.05); }
  .masthead .ref {
    font-family: 'JetBrains Mono', monospace; font-size: 11px;
    color: var(--ink-2); letter-spacing: 0.1em; text-transform: uppercase;
  }
  .masthead .ref b { color: var(--ink); }

  nav.subnav {
    display: flex; gap: 26px; align-items: center;
    padding: 12px 0 14px;
    border-bottom: 1px solid var(--rule);
    margin-bottom: 40px;
    font-family: 'JetBrains Mono', monospace;
    font-size: 11px; text-transform: uppercase; letter-spacing: 0.14em;
  }
  nav.subnav a {
    text-decoration: none; color: var(--ink-2);
    padding-bottom: 3px;
    position: relative;
    transition: color 0.25s ease;
  }
  nav.subnav a::after {
    content: '';
    position: absolute; left: 0; bottom: 0;
    height: 1px; width: 0;
    background: var(--accent);
    transition: width 0.25s ease;
  }
  nav.subnav a:hover { color: var(--ink); }
  nav.subnav a:hover::after { width: 100%; }
  nav.subnav a.active { color: var(--ink); }
  nav.subnav a.active::after { width: 100%; }
  nav.subnav .spacer { flex: 1; }
  nav.subnav .logout { color: var(--accent); }
  nav.subnav .logout::after { background: var(--accent); }

  .header-row {
    display: flex; align-items: end; justify-content: space-between;
    gap: 24px; margin-bottom: 8px;
    animation: slideUp 0.6s ease-out 0.1s backwards;
  }
  h1.page-title {
    font-family: 'Fraunces', serif; font-weight: 500;
    font-size: 56px; line-height: 1; letter-spacing: -0.025em; margin: 0;
  }
  h1.page-title em {
    font-style: italic; font-weight: 400; color: var(--accent);
    transition: color 0.4s ease;
  }
  h1.page-title:hover em { color: var(--accent-soft); }

  .page-lede {
    font-family: 'Fraunces', serif; font-style: italic; font-size: 18px;
    color: var(--ink-2); max-width: 56ch; margin: 14px 0 36px 0;
    animation: slideUp 0.6s ease-out 0.2s backwards;
  }

  .kpi-strip {
    display: grid; grid-template-columns: repeat(4, 1fr); gap: 0;
    border-top: 1px solid var(--ink); border-bottom: 1px solid var(--ink);
    padding: 24px 0; margin-bottom: 56px;
    animation: slideUp 0.6s ease-out 0.3s backwards;
  }
  .kpi-cell {
    padding: 0 26px;
    border-right: 1px solid var(--rule);
    transition: background 0.25s ease;
    cursor: default;
  }
  .kpi-cell:hover {
    background: rgba(139, 46, 42, 0.025);
  }
  .kpi-cell:first-child { padding-left: 0; }
  .kpi-cell:last-child { border-right: 0; padding-right: 0; }
  .kpi-cell .label {
    font-family: 'JetBrains Mono', monospace; text-transform: uppercase;
    font-size: 10px; letter-spacing: 0.14em; color: var(--ink-3); margin-bottom: 12px;
  }
  .kpi-cell .value {
    font-family: 'Fraunces', serif; font-weight: 500;
    font-size: 46px; line-height: 1; letter-spacing: -0.025em;
    transition: color 0.25s ease;
  }
  .kpi-cell:hover .value { color: var(--accent-deep); }
  .kpi-cell .value .unit {
    font-family: 'Inter', sans-serif; font-size: 16px;
    color: var(--ink-3); font-weight: 500; margin-left: 4px;
  }
  .kpi-cell .delta {
    font-family: 'JetBrains Mono', monospace; font-size: 10.5px;
    margin-top: 10px; color: var(--ink-3); letter-spacing: 0.06em;
    display: inline-flex; align-items: center; gap: 4px;
  }
  .kpi-cell .delta.up { color: var(--ok-fg); }
  .kpi-cell .delta.down { color: var(--bad-fg); }

  .section-eyebrow {
    font-family: 'JetBrains Mono', monospace; font-size: 11px;
    letter-spacing: 0.16em; text-transform: uppercase; color: var(--ink-3);
    margin: 0 0 12px 0; display: flex; align-items: center; gap: 12px;
    animation: slideUp 0.6s ease-out 0.4s backwards;
  }
  .section-eyebrow::before {
    content: ''; width: 24px; height: 1px; background: var(--ink-3);
    transition: width 0.4s ease, background 0.4s ease;
  }
  .section-eyebrow:hover::before { width: 36px; background: var(--accent); }

  h2 {
    font-family: 'Fraunces', serif; font-weight: 500; font-size: 30px;
    letter-spacing: -0.015em; margin: 0 0 22px 0;
    animation: slideUp 0.6s ease-out 0.45s backwards;
  }

  table {
    width: 100%; border-collapse: collapse; margin-bottom: 20px;
    font-size: 14px;
    animation: fadeIn 0.6s ease-out 0.5s backwards;
  }
  th {
    text-align: left; font-weight: 500;
    text-transform: uppercase; letter-spacing: 0.12em; font-size: 10.5px;
    color: var(--ink-3); padding: 10px 14px 12px 0;
    border-bottom: 2px solid var(--ink);
    font-family: 'JetBrains Mono', monospace;
  }
  td {
    padding: 16px 14px 16px 0; border-bottom: 1px solid var(--rule);
    vertical-align: middle;
    transition: background 0.2s ease;
  }
  tbody tr {
    animation: slideUp 0.5s ease-out backwards;
  }
  tbody tr:nth-child(1) { animation-delay: 0.55s; }
  tbody tr:nth-child(2) { animation-delay: 0.62s; }
  tbody tr:nth-child(3) { animation-delay: 0.69s; }
  tbody tr:nth-child(4) { animation-delay: 0.76s; }

  tbody tr:hover td {
    background: rgba(139, 46, 42, 0.04);
  }
  tbody tr:hover td:first-child {
    box-shadow: inset 3px 0 0 var(--accent);
  }

  td.mono, .mono {
    font-family: 'JetBrains Mono', monospace; font-size: 12.5px;
    color: var(--ink-2);
  }
  .item-name { font-weight: 500; }
  .item-id {
    font-family: 'JetBrains Mono', monospace; font-size: 11px;
    color: var(--ink-3); margin-top: 2px;
    letter-spacing: 0.05em; text-transform: uppercase;
  }

  .badge {
    display: inline-flex; align-items: center; gap: 7px;
    padding: 4px 11px 4px 10px; font-size: 10.5px; font-weight: 600;
    text-transform: uppercase; letter-spacing: 0.1em;
    font-family: 'JetBrains Mono', monospace;
    border: 1px solid rgba(0,0,0,0.08); border-radius: 0;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
  }
  .badge:hover {
    transform: translateY(-1px);
    box-shadow: 0 2px 6px rgba(20, 15, 5, 0.08);
  }
  .badge::before {
    content: ''; width: 6px; height: 6px; border-radius: 50%;
    background: currentColor;
    box-shadow: 0 0 0 2px rgba(255,255,255,0.4);
  }
  .badge.lost     { background: var(--bad-bg);  color: var(--bad-fg);  }
  .badge.found    { background: var(--ok-bg);   color: var(--ok-fg);   }
  .badge.returned { background: var(--info-bg); color: var(--info-fg); }
  .badge.pending  { background: var(--warn-bg); color: var(--warn-fg); }

  .badge.lost::before {
    animation: pulse 2.5s ease-in-out infinite;
  }
  @keyframes pulse {
    0%, 100% { box-shadow: 0 0 0 2px rgba(255,255,255,0.4); }
    50%      { box-shadow: 0 0 0 2px rgba(255,255,255,0.4), 0 0 0 6px rgba(110, 37, 33, 0.15); }
  }

  a.row-action {
    font-family: 'JetBrains Mono', monospace;
    text-transform: uppercase; letter-spacing: 0.12em; font-size: 11px;
    color: var(--ink); text-decoration: none;
    border-bottom: 1px solid var(--ink);
    padding-bottom: 2px;
    display: inline-flex; align-items: center; gap: 4px;
    transition: color 0.2s ease, border-color 0.2s ease, gap 0.2s ease;
  }
  a.row-action:hover {
    color: var(--accent); border-bottom-color: var(--accent);
    gap: 8px;
  }

  button, a.btn {
    font-family: 'JetBrains Mono', monospace; font-size: 12px; font-weight: 500;
    padding: 12px 22px; background: var(--ink); color: var(--paper);
    border: 1px solid var(--ink); cursor: pointer; border-radius: 0;
    text-transform: uppercase; letter-spacing: 0.14em; text-decoration: none;
    display: inline-block;
    transition: background 0.2s ease, border-color 0.2s ease, transform 0.2s ease, box-shadow 0.2s ease;
    position: relative;
  }
  button:hover, a.btn:hover {
    background: var(--accent); border-color: var(--accent);
    transform: translateY(-1px);
    box-shadow: 0 6px 16px rgba(139, 46, 42, 0.2);
  }
  button:active, a.btn:active {
    transform: translateY(0);
  }

  .footer-link {
    font-family: 'JetBrains Mono', monospace;
    text-transform: uppercase; letter-spacing: 0.14em; font-size: 11px;
    color: var(--ink); text-decoration: none;
    border-bottom: 1px solid var(--ink); padding-bottom: 2px;
    display: inline-flex; align-items: center; gap: 6px;
    margin-top: 8px;
    transition: color 0.2s ease, border-color 0.2s ease, gap 0.2s ease;
  }
  .footer-link:hover {
    color: var(--accent); border-bottom-color: var(--accent);
    gap: 10px;
  }

  @media (max-width: 900px) {
    .container { padding: 24px 22px 48px; }
    h1.page-title { font-size: 40px; }
    .kpi-strip { grid-template-columns: repeat(2, 1fr); row-gap: 24px; }
    .kpi-cell { border-right: 0; padding: 0 16px; }
    .kpi-cell:nth-child(odd) { padding-left: 0; }
    nav.subnav { flex-wrap: wrap; }
  }
</style>
</head>
<body>
<div class="container">
  <header class="masthead">
    <div class="title">Campus Lost <i>&amp;</i> Found Ledger</div>
    <div class="ref">Today <b>21 May 2026</b> &nbsp;�&nbsp; File <b>03 / 06</b></div>
  </header>

  <nav class="subnav">
    <a href="03_dashboard.jsp" class="active">Dashboard</a>
    <a href="04_items.jsp">Items</a>
    <a href="05_report.jsp">File a report</a>
    <a href="06_admin.jsp">Admin</a>
    <span class="spacer"></span>
    <a href="LogoutServlet" class="logout">Sign out</a>
  </nav>

  <div class="header-row">
    <div>
      <h1 class="page-title">The <em>Ledger</em>, today.</h1>
      <p class="page-lede">A daily reading of items lost, found, returned. Numbers reflect the last 30 days unless noted.</p>
    </div>
    <a href="05_report.jsp" class="btn">+ File a report</a>
  </div>

  <section class="kpi-strip">
    <div class="kpi-cell">
      <div class="label">Items logged</div>
      <div class="value" data-count="1248">0</div>
      <div class="delta up">? 6.1% vs. prev</div>
    </div>
    <div class="kpi-cell">
      <div class="label">Currently lost</div>
      <div class="value" data-count="142">0</div>
      <div class="delta down">? 3.4% vs. prev</div>
    </div>
    <div class="kpi-cell">
      <div class="label">Return rate</div>
      <div class="value"><span data-count="84">0</span><span class="unit">%</span></div>
      <div class="delta up">? 2.0 pts</div>
    </div>
    <div class="kpi-cell">
      <div class="label">Median recovery</div>
      <div class="value"><span data-count="48">0</span><span class="unit">h</span></div>
      <div class="delta">? steady</div>
    </div>
  </section>

  <p class="section-eyebrow">Recent entries</p>
  <h2>What the campus reported this week.</h2>

  <table>
    <thead>
      <tr>
        <th>Item</th>
        <th>Category</th>
        <th>Location</th>
        <th>Date</th>
        <th>Status</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>
          <div class="item-name">MacBook Air, silver</div>
          <div class="item-id">REF � LF-1248</div>
        </td>
        <td class="mono">Electronics</td>
        <td>Library, Level 2</td>
        <td class="mono">18 Jun 2025</td>
        <td><span class="badge found">Found</span></td>
        <td><a href="04_items.jsp" class="row-action">Claim ?</a></td>
      </tr>
      <tr>
        <td>
          <div class="item-name">Black leather wallet</div>
          <div class="item-id">REF � LF-1247</div>
        </td>
        <td class="mono">Accessories</td>
        <td>Cafeteria, Block C</td>
        <td class="mono">17 Jun 2025</td>
        <td><span class="badge lost">Lost</span></td>
        <td><a href="04_items.html" class="row-action">View ?</a></td>
      </tr>
      <tr>
        <td>
          <div class="item-name">Sony WH-1000 headphones</div>
          <div class="item-id">REF � LF-1246</div>
        </td>
        <td class="mono">Electronics</td>
        <td>Lecture Hall A3</td>
        <td class="mono">16 Jun 2025</td>
        <td><span class="badge returned">Returned</span></td>
        <td><a href="04_items.html" class="row-action">View ?</a></td>
      </tr>
      <tr>
        <td>
          <div class="item-name">Student ID card</div>
          <div class="item-id">REF � LF-1245</div>
        </td>
        <td class="mono">Documents</td>
        <td>Main Entrance Gate</td>
        <td class="mono">15 Jun 2025</td>
        <td><span class="badge pending">Pending</span></td>
        <td><a href="04_items.html" class="row-action">View ?</a></td>
      </tr>
    </tbody>
  </table>

  <a href="04_items.html" class="footer-link">Browse the full ledger ?</a>
</div>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    const counters = document.querySelectorAll('[data-count]');

    const animateCount = (el, target, duration = 1400) => {
      const startTime = performance.now();
      const isLarge = target > 200;

      const step = (now) => {
        const elapsed = now - startTime;
        const progress = Math.min(elapsed / duration, 1);
        const eased = 1 - Math.pow(1 - progress, 3);
        const current = Math.floor(target * eased);
        el.textContent = isLarge ? current.toLocaleString() : current;
        if (progress < 1) requestAnimationFrame(step);
        else el.textContent = isLarge ? target.toLocaleString() : target;
      };

      setTimeout(() => requestAnimationFrame(step), 400);
    };

    counters.forEach(el => {
      const target = parseInt(el.getAttribute('data-count'), 10);
      animateCount(el, target);
    });
  });
</script>
</body>
</html>
