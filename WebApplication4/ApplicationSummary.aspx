<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplicationSummary.aspx.cs" Inherits="WebApplication4.ApplicationSummary" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Application Summary</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        body {
            background: #f0f4f8;
            font-family: 'Segoe UI', Arial, sans-serif;
            font-size: 17px;
        }

        .page-title h4 {
            color: #1a3a7a;
            font-weight: 700;
        }

        .page-title h5 {
            color: #6c757d;
        }

        .page-title hr {
            border-top: 3px solid #1a3a7a;
            opacity: 0.2;
            width: 100%;
            margin-top: 5px;
        }

        .form-card {
            max-width: 1100px;
            margin: 30px auto 30px;
            background: white;
            padding: 0 0;
            border-radius: 16px;
            box-shadow: 0 8px 30px rgba(26, 58, 122, 0.10);
            overflow: hidden;
        }

        .card-header-blue {
            background: linear-gradient(135deg, #1a3a7a 0%, #2a5aaa 100%);
            color: white;
            padding: 18px 25px;
            border: none;
        }

        .card-header-blue h5 {
            margin: 0;
            font-weight: 600;
            font-size: 20px;
        }

        .card-header-blue i {
            margin-right: 10px;
        }

        .card-main {
            border-radius: 16px;
            border: none;
            box-shadow: 0 8px 30px rgba(26, 58, 122, 0.10);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .card-body {
            padding: 20px 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            font-size: 14px;
            font-weight: 600;
            color: #44496b;
            margin-bottom: 4px;
        }

        .form-control {
            font-size: 15px;
            height: 48px;
            border-radius: 8px;
            border: 1px solid #ced4da;
            padding: 10px 14px;
            transition: all .2s ease-in-out;
            background: #f8faff;
            color: #1a2332;
        }

        .form-control:focus {
            border-color: #1a3a7a;
            box-shadow: 0 0 0 .2rem rgba(26, 58, 122, 0.15);
        }

        .form-control[readonly] {
            background: #f8faff;
            color: #1a2332;
            font-weight: 500;
        }

        /* ============================================
           PROFILE IMAGE STYLES
           ============================================ */
        .profile-img-wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 15px;
        }

        .profile-img-wrapper img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 50%;
            border: 4px solid #1a3a7a;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            background: #f8faff;
            padding: 4px;
        }

        .profile-img-wrapper .no-image {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: #e8edf5;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 4px solid #1a3a7a;
            color: #1a3a7a;
            font-size: 48px;
        }

        /* ============================================
           EDUCATION TABLE
           ============================================ */
        .education-table th {
            background: #e8edf5;
            color: #1a3a7a;
            font-weight: 700;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: .3px;
            border-bottom: 2px solid #1a3a7a;
            text-align: center;
            vertical-align: middle;
            padding: 10px 8px;
            white-space: nowrap;
        }

        .education-table td {
            vertical-align: middle;
            text-align: center;
            font-size: 14px;
            color: #1a2332;
            padding: 8px 6px;
            min-width: 80px;
        }

        .education-table td:first-child {
            font-weight: 600;
            color: #1a3a7a;
            text-align: left;
            padding-left: 12px;
            font-size: 13px;
            white-space: nowrap;
            min-width: 100px;
        }

        /* Major - BIGGER */
        .education-table input[id$="_subject"] {
            border: 1px solid #d0d7e6;
            border-radius: 6px;
            padding: 6px 10px;
            font-size: 14px;
            background: #f8faff;
            width: 100%;
            min-width: 130px;
            max-width: none;
            text-align: left;
            color: #1a2332;
            font-weight: 500;
            box-sizing: border-box;
            overflow: visible;
            text-overflow: clip;
            white-space: normal;
            word-wrap: break-word;
        }

        /* Institute - BIGGER */
        .education-table input[id$="_board"] {
            border: 1px solid #d0d7e6;
            border-radius: 6px;
            padding: 6px 10px;
            font-size: 14px;
            background: #f8faff;
            width: 100%;
            min-width: 150px;
            max-width: none;
            text-align: left;
            color: #1a2332;
            font-weight: 500;
            box-sizing: border-box;
            overflow: visible;
            text-overflow: clip;
            white-space: normal;
            word-wrap: break-word;
        }

        /* Year - SMALLER, CENTERED */
        .education-table input[id$="_year"] {
            border: 1px solid #d0d7e6;
            border-radius: 6px;
            padding: 6px 8px;
            font-size: 14px;
            background: #f8faff;
            width: 100%;
            min-width: 65px;
            max-width: 85px;
            text-align: center;
            color: #1a2332;
            font-weight: 500;
            box-sizing: border-box;
        }

        /* Result - BIGGER, CENTERED */
        .education-table input[id$="_result"] {
            border: 1px solid #d0d7e6;
            border-radius: 6px;
            padding: 6px 10px;
            font-size: 14px;
            background: #f8faff;
            width: 100%;
            min-width: 85px;
            max-width: 110px;
            text-align: center;
            color: #1a2332;
            font-weight: 500;
            box-sizing: border-box;
        }

        /* Grade - CENTERED */
        .education-table input[id$="_grade"] {
            border: 1px solid #d0d7e6;
            border-radius: 6px;
            padding: 6px 8px;
            font-size: 14px;
            background: #f8faff;
            width: 100%;
            min-width: 70px;
            max-width: 100px;
            text-align: center;
            color: #1a2332;
            font-weight: 500;
            box-sizing: border-box;
        }

        .education-table input:focus {
            outline: none;
            border-color: #1a3a7a;
            box-shadow: 0 0 0 0.2rem rgba(26, 58, 122, 0.15);
        }

        .education-table input[readonly] {
            background: #f8faff;
            cursor: default;
        }

        .table-responsive {
            border-radius: 10px;
            border: 1px solid #eef1f8;
            overflow-x: auto;
        }

        /* ============================================
           DECLARATION
           ============================================ */
        .declaration-container {
            max-width: 1100px;
            margin: 0 auto 60px;
            border: 2px solid #1a3a7a;
            border-radius: 12px;
            background: #ffffff;
            overflow: hidden;
            box-shadow: 0 8px 30px rgba(26, 58, 122, 0.10);
        }

        .declaration-header {
            background: linear-gradient(135deg, #1a3a7a 0%, #2a5aaa 100%);
            color: white;
            padding: 15px 25px;
        }

        .declaration-header h3 {
            margin: 0;
            font-weight: 700;
            font-size: 22px;
        }

        .declaration-header i {
            margin-right: 10px;
        }

        .declaration-body {
            padding: 25px 30px 10px 30px;
        }

        .declaration-body .form-check-label {
            font-size: 16px;
            line-height: 1.8;
            text-align: justify;
        }

        .form-check-input:checked {
            background-color: #1a3a7a;
            border-color: #1a3a7a;
        }

        .form-check-input:focus {
            border-color: #1a3a7a;
            box-shadow: 0 0 0 .2rem rgba(26, 58, 122, 0.15);
        }

        /* ============================================
           NAVIGATION BUTTONS WITH EDIT TEXT
           ============================================ */
        .info-buttons {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 20px;
            margin-bottom: 20px;
        }

        .info-buttons .btn {
            min-width: 180px;
            padding: 10px 18px;
            height: 40px;
            font-weight: 600;
            font-size: 13px;
            border-radius: 8px;
            transition: all .2s ease-in-out;
            border: 2px solid #1a3a7a;
            color: #1a3a7a;
            background: transparent;
            white-space: nowrap;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .info-buttons .btn i {
            font-size: 15px;
        }

        .info-buttons .btn .edit-text {
            font-weight: 400;
            opacity: 0.7;
            font-size: 11px;
        }

        .info-buttons .btn:hover {
            background: #1a3a7a;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(26, 58, 122, 0.3);
            border-color: #1a3a7a;
        }

        .info-buttons .btn:hover i {
            color: white;
        }

        .info-buttons .btn:hover .edit-text {
            color: white;
            opacity: 0.8;
        }

        .info-buttons .btn:focus {
            box-shadow: 0 0 0 .2rem rgba(26, 58, 122, 0.25);
            border-color: #1a3a7a;
        }

        .submit-btn {
            background: linear-gradient(135deg, #1a3a7a 0%, #2a5aaa 100%);
            color: white;
            border: none;
            padding: 12px 40px;
            border-radius: 8px;
            font-size: 17px;
            font-weight: 600;
            transition: all .2s ease-in-out;
            min-width: 120px;
        }

        .submit-btn:hover:not(:disabled) {
            background: #2a5aaa;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(26, 58, 122, 0.35);
        }

        .submit-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .submit-btn.submitted {
            background: #6c757d;
            cursor: default;
        }

        .submit-btn.submitted:hover {
            background: #6c757d;
            transform: none;
            box-shadow: none;
        }

        .radio-group {
            display: flex;
            align-items: center;
            gap: 30px;
            margin-top: 8px;
        }

        .radio-group input[type="radio"] {
            width: 18px;
            height: 18px;
            margin-right: 8px;
            cursor: pointer;
            accent-color: #1a3a7a;
            position: relative;
            top: 4px;
        }

        .radio-group label {
            margin-bottom: 0;
            cursor: pointer;
            font-weight: 500;
            color: #44496b;
        }

        .text-danger {
            font-size: 13px;
        }

        .text-success {
            font-size: 16px;
            font-weight: 600;
        }

        /* ============================================
           RESPONSIVE
           ============================================ */
        @media(max-width:768px) {
            body {
                font-size: 15px;
            }

            .form-card {
                padding: 0;
                margin: 20px 12px;
                border-radius: 12px;
            }

            .card-body {
                padding: 15px;
            }

            .form-label {
                font-size: 13px;
            }

            .form-control {
                font-size: 14px;
                height: 42px;
                padding: 6px 12px;
            }

            .profile-img-wrapper img {
                width: 80px;
                height: 80px;
            }

            .info-buttons {
                flex-direction: column;
                gap: 8px;
                width: 100%;
            }

            .info-buttons .btn {
                min-width: 100%;
                width: 100%;
                padding: 10px 14px;
                height: 38px;
                font-size: 12px;
                border-radius: 6px;
                white-space: normal;
                text-align: center;
                justify-content: center;
            }

            .info-buttons .btn i {
                font-size: 14px;
            }

            .info-buttons .btn .edit-text {
                font-size: 10px;
            }

            .declaration-container {
                margin: 0 12px 30px;
                border-radius: 10px;
            }

            .declaration-body {
                padding: 18px 16px 10px 16px;
            }

            .declaration-body .form-check-label {
                font-size: 14px;
            }

            .declaration-header {
                padding: 12px 18px;
            }

            .declaration-header h3 {
                font-size: 18px;
            }

            .submit-btn {
                width: 100%;
                padding: 12px 20px;
                font-size: 15px;
                justify-content: center;
            }

            .education-table th {
                font-size: 10px;
                padding: 6px 4px;
                white-space: normal;
                min-width: 60px;
            }

            .education-table td {
                font-size: 12px;
                padding: 4px 4px;
                min-width: 50px;
            }

            .education-table td:first-child {
                font-size: 11px;
                padding-left: 6px;
                white-space: normal;
                min-width: 70px;
            }

            .education-table input[id$="_subject"] {
                font-size: 12px;
                padding: 4px 6px;
                min-width: 80px;
            }

            .education-table input[id$="_board"] {
                font-size: 12px;
                padding: 4px 6px;
                min-width: 90px;
            }

            .education-table input[id$="_year"] {
                font-size: 12px;
                padding: 4px 6px;
                min-width: 50px;
                max-width: 65px;
                text-align: center;
            }

            .education-table input[id$="_result"] {
                font-size: 12px;
                padding: 4px 6px;
                min-width: 65px;
                max-width: 80px;
                text-align: center;
            }

            .education-table input[id$="_grade"] {
                font-size: 12px;
                padding: 4px 6px;
                min-width: 55px;
                max-width: 75px;
                text-align: center;
            }

            .radio-group {
                gap: 15px;
            }

            .radio-group input[type="radio"] {
                width: 16px;
                height: 16px;
                top: 2px;
            }

            .page-title h4 {
                font-size: 20px;
            }

            .page-title h5 {
                font-size: 14px;
            }

            .container {
                padding-left: 8px;
                padding-right: 8px;
            }

            .card-header-blue {
                padding: 14px 18px;
            }

            .card-header-blue h5 {
                font-size: 16px;
            }
        }

        @media(max-width:480px) {
            .form-card {
                margin: 15px 8px;
                border-radius: 10px;
            }

            .card-body {
                padding: 12px;
            }

            .profile-img-wrapper img {
                width: 70px;
                height: 70px;
            }

            .education-table th {
                font-size: 9px;
                padding: 4px 3px;
                min-width: 45px;
            }

            .education-table td {
                font-size: 11px;
                padding: 3px 3px;
                min-width: 35px;
            }

            .education-table td:first-child {
                font-size: 10px;
                padding-left: 4px;
                min-width: 50px;
            }

            .education-table input[id$="_subject"] {
                font-size: 11px;
                padding: 3px 4px;
                min-width: 60px;
            }

            .education-table input[id$="_board"] {
                font-size: 11px;
                padding: 3px 4px;
                min-width: 65px;
            }

            .education-table input[id$="_year"] {
                font-size: 11px;
                padding: 3px 4px;
                min-width: 40px;
                max-width: 50px;
                text-align: center;
            }

            .education-table input[id$="_result"] {
                font-size: 11px;
                padding: 3px 4px;
                min-width: 55px;
                max-width: 65px;
                text-align: center;
            }

            .education-table input[id$="_grade"] {
                font-size: 11px;
                padding: 3px 4px;
                min-width: 45px;
                max-width: 60px;
                text-align: center;
            }

            .info-buttons .btn {
                height: 34px;
                font-size: 11px;
                padding: 6px 10px;
            }

            .info-buttons .btn i {
                font-size: 12px;
            }

            .info-buttons .btn .edit-text {
                font-size: 9px;
            }

            .declaration-container {
                margin: 0 8px 20px;
                border-radius: 8px;
            }

            .declaration-body {
                padding: 12px 12px 8px 12px;
            }

            .declaration-body .form-check-label {
                font-size: 13px;
            }

            .submit-btn {
                padding: 10px 16px;
                font-size: 14px;
            }

            .page-title h4 {
                font-size: 17px;
            }

            .page-title h5 {
                font-size: 12px;
            }

            .container {
                padding-left: 5px;
                padding-right: 5px;
            }

            .card-header-blue {
                padding: 10px 14px;
            }

            .card-header-blue h5 {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

    <form id="form1" runat="server">

        <div class="container py-3">

            <div class="text-left mb-3 page-title">
                <h4><i class="bi bi-file-text-fill me-2"></i>Application Summary</h4>
                <h5 class="text-secondary fw-normal">Bahria University HR Portal</h5>
                <hr />
            </div>

            <!-- Main Form Card -->
            <div class="form-card">

                <!-- Personal Information -->
                <div class="card-main" style="margin-bottom:0;border-radius:0;">
                    <div class="card-header-blue">
                        <h5><i class="bi bi-person-badge-fill"></i> Personal Information</h5>
                    </div>

                    <div class="card-body">
                        <!-- PROFILE IMAGE -->
                        <div class="profile-img-wrapper">
                            <asp:Image ID="imgProfile" runat="server" 
                                ImageUrl="~/Images/default-avatar.png" 
                                AlternateText="Profile Image"
                                CssClass="img-fluid rounded-circle"
                                style="width:120px; height:120px; object-fit:cover; border:4px solid #1a3a7a; border-radius:50%; background:#f8faff;" />
                        </div>

                        <div class="row">
                            <div class="col-md-4 form-group">
                                <label class="form-label">Full Name</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>

                            <div class="col-md-4 form-group">
                                <label class="form-label">CNIC</label>
                                <asp:TextBox ID="txtIdentity" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>

                            <div class="col-md-4 form-group">
                                <label class="form-label">Date of Birth</label>
                                <asp:TextBox ID="txtBirthDate" runat="server" TextMode="Date" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4 form-group">
                                <label class="form-label">Nationality</label>
                                <asp:TextBox ID="txtNationality" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>

                            <div class="col-md-4 form-group">
                                <label class="form-label">Mobile Number</label>
                                <asp:TextBox ID="txtCell" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>

                            <div class="col-md-4 form-group">
                                <label class="form-label">Gender</label>
                                <div class="radio-group">
                                    <asp:RadioButton ID="rbMale" runat="server" GroupName="Gender" Text="Male" Enabled="false" />
                                    <asp:RadioButton ID="rbFemale" runat="server" GroupName="Gender" Text="Female" Enabled="false" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Educational Information -->
                <div class="card-main" style="margin-bottom:0;border-radius:0;border-top:1px solid #eef1f8;">
                    <div class="card-header-blue">
                        <h5><i class="bi bi-mortarboard-fill"></i> Educational Information</h5>
                    </div>

                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped align-middle education-table">
                                <thead>
                                    <tr>
                                        <th style="min-width:100px;">Qualification</th>
                                        <th style="min-width:130px;">Major</th>
                                        <th style="min-width:150px;">Institute</th>
                                        <th style="min-width:65px;">Year</th>
                                        <th style="min-width:85px;">Result (%)</th>
                                        <th style="min-width:70px;">Grade</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>SSC/Matric*</td>
                                        <td><input type="text" id="ssc_subject" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="text" id="ssc_board" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="number" id="ssc_year" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="number" id="ssc_result" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="text" id="ssc_grade" runat="server" class="form-control" readonly="readonly" /></td>
                                    </tr>
                                    <tr>
                                        <td>HSSC/Inter*</td>
                                        <td><input type="text" id="hssc_subject" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="text" id="hssc_board" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="number" id="hssc_year" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="number" id="hssc_result" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="text" id="hssc_grade" runat="server" class="form-control" readonly="readonly" /></td>
                                    </tr>
                                    <tr>
                                        <td>BS Degree*</td>
                                        <td><input type="text" id="bs_subject" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="text" id="bs_board" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="number" id="bs_year" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="number" id="bs_result" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="text" id="bs_grade" runat="server" class="form-control" readonly="readonly" /></td>
                                    </tr>
                                    <tr>
                                        <td>MS/MPhil</td>
                                        <td><input type="text" id="ms_subject" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="text" id="ms_board" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="number" id="ms_year" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="number" id="ms_result" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="text" id="ms_grade" runat="server" class="form-control" readonly="readonly" /></td>
                                    </tr>
                                    <tr>
                                        <td>PhD</td>
                                        <td><input type="text" id="phd_subject" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="text" id="phd_board" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="number" id="phd_year" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="text" id="phd_result" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="text" id="phd_grade" runat="server" class="form-control" readonly="readonly" /></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Work Experience -->
                <div class="card-main" style="margin-bottom:0;border-radius:0;border-top:1px solid #eef1f8;">
                    <div class="card-header-blue">
                        <h5><i class="bi bi-briefcase-fill"></i> Work Experience</h5>
                    </div>

                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 form-group">
                                <label class="form-label">H-Index</label>
                                <asp:TextBox ID="txtHIndex" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>

                            <div class="col-md-6 form-group">
                                <label class="form-label">Experience Before PhD</label>
                                <asp:TextBox ID="txtExperienceBeforePhD" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>

                            <div class="col-md-6 form-group">
                                <label class="form-label">Experience After PhD</label>
                                <asp:TextBox ID="txtExperienceAfterPhD" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>

                            <div class="col-md-6 form-group">
                                <label class="form-label">MS Students Supervised</label>
                                <asp:TextBox ID="txtMSStudents" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>

                            <div class="col-md-6 form-group">
                                <label class="form-label">PhD Students Supervised</label>
                                <asp:TextBox ID="txtPhDStudents" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Information Navigation Buttons -->
                <div class="card-body" style="border-top:1px solid #eef1f8;">
                    <div class="info-buttons">
                        <asp:Button ID="btnPersonalInfo" runat="server" Text="✎ Edit Personal Information" CssClass="btn" OnClick="BtnPersonalInfo_Click" />
                        <asp:Button ID="btnEducationalInfo" runat="server" Text="✎ Edit Educational Information" CssClass="btn" OnClick="BtnEducationalInfo_Click" />
                        <asp:Button ID="btnExperienceInfo" runat="server" Text="✎ Edit Research &amp; Work Experience" CssClass="btn" OnClick="BtnExperienceInfo_Click" />
                    </div>
                </div>

            </div>
            <!-- End Main Form Card -->

            <!-- Declaration - Separate Container -->
            <div class="declaration-container">
                <div class="declaration-header">
                    <h3><i class="bi bi-clipboard-check-fill"></i>Terms & Conditions</h3>
                </div>
                <div class="declaration-body">
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" id="agreeDeclaration" />
                        <label class="form-check-label" for="agreeDeclaration">
                            <strong>I certify that the information given in this application form for admission is complete and accurate to the best of my knowledge.</strong>
                        </label>
                    </div>

                    <div class="text-center mt-4">
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit Application" CssClass="submit-btn" OnClick="BtnSubmit_Click" />
                    </div>
                </div>
            </div>

            <div class="mt-3 text-center">
                <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>
            </div>

        </div>

    </form>

    <script>
        const checkbox = document.getElementById('agreeDeclaration');
        const submitBtn = document.getElementById('btnSubmit');

        if (checkbox && submitBtn) {
            checkbox.addEventListener('change', function () {
                submitBtn.disabled = !this.checked;
            });

            // Initial state
            submitBtn.disabled = true;
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>