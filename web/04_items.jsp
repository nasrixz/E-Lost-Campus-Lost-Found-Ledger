<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Items ? Campus Lost &amp; Found Ledger</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,400;0,9..144,500;0,9..144,600;1,9..144,400&family=Inter:wght@400;500;600&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
<style>
  :root {
    --paper: #f4efe4;
    --card: #fbf8ef;
    --ink: #181715;
    --ink-2: #4a463f;
    --ink-3: #8a857a;
    --rule: #d6cfbe;
    --rule-2: #c5bca6;
    --accent: #8b2e2a;
    --ok-bg: #e6ecd9;  --ok-fg: #3b5021;
    --warn-bg:#f1e6c4; --warn-fg:#6b4f12;
    --bad-bg: #efd9d4; --bad-fg: #6e2521;
    --info-bg:#dde3ea; --info-fg:#1f3a55;
  }
  * { box-sizing: border-box; }
  html, body { margin: 0; padding: 0; }
  body {
    font-family: 'Inter', system-ui, sans-serif; color: var(--ink);
    background:
      radial-gradient(circle at 15% -10%, #ece5d2 0%, transparent 45%),
      radial-gradient(circle at 100% 100%, #e8e0cc 0%, transparent 50%),
      var(--paper);
    background-attachment: fixed; line-height: 1.55; font-size: 15px;
    -webkit-font-smoothing: antialiased;
  }
  .container { max-width: 1080px; margin: 0 auto; padding: 32px 48px 64px; min-height: 100vh; }
  .masthead {
    display: flex; align-items: baseline; justify-content: space-between;
    border-bottom: 2px solid var(--ink); padding-bottom: 14px;
  }
  .masthead .title { font-family: 'Fraunces', serif; font-weight: 600; font-size: 28px; letter-spacing: -0.01em; line-height: 1; }
  .masthead .title i { font-style: italic; font-weight: 400; color: var(--accent); }
  .masthead .ref { font-family: 'JetBrains Mono', monospace; font-size: 11px; color: var(--ink-2); letter-spacing: 0.1em; text-transform: uppercase; }
  .masthead .ref b { color: var(--ink); }

  nav.subnav {
    display: flex; gap: 26px; align-items: center;
    padding: 12px 0 14px; border-bottom: 1px solid var(--rule); margin-bottom: 40px;
    font-family: 'JetBrains Mono', monospace; font-size: 11px;
    text-transform: uppercase; letter-spacing: 0.14em;
  }
  nav.subnav a { text-decoration: none; color: var(--ink-2); padding-bottom: 3px; border-bottom: 1px solid transparent; }
  nav.subnav a:hover { color: var(--ink); }
  nav.subnav a.active { color: var(--ink); border-bottom-color: var(--accent); }
  nav.subnav .spacer { flex: 1; }
  nav.subnav .logout { color: var(--accent); }

  .header-row {
    display: flex; align-items: end; justify-content: space-between; gap: 24px;
    margin-bottom: 10px;
  }
  h1.page-title {
    font-family: 'Fraunces', serif; font-weight: 500;
    font-size: 56px; line-height: 1; letter-spacing: -0.025em; margin: 0;
  }
  h1.page-title em { font-style: italic; font-weight: 400; color: var(--accent); }
  .page-lede {
    font-family: 'Fraunces', serif; font-style: italic; font-size: 18px;
    color: var(--ink-2); max-width: 60ch; margin: 14px 0 32px 0;
  }
  .result-count {
    font-family: 'JetBrains Mono', monospace; font-size: 11px;
    color: var(--ink-3); text-transform: uppercase; letter-spacing: 0.14em;
  }
  .result-count b { color: var(--ink); }

  .filter-bar {
    display: grid; grid-template-columns: 2fr 1fr 1fr 1fr;
    gap: 22px; align-items: end;
    padding: 22px 0; border-top: 1px solid var(--ink); border-bottom: 1px solid var(--rule);
    margin-bottom: 22px;
  }
  .field { display: flex; flex-direction: column; gap: 6px; }
  .field label {
    font-family: 'JetBrains Mono', monospace; text-transform: uppercase;
    letter-spacing: 0.12em; font-size: 10px; color: var(--ink-3); font-weight: 500;
  }
  input[type=text], select {
    font: inherit; font-size: 14.5px; color: var(--ink);
    background: transparent; border: 0; border-bottom: 1px solid var(--ink-2);
    border-radius: 0; padding: 6px 2px; width: 100%; font-family: 'Inter', sans-serif;
  }
  input:focus, select:focus { outline: none; border-bottom-color: var(--accent); }
  select {
    appearance: none; -webkit-appearance: none;
    background-image:
      linear-gradient(45deg, transparent 50%, var(--ink) 50%),
      linear-gradient(135deg, var(--ink) 50%, transparent 50%);
    background-position: calc(100% - 12px) 14px, calc(100% - 7px) 14px;
    background-size: 6px 6px, 6px 6px; background-repeat: no-repeat;
    padding-right: 26px;
  }

  table { width: 100%; border-collapse: collapse; margin-bottom: 12px; font-size: 14px; }
  th {
    text-align: left; font-weight: 500;
    text-transform: uppercase; letter-spacing: 0.12em; font-size: 10.5px;
    color: var(--ink-3); padding: 14px 14px 12px 0;
    border-bottom: 2px solid var(--ink);
    font-family: 'JetBrains Mono', monospace;
  }
  td { padding: 16px 14px 16px 0; border-bottom: 1px solid var(--rule); vertical-align: middle; }
  td.mono, .mono { font-family: 'JetBrains Mono', monospace; font-size: 12.5px; color: var(--ink-2); }
  tr:hover td { background: rgba(0,0,0,0.018); }
  .item-name { font-weight: 500; }
  .item-id { font-family: 'JetBrains Mono', monospace; font-size: 11px; color: var(--ink-3); margin-top: 2px; letter-spacing: 0.05em; text-transform: uppercase; }

  .badge {
    display: inline-flex; align-items: center; gap: 7px;
    padding: 3px 10px 3px 9px; font-size: 10.5px; font-weight: 600;
    text-transform: uppercase; letter-spacing: 0.1em;
    font-family: 'JetBrains Mono', monospace;
    border: 1px solid rgba(0,0,0,0.08); border-radius: 0;
  }
  .badge::before { content: ''; width: 6px; height: 6px; border-radius: 50%; background: currentColor; }
  .badge.lost     { background: var(--bad-bg);  color: var(--bad-fg);  }
  .badge.found    { background: var(--ok-bg);   color: var(--ok-fg);   }
  .badge.returned { background: var(--info-bg); color: var(--info-fg); }
  .badge.pending  { background: var(--warn-bg); color: var(--warn-fg); }

  .row-actions { display: flex; gap: 16px; }
  .row-action {
    font-family: 'JetBrains Mono', monospace;
    text-transform: uppercase; letter-spacing: 0.12em; font-size: 11px;
    color: var(--ink); text-decoration: none; border-bottom: 1px solid var(--ink);
    padding-bottom: 2px; background: none; border-top: 0; border-left: 0; border-right: 0; cursor: pointer;
  }
  .row-action:hover { color: var(--accent); border-bottom-color: var(--accent); }
  .row-action.muted { color: var(--ink-3); border-bottom-color: var(--rule-2); }
  .row-action.muted:hover { color: var(--accent); border-bottom-color: var(--accent); }

  button.primary, a.btn {
    font-family: 'JetBrains Mono', monospace; font-size: 12px; font-weight: 500;
    padding: 11px 20px; background: var(--ink); color: var(--paper);
    border: 1px solid var(--ink); cursor: pointer; border-radius: 0;
    text-transform: uppercase; letter-spacing: 0.14em; text-decoration: none;
    display: inline-block; transition: background 0.15s, border-color 0.15s;
  }
  button.primary:hover, a.btn:hover { background: var(--accent); border-color: var(--accent); }

  .pagination {
    display: flex; justify-content: space-between; align-items: center;
    padding: 22px 0; border-top: 1px solid var(--rule);
  }
  .pagination .info {
    font-family: 'JetBrains Mono', monospace; font-size: 11px;
    color: var(--ink-3); text-transform: uppercase; letter-spacing: 0.14em;
  }
  .pagination .info b { color: var(--ink); }
  .page-nav { display: flex; gap: 12px; }
  .page-nav .row-action { background: none; }

  @media (max-width: 900px) {
    .container { padding: 24px 22px 48px; }
    h1.page-title { font-size: 40px; }
    .filter-bar { grid-template-columns: 1fr 1fr; }
    nav.subnav { flex-wrap: wrap; }
  }
</style>
</head>
<body>
<div class="container">
  <header class="masthead">
    <div class="title">Campus Lost <i>&amp;</i> Found Ledger</div>
    <div class="ref">File <b>04 / 06</b></div>
  </header>

  <nav class="subnav">
    <a href="03_dashboard.jsp">Dashboard</a>
    <a href="04_items.jsp" class="active">Items</a>
    <a href="05_report.jsp">File a report</a>
    <a href="06_admin.jsp">Admin</a>
    <span class="spacer"></span>
    <a href="LogoutServlet" class="logout">Sign out</a>
  </nav>

  <div class="header-row">
    <div>
      <h1 class="page-title">The <em>index</em>.</h1>
      <p class="page-lede">Every entry on record ? lost, found, claimed, returned. Search, filter, and verify before you reach out.</p>
    </div>
    <a href="05_report.jsp" class="btn">+ File a report</a>
  </div>

  <div class="result-count"><b>248</b> entries &nbsp;·&nbsp; updated <b>21 May 2026, 09:14</b></div>

  <div class="filter-bar">
    <div class="field">
      <label>Search</label>
      <input type="text" placeholder="Name, location, reference?">
    </div>
    <div class="field">
      <label>Category</label>
      <select>
        <option>All</option>
        <option>Electronics</option>
        <option>Clothing</option>
        <option>Accessories</option>
        <option>Documents</option>
      </select>
    </div>
    <div class="field">
      <label>Status</label>
      <select>
        <option>All</option>
        <option>Lost</option>
        <option>Found</option>
        <option>Returned</option>
        <option>Pending</option>
      </select>
    </div>
    <div class="field">
      <label>Sort by</label>
      <select>
        <option>Most recent</option>
        <option>Oldest first</option>
        <option>Status</option>
      </select>
    </div>
  </div>

  <table>
    <thead>
      <tr>
        <th style="width: 32%;">Item</th>
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
          <div class="item-id">REF · LF-1248</div>
        </td>
        <td class="mono">Electronics</td>
        <td>Library, Level 2</td>
        <td class="mono">18 Jun 2025</td>
        <td><span class="badge found">Found</span></td>
        <td>
          <div class="row-actions">
            <button class="row-action" type="button">View</button>
            <button class="row-action" type="button">Claim</button>
          </div>
        </td>
      </tr>
      <tr>
        <td>
          <div class="item-name">Black leather wallet</div>
          <div class="item-id">REF · LF-1247</div>
        </td>
        <td class="mono">Accessories</td>
        <td>Cafeteria, Block C</td>
        <td class="mono">17 Jun 2025</td>
        <td><span class="badge lost">Lost</span></td>
        <td>
          <div class="row-actions">
            <button class="row-action">View</button>
          </div>
        </td>
      </tr>
      <tr>
        <td>
          <div class="item-name">Sony WH-1000 headphones</div>
          <div class="item-id">REF · LF-1246</div>
        </td>
        <td class="mono">Electronics</td>
        <td>Lecture Hall A3</td>
        <td class="mono">16 Jun 2025</td>
        <td><span class="badge returned">Returned</span></td>
        <td>
          <div class="row-actions">
            <button class="row-action muted" type="button">View</button>
          </div>
        </td>
      </tr>
      <tr>
        <td>
          <div class="item-name">Student ID card</div>
          <div class="item-id">REF · LF-1245</div>
        </td>
        <td class="mono">Documents</td>
        <td>Main Entrance Gate</td>
        <td class="mono">15 Jun 2025</td>
        <td><span class="badge pending">Pending</span></td>
        <td>
          <div class="row-actions">
            <button class="row-action">View</button>
            <button class="row-action">Claim</button>
          </div>
        </td>
      </tr>
      <tr>
        <td>
          <div class="item-name">Blue Adidas cap</div>
          <div class="item-id">REF · LF-1244</div>
        </td>
        <td class="mono">Clothing</td>
        <td>Sports Complex</td>
        <td class="mono">14 Jun 2025</td>
        <td><span class="badge found">Found</span></td>
        <td>
          <div class="row-actions">
            <button class="row-action">View</button>
            <button class="row-action">Claim</button>
          </div>
        </td>
      </tr>
      <tr>
        <td>
          <div class="item-name">Black backpack</div>
          <div class="item-id">REF · LF-1243</div>
        </td>
        <td class="mono">Accessories</td>
        <td>Faculty of CS</td>
        <td class="mono">13 Jun 2025</td>
        <td><span class="badge lost">Lost</span></td>
        <td>
          <div class="row-actions">
            <button class="row-action">View</button>
          </div>
        </td>
      </tr>
    </tbody>
  </table>

  <div class="pagination">
    <div class="info">Page <b>1</b> of <b>4</b> &nbsp;·&nbsp; showing 6 of 248</div>
    <div class="page-nav">
    <button class="row-action muted" type="button">? Prev</button>
      <button class="row-action" type="button">Next ?</button>
    </div>
  </div>
</div>
</body>
</html>