<%@ page import="java.util.List" %>
<%@ page import="bean.Item" %>
<%@ page import="bean.User" %>
<%@ page import="dao.ItemDAO" %>
<%@ page import="dao.UserDAO" %>
<%
    ItemDAO itemDao = new ItemDAO();
    UserDAO userDao = new UserDAO();
    List<Item> pendingItems = itemDao.getPendingItems();
    List<User> allUsers = userDao.getAllUsers();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin &bull; Campus Lost &amp; Found Ledger</title>
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
  .header-row { display: flex; align-items: end; justify-content: space-between; gap: 24px; margin-bottom: 36px; }
  h1.page-title { font-family: 'Fraunces', serif; font-weight: 500; font-size: 56px; line-height: 1; letter-spacing: -0.025em; margin: 0 0 14px 0; }
  h1.page-title em { font-style: italic; font-weight: 400; color: var(--accent); }
  .page-lede { font-family: 'Fraunces', serif; font-style: italic; font-size: 18px; color: var(--ink-2); max-width: 56ch; margin: 0; }
  .role-tag { font-family: 'JetBrains Mono', monospace; font-size: 11px; color: var(--accent); text-transform: uppercase; letter-spacing: 0.14em; border: 1px solid var(--accent); padding: 8px 12px; white-space: nowrap; }
  .panel { border-top: 1px solid var(--ink); padding: 22px 0 8px; margin-bottom: 36px; }
  .panel-head { display: flex; justify-content: space-between; align-items: baseline; margin-bottom: 18px; }
  .panel-head h3 { font-family: 'Fraunces', serif; font-weight: 500; font-size: 24px; letter-spacing: -0.01em; margin: 0; display: flex; align-items: baseline; gap: 12px; }
  .panel-head h3 .count { font-family: 'JetBrains Mono', monospace; font-size: 11px; color: var(--ink-3); letter-spacing: 0.14em; text-transform: uppercase; font-weight: 500; }
  .panel-head .meta { font-family: 'JetBrains Mono', monospace; font-size: 11px; color: var(--ink-3); text-transform: uppercase; letter-spacing: 0.14em; }
  table { width: 100%; border-collapse: collapse; margin-bottom: 8px; font-size: 14px; }
  th { text-align: left; font-weight: 500; text-transform: uppercase; letter-spacing: 0.12em; font-size: 10.5px; color: var(--ink-3); padding: 6px 14px 10px 0; border-bottom: 1px solid var(--ink-2); font-family: 'JetBrains Mono', monospace; }
  td { padding: 16px 14px 16px 0; border-bottom: 1px solid var(--rule); vertical-align: middle; }
  td.mono, .mono { font-family: 'JetBrains Mono', monospace; font-size: 12.5px; color: var(--ink-2); }
  tr:hover td { background: rgba(0,0,0,0.018); }
  .item-name { font-weight: 500; }
  .reporter-name { font-weight: 500; }
  .reporter-id { font-family: 'JetBrains Mono', monospace; font-size: 11px; color: var(--ink-3); margin-top: 2px; letter-spacing: 0.05em; text-transform: uppercase; }
  .badge { display: inline-flex; align-items: center; gap: 7px; padding: 3px 10px 3px 9px; font-size: 10.5px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.1em; font-family: 'JetBrains Mono', monospace; border: 1px solid rgba(0,0,0,0.08); }
  .badge::before { content: ''; width: 6px; height: 6px; border-radius: 50%; background: currentColor; }
  .badge.pending { background: var(--warn-bg); color: var(--warn-fg); }
  .badge.student { background: var(--info-bg); color: var(--info-fg); }
  .badge.admin { background: var(--bad-bg); color: var(--bad-fg); }
  .row-actions { display: flex; gap: 14px; }
  .row-action { font-family: 'JetBrains Mono', monospace; text-transform: uppercase; letter-spacing: 0.12em; font-size: 11px; color: var(--ink); text-decoration: none; border-bottom: 1px solid var(--ink); padding: 0 0 2px 0; background: none; cursor: pointer; border-top: 0; border-left: 0; border-right: 0; }
  .row-action:hover { color: var(--accent); border-bottom-color: var(--accent); }
  .row-action.success { color: var(--ok-fg); border-bottom-color: var(--ok-fg); }
  .row-action.danger { color: var(--accent); border-bottom-color: var(--accent); }
  .empty-msg { color: var(--ink-3); font-style: italic; padding: 20px 0; }
  @media (max-width: 800px) { .container { padding: 24px 22px 48px; } h1.page-title { font-size: 38px; } .header-row { flex-direction: column; align-items: start; } nav.subnav { flex-wrap: wrap; } }
