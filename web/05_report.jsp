<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>File a Report ? Campus Lost &amp; Found Ledger</title>
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
    padding: 12px 0 14px; border-bottom: 1px solid var(--rule); margin-bottom: 48px;
    font-family: 'JetBrains Mono', monospace; font-size: 11px;
    text-transform: uppercase; letter-spacing: 0.14em;
  }
  nav.subnav a { text-decoration: none; color: var(--ink-2); padding-bottom: 3px; border-bottom: 1px solid transparent; }
  nav.subnav a:hover { color: var(--ink); }
  nav.subnav a.active { color: var(--ink); border-bottom-color: var(--accent); }
  nav.subnav .spacer { flex: 1; }
  nav.subnav .logout { color: var(--accent); }

  .report-grid {
    display: grid; grid-template-columns: 1.4fr 1fr; gap: 72px; align-items: start;
  }
  h1.page-title {
    font-family: 'Fraunces', serif; font-weight: 500;
    font-size: 56px; line-height: 1; letter-spacing: -0.025em; margin: 0 0 14px 0;
  }
  h1.page-title em { font-style: italic; font-weight: 400; color: var(--accent); }
  .page-lede {
    font-family: 'Fraunces', serif; font-style: italic; font-size: 18px;
    color: var(--ink-2); max-width: 50ch; margin: 0 0 36px 0;
  }
  .section-eyebrow {
    font-family: 'JetBrains Mono', monospace; font-size: 11px;
    letter-spacing: 0.16em; text-transform: uppercase; color: var(--ink-3);
    margin: 0 0 14px 0;
  }

  .type-toggle {
    display: grid; grid-template-columns: 1fr 1fr; gap: 12px; margin-bottom: 32px;
  }
  .type-toggle label {
    cursor: pointer; padding: 18px 20px;
    border: 1px solid var(--rule-2); background: transparent;
    display: flex; flex-direction: column; gap: 4px;
    transition: border-color 0.15s, background 0.15s;
  }
  .type-toggle label:hover { border-color: var(--ink); }
  .type-toggle label:has(input:checked) { border-color: var(--ink); background: var(--card); }
  .type-toggle input { display: none; }
  .type-toggle .t-eyebrow {
    font-family: 'JetBrains Mono', monospace; font-size: 10px;
    text-transform: uppercase; letter-spacing: 0.14em; color: var(--ink-3);
  }
  .type-toggle .t-label {
    font-family: 'Fraunces', serif; font-size: 22px; font-weight: 500; letter-spacing: -0.01em;
  }
  .type-toggle label:has(input:checked) .t-label { color: var(--accent); }

  form { display: flex; flex-direction: column; gap: 26px; }
  .form-grid {
    display: grid; grid-template-columns: 1fr 1fr; gap: 22px 28px;
  }
  .form-group { display: flex; flex-direction: column; gap: 8px; }
  .form-group.span-2 { grid-column: 1 / -1; }
  label.field-label, .field-label {
    font-family: 'JetBrains Mono', monospace; text-transform: uppercase;
    letter-spacing: 0.12em; font-size: 10.5px; color: var(--ink-3); font-weight: 500;
  }
  input[type=text], input[type=date], input[type=file], select, textarea {
    font: inherit; font-size: 15px; color: var(--ink);
    background: transparent; border: 0; border-bottom: 1px solid var(--ink-2);
    border-radius: 0; padding: 8px 2px; width: 100%; font-family: 'Inter', sans-serif;
  }
  textarea { resize: vertical; min-height: 96px; }
  input:focus, select:focus, textarea:focus { outline: none; border-bottom-color: var(--accent); }
  select {
    appearance: none; -webkit-appearance: none;
    background-image:
      linear-gradient(45deg, transparent 50%, var(--ink) 50%),
      linear-gradient(135deg, var(--ink) 50%, transparent 50%);
    background-position: calc(100% - 12px) 18px, calc(100% - 7px) 18px;
    background-size: 6px 6px, 6px 6px; background-repeat: no-repeat;
    padding-right: 28px;
  }
  input[type=file] { padding: 8px 0; font-family: 'JetBrains Mono', monospace; font-size: 12px; color: var(--ink-2); }

  .actions { display: flex; align-items: center; gap: 22px; margin-top: 18px; }
  button {
    font-family: 'JetBrains Mono', monospace; font-size: 12px; font-weight: 500;
    padding: 12px 22px; background: var(--ink); color: var(--paper);
    border: 1px solid var(--ink); cursor: pointer; border-radius: 0;
    text-transform: uppercase; letter-spacing: 0.14em;
    transition: background 0.15s, border-color 0.15s;
  }
  button:hover { background: var(--accent); border-color: var(--accent); }
  .cancel-link {
    color: var(--ink-3); text-decoration: underline; text-underline-offset: 3px;
    font-family: 'JetBrains Mono', monospace; font-size: 11px;
    text-transform: uppercase; letter-spacing: 0.12em;
  }
  .cancel-link:hover { color: var(--accent); }

  /* Right column guidance */
  .guidance {
    border-left: 1px solid var(--rule); padding-left: 40px;
    margin-top: 14px;
  }
  .guidance h3 {
    font-family: 'Fraunces', serif; font-weight: 500; font-size: 22px;
    letter-spacing: -0.01em; margin: 0 0 16px 0;
  }
  .guidance ol { padding-left: 0; list-style: none; counter-reset: step; margin: 0 0 28px 0; }
  .guidance ol li {
    counter-increment: step; padding: 14px 0 14px 36px;
    border-bottom: 1px solid var(--rule);
    position: relative; font-size: 14px; color: var(--ink-2);
  }
  .guidance ol li::before {
    content: counter(step, decimal-leading-zero);
    position: absolute; left: 0; top: 14px;
    font-family: 'JetBrains Mono', monospace; font-size: 11px;
    color: var(--accent); letter-spacing: 0.12em;
  }
  .guidance ol li b { color: var(--ink); font-weight: 600; }
  .callout {
    background: var(--card); border: 1px solid var(--rule);
    padding: 18px 20px; font-size: 13.5px; color: var(--ink-2);
    border-left: 3px solid var(--accent);
  }
  .callout .tag {
    font-family: 'JetBrains Mono', monospace; font-size: 10.5px;
    text-transform: uppercase; letter-spacing: 0.14em; color: var(--accent);
    margin-bottom: 6px; display: block;
  }

  @media (max-width: 900px) {
    .container { padding: 24px 22px 48px; }
    h1.page-title { font-size: 40px; }
    .report-grid { grid-template-columns: 1fr; gap: 40px; }
    .guidance { border-left: 0; border-top: 1px solid var(--rule); padding: 28px 0 0; }
    .form-grid { grid-template-columns: 1fr; }
    nav.subnav { flex-wrap: wrap; }
  }
