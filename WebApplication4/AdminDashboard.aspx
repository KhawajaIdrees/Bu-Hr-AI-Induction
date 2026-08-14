<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="AdminDashboard.aspx.cs"
    Inherits="WebApplication4.AdminDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>Faculty Induction Admin Dashboard</title>

    <meta charset="utf-8" />

    <meta name="viewport"
          content="width=device-width, initial-scale=1" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css"
          rel="stylesheet" />

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
          rel="stylesheet" />

<style>

/*====================================================
                GENERAL
====================================================*/

body{

    margin:0;
    padding:0;

    background:#f5f7fb;

    font-family:'Inter', 'Segoe UI', sans-serif;

    overflow-x:hidden;

}

*{

    box-sizing:border-box;

}

/*====================================================
                HEADER
====================================================*/

.top-header{
    top:0;

    left:250px;

    width:calc(100% - 0px);

    height:70px;

    transition:.35s ease;

    background:#fff;

    display:flex;

    align-items:center;

    justify-content:space-between;

    padding:0 25px;

    box-shadow:0 2px 12px rgba(0,0,0,.08);

    z-index:1200;

}

.dashboard-header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:30px;
    flex-wrap:wrap;
    gap:10px;
}

.dashboard-header .btn{
    min-width:190px;
}

.header-left,
.header-center,
.header-right{

    display:flex;

    align-items:center;

}

.header-left{

    min-width:80px;

}

.header-right p{
    font-size: 40px;
}

.header-center{

    flex:1;

    justify-content:center;

}

.header-center h3{

    margin:0;

    font-weight:700;

    color:#101827;

    font-family:'Inter', 'Segoe UI', sans-serif;

}

.header-right{

    gap:18px;

    justify-content:flex-end;

    min-width:220px;

}

.dashboard-title{
    font-size:2.3rem;
    font-family:'Inter', 'Segoe UI', sans-serif;
}

.create-job-btn{
    padding:8px 16px;
    font-size:15px;
    white-space:nowrap;
}

/* ===========================
        JOB BUTTONS CONTAINER
=========================== */
.job-buttons-container {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
}

.job-buttons-container .btn {
    min-width: 180px;
    padding: 10px 20px;
    font-size: 14px;
    font-weight: 600;
    border-radius: 10px;
    transition: all 0.3s ease;
}

.job-buttons-container .btn-teaching {
    background: #1a3a7a;
    color: #fff;
    border: 2px solid #1a3a7a;
}

.job-buttons-container .btn-teaching:hover {
    background: #2a5aaa;
    border-color: #2a5aaa;
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(26, 58, 122, 0.3);
}

.job-buttons-container .btn-non-teaching {
    background: #e67e22;
    color: #fff;
    border: 2px solid #e67e22;
}

.job-buttons-container .btn-non-teaching:hover {
    background: #f39c12;
    border-color: #f39c12;
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(230, 126, 34, 0.3);
}

.job-buttons-container .btn i {
    margin-right: 8px;
}

.header-icon{

    position:relative;

    border:none;

    background:none;

    font-size:23px;

    color:#101827;

    cursor:pointer;

    transition:.25s;

}

.header-icon:hover{

    color:#3557b7;

}

.notification-dot{

    position:absolute;

    width:8px;

    height:8px;

    top:4px;

    right:4px;

    background:#dc3545;

    border-radius:50%;

}

.admin-box{

    display:flex;

    align-items:center;

    gap:12px;

}

.profile-circle{

    width:42px;
    height:42px;
    border-radius:50%;
    background:#3557b7;
    color:#fff;
    display:flex;
    align-items:center;
    justify-content:center;
    font-weight:700;
    font-size:18px;
    font-family:'Inter', 'Segoe UI', sans-serif;

}

/*====================================================
                LAYOUT
====================================================*/

.wrapper{

    display:flex;

    min-height:100vh;

    padding-top:0px;

}

/*====================================================
                    SIDEBAR
====================================================*/

.sidebar{

    position:fixed;

    top:0;

    left:0;

    width:250px;

    height:100vh;

    background:#101827;

    color:#fff;

    display:flex;

    flex-direction:column;

    overflow:hidden;

    transition:all .35s ease;

    z-index:1000;

}

