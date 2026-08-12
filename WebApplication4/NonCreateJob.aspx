<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="NonCreateJob.aspx.cs"
    Inherits="WebApplication4.NonCreateJob" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>Create Non-Teaching Job</title>

    <meta charset="utf-8" />

    <meta name="viewport"
          content="width=device-width, initial-scale=1" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
          rel="stylesheet" />

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
          rel="stylesheet" />

    <style>

        body {
            background: #f0f4f8;
            font-family: 'Inter', 'Segoe UI', sans-serif;
            margin: 0;
            padding: 40px 0;
        }

        .back-icon {
            display: inline-block;
            text-decoration: none;
            color: #1a3a7a;
            font-size: 36px;
            font-weight: 700;
            transition: .25s;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: #f0f4f8;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border: 2px solid #e8edf5;
        }

        .back-icon:hover {
            color: #2a5aaa;
            transform: translateX(-3px);
            background: #e8edf5;
            border-color: #1a3a7a;
        }

        .page-card {
            background: #ffffff;
            border-radius: 16px;
            border: none;
            box-shadow: 0 8px 30px rgba(26, 58, 122, 0.08);
            padding: 45px 50px;
            margin: auto;
            max-width: 1350px;
        }

        .page-title {
            color: #1a3a7a;
            font-size: 36px;
            font-weight: 800;
            margin-bottom: 35px;
            letter-spacing: -0.5px;
        }

        .page-title i {
            color: #2a5aaa;
            margin-right: 12px;
        }

        .job-type-badge {
            display: inline-block;
            padding: 4px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            margin-left: 10px;
            vertical-align: middle;
            background: #e67e22;
            color: white;
        }

        .form-label {
            color: #1a3a7a;
            font-weight: 600;
            font-size: 15px;
            margin-bottom: 8px;
            letter-spacing: 0.3px;
        }

        .required {
            color: #dc3545;
            font-weight: 700;
        }

        .form-control,
        .form-select {
            height: 52px;
            border-radius: 10px;
            font-size: 15px;
            border: 1.5px solid #e2e8f0;
            padding: 10px 16px;
            transition: all .3s ease;
            font-family: 'Inter', 'Segoe UI', sans-serif;
            background: #fafbff;
        }

        .form-control:focus,
        .form-select:focus {
            border-color: #1a3a7a;
            box-shadow: 0 0 0 4px rgba(26, 58, 122, 0.08);
            background: #ffffff;
        }

        .form-control::placeholder {
            color: #a0aec0;
            font-size: 14px;
        }

        .submit-btn {
            width: 320px;
            height: 58px;
            border: none;
            border-radius: 12px;
            background: linear-gradient(135deg, #1a3a7a, #2a5aaa);
            color: #ffffff;
            font-size: 18px;
            font-weight: 700;
            transition: all .3s ease;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(26, 58, 122, 0.2);
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(26, 58, 122, 0.3);
            background: linear-gradient(135deg, #2a5aaa, #1a3a7a);
        }

        .message-panel {
            border-radius: 12px;
            padding: 16px 22px;
            margin-bottom: 25px;
            border: none;
            font-weight: 500;
        }

        .message-panel.success {
            background: #dcfce7;
            color: #166534;
            border-left: 5px solid #22c55e;
        }

        .message-panel.error {
            background: #ffe4e6;
            color: #991b1b;
            border-left: 5px solid #ef4444;
        }

        .validation-summary {
            color: #dc3545;
            font-weight: 500;
            font-size: 14px;
            padding: 12px 16px;
            background: #ffe4e6;
            border-radius: 10px;
            border-left: 5px solid #ef4444;
            margin-top: 20px;
        }

        @media(max-width:768px) {
            body { padding: 20px 15px; }
            .page-card { padding: 25px 20px; }
            .page-title { font-size: 28px; }
            .submit-btn { width: 100%; height: 54px; font-size: 16px; }
            .back-icon { width: 42px; height: 42px; font-size: 28px; }
            .form-control, .form-select { height: 46px; font-size: 14px; }
            .job-type-badge { font-size: 12px; padding: 2px 12px; }
        }

        @media(min-width:769px) and (max-width:1024px) {
            .page-card { padding: 35px 30px; }
            .submit-btn { width: 260px; }
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="container-fluid px-lg-5 px-3">

<div class="page-card">

    <!-- Back Button -->
    <div class="mb-4">
        <a href="AdminDashboard.aspx" class="back-icon">
            <i class="bi bi-arrow-left"></i>
        </a>
    </div>

    <!-- Page Title -->
    <h2 class="page-title">
        <i class="bi bi-briefcase-fill"></i>
        CREATE NON-TEACHING JOB
        <span class="job-type-badge">Non-Teaching</span>
    </h2>

    <!-- Message Panel -->
    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="message-panel">
        <asp:Label ID="lblMessage" runat="server"></asp:Label>
    </asp:Panel>

    <!-- ============================================================ -->
    <!-- ALL FIELDS (NO Job Type) -->
    <!-- ============================================================ -->

    <div class="row g-4">

        <div class="col-xl-4 col-lg-4 col-md-6 col-12">
            <label class="form-label">Job Title <span class="required">*</span></label>
            <asp:TextBox ID="txtJobTitle" runat="server" CssClass="form-control" placeholder="Enter Job Title"></asp:TextBox>
        </div>

        <div class="col-xl-4 col-lg-4 col-md-6 col-12">
            <label class="form-label">Job ID <span class="required">*</span></label>
            <asp:TextBox ID="txtJobID" runat="server" CssClass="form-control" placeholder="Enter Job ID"></asp:TextBox>
        </div>

        <div class="col-xl-4 col-lg-4 col-md-6 col-12">
            <label class="form-label">Reference No <span class="required">*</span></label>
            <asp:TextBox ID="txtReferenceNo" runat="server" CssClass="form-control" placeholder="Enter Reference No"></asp:TextBox>
        </div>

    </div>

    <div class="row g-4 mt-1">

        <div class="col-xl-4 col-lg-4 col-md-6 col-12">
            <label class="form-label">Campus <span class="required">*</span></label>
            <asp:TextBox ID="txtCampus" runat="server" CssClass="form-control" placeholder="Enter Campus"></asp:TextBox>
        </div>

        <div class="col-xl-4 col-lg-4 col-md-6 col-12">
            <label class="form-label">Department <span class="required">*</span></label>
            <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-control" placeholder="Enter Department"></asp:TextBox>
        </div>

        <div class="col-xl-4 col-lg-4 col-md-6 col-12">
            <label class="form-label">Specialization <span class="required">*</span></label>
            <asp:TextBox ID="txtSpecialization" runat="server" CssClass="form-control" placeholder="Enter Specialization"></asp:TextBox>
        </div>

    </div>

    <div class="row g-4 mt-1">

        <div class="col-xl-4 col-lg-4 col-md-6 col-12">
            <label class="form-label">Education Required <span class="required">*</span></label>
            <asp:DropDownList ID="ddlEducation" runat="server" CssClass="form-select">
                <asp:ListItem Value="">-- Select Education --</asp:ListItem>
                <asp:ListItem Value="Master's Degree">Master's Degree</asp:ListItem>
                <asp:ListItem Value="Bachelor's Degree">Bachelor's Degree</asp:ListItem>
                <asp:ListItem Value="Intermediate">Intermediate</asp:ListItem>
                <asp:ListItem Value="Matriculation">Matriculation</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="col-xl-4 col-lg-4 col-md-6 col-12">
            <label class="form-label">Experience Required <span class="required">*</span></label>
            <asp:DropDownList ID="ddlExperience" runat="server" CssClass="form-select">
                <asp:ListItem Value="">-- Select Experience --</asp:ListItem>
                <asp:ListItem Value="Fresh">Fresh (No Experience)</asp:ListItem>
                <asp:ListItem Value="1-2 Years">1-2 Years</asp:ListItem>
                <asp:ListItem Value="3-5 Years">3-5 Years</asp:ListItem>
                <asp:ListItem Value="5-10 Years">5-10 Years</asp:ListItem>
                <asp:ListItem Value="10+ Years">10+ Years</asp:ListItem>
            </asp:DropDownList>
        </div>

        <!-- NO JOB TYPE DROPDOWN FOR NON-TEACHING -->

    </div>

    <div class="row g-4 mt-1">

        <div class="col-xl-4 col-lg-4 col-md-6 col-12">
            <label class="form-label">Published Date <span class="required">*</span></label>
            <asp:TextBox ID="txtPublishedDate" runat="server" CssClass="form-control" TextMode="Date" placeholder="MM/DD/YYYY"></asp:TextBox>
        </div>

        <div class="col-xl-4 col-lg-4 col-md-6 col-12">
            <label class="form-label">Deadline Date <span class="required">*</span></label>
            <asp:TextBox ID="txtDeadlineDate" runat="server" CssClass="form-control" TextMode="Date" placeholder="MM/DD/YYYY"></asp:TextBox>
        </div>

    </div>

    <!-- Validation Summary -->
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validation-summary" DisplayMode="BulletList" ShowSummary="true" />

    <!-- Submit Button -->
    <div class="text-center mt-5">
        <asp:Button ID="btnSubmit" runat="server" Text="Create Non-Teaching Job" CssClass="submit-btn" OnClick="btnSubmit_Click" />
    </div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</form>

</body>

</html>