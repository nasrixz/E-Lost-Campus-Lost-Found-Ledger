<%@ page import="bean.User" %>
<%
    User user = (User) session.getAttribute("user");
    String userName = user != null ? user.getFullName() : "User";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sign Out &bull; Campus Lost &amp; Found Ledger</title>
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
    background-attachment: fixed; line-height: 1.55; font-size: 15px; -webkit-font-smoothing: antialiased;
  }
  .container { max-width: 1080px; margin: 0 auto; padding: 32px 48px 64px; min-height: 100vh; }
  .masthead { display: flex; align-items: baseline; justify-content: space-between; border-bottom: 2px solid var(--ink); padding-bottom: 14px; margin-bottom: 8px; }
  .masthead .title { font-family: 'Fraunces', serif; font-weight: 600; font-size: 28px; letter-spacing: -0.01em; line-height: 1; }
  .masthead .title i { font-style: italic; font-weight: 400; color: var(--accent); }
  .masthead .ref { font-family: 'JetBrains Mono', monospace; font-size: 11px; color: var(--ink-2); letter-spacing: 0.1em; text-transform: uppercase; }
  .masthead .ref b { color: var(--ink); }
  .submast { display: flex; justify-content: space-between; padding: 8px 0 28px; font-family: 'JetBrains Mono', monospace; font-size: 10.5px; letter-spacing: 0.14em; text-transform: uppercase; color: var(--ink-3); border-bottom: 1px solid var(--rule); margin-bottom: 40px; }
  .logout-box { max-width: 480px; margin: 80px auto 0; text-align: center; }
  .logout-icon { font-size: 48px; margin-bottom: 24px; color: var(--accent); }
  h1.page-title { font-family: 'Fraunces', serif; font-weight: 500; font-size: 44px; line-height: 1.1; letter-spacing: -0.025em; margin: 0 0 12px 0; }
  h1.page-title em { font-style: italic; font-weight: 400; color: var(--accent); }
  .page-lede { font-family: 'Fraunces', serif; font-style: italic; font-size: 18px; color: var(--ink-2); margin: 0 0 36px 0; line-height: 1.4; }
  .user-name { font-weight: 600; color: var(--ink); font-style: normal; }
  .actions { display: flex; gap: 16px; justify-content: center; margin-top: 32px; }
  .btn-confirm {
    font-family: 'JetBrains Mono', monospace; font-size: 12px; font-weight: 500;
    padding: 12px 28px; background: var(--accent); color: var(--paper);
    border: 1px solid var(--accent); cursor: pointer; border-radius: 0;
    text-transform: uppercase; letter-spacing: 0.14em; text-decoration: none;
    transition: background 0.15s, border-color 0.15s;
  }
  .btn-confirm:hover { background: #6e2421; border-color: #6e2421; }
  .btn-cancel {
    font-family: 'JetBrains Mono', monospace; font-size: 12px; font-weight: 500;
    padding: 12px 28px; background: transparent; color: var(--ink);
    border: 1px solid var(--ink); cursor: pointer; border-radius: 0;
    text-transform: uppercase; letter-spacing: 0.14em; text-decoration: none;
    transition: background 0.15s;
  }
  .btn-cancel:hover { background: var(--card); }
  @media (max-width: 760px) { .container { padding: 24px 22px 48px; } h1.page-title { font-size: 32px; } }
</style>
</head>
<body>
<div class="container">
  <header class="masthead">
    <div class="title">Campus Lost <i>&amp;</i> Found Ledger</div>
    <div class="ref">Est. <b>2025</b></div>
  </header>
  <div class="submast">
    <span>Session &nbsp;&bull;&nbsp; Sign Out</span>
    <span>Confirmation Required</span>
  </div>

  <div class="logout-box">
    <div class="logout-icon">&larr;</div>
    <h1 class="page-title">Leaving <em>the ledger</em>?</h1>
    <p class="page-lede">You are signed in as <span class="user-name"><%= userName %></span>. Are you sure you want to sign out?</p>

    <div class="actions">
      <a href="LogoutServlet?confirm=yes" class="btn-confirm">Yes, Sign Out</a>
      <a href="javascript:history.back()" class="btn-cancel">Cancel</a>
    </div>
  </div>
</div>
</body>
</html>