.sidebar.collapsed{

    width:80px;

}

.sidebar.collapsed .nav-link span {
    display: none;
}
.sidebar.collapsed .nav-link i {
    width: 100%;
    min-width: unset;
}
.sidebar.collapsed .sidebar-header .header-text {
    display: none;
}

.sidebar-header{

    height:70px;

    display:flex;

    align-items:center;

    justify-content:center;

    border-bottom:1px solid rgba(255,255,255,.08);

    transition:.3s;
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
.sidebar-header .toggle-btn:hover {
    background: rgba(255,255,255,.08);
}
.sidebar-header .toggle-btn i {
    font-size: 24px;
}

.sidebar .nav{

    margin-top:18px;
    padding:0;

}

.sidebar .nav-item{

    margin-bottom:8px;

}

.sidebar .nav-link{

    display:flex;
    align-items:center;
    height:52px;
    margin:0 12px;
    padding:0 16px;
    border-radius:12px;
    color:#d7dce6;
    text-decoration:none;
    transition:.25s;
    white-space:nowrap;
    font-family:'Inter', 'Segoe UI', sans-serif;

}

.sidebar .nav-link:hover{

    background:#233c87;
    color:#fff;

}

.sidebar .nav-link.active{

    background:#3557b7;
    color:#fff;

}

.sidebar .nav-link i{

    width:42px;
    min-width:42px;
    text-align:center;
    font-size:20px;

}

.sidebar .nav-link span{

    transition:opacity .2s ease;

}

.logout{

    margin-top:auto;
    padding:20px 0;
    border-top:1px solid rgba(255,255,255,.08);

}

/*============ COLLAPSED ============*/

.sidebar.collapsed .nav-link{

    justify-content:center;
    width:56px;
    margin:0 auto 8px;
    padding:0;

}

.sidebar.collapsed .nav-link i{

    width:100%;
    margin:0;
    font-size:22px;

}

.sidebar.collapsed .nav-link span{

    display:none;

}

.sidebar.collapsed .logout .nav-link{

    justify-content:center;

}

.sidebar.collapsed .sidebar-header{

    justify-content:center;

}

.sidebar.collapsed + .top-header{

    left:80px;
    width:calc(100% - 80px);

}

/*====================================================
                    CONTENT
====================================================*/

.content{

    margin-left:250px;
    width:calc(100% - 250px);
    min-height:calc(100vh - 70px);
    padding:30px;
    transition:all .35s ease;

}

.content.expanded{

    margin-left:80px;
    width:calc(100% - 80px);

}

.container-fluid{

    padding:0;

}

.content h2{

    margin-top: 0px;
    font-weight:700;
    color:#101827;
    margin-bottom:30px;
    font-family:'Inter', 'Segoe UI', sans-serif;

}

/*====================================================
                    CARDS
====================================================*/

.card{

    border:none;
    border-radius:16px;
    box-shadow:0 4px 15px rgba(0,0,0,.08);
    transition:all .3s ease;

}

.card-header{

    border:none;
    border-radius:16px 16px 0 0 !important;
    font-weight:600;
    font-family:'Inter', 'Segoe UI', sans-serif;

}

.stats-card{

    border:2px solid transparent;
    cursor:pointer;
    transition:all .3s ease;

}

.stats-card:hover{

    border-color:#101827;
    transform:translateY(-5px);
    box-shadow:0 12px 25px rgba(16,24,39,.18);

}

.stats-card .card-body{
    padding:30px 20px;
    display:flex;
    flex-direction:column;
    align-items:center;
    justify-content:center;
    text-align:center;
}

.stats-card h3{
    font-weight:700;
    color:#101827;
    margin-bottom:8px;
    text-align:center;
    font-family:'Inter', 'Segoe UI', sans-serif;
}

.stats-card h6{
    font-weight:600;
    margin-bottom:4px;
    text-align:center;
    font-family:'Inter', 'Segoe UI', sans-serif;
}

.stats-card small{
    color:#6c757d;
    text-align:center;
    display:block;
    font-family:'Inter', 'Segoe UI', sans-serif;
}
.stat-icon{
    width:54px;
    height:54px;
    display:flex;
    align-items:center;
    justify-content:center;
    border-radius:14px;
    margin-bottom:15px;
}

.stat-icon i{
    font-size:24px;
}

.stat-icon i.icon-submitted{
    color:#3b82f6;
}

.stat-icon i.icon-pending{
    color:#f59e0b;
}

.stat-icon i.icon-shortlisted{
    color:#22c55e;
}

.stat-icon i.icon-rejected{
    color:#ef4444;
}

.stat-icon i.icon-hired{
    color:#6366f1;
}

.stat-icon i.icon-incomplete{
    color:#6b7280;
}

/*====================================================
                    BUTTONS
====================================================*/

.btn{

    border-radius:10px;
    font-weight:500;
    font-family:'Inter', 'Segoe UI', sans-serif;

}

.btn-primary{

    background:#101827;
    border-color:#101827;

}

.btn-primary:hover{

    background:#2a2a3a;
    border-color:#2a2a3a;

}

.btn-outline-primary{

    color:#101827;
    border-color:#101827;

}

.btn-outline-primary:hover{

    background:#101827;
    color:#fff;
    border-color:#101827;

}

.btn-success{

    background:#198754;
    border:none;

}

.btn-success:hover{

    background:#157347;
    border:none;

}

/*====================================================
                SEARCH GROUP
====================================================*/

.search-group {
    display: flex;
    gap: 0;
}

.search-group .form-control {
    border-radius: 10px 0 0 10px;
    border-right: none;
}

.search-group .btn-search {
    border-radius: 0 10px 10px 0;
    background: #101827;
    color: #fff;
    border: 1px solid #101827;
    padding: 0 18px;
    display: flex;
    align-items: center;
    justify-content: center;
    min-height: 45px;
}

.search-group .btn-search:hover {
    background: #2a2a3a;
    border-color: #2a2a3a;
    color: #fff;
}

/*====================================================
                    TABLES
====================================================*/

.table-responsive{

    border-radius:12px;

}

.table{

    margin-bottom:0;
    border-radius:12px;
    overflow:hidden;

}

.table thead{

    background:#f3f4f6;

}

.table th{

    font-weight:600;
    color:#101827;
    white-space:nowrap;
    font-family:'Inter', 'Segoe UI', sans-serif;

}

.table td{

    vertical-align:middle;
    font-family:'Inter', 'Segoe UI', sans-serif;

}

.table-hover tbody tr:hover{

    background:#f8f9fb;

}

/*====================================================
                FORM CONTROLS
====================================================*/

.form-control,
.form-select{

    border-radius:10px;
    min-height:45px;
    box-shadow:none;
    font-family:'Inter', 'Segoe UI', sans-serif;

}

.form-control:focus,
.form-select:focus{

    border-color:#3557b7;
    box-shadow:0 0 0 .2rem rgba(53,87,183,.15);

}

.new-form{

    margin-bottom:25px;

}

.menu-btn{

    display:none;

}

/*====================================================
                ACTIVE TAB INDICATOR
====================================================*/

.tab-active {
    background: #101827 !important;
    color: #fff !important;
    border-color: #101827 !important;
}

.tab-active:hover {
    background: #2a2a3a !important;
    color: #fff !important;
}

/*====================================================
                RESPONSIVE
====================================================*/

/* ===========================
        Large Screens
=========================== */

@media (min-width:1200px){

    .content{

        padding:35px;

    }

}

/* ===========================
        Tablet
=========================== */

@media (min-width:768px) and (max-width:1024px){

     /* Sidebar */

    .sidebar{
        width:180px;
        top:0px;
        height:100vh;
    }

    .sidebar.collapsed{
        width:70px;
    }

    /* Header */

    .top-header{
        left:180px;
        width:calc(100% - 0px);
    }

    .top-header.expanded{
        left:70px;
        width:calc(100% - 70px);
    }

    /* Content */

    .content{
        margin-left:180px;
        width:calc(100% - 180px);
        padding:20px;
    }

    .content.expanded{
        margin-left:70px;
        width:calc(100% - 70px);
    }

    /* Sidebar Text */

    .sidebar .nav-link{
        padding:0 12px;
    }

    .sidebar .nav-link i{
        width:34px;
        min-width:34px;
        font-size:18px;
    }

    .sidebar .nav-link span{
        font-size:14px;
    }

    .sidebar-toggle{
        width:34px;
        height:34px;
        font-size:22px;
    }

    /* Header */

    .header-center h3{
        font-size:22px;
    }

    .header-right{
        gap:12px;
    }

    .profile-circle{
        width:38px;
        height:38px;
        font-size:16px;
    }

    /* Dashboard cards */

    .stat-icon{

    width:54px;
    height:54px;

    border-radius:14px;

    display:flex;
    align-items:center;
    justify-content:center;

    font-size:24px;

    margin-bottom:15px;
}

.stat-icon i{

    font-size:24px;
}

.icon-submitted{

    background:#e7f0ff;
    color:#3b82f6;
}

.icon-pending{

    background:#fff4d6;
    color:#f59e0b;
}

.icon-shortlisted{

    background:#dcfce7;
    color:#22c55e;
}

.icon-rejected{

    background:#ffe4e6;
    color:#ef4444;
}

.icon-hired{

    background:#ede9fe;
    color:#6366f1;
}

.icon-incomplete{

    background:#eef2f7;
    color:#6b7280;
}

    .stats-card .card-body{
        padding:20px 15px;
    }

    .stats-card h3{
        font-size:28px;
    }

    .stats-card h6{
        font-size:15px;
    }

    /* Tables */

    .table-responsive{
        overflow-x:auto;
    }

    .table{
        min-width:850px;
    }

}

/* ===========================
        Mobile
=========================== */

@media (max-width:767px){

    .top-header{

        height:70px;

        padding:0 15px;

    }

    .header-left{

        min-width:auto;

    }

    .header-center h3{

        font-size:20px;

    }

    .header-right{

        gap:10px;

        min-width:auto;

    }
    .dashboard-header{
        display:flex;
        flex-direction:row;
        justify-content:space-between;
        align-items:center;
        gap:10px;
    }

    .dashboard-header h2{
        font-size:26px;
        margin:0;
        flex:1;
    }

    .dashboard-header .btn{
        width:auto !important;
        min-width:auto !important;
        display:inline-flex;
        align-items:center;
        justify-content:center;
        padding:6px 12px;
        font-size:13px;
        border-radius:8px;
        flex-shrink:0;
    }

    .dashboard-header .btn i{
        font-size:13px;
        margin-right:4px;
    }

    .dashboard-title{
        font-size:22px;
    }

    .create-job-btn{
        padding:5px 10px !important;
        font-size:12px !important;
        line-height:1.2;
    }

    .create-job-btn i{
        font-size:12px;
        margin-right:3px !important;
    }

    .job-buttons-container .btn {
        min-width: 140px !important;
        padding: 8px 14px !important;
        font-size: 12px !important;
    }

    .admin-box .text-end{

        display:none;

    }

    .profile-circle{

        width:38px;

        height:38px;

        font-size:16px;

    }

    .menu-btn{

        display:flex;

        align-items:center;

        justify-content:center;

        border:none;

        background:none;

        font-size:28px;

        color:#101827;

        padding:0;

    }

    #headerSidebarToggle{

        display:none;

    }

    .wrapper{

        display:block;

        padding-top:0px;

    }

    .sidebar{

        position:relative;

        top:0;

        width:100%;

        height:0;

        min-height:0;

        overflow:hidden;

        transition:height .3s ease;

    }

    .sidebar.show{

        height:265px;

    }

    .sidebar.collapsed{

        width:100%;

    }

    .sidebar-header{

        display:none;

    }

    .sidebar .nav-link span{

        display:inline;

    }

    .sidebar .nav-link{

        justify-content:flex-start;

    }

    .content{

        margin-left:0;

        width:100%;

        padding:20px 15px;

    }

    .content.expanded{

        margin-left:0;

        width:100%;

    }

    .row.g-3>.col-12{

        flex:0 0 100%;

        max-width:100%;

    }

    .table-responsive{

        overflow-x:auto;

    }

    .table{

        min-width:700px;

    }

}

