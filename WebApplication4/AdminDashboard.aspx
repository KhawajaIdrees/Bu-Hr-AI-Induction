<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="WebApplication4.AdminDashboard" %>

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

    font-family:'Segoe UI', Arial, sans-serif;

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

    font-family:'Segoe UI', Arial, sans-serif;

}

.header-right{

    gap:18px;

    justify-content:flex-end;

    min-width:220px;

}

.dashboard-title{
    font-size:2.3rem;
    font-family:'Segoe UI', Arial, sans-serif;
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

    position:relative;
    cursor:pointer;

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
    font-family:'Segoe UI', Arial, sans-serif;
    cursor:pointer;
    transition: all 0.3s ease;
    position: relative;
}

.profile-circle:hover {
    transform: scale(1.05);
}

/* Arrow - half inside circle, half outside */
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
    box-shadow: 0 1px 4px rgba(0,0,0,0.2);
    font-size: 8px;
    padding: 0;
    line-height: 1;
}

/* Dropdown Menu - Works on ALL screen sizes */
.dropdown-menu-custom {
    display: none;
    position: absolute;
    top: 60px;
    right: 0;
    background: #ffffff;
    border-radius: 12px;
    box-shadow: 0 8px 30px rgba(0,0,0,0.15);
    min-width: 180px;
    padding: 8px 0;
    z-index: 1300;
    border: 1px solid #e8ecf1;
    overflow: hidden;
}

.dropdown-menu-custom.show {
    display: block;
}

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

.dropdown-menu-custom .dropdown-item:hover {
    background: #f5f7fb;
}

.dropdown-menu-custom .dropdown-item i {
    font-size: 18px;
    color: #64748b;
}

.dropdown-menu-custom .dropdown-divider {
    height: 1px;
    background: #e8ecf1;
    margin: 4px 0;
}

.dropdown-menu-custom .dropdown-item.logout-item {
    color: #dc3545;
}

.dropdown-menu-custom .dropdown-item.logout-item i {
    color: #dc3545;
}

.dropdown-menu-custom .dropdown-item.logout-item:hover {
    background: #fef2f2;
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
    flex: 1;

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
    font-family:'Segoe UI', Arial, sans-serif;

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
    font-family:'Segoe UI', Arial, sans-serif;

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
    font-family:'Segoe UI', Arial, sans-serif;

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
    font-family:'Segoe UI', Arial, sans-serif;
}

.stats-card h6{
    font-weight:600;
    margin-bottom:4px;
    text-align:center;
    font-family:'Segoe UI', Arial, sans-serif;
}

.stats-card small{
    color:#6c757d;
    text-align:center;
    display:block;
    font-family:'Segoe UI', Arial, sans-serif;
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
    font-family:'Segoe UI', Arial, sans-serif;

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
                APPLICANT TABLE
====================================================*/

.applicant-table-container {
    background: #ffffff;
    border-radius: 16px;
    border: 1px solid #e8ecf1;
    box-shadow: 0 2px 8px rgba(0,0,0,0.04);
    overflow: hidden;
}

.applicant-table {
    width: 100%;
    border-collapse: collapse;
    font-family: 'Segoe UI', Arial, sans-serif;
}

.applicant-table thead {
    background: #f8fafc;
    border-bottom: 1px solid #e8ecf1;
}

.applicant-table th {
    padding: 14px 20px;
    text-align: left;
    font-size: 11px;
    font-weight: 700;
    color: #64748b;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.applicant-table td {
    padding: 12px 20px;
    border-bottom: 1px solid #f1f4f9;
    vertical-align: middle;
}

.applicant-table tbody tr {
    transition: background 0.2s ease;
}

.applicant-table tbody tr:hover {
    background: #f8faff;
}

.applicant-table .candidate-cell {
    display: flex;
    align-items: center;
    gap: 12px;
}

.applicant-table .avatar-img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    object-fit: cover;
    border: 2px solid #e8ecf1;
    background: #f8faff;
    flex-shrink: 0;
}

