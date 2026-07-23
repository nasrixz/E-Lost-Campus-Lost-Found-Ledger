<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Reset Password &bull; Campus Lost &amp; Found Ledger</title>
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
    font-family: 'Inter', system-ui, sans-serif; color: var(--ink);
    background:
      radial-gradient(circle at 15% -10%, #FFE8D6 0%, transparent 45%),
      radial-gradient(circle at 100% 100%, #F5D0B0 0%, transparent 50%),
      var(--paper);
    background-attachment: fixed; line-height: 1.55; font-size: 15px;
    -webkit-font-smoothing: antialiased;
  }
  .container { max-width: 1080px; margin: 0 auto; padding: 32px 48px 64px; min-height: 100vh; }
  .masthead {
    display: flex; align-items: baseline; justify-content: space-between;
    border-bottom: 2px solid var(--ink); padding-bottom: 14px; margin-bottom: 8px;
  }
  .masthead .title { font-family: 'Fraunces', serif; font-weight: 600; font-size: 28px; letter-spacing: -0.01em; line-height: 1; }
  .masthead .title i { font-style: italic; font-weight: 400; color: var(--accent); }
  .masthead .ref { font-family: 'JetBrains Mono', monospace; font-size: 11px; color: var(--ink-2); letter-spacing: 0.1em; text-transform: uppercase; }
  .masthead .ref b { color: var(--ink); }
  .submast {
    display: flex; justify-content: space-between; padding: 8px 0 28px;
    font-family: 'JetBrains Mono', monospace; font-size: 10.5px;
    letter-spacing: 0.14em; text-transform: uppercase; color: var(--ink-3);
    border-bottom: 1px solid var(--rule); margin-bottom: 40px;
  }
  .back-link {
    font-family: 'JetBrains Mono', monospace; text-transform: uppercase;
    letter-spacing: 0.12em; font-size: 11px; color: var(--ink-2);
    text-decoration: none; margin-bottom: 18px; display: inline-block;
  }
  .back-link:hover { color: var(--accent); }
  h1.page-title {
    font-family: 'Fraunces', serif; font-weight: 500;
    font-size: 52px; line-height: 1; letter-spacing: -0.025em; margin: 0 0 12px 0;
  }
  h1.page-title em { font-style: italic; font-weight: 400; color: var(--accent); }
  .page-lede {
    font-family: 'Fraunces', serif; font-style: italic; font-size: 18px;
    color: var(--ink-2); max-width: 52ch; margin: 0 0 40px 0; line-height: 1.4;
  }
  .form-group { display: flex; flex-direction: column; gap: 8px; max-width: 440px; margin-bottom: 22px; }
  label {
    font-family: 'JetBrains Mono', monospace; text-transform: uppercase;
    letter-spacing: 0.12em; font-size: 10.5px; color: var(--ink-3); font-weight: 500;
  }
  input[type=text], input[type=email] {
    font: inherit; font-size: 16px; color: var(--ink);
    background: transparent; border: 0; border-bottom: 1px solid var(--ink-2);
    border-radius: 0; padding: 8px 2px; width: 100%;
  }
  input:focus { outline: none; border-bottom-color: var(--accent); }
  button {
    font: inherit; font-size: 13px; font-weight: 500;
    padding: 12px 22px; background: var(--ink); color: var(--paper);
    border: 1px solid var(--ink); cursor: pointer; border-radius: 0;
    text-transform: uppercase; letter-spacing: 0.12em;
    font-family: 'JetBrains Mono', monospace;
    transition: background 0.15s, border-color 0.15s;
  }
  button:hover { background: var(--accent); border-color: var(--accent); }
  .msg-ok { background: var(--ok-bg); color: var(--ok-fg); padding: 14px 18px; font-size: 14px; border-left: 3px solid var(--ok-fg); margin-bottom: 24px; max-width: 440px; line-height: 1.5; }
  .msg-err { background: var(--bad-bg); color: var(--bad-fg); padding: 14px 18px; font-size: 14px; border-left: 3px solid var(--accent); margin-bottom: 24px; max-width: 440px; line-height: 1.5; }
  .links { margin-top: 28px; font-size: 13px; color: var(--ink-2); }
  .links a { color: var(--ink); text-decoration: underline; text-underline-offset: 3px; }
  .links a:hover { color: var(--accent); }
  .how-it-works {
    margin-top: 48px; padding-top: 32px; border-top: 1px solid var(--rule); max-width: 440px;
  }
  .how-it-works h3 {
    font-family: 'JetBrains Mono', monospace; text-transform: uppercase;
    letter-spacing: 0.12em; font-size: 11px; color: var(--ink-3); margin: 0 0 16px 0;
  }
  .how-it-works ol { margin: 0; padding-left: 20px; color: var(--ink-2); font-size: 14px; }
  .how-it-works li { margin-bottom: 8px; }

  @media (max-width: 760px) {
    .container { padding: 24px 22px 48px; }
    h1.page-title { font-size: 36px; }
  }
</style>
</head>
<body>
<div class="container">
  <header class="masthead">
    <div class="title">Campus Lost <i>&amp;</i> Found Ledger</div>
    <div class="ref">Est. <b>2025</b> &nbsp;&middot;&nbsp; File <b>07 / 07</b></div>
  </header>
  <div class="submast">
    <span>Volume I &nbsp;&bull;&nbsp; Account Recovery</span>
    <span>Password Reset</span>
  </div>

  <a href="01_login.jsp" class="back-link">&larr; Back to sign in</a>

  <h1 class="page-title">Forgot your <em>password</em>?</h1>
  <p class="page-lede">Enter your Student/Staff ID and registered email below. We will send a new temporary password to your email.</p>

  <%-- Messages --%>
  <% String success = (String) request.getAttribute("success");
     String error = (String) request.getAttribute("error");
     if (success != null) { %>
    <div class="msg-ok"><%= success %></div>
  <% } if (error != null) { %>
    <div class="msg-err"><%= error %></div>
  <% } %>

  <form action="ForgotPasswordServlet" method="post">

    <div class="form-group">
      <label for="student_id">Student / Staff ID</label>
      <input type="text" id="student_id" name="student_id" placeholder="S12345678" required>
    </div>

    <div class="form-group">
      <label for="email">Registered email</label>
      <input type="email" id="email" name="email" placeholder="yourname@student.edu.my" required>
    </div>

    <div style="margin-top: 14px;">
      <button type="submit">Send New Password &nbsp;&rarr;</button>
    </div>

  </form>

  <div class="links">
    Remember your password? <a href="01_login.jsp">Sign in</a>.
  </div>

  <div class="how-it-works">
    <h3>How it works</h3>
    <ol>
      <li>Enter your Student/Staff ID and the email you registered with.</li>
      <li>If they match, a new temporary password is generated.</li>
      <li>The new password is sent to your email.</li>
      <li>Sign in with the temporary password, then change it in your profile.</li>
    </ol>
  </div>
</div>
</body>
</html>