/* ===========================
    Desktop Only
=========================== */

@media (min-width:768px){

    .menu-btn{

        display:none;

    }

    #headerSidebarToggle{

        display:flex;

        align-items:center;

        justify-content:center;

        width:40px;

        height:40px;

    }

}

</style>

</head>

<body class="bg-light">

<form id="form1" runat="server">

    <asp:ScriptManager
        ID="ScriptManager1"
        runat="server" />

    <header class="top-header">

    <div class="header-left">

        <!-- Mobile Hamburger -->
        <button type="button"
                class="btn menu-btn"
                onclick="toggleSidebar()">

            <i class="bi bi-list fs-4"></i>

        </button>

    </div>

    <div class="header-center">

        <h3 class="m-0 fw-bold">

            Faculty ATS

        </h3>

    </div>

    <div class="header-right">

        <button type="button" class="header-icon">

            <i class="bi bi-bell"></i>

            <span class="notification-dot"></span>

        </button>
      <p>|</p>  
        <div class="admin-box">

            <div class="text-end">

                <div class="fw-semibold">

                    System Administrator

                </div>

                <small class="text-muted">

                    ADMIN

                </small>

            </div>

            <div class="profile-circle">

                A

            </div>

        </div>

    </div>

</header>

<div class="wrapper">

    <!-- Sidebar -->
    <div id="sidebar" class="sidebar">
        <div class="sidebar-header">
            <button type="button" id="sidebarToggleBtn" class="toggle-btn">
                <i class="bi bi-arrow-left-circle"></i>
            </button>
        </div>

        <ul class="nav flex-column">

            <li class="nav-item">

                <a href="AdminDashboard.aspx"
                   class="nav-link active">

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

                <a href="Settings.aspx"
                   class="nav-link">

                    <i class="bi bi-gear-fill"></i>

                    <span>Settings</span>

                </a>

            </li>

        </ul>

        <div class="logout">

            <a href="Logout.aspx"
               class="nav-link">

                <i class="bi bi-box-arrow-right"></i>

                <span>Logout</span>

            </a>

        </div>

    </div>

    <!-- Main Content -->

    <div id="content" class="content">

        

        <div class="container-fluid pt-2 pb-4 p-0">

            <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">

                <h2 class="fw-bold mb-0 dashboard-title">
                    Admin Dashboard
                </h2>

                <div class="job-buttons-container">
                    <!-- Teaching Job Post Button -->
                    <asp:HyperLink
                        ID="lnkCreateTeachingJob"
                        runat="server"
                        NavigateUrl="~/CreateJob.aspx?type=Teaching"
                        CssClass="btn btn-teaching">

                        <i class="bi bi-plus-circle me-1"></i>
                        Create Teaching Job

                    </asp:HyperLink>

                    <!-- Non-Teaching Job Post Button -->
                    <asp:HyperLink
                        ID="lnkCreateNonTeachingJob"
                        runat="server"
                        NavigateUrl="~/NonCreateJob.aspx"
                        CssClass="btn btn-non-teaching">

                        <i class="bi bi-plus-circle me-1"></i>
                        Create Non-Teaching Job

                    </asp:HyperLink>
                </div>

            </div>
            <!-- ========================= -->
