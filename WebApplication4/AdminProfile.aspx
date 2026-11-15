<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminProfile.aspx.cs" Inherits="WebApplication4.AdminProfile" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Profile</title>
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
            overflow-x: hidden;
        }

        /* HEADER */
        .top-header {
            position: fixed;
            top: 0;
            left: 250px;
            width: calc(100% - 250px);
            height: 70px;
            transition: all .35s ease;
            background: #fff;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 25px;
            border-bottom: 1px solid var(--border);
            box-shadow: 0 1px 3px rgba(15,23,42,0.04);
            z-index: 1200;
        }
        .header-left, .header-center, .header-right { display: flex; align-items: center; }
        .header-left { min-width: 80px; }
        .header-center { flex: 1; justify-content: center; }
        .header-center h3 {
            margin: 0;
            font-family: var(--font-ui);
            font-weight: 700;
            font-size: 18px;
            color: var(--primary-navy);
        }
        .header-right { gap: 18px; justify-content: flex-end; min-width: 220px; }
        .header-right .divider-pipe {
            font-size: 22px;
            color: var(--border);
            margin: 0;
            line-height: 1;
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
            transition: all .2s ease;
        }
        .header-icon:hover { background: #F1F5F9; border-color: var(--action-blue); }
        .notification-dot {
            position: absolute;
            width: 8px;
            height: 8px;
            top: 8px;
            right: 8px;
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
        .admin-box .text-end {
            cursor: default;
            text-align: right;
            line-height: 1.25;
        }
        .admin-box .text-end .fw-semibold {
            font-family: var(--font-ui);
            font-weight: 600;
            font-size: 14px;
            color: var(--primary-navy);
        }
        .admin-box .text-end small {
            font-family: var(--font-ui);
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
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: var(--font-ui);
            font-weight: 700;
            font-size: 16px;
            cursor: pointer;
            position: relative;
            transition: transform 0.2s ease;
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
            display: flex;
            align-items: center;
            justify-content: center;
            border: 2px solid #fff;
            padding: 0;
            line-height: 1;
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
            font-family: var(--font-ui);
            font-size: 13px;
            font-weight: 500;
            border: none;
            background: none;
            width: 100%;
            text-align: left;
            cursor: pointer;
            transition: background .15s ease;
        }
        .dropdown-menu-custom .dropdown-item:hover { background: #F8FAFC; }
        .dropdown-menu-custom .dropdown-item i { font-size: 16px; color: var(--muted-text); }
        .dropdown-menu-custom .dropdown-divider { height: 1px; background: var(--divider); margin: 4px 0; }
        .dropdown-menu-custom .dropdown-item.logout-item { color: var(--error-red); }
        .dropdown-menu-custom .dropdown-item.logout-item i { color: var(--error-red); }
        .dropdown-menu-custom .dropdown-item.logout-item:hover { background: #FEF2F2; }
        .menu-btn { display: none; }

        /* SIDEBAR */
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
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background .2s ease;
        }
        .sidebar-header .toggle-btn:hover { background: rgba(255,255,255,0.08); }
        .sidebar-header .toggle-btn i { font-size: 22px; }
        .sidebar .nav { margin-top: 18px; padding: 0; flex: 1; list-style: none; }
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

        /* CONTENT */
        .content {
            margin-left: 250px;
            width: calc(100% - 250px);
            min-height: calc(100vh - 70px);
            padding: 100px 30px 30px 30px;
            transition: all .35s ease;
        }
        .content.expanded {
            margin-left: 80px;
            width: calc(100% - 80px);
        }

        /* PROFILE CARD */
        .profile-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            box-shadow: 0 1px 3px rgba(15,23,42,0.03);
            padding: 30px;
            max-width: 800px;
            margin: 0 auto;
        }
        .profile-card .page-title {
            font-family: var(--font-heading);
            font-size: 30px;
            font-weight: 600;
            color: var(--primary-navy);
            margin: 0 0 5px 0;
            letter-spacing: -0.2px;
        }
        .profile-card .page-subtitle {
            font-family: var(--font-ui);
            font-size: 14px;
            color: var(--muted-text);
            margin: 0 0 25px 0;
        }
        .profile-card .section-title {
            font-family: var(--font-heading);
            font-size: 20px;
            font-weight: 600;
            color: var(--primary-navy);
            margin: 0 0 20px 0;
            padding-bottom: 10px;
            border-bottom: 1px solid var(--divider);
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .profile-card .section-title i { color: var(--action-blue); font-size: 16px; }
        .profile-card .form-label {
            display: block;
            font-family: var(--font-ui);
            font-weight: 500;
            font-size: 13px;
            color: var(--body-text);
            margin-bottom: 7px;
        }
        .profile-card .form-control {
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
        .profile-card .form-control:focus {
            outline: none;
            border-color: var(--action-blue);
            box-shadow: 0 0 0 2px rgba(23,105,168,0.08);
        }
        .profile-card .form-control[readonly] {
            background: #F1F5F9;
            cursor: not-allowed;
            color: var(--muted-text);
        }
        .profile-card .btn-primary {
            background: var(--action-blue);
            border: none;
            color: #fff;
            border-radius: var(--radius);
            padding: 11px 26px;
            font-family: var(--font-ui);
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: background .15s ease;
            margin-top: 8px;
            margin-bottom: 8px;
            white-space: nowrap;
        }
        .profile-card .btn-primary:hover { background: var(--action-blue-hover); }
        .profile-card .btn-primary.btn-sm {
            padding: 11px 22px;
            font-size: 14px;
            margin-top: 0;
            margin-bottom: 0;
        }
        .profile-card .alert {
            border-radius: var(--radius);
            padding: 14px 18px;
            font-family: var(--font-ui);
            font-size: 14px;
            margin-bottom: 20px;
            border: none;
            border-left: 4px solid;
        }
        .profile-card .alert-success {
            background: #DCFCE7;
            color: #166534;
            border-left-color: #22C55E;
        }
        .profile-card .alert-danger {
            background: #FEE2E2;
            color: #991B1B;
            border-left-color: var(--error-red);
        }
        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid var(--border);
            background: #F1F5F9;
        }
        .profile-avatar-placeholder {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: var(--action-blue);
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: var(--font-ui);
            font-weight: 700;
            font-size: 40px;
            border: 3px solid var(--border);
        }
        .text-muted { color: var(--muted-text) !important; }

        /* ============================================
           FILE UPLOAD + UPLOAD BUTTON ROW
           ============================================ */

        /* File input styling — matches Personal.aspx, doesn't eat the whole row */
        .profile-card input[type="file"] {
            font-family: var(--font-ui);
            font-size: 13px;
            color: var(--body-text);
            background: var(--input-bg);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            height: 44px;
            padding: 5px 12px;
            width: auto;
            max-width: 260px;
            flex: 0 0 auto;
            display: inline-flex;
            align-items: center;
            vertical-align: middle;
        }

        .profile-card input[type="file"]::file-selector-button {
            background: #FFFFFF;
            border: 1px solid #C9D6E2;
            color: var(--primary-navy);
            font-family: var(--font-ui);
            font-weight: 500;
            font-size: 13px;
            border-radius: var(--radius);
            padding: 7px 16px;
            cursor: pointer;
            transition: background 0.15s ease;
            margin-right: 12px;
        }

        .profile-card input[type="file"]::file-selector-button:hover {
            background: #F1F5F9;
        }

        /* Upload row: file input + Upload button, well-spaced */
        .profile-card .upload-row {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 16px;
            flex-wrap: nowrap;
            margin-top: 16px;
        }

        /* MOBILE */
        .mobile-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(18,48,74,0.5);
            z-index: 999;
            opacity: 0;
            transition: opacity .3s ease;
            pointer-events: none;
        }
        .mobile-overlay.active { opacity: 1; pointer-events: auto; }
        body.no-scroll { overflow: hidden !important; }

        @media (max-width: 767px) {
            .menu-btn {
                display: flex !important;
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
            .mobile-overlay { display: block; z-index: 999; }
            .top-header { left: 0; width: 100%; height: 70px; padding: 0 15px; }
            .header-left { min-width: auto; }
            .header-center h3 { font-size: 16px; }
            .header-right { gap: 10px; min-width: auto; }
            .admin-box .text-end { display: none; }
            .profile-circle { width: 38px; height: 38px; font-size: 14px; }
            .content {
                margin-left: 0;
                width: 100%;
                padding: 90px 15px 20px 15px;
                min-height: calc(100vh - 70px);
            }
            .content.expanded { margin-left: 0; width: 100%; }
            .profile-card { padding: 22px 18px; }
            .profile-card .page-title { font-size: 24px; }
            .profile-card .section-title { font-size: 18px; }
            .dropdown-menu-custom { position: fixed; top: 62px; right: 12px; min-width: 160px; }
            .dropdown-menu-custom .dropdown-item { padding: 10px 16px; font-size: 13px; }
        }

        @media (min-width: 768px) {
            .menu-btn { display: none; }
            .mobile-overlay { display: none !important; }
            .dropdown-menu-custom { position: absolute; top: 56px; right: 0; min-width: 180px; }
        }

        @media (max-width: 560px) {
            .profile-card .upload-row {
                flex-wrap: wrap;
            }
            .profile-card input[type="file"] {
                max-width: 100%;
                width: 100%;
                padding:5px;
            }
        }

        @media (max-width: 480px) {
            .profile-card .page-title { font-size: 22px; }
            .profile-card .form-label { font-size: 12px; }
            .profile-card .form-control { font-size: 13px; height: 42px; }
            .profile-avatar, .profile-avatar-placeholder {
                width: 70px; height: 70px; font-size: 28px;
            }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <header class="top-header">
            <div class="header-left">
                <button type="button" class="menu-btn" onclick="toggleSidebar()">
                    <i class="bi bi-list"></i>
                </button>
            </div>
            <div class="header-center">
                <h3>My Profile</h3>
            </div>
            <div class="header-right">
                <button type="button" class="header-icon">
                    <i class="bi bi-bell"></i>
                    <span class="notification-dot"></span>
                </button>
                <span class="divider-pipe">|</span>
                <div class="admin-box">
                    <div class="text-end">
                        <div class="fw-semibold">
                            <asp:Label ID="lblAdminName" runat="server" Text="System Administrator" />
                        </div>
                        <small>ADMIN</small>
                    </div>
                    <div class="profile-circle" onclick="toggleDropdown(event)">
                        <asp:Label ID="lblAdminInitial" runat="server" Text="A" />
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
        </header>

        <div id="mobileOverlay" class="mobile-overlay"></div>

        <div id="sidebar" class="sidebar">
            <div class="sidebar-header">
                <button type="button" id="sidebarToggleBtn" class="toggle-btn">
                    <i class="bi bi-arrow-left-circle"></i>
                </button>
            </div>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a href="AdminDashboard.aspx" class="nav-link">
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
                <li class="nav-item">
                    <a href="AdminProfile.aspx" class="nav-link active">
                        <i class="bi bi-person-circle"></i>
                        <span>My Profile</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="AdminSettings.aspx" class="nav-link">
                        <i class="bi bi-gear"></i>
                        <span>Settings</span>
                    </a>
                </li>
            </ul>
        </div>

        <div id="content" class="content">
            <div class="profile-card">

                <h1 class="page-title">My Profile</h1>
                <p class="page-subtitle">View and update your personal information</p>

                <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="bi bi-check-circle me-2"></i>
                        <asp:Label ID="lblMessage" runat="server" />
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlError" runat="server" Visible="false">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-circle me-2"></i>
                        <asp:Label ID="lblError" runat="server" />
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </asp:Panel>

                <h5 class="section-title"><i class="bi bi-image"></i>Profile Picture</h5>

                <div class="row g-3 mb-4">
                    <div class="col-12 text-center">
                        <asp:Image ID="imgProfile" runat="server" CssClass="profile-avatar" ImageUrl="~/Images/default-avatar.png" AlternateText="Profile" />
                        <div class="upload-row">
                            <asp:FileUpload ID="fuProfileImage" runat="server" />
                            <asp:Button ID="btnUploadImage" runat="server" Text="Upload" CssClass="btn btn-primary btn-sm" OnClick="btnUploadImage_Click" />
                        </div>
                        <small class="text-muted d-block mt-2">Upload a profile picture (JPG or PNG, max 2MB)</small>
                    </div>
                </div>

                <h5 class="section-title"><i class="bi bi-person"></i>Personal Information</h5>

                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Full Name</label>
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Phone Number</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Role</label>
                        <asp:TextBox ID="txtRole" runat="server" CssClass="form-control" ReadOnly="true" Text="Administrator" />
                    </div>
                    <div class="col-12 mt-3">
                        <asp:Button ID="btnUpdateProfile" runat="server" Text="Update Profile" CssClass="btn btn-primary" OnClick="btnUpdateProfile_Click" />
                    </div>
                </div>

            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
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

        // FALLBACK: close sidebar when clicking outside it on mobile
        document.addEventListener('click', function (e) {
            if (window.innerWidth > 767) return;
            var sidebar = document.getElementById('sidebar');
            if (!sidebar || !sidebar.classList.contains('mobile-open')) return;
            if (sidebar.contains(e.target)) return;
            var hamburger = document.querySelector('.menu-btn');
            if (hamburger && hamburger.contains(e.target)) return;
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