<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="WebApplication4.AdminDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Faculty ATS — Admin Dashboard</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Georgia&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" />

    <style>
        :root {
            --font-ui: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            --font-heading: Georgia, 'Times New Roman', serif;
            --page-bg: #F8F7F3;
            --card-bg: #FFFFFF;
            --input-bg: #FCFCFB;
            --primary-navy: #12304A;
            --secondary-navy: #315A7D;
            --action-blue: #1769A8;
            --action-blue-hover: #125789;
            --body-text: #334155;
            --muted-text: #718096;
            --placeholder: #94A3B8;
            --border: #D9E1E8;
            --divider: #E2E6EA;
            --error-red: #DC3B3B;
            --radius: 6px;
            --radius-lg: 8px;
        }

        * { box-sizing: border-box; }
        html, body { margin: 0; padding: 0; }

        body {
            background: var(--page-bg);
            font-family: var(--font-ui);
            font-size: 14px;
            color: var(--body-text);
            line-height: 1.5;
            -webkit-font-smoothing: antialiased;
        }

        /* ============================
           LAYOUT
           ============================ */
        .wrapper {
            display: flex;
            min-height: 100vh;
        }

        /* ============================
           SIDEBAR
           ============================ */
        .sidebar {
            position: fixed;
            top: 0; left: 0;
            width: 250px;
            height: 100vh;
            background: var(--primary-navy);
            color: #fff;
            display: flex;
            flex-direction: column;
            overflow: hidden;
            transition: all .35s ease;
            z-index: 1000;
            border-right: 1px solid rgba(255,255,255,0.06);
        }
        .sidebar.collapsed { width: 80px; }
        .sidebar.collapsed .nav-link span { display: none; }
        .sidebar.collapsed .nav-link i { width: 100%; min-width: unset; }
        .sidebar.collapsed .sidebar-header .header-text { display: none; }

        .sidebar-header {
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-bottom: 1px solid rgba(255,255,255,0.08);
            padding: 0 16px;
        }
        .sidebar-header .toggle-btn {
            background: none;
            border: none;
            color: #fff;
            font-size: 22px;
            cursor: pointer;
            padding: 8px;
            border-radius: var(--radius);
            display: flex; align-items: center; justify-content: center;
            transition: background .2s ease;
        }
        .sidebar-header .toggle-btn:hover { background: rgba(255,255,255,0.08); }

        .sidebar .nav {
            margin-top: 18px;
            padding: 0;
            flex: 1;
            list-style: none;
        }
        .sidebar .nav-item { margin-bottom: 6px; }
        .sidebar .nav-link {
            display: flex;
            align-items: center;
            height: 50px;
            margin: 0 12px;
            padding: 0 16px;
            border-radius: var(--radius);
            color: #d7dce6;
            text-decoration: none;
            transition: background .2s ease, color .2s ease;
            white-space: nowrap;
            font-family: var(--font-ui);
            font-size: 14px;
            font-weight: 500;
        }
        .sidebar .nav-link:hover { background: var(--secondary-navy); color: #fff; }
        .sidebar .nav-link.active { background: var(--action-blue); color: #fff; }
        .sidebar .nav-link i {
            width: 42px; min-width: 42px;
            text-align: center;
            font-size: 18px;
        }
        .sidebar .nav-link span { transition: opacity .2s ease; }

        /* ============================
           CONTENT
           ============================ */
        .content {
            margin-left: 250px;
            width: calc(100% - 250px);
            padding: 32px 48px 60px;
            transition: all .35s ease;
        }
        .content.expanded {
            margin-left: 80px;
            width: calc(100% - 80px);
        }

        /* ============================
           PAGE HEADER (matches Personal.aspx)
           ============================ */
        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 14px;
            margin-bottom: 32px;
            flex-wrap: wrap;
        }
        .page-header-left {
            display: flex;
            align-items: center;
            gap: 14px;
        }
        .page-header .logo { height: 56px; width: auto; }
        .page-header .uni-name {
            font-family: var(--font-ui);
            font-weight: 600;
            font-size: 24px;
            color: var(--primary-navy);
            line-height: 1.2;
        }
        .page-header .hr-portal {
            font-family: var(--font-ui);
            font-weight: 400;
            font-size: 14px;
            color: var(--muted-text);
            line-height: 1.2;
            margin-top: 2px;
        }
        .page-header-right {
            display: flex;
            align-items: center;
            gap: 14px;
        }
        .header-icon {
            position: relative;
            border: 1px solid var(--border);
            background: #fff;
            width: 42px;
            height: 42px;
            border-radius: var(--radius);
            font-size: 18px;
            color: var(--primary-navy);
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background .2s ease, border-color .2s ease;
        }
        .header-icon:hover { background: #F1F5F9; border-color: var(--action-blue); }
        .notification-dot {
            position: absolute;
            width: 8px; height: 8px;
            top: 8px; right: 8px;
            background: var(--error-red);
            border-radius: 50%;
            border: 2px solid #fff;
        }
        .admin-box {
            display: flex;
            align-items: center;
            gap: 12px;
            position: relative;
        }
        .admin-box .admin-text {
            text-align: right;
            line-height: 1.25;
        }
        .admin-box .admin-text .admin-name {
            font-weight: 600;
            font-size: 14px;
            color: var(--primary-navy);
        }
        .admin-box .admin-text .admin-role {
            font-size: 11px;
            color: var(--muted-text);
            text-transform: uppercase;
            letter-spacing: 0.4px;
            font-weight: 600;
        }
        .profile-circle {
            width: 42px; height: 42px;
            border-radius: 50%;
            background: var(--action-blue);
            color: #fff;
            display: flex; align-items: center; justify-content: center;
            font-weight: 700;
            font-size: 16px;
            cursor: pointer;
            position: relative;
            transition: transform .2s ease;
        }
        .profile-circle:hover { transform: scale(1.05); }
        .profile-circle .dropdown-arrow {
            position: absolute;
            bottom: -2px; right: -4px;
            font-size: 8px;
            background: var(--primary-navy);
            color: #fff;
            border-radius: 50%;
            width: 16px; height: 16px;
            display: flex; align-items: center; justify-content: center;
            border: 2px solid #fff;
            padding: 0; line-height: 1;
        }
        .dropdown-menu-custom {
            display: none;
            position: absolute;
            top: 56px; right: 0;
            background: #fff;
            border-radius: var(--radius);
            box-shadow: 0 8px 30px rgba(15,23,42,0.12);
            min-width: 180px;
            padding: 6px 0;
            z-index: 1300;
            border: 1px solid var(--border);
            overflow: hidden;
        }
        .dropdown-menu-custom.show { display: block; }
        .dropdown-menu-custom .dropdown-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 11px 18px;
            color: var(--body-text);
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
            border: none;
            background: none;
            width: 100%;
            text-align: left;
            cursor: pointer;
            transition: background .15s ease;
            font-family: var(--font-ui);
        }
        .dropdown-menu-custom .dropdown-item:hover { background: #F8FAFC; }
        .dropdown-menu-custom .dropdown-item i { font-size: 16px; color: var(--muted-text); }
        .dropdown-menu-custom .dropdown-divider {
            height: 1px;
            background: var(--divider);
            margin: 4px 0;
        }
        .dropdown-menu-custom .dropdown-item.logout-item { color: var(--error-red); }
        .dropdown-menu-custom .dropdown-item.logout-item i { color: var(--error-red); }
        .dropdown-menu-custom .dropdown-item.logout-item:hover { background: #FEF2F2; }

        /* ============================
           HEADINGS (matches Personal.aspx)
           ============================ */
        .main-heading {
            font-family: var(--font-heading);
            font-weight: 600;
            font-size: 42px;
            color: var(--primary-navy);
            line-height: 1.15;
            margin: 0 0 8px 0;
            letter-spacing: -0.3px;
        }
        .main-subtitle {
            font-family: var(--font-ui);
            font-weight: 400;
            font-size: 16px;
            color: var(--muted-text);
            margin: 0 0 32px 0;
        }

        /* ============================
           CARD (matches Personal.aspx)
           ============================ */
        .section-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 22px 26px;
            margin-bottom: 16px;
            box-shadow: 0 1px 3px rgba(15,23,42,0.03);
        }
        .section-card:last-of-type { margin-bottom: 0; }

        .section-heading {
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 20px;
        }
        .section-heading h3 {
            font-family: var(--font-heading);
            font-weight: 600;
            font-size: 22px;
            color: var(--primary-navy);
            margin: 0;
            white-space: nowrap;
        }
        .section-heading::after {
            content: "";
            flex: 1;
            height: 1px;
            background: var(--divider);
        }

        /* ============================
           BUTTONS
           ============================ */
        .btn-action {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: var(--action-blue);
            color: #fff;
            border: none;
            border-radius: var(--radius);
            height: 44px;
            padding: 0 22px;
            font-family: var(--font-ui);
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            transition: background .15s ease;
        }
        .btn-action:hover { background: var(--action-blue-hover); color: #fff; }

        .btn-action-alt {
            background: var(--secondary-navy);
        }
        .btn-action-alt:hover { background: var(--primary-navy); }

        /* ============================
           STAT CARDS
           ============================ */
        .stats-row {
            display: grid;
            grid-template-columns: repeat(6, 1fr);
            gap: 14px;
            margin-bottom: 24px;
        }
        .stats-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 22px 16px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            cursor: pointer;
            transition: all .2s ease;
            text-decoration: none;
            color: inherit;
        }
        .stats-card:hover {
            border-color: var(--action-blue);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(23,105,168,0.10);
        }
        .stat-icon {
            width: 54px;
            height: 54px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 14px;
            margin-bottom: 12px;
            background: #F1F5F9;
        }
        .stat-icon i { font-size: 22px; }
        .stat-icon i.icon-submitted { color: #3b82f6; }
        .stat-icon i.icon-pending { color: #f59e0b; }
        .stat-icon i.icon-shortlisted { color: #22c55e; }
        .stat-icon i.icon-rejected { color: #ef4444; }
        .stat-icon i.icon-hired { color: #6366f1; }
        .stat-icon i.icon-incomplete { color: #6b7280; }
        .stats-card .stat-number {
            font-family: var(--font-heading);
            font-weight: 700;
            font-size: 26px;
            color: var(--primary-navy);
            margin-bottom: 4px;
        }
        .stats-card .stat-label {
            font-family: var(--font-ui);
            font-size: 10px;
            font-weight: 700;
            color: var(--muted-text);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* ============================
           TABS
           ============================ */
        .tabs-row {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-bottom: 22px;
        }
        .tab-btn {
            font-family: var(--font-ui);
            font-size: 12px;
            font-weight: 700;
            padding: 8px 18px;
            border-radius: 20px;
            border: 1px solid var(--border);
            background: #fff;
            color: var(--body-text);
            text-decoration: none;
            cursor: pointer;
            transition: all .15s ease;
        }
        .tab-btn:hover { border-color: var(--action-blue); color: var(--action-blue); }
        .tab-active {
            background: var(--action-blue) !important;
            color: #fff !important;
            border-color: var(--action-blue) !important;
        }
        .tab-active:hover { background: var(--action-blue-hover) !important; color: #fff !important; }

        /* ============================
           SEARCH & SORT
           ============================ */
        .search-group {
            display: flex;
            gap: 0;
        }
        .search-group .form-control {
            border-radius: var(--radius) 0 0 var(--radius);
            border-right: none;
        }
        .search-group .btn-search {
            border-radius: 0 var(--radius) var(--radius) 0;
            background: var(--action-blue);
            color: #fff;
            border: 1px solid var(--action-blue);
            padding: 0 20px;
            height: 44px;
            font-family: var(--font-ui);
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            transition: background .15s ease;
        }
        .search-group .btn-search:hover { background: var(--action-blue-hover); border-color: var(--action-blue-hover); }

        .form-control, .form-select {
            width: 100%;
            background: var(--input-bg);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            height: 44px;
            font-family: var(--font-ui);
            font-size: 14px;
            color: var(--body-text);
            padding: 0 14px;
            transition: border-color .15s ease, box-shadow .15s ease;
        }
        .form-control::placeholder { color: var(--placeholder); }
        .form-control:focus, .form-select:focus {
            outline: none;
            border-color: var(--action-blue);
            box-shadow: 0 0 0 2px rgba(23,105,168,0.08);
        }

        .row-grid-2 {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
            align-items: end;
            margin-bottom: 22px;
        }

        /* ============================
           APPLICANT TABLE
           ============================ */
        .applicant-table-container {
            background: #fff;
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            overflow: hidden;
        }
        .applicant-table {
            width: 100%;
            border-collapse: collapse;
            font-family: var(--font-ui);
        }
        .applicant-table thead { background: #F8FAFC; }
        .applicant-table th {
            padding: 14px 20px;
            text-align: left;
            font-size: 11px;
            font-weight: 700;
            color: var(--muted-text);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 1px solid var(--border);
        }
        .applicant-table td {
            padding: 14px 20px;
            border-bottom: 1px solid #F1F4F9;
            vertical-align: middle;
            font-size: 13px;
        }
        .applicant-table tbody tr { transition: background .15s ease; }
        .applicant-table tbody tr:hover { background: #F8FAFC; }
        .applicant-table .candidate-cell { display: flex; align-items: center; gap: 12px; }
        .applicant-table .avatar-img {
            width: 40px; height: 40px;
            border-radius: 50%;
            object-fit: cover;
            border: 1px solid var(--border);
            background: #F1F5F9;
            flex-shrink: 0;
        }
        .applicant-table .candidate-name {
            font-weight: 600;
            font-size: 14px;
            color: var(--primary-navy);
            text-decoration: none;
        }
        .applicant-table .candidate-name:hover { color: var(--action-blue); text-decoration: underline; }
        .applicant-table .candidate-email { font-size: 12px; color: var(--muted-text); }
        .applicant-table .position-text {
            font-weight: 600;
            font-size: 13px;
            color: var(--body-text);
        }
        .applicant-table .hiring-badge {
            font-size: 10px;
            font-weight: 700;
            padding: 3px 10px;
            border-radius: 12px;
            background: #DBEAFE;
            color: #1E40AF;
            white-space: nowrap;
            display: inline-block;
            margin-top: 4px;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }
        .applicant-table .score-wrapper { display: flex; align-items: center; gap: 10px; }
        .applicant-table .score-number {
            font-weight: 700;
            font-size: 15px;
            color: var(--primary-navy);
            min-width: 30px;
        }
        .applicant-table .progress-bar {
            width: 80px; height: 4px;
            background: #EEF2F6;
            border-radius: 4px;
            overflow: hidden;
        }
        .applicant-table .progress-fill {
            height: 100%;
            background: var(--action-blue);
            border-radius: 4px;
            transition: width .3s ease;
        }
        .applicant-table .status-badge {
            font-size: 10px;
            font-weight: 700;
            padding: 4px 14px;
            border-radius: 20px;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            display: inline-block;
        }
        .status-pending     { background: #FEF3C7; color: #92400E; }
        .status-shortlisted { background: #D1FAE5; color: #065F46; }
        .status-rejected    { background: #FEE2E2; color: #991B1B; }
        .status-hired       { background: #E0E7FF; color: #3730A3; }

        .applicant-table .action-link {
            width: 34px; height: 34px;
            border-radius: 50%;
            border: 1px solid var(--border);
            background: #fff;
            color: var(--action-blue);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            transition: all .2s ease;
        }
        .applicant-table .action-link:hover {
            background: var(--action-blue);
            color: #fff;
            border-color: var(--action-blue);
        }

        .eligibility-text {
            font-size: 11px;
            font-weight: 600;
            font-family: var(--font-ui);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--placeholder);
        }
        .empty-state i { font-size: 42px; color: #CBD5E1; }
        .empty-state p { margin: 14px 0 0 0; font-family: var(--font-ui); }

        /* ============================
           MOBILE
           ============================ */
        .mobile-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.5);
            z-index: 999;
            opacity: 0;
            transition: opacity .3s ease;
            pointer-events: none;
        }
        .mobile-overlay.active { opacity: 1; pointer-events: auto; }
        body.no-scroll { overflow: hidden !important; }
        .menu-btn { display: none; }

        /* ============================
           RESPONSIVE
           ============================ */
        @media (min-width: 1200px) {
            .content { padding: 32px 48px 60px; }
        }

        @media (min-width: 768px) and (max-width: 1024px) {
            .sidebar { width: 200px; }
            .sidebar.collapsed { width: 70px; }
            .content {
                margin-left: 200px;
                width: calc(100% - 200px);
                padding: 24px 24px 40px;
            }
            .content.expanded { margin-left: 70px; width: calc(100% - 70px); }
            .stats-row { grid-template-columns: repeat(3, 1fr); }
            .main-heading { font-size: 34px; }
        }

        @media (max-width: 900px) {
            .stats-row { grid-template-columns: repeat(3, 1fr); }
            .row-grid-2 { grid-template-columns: 1fr; }
        }

        @media (max-width: 767px) {
            .menu-btn {
                display: inline-flex !important;
                align-items: center;
                justify-content: center;
                border: 1px solid var(--border);
                background: #fff;
                font-size: 20px;
                color: var(--primary-navy);
                padding: 0;
                width: 42px;
                height: 42px;
                border-radius: var(--radius);
                cursor: pointer;
            }
            .sidebar-header .toggle-btn { display: none; }
            .sidebar {
                transform: translateX(-100%);
                width: 280px;
                transition: transform .35s ease;
            }
            .sidebar.mobile-open { transform: translateX(0); }
            .sidebar.collapsed { width: 280px; }
            .sidebar.collapsed .nav-link span { display: inline; }
            .sidebar.collapsed .nav-link i { width: 42px; min-width: 42px; }

            .content {
                margin-left: 0;
                width: 100%;
                padding: 20px 16px 40px;
            }
            .content.expanded { margin-left: 0; width: 100%; }

            .main-heading { font-size: 30px; }
            .stats-row { grid-template-columns: repeat(2, 1fr); }
            .page-header { flex-direction: column; align-items: flex-start; gap: 16px; }
            .page-header-right { width: 100%; justify-content: flex-end; }
            .admin-box .admin-text { display: none; }
            .dropdown-menu-custom { position: fixed; top: 62px; right: 12px; }

            .applicant-table-container { overflow-x: auto; }
            .applicant-table { min-width: 700px; }
        }

        @media (max-width: 480px) {
            .stats-row { grid-template-columns: 1fr; }
            .main-heading { font-size: 26px; }
        }

        @media (min-width: 768px) {
            .menu-btn { display: none; }
            .mobile-overlay { display: none !important; }
        }
    </style>
</head>

<body>

<form id="form1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <!-- Mobile overlay -->
    <div id="mobileOverlay" class="mobile-overlay"></div>

    <div class="wrapper">

        <!-- ============================
             SIDEBAR
             ============================ -->
        <div id="sidebar" class="sidebar">
            <div class="sidebar-header">
                <button type="button" id="sidebarToggleBtn" class="toggle-btn">
                    <i class="bi bi-arrow-left-circle"></i>
                </button>
            </div>

            <ul class="nav flex-column">
                <li class="nav-item">
                    <a href="AdminDashboard.aspx" class="nav-link active">
                        <i class="bi bi-grid-fill"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="AdminCandidatesView.aspx" class="nav-link">
                        <i class="bi bi-people-fill"></i>
                        <span>Candidates</span>
                    </a>
                </li>
            </ul>
        </div>

        <!-- ============================
             CONTENT
             ============================ -->
        <div id="content" class="content">

            <!-- ============================
                 PAGE HEADER (matches Personal.aspx)
                 ============================ -->
            <div class="page-header">

                <div class="page-header-left">
                    <button type="button" class="menu-btn" onclick="toggleSidebar()">
                        <i class="bi bi-list"></i>
                    </button>
                    <img src="Images/bu_logo.png" alt="Bahria University" class="logo" />
                    <div>
                        <div class="uni-name">Bahria University</div>
                        <div class="hr-portal">HR Portal</div>
                    </div>
                </div>

                <div class="page-header-right">

                    <button type="button" class="header-icon">
                        <i class="bi bi-bell"></i>
                        <span class="notification-dot"></span>
                    </button>

                    <div class="admin-box">
                        <div class="admin-text">
                            <div class="admin-name">
                                <asp:Label ID="lblAdminName" runat="server" Text="System Administrator" />
                            </div>
                            <div class="admin-role">Admin</div>
                        </div>
                        <div class="profile-circle" onclick="toggleDropdown(event)">
                            A
                            <span class="dropdown-arrow">▼</span>
                        </div>

                        <div id="dropdownMenu" class="dropdown-menu-custom">
                            <a href="AdminProfile.aspx" class="dropdown-item" onclick="event.stopPropagation();">
                                <i class="bi bi-person-circle"></i> My Profile
                            </a>
                            <a href="AdminSettings.aspx" class="dropdown-item" onclick="event.stopPropagation();">
                                <i class="bi bi-gear"></i> Settings
                            </a>
                            <div class="dropdown-divider"></div>
                            <asp:LinkButton ID="lnkLogout" runat="server"
                                CssClass="dropdown-item logout-item"
                                OnClick="lnkLogout_Click"
                                OnClientClick="event.stopPropagation();">
                                <i class="bi bi-box-arrow-right"></i> Logout
                            </asp:LinkButton>
                        </div>
                    </div>

                </div>

            </div>

            <!-- ============================
                 MAIN HEADING
                 ============================ -->
            <h1 class="main-heading">System Dashboard</h1>
            <p class="main-subtitle">Overview of all candidate applications across all stages.</p>

            <!-- ============================
                 CREATE JOB BUTTONS
                 ============================ -->
            <div class="section-card">
                <div class="section-heading">
                    <h3>Quick Actions</h3>
                </div>
                <div style="display:flex; gap:12px; flex-wrap:wrap;">
                    <asp:HyperLink ID="lnkCreateTeachingJob" runat="server"
                        NavigateUrl="~/CreateJob.aspx"
                        CssClass="btn-action">
                        <i class="bi bi-plus-circle"></i>
                        Create Teaching Job Post
                    </asp:HyperLink>
                    <asp:HyperLink ID="lnkCreateNonTeachingJob" runat="server"
                        NavigateUrl="~/NonCreateJob.aspx"
                        CssClass="btn-action btn-action-alt">
                        <i class="bi bi-plus-circle"></i>
                        Create Non-Teaching Job Post
                    </asp:HyperLink>
                </div>
            </div>

            <!-- ============================
                 STATS CARDS
                 ============================ -->
            <div class="section-card" style="padding: 22px 26px;">
                <div class="section-heading">
                    <h3>Statistics</h3>
                </div>

                <asp:Repeater ID="rptStats" runat="server" OnItemCommand="rptStats_ItemCommand">
                    <HeaderTemplate>
                        <div class="stats-row">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:LinkButton ID="btnStat" runat="server"
                            CssClass="stats-card"
                            CommandName="select"
                            CommandArgument='<%# Eval("Key") %>'>
                            <div class="stat-icon">
                                <i class='<%# GetStatIcon(Eval("Key").ToString()) %>'></i>
                            </div>
                            <div class="stat-number"><%# Eval("Value") %></div>
                            <div class="stat-label"><%# Eval("Label") %></div>
                        </asp:LinkButton>
                    </ItemTemplate>
                    <FooterTemplate>
                        </div>
                    </FooterTemplate>
                </asp:Repeater>
            </div>

            <!-- ============================
                 TABS
                 ============================ -->
            <div class="section-card">
                <div class="section-heading">
                    <h3>Filter</h3>
                </div>
                <div class="tabs-row">
                    <asp:Repeater ID="rptTabs" runat="server" OnItemCommand="rptTabs_ItemCommand">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnTab" runat="server"
                                CssClass='<%# GetTabClass(Eval("Id").ToString()) %> tab-btn'
                                CommandName="select"
                                CommandArgument='<%# Eval("Id") %>'>
                                <%# Eval("Label") %>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <!-- ============================
                 APPLICATIONS (with Search + Sort)
                 ============================ -->
            <asp:UpdatePanel ID="upnlMain" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                <ContentTemplate>

                    <asp:Panel ID="pnlSort" runat="server">
                        <div class="section-card">
                            <div class="section-heading">
                                <h3>Applicants</h3>
                            </div>

                            <div class="row-grid-2">
                                <div class="search-group">
                                    <asp:TextBox ID="txtSearch" runat="server"
                                        CssClass="form-control"
                                        placeholder="Search candidate name, email, or position..."
                                        AutoPostBack="true"
                                        OnTextChanged="txtSearch_TextChanged" />
                                    <asp:Button ID="btnSearch" runat="server"
                                        Text="Search"
                                        CssClass="btn-search"
                                        OnClick="btnSearch_Click" />
                                </div>

                                <asp:DropDownList ID="ddlSort" runat="server"
                                    CssClass="form-select"
                                    AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlSort_SelectedIndexChanged">
                                    <asp:ListItem Text="Top Scored" Value="score" />
                                    <asp:ListItem Text="Most Recent" Value="submitted" />
                                </asp:DropDownList>
                            </div>

                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlApplications" runat="server">
                        <div class="applicant-table-container">

                            <asp:Panel ID="pnlApplicationsEmpty" runat="server" Visible="false">
                                <div class="empty-state">
                                    <i class="bi bi-inbox"></i>
                                    <p>No applications found.</p>
                                </div>
                            </asp:Panel>

                            <table class="applicant-table">
                                <thead>
                                    <tr>
                                        <th>Candidate</th>
                                        <th>Position &amp; Hiring</th>
                                        <th>Total Score</th>
                                        <th>Status</th>
                                        <th style="text-align:right;">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptApplicantCards" runat="server"
                                        OnItemDataBound="rptApplicantCards_ItemDataBound">
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <div class="candidate-cell">
                                                        <asp:Image ID="imgApplicant" runat="server"
                                                            ImageUrl='<%# GetProfileImageUrl(Eval("Applicant.UserId")) %>'
                                                            CssClass="avatar-img"
                                                            AlternateText="Profile" />
                                                        <div>
                                                            <asp:HyperLink ID="hlApplicantName" runat="server"
                                                                NavigateUrl='<%# "AdminCandidatesView.aspx?id=" + Eval("Applicant.UserId") %>'
                                                                CssClass="candidate-name">
                                                                <%# Eval("Applicant.FullName") %>
                                                            </asp:HyperLink>
                                                            <div class="candidate-email"><%# Eval("Applicant.Email") %></div>
                                                            <asp:Label ID="lblEligibility" runat="server"
                                                                CssClass="eligibility-text"
                                                                Text='<%# Eval("EligibilityStatus") %>'
                                                                ForeColor='<%# Eval("EligibilityStatus").ToString().Contains("Not Eligible") ? System.Drawing.Color.Red : System.Drawing.Color.Green %>' />
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div>
                                                        <span class="position-text">Lecturer</span><br />
                                                        <span class="hiring-badge">PERMANENT</span>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="score-wrapper">
                                                        <span class="score-number"><%# GetTotalScoreDisplay(Eval("GrandTotalScore")) %></span>
                                                        <div class="progress-bar">
                                                            <div id="progressFill" runat="server" class="progress-fill" style="width: 0%;"></div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <span class='status-badge status-<%# Eval("Status").ToString().ToLower() %>'>
                                                        <%# Eval("Status") %>
                                                    </span>
                                                </td>
                                                <td style="text-align:right;">
                                                    <asp:HyperLink ID="hlViewApplicant" runat="server"
                                                        NavigateUrl='<%# "AdminCandidatesView.aspx?id=" + Eval("Applicant.UserId") %>'
                                                        CssClass="action-link"
                                                        ToolTip="View Applicant Details">
                                                        <i class="bi bi-arrow-right"></i>
                                                    </asp:HyperLink>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>

                        </div>
                    </asp:Panel>

                </ContentTemplate>
            </asp:UpdatePanel>

            <!-- ============================
                 INCOMPLETE APPLICANTS
                 ============================ -->
            <asp:UpdatePanel ID="upnlIncomplete" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                <ContentTemplate>

                    <asp:Panel ID="pnlIncomplete" runat="server">

                        <asp:Panel ID="pnlIncompleteSort" runat="server">
                            <div class="section-card">
                                <div class="section-heading">
                                    <h3>Incomplete Applicants</h3>
                                </div>

                                <div class="row-grid-2" style="grid-template-columns: 2fr 1fr;">
                                    <div class="search-group">
                                        <asp:TextBox ID="txtIncompleteSearch" runat="server"
                                            CssClass="form-control"
                                            placeholder="Search applicant..."
                                            AutoPostBack="true"
                                            OnTextChanged="txtIncompleteSearch_TextChanged" />
                                        <asp:Button ID="btnIncompleteSearch" runat="server"
                                            Text="Search"
                                            CssClass="btn-search"
                                            OnClick="btnIncompleteSearch_Click" />
                                    </div>

                                    <asp:DropDownList ID="ddlIncompleteSort" runat="server"
                                        CssClass="form-select"
                                        AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlIncompleteSort_SelectedIndexChanged">
                                        <asp:ListItem Text="Latest Registered" Value="registered" />
                                        <asp:ListItem Text="Name (A-Z)" Value="name" />
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </asp:Panel>

                        <div class="applicant-table-container">

                            <asp:Panel ID="pnlIncompleteEmpty" runat="server" Visible="false">
                                <div class="empty-state">
                                    <i class="bi bi-inbox"></i>
                                    <p>No incomplete applicants found.</p>
                                </div>
                            </asp:Panel>

                            <table class="applicant-table">
                                <thead>
                                    <tr>
                                        <th>Candidate</th>
                                        <th>Registered</th>
                                        <th>Status</th>
                                        <th style="text-align:right;">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptIncompleteCards" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <div class="candidate-cell">
                                                        <asp:Image ID="imgIncompleteApplicant" runat="server"
                                                            ImageUrl='<%# GetProfileImageUrl(Eval("UserId")) %>'
                                                            CssClass="avatar-img"
                                                            AlternateText="Profile" />
                                                        <div>
                                                            <asp:HyperLink ID="hlIncompleteName" runat="server"
                                                                NavigateUrl='<%# "AdminCandidatesView.aspx?id=" + Eval("UserId") %>'
                                                                CssClass="candidate-name">
                                                                <%# Eval("FullName") %>
                                                            </asp:HyperLink>
                                                            <div class="candidate-email"><%# Eval("Email") %></div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <span style="font-size:13px; color:#64748b;">
                                                        <%# FormatDate(Eval("RegisteredAt")) %>
                                                    </span>
                                                </td>
                                                <td>
                                                    <span class="status-badge status-pending">Incomplete</span>
                                                </td>
                                                <td style="text-align:right;">
                                                    <asp:HyperLink ID="hlViewIncomplete" runat="server"
                                                        NavigateUrl='<%# "AdminCandidatesView.aspx?id=" + Eval("UserId") %>'
                                                        CssClass="action-link"
                                                        ToolTip="View Applicant Details">
                                                        <i class="bi bi-arrow-right"></i>
                                                    </asp:HyperLink>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>

                        </div>

                    </asp:Panel>

                </ContentTemplate>
            </asp:UpdatePanel>

        </div>
        <!-- content -->

    </div>
    <!-- wrapper -->

</form>

<script>

    function toggleDropdown(event) {
        event.stopPropagation();
        var dropdown = document.getElementById('dropdownMenu');
        dropdown.classList.toggle('show');
    }

    document.addEventListener('click', function (event) {
        var dropdown = document.getElementById('dropdownMenu');
        var adminBox = document.querySelector('.admin-box');
        if (dropdown && adminBox) {
            if (!adminBox.contains(event.target)) {
                dropdown.classList.remove('show');
            }
        }
    });

    function toggleSidebar() {
        const sidebar = document.getElementById("sidebar");
        const overlay = document.getElementById("mobileOverlay");
        const body = document.body;

        if (!sidebar) return;

        sidebar.classList.toggle("mobile-open");
        overlay.classList.toggle("active");

        if (sidebar.classList.contains('mobile-open')) {
            body.classList.add('no-scroll');
        } else {
            body.classList.remove('no-scroll');
        }

        const icon = document.querySelector('.menu-btn i');
        if (icon) {
            if (sidebar.classList.contains('mobile-open')) {
                icon.className = 'bi bi-x-lg';
            } else {
                icon.className = 'bi bi-list';
            }
        }
    }

    document.addEventListener('DOMContentLoaded', function () {
        const overlay = document.getElementById('mobileOverlay');
        if (overlay) {
            overlay.addEventListener('click', function () {
                const sidebar = document.getElementById('sidebar');
                if (sidebar && sidebar.classList.contains('mobile-open')) {
                    toggleSidebar();
                }
            });
        }

        document.querySelectorAll('.sidebar .nav-link').forEach(function (link) {
            link.addEventListener('click', function () {
                const sidebar = document.getElementById('sidebar');
                if (window.innerWidth <= 768 && sidebar && sidebar.classList.contains('mobile-open')) {
                    toggleSidebar();
                }
            });
        });
    });

    document.addEventListener('DOMContentLoaded', function () {
        var toggleBtn = document.getElementById('sidebarToggleBtn');
        var sidebar = document.getElementById('sidebar');
        var content = document.getElementById('content');
        var icon = toggleBtn ? toggleBtn.querySelector('i') : null;

        if (toggleBtn) {
            toggleBtn.addEventListener('click', function () {
                if (window.innerWidth > 768) {
                    sidebar.classList.toggle('collapsed');
                    content.classList.toggle('expanded');

                    if (sidebar.classList.contains('collapsed')) {
                        icon.className = 'bi bi-arrow-right-circle';
                    } else {
                        icon.className = 'bi bi-arrow-left-circle';
                    }
                }
            });
        }
    });

    // ============================================
    // FALLBACK: close sidebar when clicking outside it on mobile
    // ============================================
    document.addEventListener('click', function (e) {
        if (window.innerWidth > 767) return;
        var sidebar = document.getElementById('sidebar');
        if (!sidebar || !sidebar.classList.contains('mobile-open')) return;

        // Ignore clicks inside the sidebar
        if (sidebar.contains(e.target)) return;

        // Ignore clicks on the hamburger button
        var hamburger = document.querySelector('.menu-btn');
        if (hamburger && hamburger.contains(e.target)) return;

        // Close the sidebar
        sidebar.classList.remove('mobile-open');
        var overlay = document.getElementById('mobileOverlay');
        if (overlay) overlay.classList.remove('active');
        document.body.classList.remove('no-scroll');
        var icon = hamburger ? hamburger.querySelector('i') : null;
        if (icon) icon.className = 'bi bi-list';
    });

</script>

</body>
</html>