<!-- Statistics Cards -->
<!-- ========================= -->

<div class="row g-3 mb-4">

    <asp:Repeater
        ID="rptStats"
        runat="server"
        OnItemCommand="rptStats_ItemCommand">

        <ItemTemplate>

            <div class="col-12 col-sm-6 col-md-4 col-xl-2">

                <asp:LinkButton
                    ID="btnStat"
                    runat="server"
                    CssClass="text-decoration-none"
                    CommandName="select"
                    CommandArgument='<%# Eval("Key") %>'>

                    <div class="card stats-card h-100">

                       <div class="card-body">

    <div class="stat-icon">
        <i class='<%# GetStatIcon(Eval("Key").ToString()) %>'></i>
    </div>

    <h3 class="fw-bold mt-3 mb-1">
        <%# Eval("Value") %>
    </h3>

    <h6 class="mb-1">
        <%# Eval("Label") %>
    </h6>

    <small class="text-muted">
        <%# Eval("Hint") %>
    </small>

</div>

                    </div>

                </asp:LinkButton>

            </div>

        </ItemTemplate>

    </asp:Repeater>

</div>

<hr class="my-4"/>

<!-- ========================= -->
<!-- Tabs -->
<!-- ========================= -->

<div class="d-flex flex-wrap gap-2 mb-4">

    <asp:Repeater
        ID="rptTabs"
        runat="server"
        OnItemCommand="rptTabs_ItemCommand">

        <ItemTemplate>

            <div class="me-3 mb-2">

                <asp:LinkButton
                    ID="btnTab"
                    runat="server"
                    CssClass='<%# GetTabClass(Eval("Id").ToString()) %>'
                    CommandName="select"
                    CommandArgument='<%# Eval("Id") %>'>

                    <%# Eval("Label") %>

                </asp:LinkButton>

            </div>

        </ItemTemplate>

    </asp:Repeater>