</style>
</head>
<body>
<div class="container">
  <header class="masthead">
    <div class="title">Campus Lost <i>&amp;</i> Found Ledger</div>
    <div class="ref">File <b>05 / 06</b></div>
  </header>

  <nav class="subnav">
    <a href="03_dashboard.jsp">Dashboard</a>
    <a href="04_items.jsp">Items</a>
    <a href="05_report.jsp" class="active">File a report</a>
    <a href="06_admin.jsp">Admin</a>
    <span class="spacer"></span>
    <a href="LogoutServlet" class="logout">Sign out</a>
  </nav>

  <div class="report-grid">
    <section>
      <h1 class="page-title">File a new <em>entry</em>.</h1>
      <p class="page-lede">Two minutes of detail today saves a fellow student a week of looking. Be specific.</p>

      <p class="section-eyebrow">? Entry type</p>
      <div class="type-toggle">
        <label>
          <input type="radio" name="report_type" value="lost" checked>
          <span class="t-eyebrow">? 01</span>
          <span class="t-label">I lost something</span>
        </label>
        <label>
          <input type="radio" name="report_type" value="found">
          <span class="t-eyebrow">? 02</span>
          <span class="t-label">I found something</span>
        </label>
      </div>

      <form action="AddItemServlet" method="post" enctype="multipart/form-data">
        
        <div class="form-grid">
          <div class="form-group span-2">
            <label class="field-label" for="item_name">Item name</label>
            <input type="text" id="item_name" name="item_name" placeholder="Blue backpack, laptop, wallet?" required>
          </div>

          <div class="form-group">
            <label class="field-label" for="category">Category</label>
            <select id="category" name="category" required>
              <option>Accessories</option>
              <option>Electronics</option>
              <option>Clothing</option>
              <option>Documents</option>
              <option>Bags</option>
              <option>Other</option>
            </select>
          </div>

          <div class="form-group">
            <label class="field-label" for="date_lost_found">Date</label>
            <input type="date" id="date_lost_found" name="date_lost_found"required>
          </div>

          <div class="form-group span-2">
            <label class="field-label" for="description">Description</label>
            <textarea id="description" name="description" placeholder="Colour, size, distinguishing marks, contents?" required></textarea>
          </div>

          <div class="form-group">
            <label class="field-label" for="building">Building</label>
            <select id="building" name="building" required>
              <option>Cafeteria, Block C</option>
              <option>Library</option>
              <option>Lecture Hall, Block A</option>
              <option>Sports Complex</option>
              <option>Faculty of CS</option>
            </select>
          </div>

          <div class="form-group">
            <label class="field-label" for="specific_loc">Specific location</label>
            <input type="text" id="specific_loc" name="specific_loc" placeholder="Level 2, Room 204?">
          </div>

          <div class="form-group span-2">
            <label class="field-label" for="photo">Photo (optional)</label>
            <input type="file" id="photo" name="photo" accept="image/*">
          </div>
        </div>

        <div class="actions">
          <button type="submit">Submit entry ?</button>
          <a href="04_items.jsp" class="cancel-link">Cancel</a>
        </div>
      </form>
    </section>

    <aside class="guidance">
      <h3>How an entry travels.</h3>
      <ol>
        <li>You file the report ? <b>visible only to admins</b> at first.</li>
        <li>Security verifies and publishes it to the public ledger.</li>
        <li>Match notifications go to anyone with a matching entry.</li>
        <li>Claim is confirmed in person at the security desk.</li>
      </ol>
      <div class="callout">
        <span class="tag">Tip</span>
        Describe what only the owner would know: a sticker, a scratch, a name inside. It helps the verifier separate genuine claims from guesses.
      </div>
    </aside>
  </div>
</div>
</body>
</html>