</style>
</head>
<body>
<div class="container">
  <header class="masthead">
    <div class="title">Campus Lost <i>&amp;</i> Found Ledger</div>
    <div class="ref">File <b>06 / 06</b></div>
  </header>

  <nav class="subnav">
    <a href="03_dashboard.jsp">Dashboard</a>
    <a href="04_items.jsp">Items</a>
    <a href="05_report.jsp">File a report</a>
    <a href="06_admin.jsp" class="active">Admin</a>
    <span class="spacer"></span>
<a href="profile.jsp" style="display:inline-flex;align-items:center;gap:6px;"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="4"/><path d="M20 21a8 8 0 1 0-16 0"/></svg>Profile</a>
    <a href="LogoutServlet" class="logout">Sign out</a>  </nav>

  <div class="header-row">
    <div>
      <h1 class="page-title">The <em>custodian's</em> desk.</h1>
      <p class="page-lede">Verify reports before publication, manage user roles, and review what's moved across the ledger today.</p>
    </div>
    <span class="role-tag">Security Admin</span>
  </div>

  <section class="panel">
    <div class="panel-head">
      <h3>Awaiting verification <span class="count"><%= String.format("%02d", pendingItems.size()) %> pending</span></h3>
      <span class="meta">Sorted by oldest</span>
    </div>
    <table>
      <thead>
        <tr><th>Item</th><th>Reported by</th><th>Status</th><th></th></tr>
      </thead>
      <tbody>
        <% if (pendingItems.isEmpty()) { %>
          <tr><td colspan="4" class="empty-msg">No pending items to verify.</td></tr>
        <% } else {
             for (Item item : pendingItems) {
               String[] reporterInfo = item.getDescription().split("\\|\\|");
               String reporterName = reporterInfo.length > 0 ? reporterInfo[0] : "Unknown";
               String reporterSid = reporterInfo.length > 1 ? reporterInfo[1] : "";
        %>
          <tr>
            <td>
              <div class="item-name"><%= item.getItemName() %></div>
              <div class="reporter-id">REF &middot; LF-<%= item.getItemId() %></div>
            </td>
            <td>
              <div class="reporter-name"><%= reporterName %></div>
              <div class="reporter-id"><%= reporterSid %></div>
            </td>
            <td><span class="badge pending">Pending</span></td>
            <td>
              <div class="row-actions">
                <a class="row-action success" href="AdminServlet?action=verify&item_id=<%= item.getItemId() %>"
                   onclick="return confirm('Verify this item?')">Verify</a>
                <a class="row-action danger" href="AdminServlet?action=reject&item_id=<%= item.getItemId() %>"
                   onclick="return confirm('Reject and delete this item?')">Reject</a>
              </div>
            </td>
          </tr>
        <% } } %>
      </tbody>
    </table>
  </section>

  <section class="panel">
    <div class="panel-head">
      <h3>User management <span class="count"><%= String.format("%02d", allUsers.size()) %> users</span></h3>
      <span class="meta">All registered</span>
    </div>
    <table>
      <thead>
        <tr><th>Name</th><th>ID</th><th>Role</th><th></th></tr>
      </thead>
      <tbody>
        <% for (User u : allUsers) { %>
          <tr>
            <td>
              <div class="reporter-name"><%= u.getFullName() %></div>
              <div class="reporter-id"><%= u.getFaculty() != null ? u.getFaculty() : "" %></div>
            </td>
            <td class="mono"><%= u.getStudentId() %></td>
            <td><span class="badge <%= u.getRole() %>"><%= u.getRole() %></span></td>
            <td>
              <div class="row-actions">
                <a class="row-action" href="AdminServlet?action=toggle_role&user_id=<%= u.getUserId() %>&current_role=<%= u.getRole() %>"
                   onclick="return confirm('Change role from <%= u.getRole() %> to <%= "student".equals(u.getRole()) ? "admin" : "student" %>?')">
                   Toggle Role</a>
                <a class="row-action danger" href="AdminServlet?action=delete_user&user_id=<%= u.getUserId() %>"
                   onclick="return confirm('Delete user <%= u.getFullName() %>? This cannot be undone.')">Delete</a>
              </div>
            </td>
          </tr>
        <% } %>
      </tbody>
    </table>
  </section>
</div>
</body>
</html>