</div>

<!-- ========================= -->
<!-- Search & Sort -->
<!-- ========================= -->

<asp:UpdatePanel ID="upnlMain" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
    <ContentTemplate>

<asp:Panel
    ID="pnlSort"
    runat="server">

    <div class="row g-3 align-items-end mb-4">

        <div class="col-12 col-lg-8">

            <div class="search-group">

                <asp:TextBox
                    ID="txtSearch"
                    runat="server"
                    CssClass="form-control"
                    placeholder="Search applicant..."
                    AutoPostBack="true"
                    OnTextChanged="txtSearch_TextChanged">
                </asp:TextBox>

                <asp:Button
                    ID="btnSearch"
                    runat="server"
                    Text="Search"
                    CssClass="btn-search"
                    OnClick="btnSearch_Click" />

            </div>

        </div>

        <div class="col-12 col-lg-4">

            <asp:DropDownList
                ID="ddlSort"
                runat="server"
                CssClass="form-select"
                AutoPostBack="true"
                OnSelectedIndexChanged="ddlSort_SelectedIndexChanged">

                <asp:ListItem
                    Text="Latest Submitted"
                    Value="submitted" />

                <asp:ListItem
                    Text="Highest Score"
                    Value="score" />

            </asp:DropDownList>

        </div>

    </div>