.applicant-table .avatar-placeholder {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: #1a3a7a;
    color: #ffffff;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 700;
    font-size: 16px;
    flex-shrink: 0;
    font-family: 'Segoe UI', Arial, sans-serif;
}

.applicant-table .candidate-name {
    font-weight: 600;
    font-size: 14px;
    color: #0f172a;
    text-decoration: none;
}

.applicant-table .candidate-name:hover {
    color: #1a3a7a;
}

.applicant-table .candidate-email {
    font-size: 12px;
    color: #64748b;
}

/* Position & Hiring - Stacked vertically with left alignment */
.applicant-table .position-hiring-wrapper {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    gap: 2px;
}

.applicant-table .position-text {
    font-weight: 600;
    font-size: 13px;
    color: #0f172a;
    padding: 0;
}

.applicant-table .hiring-badge {
    font-size: 10px;
    font-weight: 700;
    padding: 2px 10px;
    border-radius: 12px;
    text-transform: uppercase;
    letter-spacing: 0.3px;
    display: inline-block;
    background: #e0e7ff;
    color: #3730a3;
    white-space: nowrap;
    margin: 0;
}

.applicant-table .score-wrapper {
    display: flex;
    align-items: center;
    gap: 10px;
}

.applicant-table .score-number {
    font-weight: 700;
    font-size: 15px;
    color: #0f172a;
    min-width: 30px;
}

.applicant-table .progress-bar {
    width: 80px;
    height: 4px;
    background: #eef2f6;
    border-radius: 4px;
    overflow: hidden;
}

.applicant-table .progress-fill {
    height: 100%;
    border-radius: 4px;
    background: #1a3a7a;
    transition: width 0.3s ease;
}

.applicant-table .status-badge {
    font-size: 10px;
    font-weight: 700;
    padding: 4px 14px;
    border-radius: 20px;
    text-transform: uppercase;
    letter-spacing: 0.3px;
    display: inline-block;
    font-family: 'Segoe UI', Arial, sans-serif;
}

