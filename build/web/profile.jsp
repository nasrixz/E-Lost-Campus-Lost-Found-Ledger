<%@ page import="bean.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("01_login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Profile &bull; Campus Lost &amp; Found Ledger</title>
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
  .masthead { display: flex; align-items: baseline; justify-content: space-between; border-bottom: 2px solid var(--ink); padding-bottom: 14px; }
  .masthead .title { font-family: 'Fraunces', serif; font-weight: 600; font-size: 28px; letter-spacing: -0.01em; line-height: 1; }
  .masthead .title i { font-style: italic; font-weight: 400; color: var(--accent); }
  .masthead .ref { font-family: 'JetBrains Mono', monospace; font-size: 11px; color: var(--ink-2); letter-spacing: 0.1em; text-transform: uppercase; }
  .masthead .ref b { color: var(--ink); }
  nav.subnav { display: flex; gap: 26px; align-items: center; padding: 12px 0 14px; border-bottom: 1px solid var(--rule); margin-bottom: 40px; font-family: 'JetBrains Mono', monospace; font-size: 11px; text-transform: uppercase; letter-spacing: 0.14em; }
  nav.subnav a { text-decoration: none; color: var(--ink-2); padding-bottom: 3px; border-bottom: 1px solid transparent; }
  nav.subnav a:hover { color: var(--ink); }
  nav.subnav a.active { color: var(--ink); border-bottom-color: var(--accent); }
  nav.subnav .spacer { flex: 1; }
  nav.subnav .logout { color: var(--accent); }
  h1.page-title { font-family: 'Fraunces', serif; font-weight: 500; font-size: 52px; line-height: 1; letter-spacing: -0.025em; margin: 0 0 12px 0; }
  h1.page-title em { font-style: italic; font-weight: 400; color: var(--accent); }
  .page-lede { font-family: 'Fraunces', serif; font-style: italic; font-size: 18px; color: var(--ink-2); max-width: 56ch; margin: 0 0 36px 0; line-height: 1.4; }
  .msg-ok { background: var(--ok-bg); color: var(--ok-fg); padding: 12px 16px; font-size: 13px; border-left: 3px solid var(--ok-fg); margin-bottom: 24px; max-width: 600px; }
  .msg-err { background: var(--bad-bg); color: var(--bad-fg); padding: 12px 16px; font-size: 13px; border-left: 3px solid var(--accent); margin-bottom: 24px; max-width: 600px; }
  .profile-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 56px; align-items: start; }
  .panel { border-top: 1px solid var(--ink); padding-top: 22px; margin-bottom: 36px; }
  .panel h3 { font-family: 'Fraunces', serif; font-weight: 500; font-size: 24px; letter-spacing: -0.01em; margin: 0 0 6px 0; }
  .panel .panel-desc { font-size: 13px; color: var(--ink-3); margin: 0 0 24px 0; }
  .form-group { display: flex; flex-direction: column; gap: 8px; margin-bottom: 20px; }
  .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 18px 24px; }
  .form-group.span-2 { grid-column: 1 / -1; }
  label.field-label { font-family: 'JetBrains Mono', monospace; text-transform: uppercase; letter-spacing: 0.12em; font-size: 10.5px; color: var(--ink-3); font-weight: 500; }
  input[type=text], input[type=email], input[type=password], input[type=tel], select {
    font: inherit; font-size: 15px; color: var(--ink);
    background: transparent; border: 0; border-bottom: 1px solid var(--ink-2);
    border-radius: 0; padding: 8px 2px; width: 100%; font-family: 'Inter', sans-serif;
  }
  input:focus, select:focus { outline: none; border-bottom-color: var(--accent); }
  select {
    appearance: none; -webkit-appearance: none;
    background-image: linear-gradient(45deg, transparent 50%, var(--ink) 50%), linear-gradient(135deg, var(--ink) 50%, transparent 50%);
    background-position: calc(100% - 12px) 18px, calc(100% - 7px) 18px;
    background-size: 6px 6px, 6px 6px; background-repeat: no-repeat; padding-right: 28px;
  }
  input[readonly] { color: var(--ink-3); border-bottom-style: dashed; }
  button {
    font-family: 'JetBrains Mono', monospace; font-size: 12px; font-weight: 500;
    padding: 11px 20px; background: var(--ink); color: var(--paper);
    border: 1px solid var(--ink); cursor: pointer; border-radius: 0;
    text-transform: uppercase; letter-spacing: 0.14em;
    transition: background 0.15s, border-color 0.15s;
  }
  button:hover { background: var(--accent); border-color: var(--accent); }
  .info-row { display: flex; justify-content: space-between; padding: 14px 0; border-bottom: 1px solid var(--rule); }
  .info-label { font-family: 'JetBrains Mono', monospace; text-transform: uppercase; letter-spacing: 0.12em; font-size: 10.5px; color: var(--ink-3); }
  .info-value { font-size: 15px; color: var(--ink); font-weight: 500; }
  .badge { display: inline-flex; align-items: center; gap: 7px; padding: 3px 10px 3px 9px; font-size: 10.5px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.1em; font-family: 'JetBrains Mono', monospace; border: 1px solid rgba(0,0,0,0.08); }
  .badge::before { content: ''; width: 6px; height: 6px; border-radius: 50%; background: currentColor; }
  .badge.student { background: #dde3ea; color: #1f3a55; }
  .badge.admin { background: #efd9d4; color: #6e2521; }
  @media (max-width: 800px) { .container { padding: 24px 22px 48px; } h1.page-title { font-size: 36px; } .profile-grid { grid-template-columns: 1fr; gap: 0; } .form-grid { grid-template-columns: 1fr; } nav.subnav { flex-wrap: wrap; } }
</style>
</head>
<body>
<div class="container">
  <header class="masthead">
    <div class="title">Campus Lost <i>&amp;</i> Found Ledger</div>
    <div class="ref">File <b>08 / 08</b></div>
  </header>

  <nav class="subnav">
    <a href="03_dashboard.jsp">Dashboard</a>
    <a href="04_items.jsp">Items</a>
    <a href="05_report.jsp">File a report</a>
    <a href="06_admin.jsp">Admin</a>
    <span class="spacer"></span>
    <a href="profile.jsp" class="active">Profile</a>
    <a href="LogoutServlet" class="logout">Sign out</a>
  </nav>

  <h1 class="page-title">Your <em>profile</em>.</h1>
  <p class="page-lede">View your account details, update your information, or change your password.</p>

  <% String success = (String) request.getAttribute("success");
     String error = (String) request.getAttribute("error");
     if (success != null) { %>
    <div class="msg-ok"><%= success %></div>
  <% } if (error != null) { %>
    <div class="msg-err"><%= error %></div>
  <% } %>

  <div class="profile-grid">
    <div>
      <section class="panel">
        <h3>Account overview</h3>
        <p class="panel-desc">Your registered account details.</p>

        <div class="info-row">
          <span class="info-label">Student / Staff ID</span>
          <span class="info-value"><%= user.getStudentId() %></span>
        </div>
        <div class="info-row">
          <span class="info-label">Role</span>
          <span class="info-value"><span class="badge <%= user.getRole() %>"><%= user.getRole() %></span></span>
        </div>
        <div class="info-row">
          <span class="info-label">Full Name</span>
          <span class="info-value"><%= user.getFullName() %></span>
        </div>
        <div class="info-row">
          <span class="info-label">Email</span>
          <span class="info-value"><%= user.getEmail() %></span>
        </div>
        <div class="info-row">
          <span class="info-label">Phone</span>
          <span class="info-value"><%= user.getPhone() != null && !user.getPhone().isEmpty() ? user.getPhone() : "Not set" %></span>
        </div>
        <div class="info-row">
          <span class="info-label">Faculty</span>
          <span class="info-value"><%= user.getFaculty() != null ? user.getFaculty() : "Not set" %></span>
        </div>
      </section>

      <section class="panel">
        <h3>Edit profile</h3>
        <p class="panel-desc">Update your personal information below.</p>
        <form action="ProfileServlet" method="post">
          <input type="hidden" name="action" value="update">
          <div class="form-grid">
            <div class="form-group span-2">
              <label class="field-label" for="full_name">Full name</label>
              <input type="text" id="full_name" name="full_name" value="<%= user.getFullName() %>" required>
            </div>
            <div class="form-group">
              <label class="field-label" for="email">Email</label>
              <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required>
            </div>
            <div class="form-group">
              <label class="field-label" for="phone">Phone</label>
              <input type="tel" id="phone" name="phone" value="<%= user.getPhone() != null ? user.getPhone() : "" %>" placeholder="+60 ___ ____ ___">
            </div>
            <div class="form-group span-2">
              <label class="field-label" for="faculty">Faculty / Department</label>
              <select id="faculty" name="faculty">
                <option <%= "Computer Science & IT".equals(user.getFaculty()) ? "selected" : "" %>>Computer Science & IT</option>
                <option <%= "Engineering".equals(user.getFaculty()) ? "selected" : "" %>>Engineering</option>
                <option <%= "Business Administration".equals(user.getFaculty()) ? "selected" : "" %>>Business Administration</option>
                <option <%= "Social Sciences".equals(user.getFaculty()) ? "selected" : "" %>>Social Sciences</option>
                <option <%= "Security".equals(user.getFaculty()) ? "selected" : "" %>>Security</option>
              </select>
            </div>
          </div>
          <div style="margin-top: 8px;">
            <button type="submit">Save Changes &nbsp;&rarr;</button>
          </div>
        </form>
      </section>
    </div>

    <div>
      <section class="panel">
        <h3>Change password</h3>
        <p class="panel-desc">Enter your current password and choose a new one.</p>
        <form action="ProfileServlet" method="post">
          <input type="hidden" name="action" value="password">
          <div class="form-group">
            <label class="field-label" for="old_password">Current password</label>
            <input type="password" id="old_password" name="old_password" required>
          </div>
          <div class="form-group">
            <label class="field-label" for="new_password">New password</label>
            <input type="password" id="new_password" name="new_password" required>
          </div>
          <div class="form-group">
            <label class="field-label" for="confirm_password">Confirm new password</label>
            <input type="password" id="confirm_password" name="confirm_password" required>
          </div>
          <div style="margin-top: 8px;">
            <button type="submit">Change Password &nbsp;&rarr;</button>
          </div>
        </form>
      </section>
    </div>
  </div>
</div>
</body>
</html>