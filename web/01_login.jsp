<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sign In ? Campus Lost &amp; Found Ledger</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,400;0,9..144,500;0,9..144,600;1,9..144,400&family=Inter:wght@400;500;600&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
<style>
  :root {
    --paper: #FFF5F0;
    --paper-edge: #FFE8D6;
    --card: #FFFFFF;
    --ink: #2D2B55;
    --ink-2: #5C5A8A;
    --ink-3: #8E8B6A;
    --rule: #F0D9C4;
    --rule-2: #E0C4A8;
    --accent: #FF6B6B;
    --accent-ink: #5B4FCF;
    --accent-deep: #E05555;
    --accent-soft: #FF8E8E;
    --ok-bg: #E8F5E0;  --ok-fg: #2E7D32;
    --warn-bg: #FFF8E1; --warn-fg: #E67C00;
    --bad-bg: #FFE0E0; --bad-fg: #C62828;
    --info-bg: #EDE7F6; --info-fg: #5B4FCF;
  }
  * { box-sizing: border-box; }
  html, body { margin: 0; padding: 0; }
  body {
    font-family: 'Inter', system-ui, sans-serif;
    color: var(--ink);
    background:
      radial-gradient(circle at 15% -10%, #FFE8D6 0%, transparent 45%),
      radial-gradient(circle at 100% 100%, #F5D0B0 0%, transparent 50%),
      var(--paper);
    background-attachment: fixed;
    line-height: 1.55;
    font-size: 15px;
    -webkit-font-smoothing: antialiased;
  }
  .container { max-width: 1080px; margin: 0 auto; padding: 32px 48px 64px; min-height: 100vh; }
  .masthead {
    display: flex; align-items: baseline; justify-content: space-between;
    border-bottom: 2px solid var(--ink);
    padding-bottom: 14px; margin-bottom: 8px;
  }
  .masthead .title {
    font-family: 'Fraunces', serif; font-weight: 600;
    font-size: 28px; letter-spacing: -0.01em; line-height: 1;
  }
  .masthead .title i { font-style: italic; font-weight: 400; color: var(--accent); }
  .masthead .ref {
    font-family: 'JetBrains Mono', monospace; font-size: 11px;
    color: var(--ink-2); letter-spacing: 0.1em; text-transform: uppercase;
  }
  .masthead .ref b { color: var(--ink); }
  .submast {
    display: flex; justify-content: space-between; padding: 8px 0 28px;
    font-family: 'JetBrains Mono', monospace; font-size: 10.5px;
    letter-spacing: 0.14em; text-transform: uppercase; color: var(--ink-3);
    border-bottom: 1px solid var(--rule);
    margin-bottom: 48px;
  }

  h1.page-title {
    font-family: 'Fraunces', serif; font-weight: 500;
    font-size: 60px; line-height: 0.98; letter-spacing: -0.025em;
    margin: 0 0 14px 0;
  }
  h1.page-title em { font-style: italic; font-weight: 400; color: var(--accent); }
  .page-lede {
    font-family: 'Fraunces', serif; font-style: italic; font-size: 19px;
    color: var(--ink-2); max-width: 42ch; margin: 0 0 36px 0; line-height: 1.4;
  }

  .auth-grid {
    display: grid; grid-template-columns: 1.05fr 1fr;
    gap: 72px; align-items: start;
  }
  .auth-aside { border-left: 1px solid var(--rule); padding-left: 44px; padding-top: 8px; }
  .auth-aside .quote {
    font-family: 'Fraunces', serif; font-style: italic;
    font-size: 24px; line-height: 1.35; color: var(--ink); margin: 0 0 18px 0;
  }
  .auth-aside .quote::before { content: '\201C'; color: var(--accent); margin-right: 2px; }
  .auth-aside .quote::after { content: '\201D'; color: var(--accent); }
  .auth-aside .caption {
    font-family: 'JetBrains Mono', monospace; font-size: 10.5px;
    color: var(--ink-3); text-transform: uppercase; letter-spacing: 0.14em;
  }
  .stat-row {
    display: flex; gap: 36px; margin-top: 36px;
    padding-top: 24px; border-top: 1px solid var(--rule);
  }
  .stat-row .num { font-family: 'Fraunces', serif; font-size: 36px; font-weight: 500; line-height: 1; letter-spacing: -0.02em; }
  .stat-row .lbl { font-family: 'JetBrains Mono', monospace; text-transform: uppercase; font-size: 10px; letter-spacing: 0.14em; color: var(--ink-3); margin-top: 8px; }

  form { display: flex; flex-direction: column; gap: 22px; }
  .form-group { display: flex; flex-direction: column; gap: 8px; }
  label {
    font-family: 'JetBrains Mono', monospace; text-transform: uppercase;
    letter-spacing: 0.12em; font-size: 10.5px; color: var(--ink-3); font-weight: 500;
  }
  input[type=text], input[type=email], input[type=password], input[type=tel] {
    font: inherit; font-size: 16px; color: var(--ink);
    background: transparent; border: 0;
    border-bottom: 1px solid var(--ink-2);
    border-radius: 0; padding: 8px 2px; width: 100%;
  }
  input:focus { outline: none; border-bottom-color: var(--accent); }
  .role-select { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
  .role-select label {
    font-family: 'Inter', sans-serif; text-transform: none; letter-spacing: 0;
    font-size: 14px; color: var(--ink); cursor: pointer;
    padding: 12px 14px; border: 1px solid var(--rule-2);
    display: flex; align-items: center; gap: 10px;
    transition: border-color 0.15s, background 0.15s;
  }
  .role-select label:hover { border-color: var(--ink); }
  .role-select input { accent-color: var(--accent); }
  .role-select input:checked + span,
  .role-select label:has(input:checked) { border-color: var(--ink); background: var(--card); }

  button {
    font: inherit; font-size: 13px; font-weight: 500;
    padding: 12px 22px; background: var(--ink); color: var(--paper);
    border: 1px solid var(--ink); cursor: pointer; border-radius: 0;
    text-transform: uppercase; letter-spacing: 0.12em;
    font-family: 'JetBrains Mono', monospace;
    transition: background 0.15s, border-color 0.15s;
  }
  button:hover { background: var(--accent); border-color: var(--accent); }
  .links { margin-top: 26px; font-size: 13px; color: var(--ink-2); }
  .links a { color: var(--ink); text-decoration: underline; text-underline-offset: 3px; text-decoration-thickness: 1px; }
  .links a:hover { color: var(--accent); }

  @media (max-width: 800px) {
    .container { padding: 24px 22px 48px; }
    h1.page-title { font-size: 40px; }
    .auth-grid { grid-template-columns: 1fr; gap: 36px; }
    .auth-aside { border-left: 0; padding-left: 0; border-top: 1px solid var(--rule); padding-top: 28px; }
  }
</style>
</head>
<body>
<div class="container">
  <header class="masthead">
    <div class="title">Campus Lost <i>&amp;</i> Found Ledger</div>
    <div class="ref">Est. <b>2025</b> &nbsp;·&nbsp; File <b>01 / 06</b></div>
  </header>
  <div class="submast">
    <span>Volume I &nbsp;?&nbsp; Access &amp; Identity</span>
    <span>A community register</span>
  </div>

  <div class="auth-grid">
    <section>
      <h1 class="page-title">Sign in to <em>the ledger</em>.</h1>
      <p class="page-lede">Every wallet, headphone, &amp; ID card finds its way home through a verified record. Sign in to view yours.</p>

      <form action="LoginServlet" method="post">
        <div class="form-group">
          <label>Role</label>
          <div class="role-select">
            <label><input type="radio" name="role" value="student" checked> <span>Student</span></label>
            <label><input type="radio" name="role" value="admin"> <span>Security Admin</span></label>
          </div>
        </div>

        <div class="form-group">
          <label for="student_id">Student / Staff ID</label>
          <input type="text" id="student_id" name="student_id" placeholder="S12345678" required autocomplete="username">
        </div>

        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" placeholder="????????" required autocomplete="current-password">
        </div>

        <div style="margin-top: 6px;">
          <button type="submit">Sign In &nbsp;?</button>
        </div>
      </form>

      <div class="links">
        <div class="links">
        <a href="forgot_password.jsp">Forgot password?</a> &nbsp;&middot;&nbsp; New here? <a href="02_register.jsp">Create an account</a>
      </div>     </div>
    </section>

    <aside class="auth-aside">
      <p class="quote">A campus that returns what it finds is a campus that trusts itself.</p>
      <div class="caption">From the foreword &nbsp;·&nbsp; Office of Student Affairs</div>
      <div class="stat-row">
        <div>
          <div class="num">1,248</div>
          <div class="lbl">Items logged</div>
        </div>
        <div>
          <div class="num">84<span style="font-size:18px;color:var(--ink-3)">%</span></div>
          <div class="lbl">Returned to owner</div>
        </div>
        <div>
          <div class="num">48<span style="font-size:18px;color:var(--ink-3)">h</span></div>
          <div class="lbl">Median recovery</div>
        </div>
      </div>
    </aside>
  </div>
</div>
</body>
</html>