</asp:Panel>

<!-- ========================= -->
<!-- Applications Section -->
<!-- ========================= -->

<asp:Panel
    ID="pnlApplications"
    runat="server">

    <div class="card shadow-sm">

        <div class="card-header bg-primary text-white">

            Submitted Applications

        </div>

        <div class="card-body">

            <asp:Panel
                ID="pnlApplicationsEmpty"
                runat="server"
                Visible="false">

                <div class="alert alert-warning mb-3">

                    No applications found.

                </div>

            </asp:Panel>
            <div class="table-responsive">

            <asp:GridView
                ID="gvApplications"
                runat="server"
                CssClass="table table-bordered table-hover table-striped"
                AutoGenerateColumns="False"
                OnRowDataBound="gvApplications_RowDataBound"
                DataKeyNames="Id">

                <Columns>

                    <asp:BoundField
                        HeaderText="#"
                        DataField="Rank" />

                    <asp:TemplateField HeaderText="Applicant">
                        <ItemTemplate>
                            <!-- Applicant Name - BLACK -->
                            <strong style="color: #000000;">
                                <%# Eval("Applicant.FullName") %>
                            </strong>
                            <br />
                            <small class="text-muted">
                                <%# Eval("Applicant.Email") %>
                            </small>
                            <br />
                            <small>
                                <!-- Eligibility Status - Using Label with ForeColor -->
                                <asp:Label ID="lblEligibility" runat="server" 
                                    Text='<%# Eval("EligibilityStatus") %>' 
                                    Font-Bold="true"
                                    ForeColor='<%# Eval("EligibilityStatus").ToString().Contains("Not Eligible") ? System.Drawing.Color.Red : System.Drawing.Color.Green %>' />
                            </small>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField
                        HeaderText="Academic<br/>(Max 50)"
                        DataField="TotalAcademicScore"
                        HtmlEncode="false" />

                    <asp:BoundField
                        HeaderText="Experience<br/>(Max 25)"
                        DataField="TotalExperienceScore"
                        HtmlEncode="false" />

                    <asp:BoundField
                        HeaderText="Research<br/>(Max 25)"
                        DataField="ResearchScore"
                        HtmlEncode="false" />

                    <asp:TemplateField HeaderText="Total<br/>(Max 100)">
                        <ItemTemplate>
                            <strong class='<%# Eval("ScoreColor") %>'>
                                <%# Eval("GrandTotalScore") %>
                            </strong>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField
                        HeaderText="Status"
                        DataField="Status" />

                    <asp:TemplateField HeaderText="Submitted">
                        <ItemTemplate>
                            <%# FormatDate(Eval("SubmittedAt")) %>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>

            </asp:GridView>
                
