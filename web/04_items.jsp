<%@ page import="java.util.List" %>
<%@ page import="bean.Item" %>
<%@ page import="dao.ItemDAO" %>
<%
    int currentPage = 1;
    int pageSize = 6;
    String pageParam = request.getParameter("page");
    if (pageParam != null) {
        try { currentPage = Integer.parseInt(pageParam); } catch (Exception e) {}
        if (currentPage < 1) currentPage = 1;
    }

    ItemDAO dao = new ItemDAO();
    int totalItems = dao.countItems();
    int totalPages = (int) Math.ceil((double) totalItems / pageSize);
    if (currentPage > totalPages && totalPages > 0) currentPage = totalPages;

    List<Item> items = dao.getAllItems(currentPage, pageSize);
    int showingFrom = (currentPage - 1) * pageSize + 1;
    int showingTo = Math.min(currentPage * pageSize, totalItems);
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Items &bull; Campus Lost &amp; Found Ledger</title>
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
  .header-row { display: flex; align-items: end; justify-content: space-between; gap: 24px; margin-bottom: 10px; }
  h1.page-title { font-family: 'Fraunces', serif; font-weight: 500; font-size: 56px; line-height: 1; letter-spacing: -0.025em; margin: 0; }
  h1.page-title em { font-style: italic; font-weight: 400; color: var(--accent); }
  .page-lede { font-family: 'Fraunces', serif; font-style: italic; font-size: 18px; color: var(--ink-2); max-width: 60ch; margin: 14px 0 32px 0; }
  .result-count { font-family: 'JetBrains Mono', monospace; font-size: 11px; color: var(--ink-3); text-transform: uppercase; letter-spacing: 0.14em; }
  .result-count b { color: var(--ink); }
  button.primary, a.btn { font-family: 'JetBrains Mono', monospace; font-size: 12px; font-weight: 500; padding: 11px 20px; background: var(--ink); color: var(--paper); border: 1px solid var(--ink); cursor: pointer; border-radius: 0; text-transform: uppercase; letter-spacing: 0.14em; text-decoration: none; display: inline-block; transition: background 0.15s, border-color 0.15s; }
  button.primary:hover, a.btn:hover { background: var(--accent); border-color: var(--accent); }
  table { width: 100%; border-collapse: collapse; margin-bottom: 12px; font-size: 14px; margin-top: 22px; }
  th { text-align: left; font-weight: 500; text-transform: uppercase; letter-spacing: 0.12em; font-size: 10.5px; color: var(--ink-3); padding: 14px 14px 12px 0; border-bottom: 2px solid var(--ink); font-family: 'JetBrains Mono', monospace; }
  td { padding: 16px 14px 16px 0; border-bottom: 1px solid var(--rule); vertical-align: middle; }
  td.mono { font-family: 'JetBrains Mono', monospace; font-size: 12.5px; color: var(--ink-2); }
  tr:hover td { background: rgba(0,0,0,0.018); }
  .item-name { font-weight: 500; }
  .item-id { font-family: 'JetBrains Mono', monospace; font-size: 11px; color: var(--ink-3); margin-top: 2px; letter-spacing: 0.05em; text-transform: uppercase; }
  .badge { display: inline-flex; align-items: center; gap: 7px; padding: 3px 10px 3px 9px; font-size: 10.5px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.1em; font-family: 'JetBrains Mono', monospace; border: 1px solid rgba(0,0,0,0.08); }
  .badge::before { content: ''; width: 6px; height: 6px; border-radius: 50%; background: currentColor; }
  .badge.lost { background: var(--bad-bg); color: var(--bad-fg); }
  .badge.found { background: var(--ok-bg); color: var(--ok-fg); }
  .badge.returned { background: var(--info-bg); color: var(--info-fg); }
  .badge.pending { background: var(--warn-bg); color: var(--warn-fg); }
  .row-actions { display: flex; gap: 16px; }
  .row-action { font-family: 'JetBrains Mono', monospace; text-transform: uppercase; letter-spacing: 0.12em; font-size: 11px; color: var(--ink); text-decoration: none; border-bottom: 1px solid var(--ink); padding-bottom: 2px; }
  .row-action:hover { color: var(--accent); border-bottom-color: var(--accent); }
  .pagination { display: flex; justify-content: space-between; align-items: center; padding: 22px 0; border-top: 1px solid var(--rule); }
  .pagination .info { font-family: 'JetBrains Mono', monospace; font-size: 11px; color: var(--ink-3); text-transform: uppercase; letter-spacing: 0.14em; }
  .pagination .info b { color: var(--ink); }
  .page-nav { display: flex; gap: 12px; }
  .page-nav a { font-family: 'JetBrains Mono', monospace; text-transform: uppercase; letter-spacing: 0.12em; font-size: 11px; color: var(--ink); text-decoration: none; border-bottom: 1px solid var(--ink); padding-bottom: 2px; }
  .page-nav a:hover { color: var(--accent); border-bottom-color: var(--accent); }
  .page-nav span.disabled { font-family: 'JetBrains Mono', monospace; text-transform: uppercase; letter-spacing: 0.12em; font-size: 11px; color: var(--ink-3); padding-bottom: 2px; }
  .empty-msg { color: var(--ink-3); font-style: italic; padding: 40px 0; text-align: center; }
  @media (max-width: 900px) { .container { padding: 24px 22px 48px; } h1.page-title { font-size: 40px; } nav.subnav { flex-wrap: wrap; } }
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
<a href="profile.jsp" style="display:inline-flex;align-items:center;gap:6px;"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="4"/><path d="M20 21a8 8 0 1 0-16 0"/></svg>Profile</a>
    <a href="LogoutServlet" class="logout">Sign out</a>  </nav>

  <div class="header-row">
    <div>
      <h1 class="page-title">The <em>index</em>.</h1>
      <p class="page-lede">Every entry on record. Search, filter, and verify before you reach out.</p>
    </div>
    <a href="05_report.jsp" class="btn">+ File a report</a>
  </div>

  <div class="result-count"><b><%= totalItems %></b> entries</div>

  <table>
    <thead>
      <tr>
        <th style="width:30%">Item</th>
        <th>Category</th>
        <th>Location</th>
        <th>Date</th>
        <th>Status</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      <% if (items.isEmpty()) { %>
        <tr><td colspan="6" class="empty-msg">No items reported yet.</td></tr>
      <% } else {
           for (Item item : items) {
             String statusClass = item.getStatus().toLowerCase();
      %>
        <tr>
          <td>
            <div class="item-name"><%= item.getItemName() %></div>
            <div class="item-id">REF &middot; LF-<%= item.getItemId() %></div>
          </td>
          <td class="mono"><%= item.getCategory() %></td>
          <td><%= item.getBuilding() %><% if (item.getSpecificLoc() != null && !item.getSpecificLoc().isEmpty()) { %>, <%= item.getSpecificLoc() %><% } %></td>
          <td class="mono"><%= item.getDateLostFound() %></td>
          <td><span class="badge <%= statusClass %>"><%= item.getStatus() %></span></td>
          <td>
            <div class="row-actions">
              <a class="row-action" href="#">View</a>
            </div>
          </td>
        </tr>
      <% } } %>
    </tbody>
  </table>

  <% if (totalPages > 0) { %>
  <div class="pagination">
    <div class="info">
      Page <b><%= currentPage %></b> of <b><%= totalPages %></b>
      &nbsp;&middot;&nbsp; showing <%= showingFrom %>-<%= showingTo %> of <%= totalItems %>
    </div>
    <div class="page-nav">
      <% if (currentPage > 1) { %>
        <a href="04_items.jsp?page=<%= currentPage - 1 %>">&larr; Prev</a>
      <% } else { %>
        <span class="disabled">&larr; Prev</span>
      <% } %>
      <% if (currentPage < totalPages) { %>
        <a href="04_items.jsp?page=<%= currentPage + 1 %>">Next &rarr;</a>
      <% } else { %>
        <span class="disabled">Next &rarr;</span>
      <% } %>
    </div>
  </div>
  <% } %>
</div>
</body>
</html>