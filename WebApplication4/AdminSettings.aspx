<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminSettings.aspx.cs" Inherits="WebApplication4.AdminSettings" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Settings</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <style>
        /*====================================================
            GENERAL
        ====================================================*/
        body {
            margin: 0;
            padding: 0;
            background: #f5f7fb;
            font-family: 'Segoe UI', Arial, sans-serif;
            overflow-x: hidden;
        }
        * {
            box-sizing: border-box;
        }

        /*====================================================
            HEADER
        ====================================================*/
        .top-header {
            position: fixed;
            top: 0;
            left: 250px;
            width: calc(100% - 250px);
            height: 70px;
            transition: .35s ease;
            background: #fff;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 25px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, .08);
            z-index: 1200;
        }
        .header-left, .header-center, .header-right {
            display: flex;
            align-items: center;
        }
        .header-left { min-width: 80px; }
        .header-center { flex: 1; justify-content: center; }
        .header-center h3 {
            margin: 0;
            font-weight: 700;
            color: #101827;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .header-right {
            gap: 18px;
            justify-content: flex-end;
            min-width: 220px;
        }
        .header-icon {
            position: relative;
            border: none;
            background: none;
            font-size: 23px;
            color: #101827;
            cursor: pointer;
            transition: .25s;
        }
        .header-icon:hover { color: #3557b7; }
        .notification-dot {
            position: absolute;
            width: 8px;
            height: 8px;
            top: 4px;
            right: 4px;
            background: #dc3545;
            border-radius: 50%;
        }
        .admin-box {
            display: flex;
            align-items: center;
            gap: 12px;
            position: relative;
            cursor: pointer;
        }
        .profile-circle {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: #3557b7;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 18px;
            font-family: 'Segoe UI', Arial, sans-serif;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
        }
        .profile-circle:hover { transform: scale(1.05); }
        .profile-circle .dropdown-arrow {
            position: absolute;
            bottom: -2px;
            right: -6px;
            font-size: 12px;
            background: #3557b7;
            color: #fff;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 2px solid #fff;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.2);
            font-size: 8px;
            padding: 0;
            line-height: 1;
        }
        .dropdown-menu-custom {
            display: none;
            position: absolute;
            top: 60px;
            right: 0;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
            min-width: 180px;
            padding: 8px 0;
            z-index: 1300;
            border: 1px solid #e8ecf1;
            overflow: hidden;
        }
        .dropdown-menu-custom.show { display: block; }
        .dropdown-menu-custom .dropdown-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 20px;
            color: #1a2332;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s ease;
            font-family: 'Segoe UI', Arial, sans-serif;
            border: none;
            background: none;
            width: 100%;
            text-align: left;
            cursor: pointer;
        }
        .dropdown-menu-custom .dropdown-item:hover { background: #f5f7fb; }
        .dropdown-menu-custom .dropdown-item i {
            font-size: 18px;
            color: #64748b;
        }
        .dropdown-menu-custom .dropdown-divider {
            height: 1px;
            background: #e8ecf1;
            margin: 4px 0;
        }
        .dropdown-menu-custom .dropdown-item.logout-item { color: #dc3545; }
        .dropdown-menu-custom .dropdown-item.logout-item i { color: #dc3545; }
        .dropdown-menu-custom .dropdown-item.logout-item:hover { background: #fef2f2; }
        .menu-btn { display: none; }

        /*====================================================
            SIDEBAR
        ====================================================*/
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            height: 100vh;
            background: #101827;
            color: #fff;
            display: flex;
            flex-direction: column;
            overflow: hidden;
            transition: all .35s ease;
            z-index: 1000;
        }
        .sidebar.collapsed { width: 80px; }
        .sidebar.collapsed .nav-link span { display: none; }
        .sidebar.collapsed .nav-link i {
            width: 100%;
            min-width: unset;
        }
        .sidebar.collapsed .sidebar-header .header-text { display: none; }
        .sidebar-header {
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-bottom: 1px solid rgba(255, 255, 255, .08);
            transition: .3s;
            padding: 0 16px;
        }
        .sidebar-header .toggle-btn {
            background: none;
            border: none;
            color: #fff;
            font-size: 24px;
            cursor: pointer;
            padding: 8px;
            border-radius: 8px;
            transition: .25s;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .sidebar-header .toggle-btn:hover { background: rgba(255, 255, 255, .08); }
        .sidebar-header .toggle-btn i { font-size: 24px; }
        .sidebar .nav {
            margin-top: 18px;
            padding: 0;
            flex: 1;
        }
        .sidebar .nav-item { margin-bottom: 8px; }
        .sidebar .nav-link {
            display: flex;
            align-items: center;
            height: 52px;
            margin: 0 12px;
            padding: 0 16px;
            border-radius: 12px;
            color: #d7dce6;
            text-decoration: none;
            transition: .25s;
            white-space: nowrap;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .sidebar .nav-link:hover {
            background: #233c87;
            color: #fff;
        }
        .sidebar .nav-link.active {
            background: #3557b7;
            color: #fff;
        }
        .sidebar .nav-link i {
            width: 42px;
            min-width: 42px;
            text-align: center;
            font-size: 20px;
        }

        /*====================================================
            CONTENT
        ====================================================*/
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

        /*====================================================
            SETTINGS CARD
        ====================================================*/
        .settings-card {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, .08);
            padding: 30px;
            border: 1px solid #e8ecf1;
            max-width: 800px;
            margin: 0 auto;
        }
        .settings-card .page-title {
            font-size: 24px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 5px;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .settings-card .page-subtitle {
            font-size: 14px;
            color: #6c757d;
            margin-bottom: 25px;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .settings-card .section-title {
            font-size: 16px;
            font-weight: 600;
            color: #0f172a;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f1f4f9;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .settings-card .form-label {
            font-weight: 600;
            font-size: 13px;
            color: #1a2332;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .settings-card .form-control {
            border-radius: 10px;
            min-height: 45px;
            box-shadow: none;
            font-family: 'Segoe UI', Arial, sans-serif;
            border: 1px solid #e2e8f0;
        }
        .settings-card .form-control:focus {
            border-color: #3557b7;
            box-shadow: 0 0 0 .2rem rgba(53, 87, 183, .15);
        }
        .settings-card .form-control[readonly] {
            background: #f8fafc;
            cursor: not-allowed;
        }
        .settings-card .btn-primary {
            background: #1a3a7a;
            border-color: #1a3a7a;
            border-radius: 10px;
            padding: 10px 30px;
            font-weight: 600;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .settings-card .btn-primary:hover {
            background: #2a5aaa;
            border-color: #2a5aaa;
        }
        .settings-card .alert {
            border-radius: 10px;
            font-family: 'Segoe UI', Arial, sans-serif;
        }

        /*====================================================
            MOBILE RESPONSIVE
        ====================================================*/
        .mobile-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 999;
            opacity: 0;
            transition: opacity 0.3s ease;
            pointer-events: none;
        }
        .mobile-overlay.active {
            opacity: 1;
            pointer-events: auto;
        }
        body.no-scroll { overflow: hidden !important; }

        @media (max-width: 767px) {
            .menu-btn {
                display: flex !important;
                align-items: center;
                justify-content: center;
                border: none;
                background: none;
                font-size: 28px;
                color: #101827;
                padding: 0;
                width: 40px;
                height: 40px;
            }
            .sidebar-header .toggle-btn { display: none; }
            .sidebar {
                transform: translateX(-100%);
                width: 280px;
                transition: transform 0.35s ease;
                z-index: 1000;
                position: fixed;
                top: 0;
                left: 0;
                height: 100vh;
                display: flex;
                flex-direction: column;
                overflow: hidden;
            }
            .sidebar.mobile-open { transform: translateX(0); }
            .sidebar.collapsed { width: 280px; }
            .sidebar.collapsed .nav-link span { display: inline; }
            .sidebar.collapsed .nav-link i {
                width: 42px;
                min-width: 42px;
            }
            .mobile-overlay {
                display: block;
                z-index: 999;
            }
            .top-header {
                left: 0;
                width: 100%;
                height: 70px;
                padding: 0 15px;
            }
            .header-left { min-width: auto; }
            .header-center h3 { font-size: 20px; }
            .header-right {
                gap: 10px;
                min-width: auto;
            }
            .admin-box .text-end { display: none; }
            .profile-circle {
                width: 38px;
                height: 38px;
                font-size: 16px;
            }
            .content {
                margin-left: 0;
                width: 100%;
                padding: 80px 15px 20px 15px;
                min-height: calc(100vh - 70px);
            }
            .content.expanded {
                margin-left: 0;
                width: 100%;
            }
            .settings-card { padding: 20px; }
            .settings-card .page-title { font-size: 20px; }
            .dropdown-menu-custom {
                position: fixed;
                top: 60px;
                right: 10px;
                min-width: 160px;
            }
            .dropdown-menu-custom .dropdown-item {
                padding: 10px 16px;
                font-size: 13px;
            }
        }

        @media (min-width: 768px) {
            .menu-btn { display: none; }
            .mobile-overlay { display: none !important; }
            .dropdown-menu-custom {
                position: absolute;
                top: 60px;
                right: 0;
                min-width: 180px;
            }
        }

        @media (max-width: 480px) {
            .settings-card .page-title { font-size: 18px; }
            .settings-card .form-label { font-size: 12px; }
            .settings-card .form-control { font-size: 13px; min-height: 40px; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <!-- HEADER -->
        <header class="top-header">
            <div class="header-left">
                <button type="button" class="btn menu-btn" onclick="toggleSidebar()">
                    <i class="bi bi-list fs-4"></i>
                </button>
            </div>
            <div class="header-center">
                <h3 class="m-0 fw-bold">Settings</h3>
            </div>
            <div class="header-right">
                <button type="button" class="header-icon">
                    <i class="bi bi-bell"></i>
                    <span class="notification-dot"></span>
                </button>
                <p>|</p>
                <div class="admin-box" onclick="toggleDropdown(event)">
                    <div class="text-end">
                        <div class="fw-semibold">
                            <asp:Label ID="lblAdminName" runat="server" Text="Administrator" />
                        </div>
                        <small class="text-muted">ADMIN</small>
                    </div>
                    <div class="profile-circle">
                        <asp:Label ID="lblAdminInitial" runat="server" Text="A" />
                        <span class="dropdown-arrow">▼</span>
                    </div>
                   <asp:LinkButton ID="lnkLogout" runat="server" 
    CssClass="dropdown-item logout-item" 
    OnClick="lnkLogout_Click"
    OnClientClick="event.stopPropagation();">
    <i class="bi bi-box-arrow-right"></i> Logout
</asp:LinkButton>
                </div>
            </div>
        </header>

        <!-- Mobile Overlay -->
        <div id="mobileOverlay" class="mobile-overlay"></div>

        <!-- SIDEBAR -->
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
                    <a href="AdminProfile.aspx" class="nav-link">
                        <i class="bi bi-person-circle"></i>
                        <span>My Profile</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="AdminSettings.aspx" class="nav-link active">
                        <i class="bi bi-gear"></i>
                        <span>Settings</span>
                    </a>
                </li>
            </ul>
        </div>

        <!-- CONTENT -->
        <div id="content" class="content">
            <div class="settings-card">

                <h1 class="page-title"><i class="bi bi-gear me-2" style="color:#1a3a7a;"></i>Settings</h1>
                <p class="page-subtitle">Manage your account security and preferences</p>

                <!-- Success/Error Messages -->
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

                <!-- CHANGE EMAIL -->
                <h5 class="section-title"><i class="bi bi-envelope me-2"></i>Change Email</h5>

                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Current Email</label>
                        <asp:TextBox ID="txtCurrentEmail" runat="server" CssClass="form-control" ReadOnly="true" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">New Email</label>
                        <asp:TextBox ID="txtNewEmail" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Confirm New Email</label>
                        <asp:TextBox ID="txtConfirmEmail" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-6 d-flex align-items-end">
                        <asp:Button ID="btnChangeEmail" runat="server" Text="Change Email" CssClass="btn btn-primary" OnClick="btnChangeEmail_Click" />
                    </div>
                </div>

                <hr class="my-4" />

                <!-- CHANGE PASSWORD -->
                <h5 class="section-title"><i class="bi bi-shield-lock me-2"></i>Change Password</h5>

                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Current Password</label>
                        <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="form-control" TextMode="Password" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">New Password</label>
                        <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Confirm New Password</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" />
                    </div>
                    <div class="col-md-6 d-flex align-items-end">
                        <asp:Button ID="btnChangePassword" runat="server" Text="Change Password" CssClass="btn btn-primary" OnClick="btnChangePassword_Click" />
                    </div>
                </div>

                <hr class="my-4" />

                <!-- SESSION MANAGEMENT -->
                <h5 class="section-title"><i class="bi bi-clock-history me-2"></i>Session Management</h5>

                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Last Login</label>
                        <asp:TextBox ID="txtLastLogin" runat="server" CssClass="form-control" ReadOnly="true" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Account Status</label>
                        <asp:TextBox ID="txtAccountStatus" runat="server" CssClass="form-control" ReadOnly="true" Text="Active" />
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
                    icon.className = 'bi bi-x-lg fs-4';
                } else {
                    icon.className = 'bi bi-list fs-4';
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
    </script>
</body>
</html>