</div>

        </div>

    </div>

</asp:Panel>

    </ContentTemplate>
</asp:UpdatePanel>

<br />

<!-- ========================= -->
<!-- Incomplete Applicants -->
<!-- ========================= -->

<asp:UpdatePanel ID="upnlIncomplete" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
    <ContentTemplate>

<asp:Panel
    ID="pnlIncomplete"
    runat="server">

    <asp:Panel
        ID="pnlIncompleteSort"
        runat="server">

        <div class="row mb-4">

            <div class="col-md-6">

                <div class="search-group">

                    <asp:TextBox
                        ID="txtIncompleteSearch"
                        runat="server"
                        CssClass="form-control"
                        placeholder="Search applicant..."
                        AutoPostBack="true"
                        OnTextChanged="txtIncompleteSearch_TextChanged">
                    </asp:TextBox>

                    <asp:Button
                        ID="btnIncompleteSearch"
                        runat="server"
                        Text="Search"
                        CssClass="btn-search"
                        OnClick="btnIncompleteSearch_Click" />

                </div>

            </div>

            <div class="col-md-3">

                <asp:DropDownList
                    ID="ddlIncompleteSort"
                    runat="server"
                    CssClass="form-select"
                    AutoPostBack="true"
                    OnSelectedIndexChanged="ddlIncompleteSort_SelectedIndexChanged">

                    <asp:ListItem
                        Text="Latest Registered"
                        Value="registered" />

                    <asp:ListItem
                        Text="Name (A-Z)"
                        Value="name" />

                </asp:DropDownList>

            </div>

        </div>

    </asp:Panel>

    <div class="card shadow-sm">

        <div class="card-header text-white"
             style="background:#b71c1c;">

            Applicants Not Submitted Yet

        </div>

        <div class="card-body">

            <asp:Panel
                ID="pnlIncompleteEmpty"
                runat="server"
                Visible="false">

                <div class="alert alert-info">

                    No incomplete applicants found.

                </div>

            </asp:Panel>
            <div class="table-responsive">

            <asp:GridView
                ID="gvIncomplete"
                runat="server"
                CssClass="table table-bordered table-hover table-striped"
                AutoGenerateColumns="False"
                DataKeyNames="Id">

                <Columns>

                    <asp:BoundField
                        DataField="Id"
                        HeaderText="ID" />

                    <asp:BoundField
                        DataField="FullName"
                        HeaderText="Full Name" />

                    <asp:BoundField
                        DataField="Email"
                        HeaderText="Email" />

                    <asp:BoundField
                        DataField="Phone"
                        HeaderText="Phone" />

                    <asp:TemplateField HeaderText="Registered">
                        <ItemTemplate>
                            <%# FormatDate(Eval("RegisteredAt")) %>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>

            </asp:GridView>
                </div>

        </div>

    </div>

</asp:Panel>

    </ContentTemplate>
</asp:UpdatePanel>

                    </div>   <!-- container-fluid -->

    </div>   <!-- content -->

</div>   <!-- wrapper -->

</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>

<script>

    //
    // Mobile Sidebar
    //
    function toggleSidebar() {

        const sidebar = document.getElementById("sidebar");

        if (!sidebar) {
            return;
        }

        sidebar.classList.toggle("show");
    }

    //
    // Desktop Sidebar Toggle (Arrow Button)
    //
    document.addEventListener('DOMContentLoaded', function () {
        var toggleBtn = document.getElementById('sidebarToggleBtn');
        var sidebar = document.getElementById('sidebar');
        var content = document.getElementById('content');
        var icon = toggleBtn.querySelector('i');

        if (toggleBtn) {
            toggleBtn.addEventListener('click', function () {
                sidebar.classList.toggle('collapsed');
                content.classList.toggle('expanded');

                if (sidebar.classList.contains('collapsed')) {
                    icon.className = 'bi bi-arrow-right-circle';
                } else {
                    icon.className = 'bi bi-arrow-left-circle';
                }
            });
        }
    });

</script>

</body>

</html>