.status-pending { background: #fef3c7; color: #92400e; }
.status-shortlisted { background: #d1fae5; color: #065f46; }
.status-rejected { background: #fee2e2; color: #991b1b; }
.status-hired { background: #e0e7ff; color: #3730a3; }

.applicant-table .action-link {
    width: 34px;
    height: 34px;
    border-radius: 50%;
    border: 1px solid #e2e8f0;
    background: #ffffff;
    color: #1a3a7a;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    transition: all 0.25s ease;
    text-decoration: none;
}

.applicant-table .action-link:hover {
    background: #1a3a7a;
    color: #ffffff;
    border-color: #1a3a7a;
}

.applicant-table .action-link i {
    font-size: 16px;
}

/* Eligibility text */
.eligibility-text {
    font-size: 11px;
    font-weight: 600;
    font-family: 'Segoe UI', Arial, sans-serif;
}

/*====================================================
                MOBILE HAMBURGER MENU
====================================================*/

/* Mobile overlay */
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

/* Prevent body scroll when sidebar is open */
body.no-scroll {
    overflow: hidden !important;
}

/*====================================================
                FORM CONTROLS
====================================================*/

.form-control,
.form-select{

    border-radius:10px;
    min-height:45px;
    box-shadow:none;
    font-family:'Segoe UI', Arial, sans-serif;

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

}

/* ===========================
        Mobile
=========================== */

@media (max-width:767px){

    /* Show hamburger button in header */
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

    /* Hide desktop toggle button on mobile */
    .sidebar-header .toggle-btn {
        display: none;
    }

    /* Sidebar becomes off-canvas drawer */
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
    .sidebar.mobile-open {
        transform: translateX(0);
    }
    .sidebar.collapsed {
        width: 280px;
    }
    .sidebar.collapsed .nav-link span {
        display: inline;
    }
    .sidebar.collapsed .nav-link i {
        width: 42px;
        min-width: 42px;
    }

    /* Sidebar content - no scroll */
    .sidebar .nav {
        flex: 1;
        overflow: hidden;
        padding: 0;
        margin-top: 10px;
    }

    .sidebar .nav-item {
        margin-bottom: 6px;
    }

    .sidebar .nav-link {
        height: 46px;
        margin: 0 12px;
        padding: 0 14px;
        font-size: 14px;
    }

    .sidebar .nav-link i {
        width: 36px;
        min-width: 36px;
        font-size: 18px;
    }

    /* Dropdown on mobile */
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

    /* Overlay */
    .mobile-overlay {
        display: block;
        z-index: 999;
    }

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

    .content{

        margin-left:0;

        width:100%;

        padding:20px 15px;

        min-height:calc(100vh - 70px);

    }

    .content.expanded{

        margin-left:0;

        width:100%;

    }

    .row.g-3>.col-12{

        flex:0 0 100%;

        max-width:100%;

    }

    /* Mobile Table */
    .applicant-table-container {
        overflow-x: auto;
    }

    .applicant-table {
        min-width: 650px;
    }

    .applicant-table th,
    .applicant-table td {
        padding: 10px 14px;
        font-size: 12px;
    }

    .applicant-table .avatar-img,
    .applicant-table .avatar-placeholder {
        width: 32px;
        height: 32px;
        font-size: 12px;
    }

    .applicant-table .candidate-name {
        font-size: 13px;
    }

    .applicant-table .candidate-email {
        font-size: 11px;
    }

    .applicant-table .progress-bar {
        width: 50px;
    }

    .applicant-table .score-number {
        font-size: 13px;
        min-width: 24px;
    }

}

/* ===========================
    Desktop Only
=========================== */

@media (min-width:768px){

    .menu-btn{

        display:none;

    }

    .mobile-overlay {
        display: none !important;
    }

    /* Dropdown works on desktop too */
    .dropdown-menu-custom {
        position: absolute;
        top: 60px;
        right: 0;
        min-width: 180px;
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
        <div class="admin-box" onclick="toggleDropdown(event)">

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
                <span class="dropdown-arrow">▼</span>
            </div>

            <!-- Dropdown Menu - Works on ALL screen sizes -->
            <div id="dropdownMenu" class="dropdown-menu-custom">
                <a href="#" class="dropdown-item" onclick="event.stopPropagation();">
                    <i class="bi bi-person-circle"></i> My Profile
                </a>
                <a href="Settings.aspx" class="dropdown-item" onclick="event.stopPropagation();">
                    <i class="bi bi-gear"></i> Settings
                </a>
                <div class="dropdown-divider"></div>
                <a href="Logout.aspx" class="dropdown-item logout-item" onclick="event.stopPropagation();">
                    <i class="bi bi-box-arrow-right"></i> Logout
                </a>
            </div>

        </div>

    </div>

</header>

<!-- Mobile Overlay -->
<div id="mobileOverlay" class="mobile-overlay"></div>

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

        </ul>

    </div>

    <!-- Main Content -->

    <div id="content" class="content">

        

        <div class="container-fluid pt-2 pb-4 p-0">

            <!-- Page Title -->
            <div class="mb-4">
                <h1 class="fw-bold text-slate-900" style="font-size:28px; font-family:'Segoe UI', Arial, sans-serif;">
                    System Dashboard
                </h1>
                <p class="text-muted" style="font-family:'Segoe UI', Arial, sans-serif; font-size:14px;">
                    Overview of all candidate applications across all stages.
                </p>
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

                        <div class="col-6 col-sm-4 col-md-3 col-xl-2">

                            <asp:LinkButton
                                ID="btnStat"
                                runat="server"
                                CssClass="text-decoration-none d-block"
                                CommandName="select"
                                CommandArgument='<%# Eval("Key") %>'>

                                <div class="card stats-card h-100">

                                   <div class="card-body">

                                        <div class="stat-icon">
                                            <i class='<%# GetStatIcon(Eval("Key").ToString()) %>'></i>
                                        </div>

                                        <h3 class="fw-bold mt-2 mb-0" style="font-size:24px;">
                                            <%# Eval("Value") %>
                                        </h3>

                                        <h6 class="mb-0 mt-1" style="font-size:10px; font-weight:700; color:#64748b; text-transform:uppercase; letter-spacing:0.5px;">
                                            <%# Eval("Label") %>
                                        </h6>

                                    </div>

                                </div>

                            </asp:LinkButton>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

            </div>

            <!-- ========================= -->
            <!-- Tabs -->
            <!-- ========================= -->

            <div class="d-flex flex-wrap gap-2 mb-4">

                <asp:Repeater
                    ID="rptTabs"
                    runat="server"
                    OnItemCommand="rptTabs_ItemCommand">

                    <ItemTemplate>

                        <asp:LinkButton
                            ID="btnTab"
                            runat="server"
                            CssClass='<%# GetTabClass(Eval("Id").ToString()) %>'
                            CommandName="select"
                            CommandArgument='<%# Eval("Id") %>'
                            style="font-size:12px; font-weight:700; padding:6px 18px; border-radius:20px; font-family:'Segoe UI', Arial, sans-serif;">

                            <%# Eval("Label") %>

                        </asp:LinkButton>

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
                                placeholder="Search candidate name, email, or position..."
                                AutoPostBack="true"
                                OnTextChanged="txtSearch_TextChanged"
                                style="font-size:14px; padding:10px 16px; height:46px; border-radius:10px 0 0 10px;">
                            </asp:TextBox>

                            <asp:Button
                                ID="btnSearch"
                                runat="server"
                                Text="Search"
                                CssClass="btn-search"
                                OnClick="btnSearch_Click"
                                style="padding:0 20px; height:46px; border-radius:0 10px 10px 0; background:#101827; color:#fff; border:1px solid #101827; font-weight:600; font-size:13px;" />

                        </div>

                    </div>

                    <div class="col-12 col-lg-4">

                        <asp:DropDownList
                            ID="ddlSort"
                            runat="server"
                            CssClass="form-select"
                            AutoPostBack="true"
                            OnSelectedIndexChanged="ddlSort_SelectedIndexChanged"
                            style="font-size:13px; font-weight:600; height:46px; border-radius:10px; border-color:#e2e8f0;">

                            <asp:ListItem
                                Text="Top Scored"
                                Value="score" />

                            <asp:ListItem
                                Text="Most Recent"
                                Value="submitted" />

                        </asp:DropDownList>

                    </div>

                </div>

            </asp:Panel>

            <!-- ========================= -->
            <!-- Applications Table -->
            <!-- ========================= -->

            <asp:Panel
                ID="pnlApplications"
                runat="server">

                <div class="applicant-table-container">

                    <asp:Panel
                        ID="pnlApplicationsEmpty"
                        runat="server"
                        Visible="false">

                        <div class="text-center py-5">
                            <i class="bi bi-inbox" style="font-size:48px; color:#cbd5e1;"></i>
                            <p class="text-muted mt-3" style="font-family:'Segoe UI', Arial, sans-serif;">No applications found.</p>
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
                            <asp:Repeater
                                ID="rptApplicantCards"
                                runat="server"
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
                                                    <div class="candidate-email">
                                                        <%# Eval("Applicant.Email") %>
                                                    </div>
                                                    <asp:Label ID="lblEligibility" runat="server" 
                                                        CssClass="eligibility-text"
                                                        Text='<%# Eval("EligibilityStatus") %>' 
                                                        ForeColor='<%# Eval("EligibilityStatus").ToString().Contains("Not Eligible") ? System.Drawing.Color.Red : System.Drawing.Color.Green %>' />
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="position-hiring-wrapper">
                                                <span class="position-text">Lecturer</span>
                                                <span class="hiring-badge">PERMANENT</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="score-wrapper">
                                                <span class="score-number"><%# Eval("GrandTotalScore") %></span>
                                                <div class="progress-bar">
                                                    <div class="progress-fill" 
                                                         style='width: <%# GetProgressWidth(Eval("GrandTotalScore")) %>;'>
                                                    </div>
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
                                    OnTextChanged="txtIncompleteSearch_TextChanged"
                                    style="font-size:14px; padding:10px 16px; height:46px; border-radius:10px 0 0 10px;">
                                </asp:TextBox>

                                <asp:Button
                                    ID="btnIncompleteSearch"
                                    runat="server"
                                    Text="Search"
                                    CssClass="btn-search"
                                    OnClick="btnIncompleteSearch_Click"
                                    style="padding:0 20px; height:46px; border-radius:0 10px 10px 0; background:#101827; color:#fff; border:1px solid #101827; font-weight:600; font-size:13px;" />

                            </div>

                        </div>

                        <div class="col-md-3">

                            <asp:DropDownList
                                ID="ddlIncompleteSort"
                                runat="server"
                                CssClass="form-select"
                                AutoPostBack="true"
                                OnSelectedIndexChanged="ddlIncompleteSort_SelectedIndexChanged"
                                style="font-size:13px; font-weight:600; height:46px; border-radius:10px; border-color:#e2e8f0;">

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

                <div class="applicant-table-container">

                    <asp:Panel
                        ID="pnlIncompleteEmpty"
                        runat="server"
                        Visible="false">

                        <div class="text-center py-5">
                            <i class="bi bi-inbox" style="font-size:48px; color:#cbd5e1;"></i>
                            <p class="text-muted mt-3" style="font-family:'Segoe UI', Arial, sans-serif;">No incomplete applicants found.</p>
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
                            <asp:Repeater
                                ID="rptIncompleteCards"
                                runat="server">

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
                                                    <div class="candidate-email">
                                                        <%# Eval("Email") %>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <span style="font-size:13px; color:#64748b;">
                                                <%# FormatDate(Eval("RegisteredAt")) %>
                                            </span>
                                        </td>
                                        <td>
                                            <span class="status-badge status-pending">
                                                Incomplete
                                            </span>
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

                    </div>   <!-- container-fluid -->

    </div>   <!-- content -->

</div>   <!-- wrapper -->

</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>

<script>

    //
    // Dropdown Toggle - Works on ALL screen sizes
    //
    function toggleDropdown(event) {
        event.stopPropagation();
        var dropdown = document.getElementById('dropdownMenu');
        dropdown.classList.toggle('show');
    }

    // Close dropdown when clicking outside
    document.addEventListener('click', function (event) {
        var dropdown = document.getElementById('dropdownMenu');
        var adminBox = document.querySelector('.admin-box');
        if (dropdown && adminBox) {
            if (!adminBox.contains(event.target)) {
                dropdown.classList.remove('show');
            }
        }
    });

    //
    // Mobile Sidebar Toggle
    //
    function toggleSidebar() {
        const sidebar = document.getElementById("sidebar");
        const overlay = document.getElementById("mobileOverlay");
        const body = document.body;

        if (!sidebar) return;

        sidebar.classList.toggle("mobile-open");
        overlay.classList.toggle("active");

        // Prevent/allow body scroll
        if (sidebar.classList.contains('mobile-open')) {
            body.classList.add('no-scroll');
        } else {
            body.classList.remove('no-scroll');
        }

        // Change icon
        const icon = document.querySelector('.menu-btn i');
        if (icon) {
            if (sidebar.classList.contains('mobile-open')) {
                icon.className = 'bi bi-x-lg fs-4';
            } else {
                icon.className = 'bi bi-list fs-4';
            }
        }
    }

    // Close sidebar when clicking overlay
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

        // Close sidebar when clicking a nav link
        document.querySelectorAll('.sidebar .nav-link').forEach(function (link) {
            link.addEventListener('click', function () {
                const sidebar = document.getElementById('sidebar');
                if (window.innerWidth <= 768 && sidebar && sidebar.classList.contains('mobile-open')) {
                    toggleSidebar();
                }
            });
        });
    });

    //
    // Desktop Sidebar Toggle (Arrow Button)
    //
    document.addEventListener('DOMContentLoaded', function () {
        var toggleBtn = document.getElementById('sidebarToggleBtn');
        var sidebar = document.getElementById('sidebar');
        var content = document.getElementById('content');
        var icon = toggleBtn ? toggleBtn.querySelector('i') : null;

        if (toggleBtn) {
            toggleBtn.addEventListener('click', function () {
                // Only work on desktop
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