<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="CreateJob.aspx.cs"
    Inherits="WebApplication4.CreateJob" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>Create Teaching Job</title>

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

        .page-wrap {
            max-width: 1440px;
            margin: 0 auto;
            padding: 32px 48px 60px;
        }

        .page-header {
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 36px;
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

        .back-link {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 42px;
            height: 42px;
            border-radius: var(--radius);
            color: var(--primary-navy);
            text-decoration: none;
            font-size: 20px;
            border: 1px solid var(--border);
            background: #ffffff;
            margin-bottom: 20px;
            transition: all .2s ease;
        }
        .back-link:hover {
            background: #F1F5F9;
            border-color: var(--action-blue);
            color: var(--action-blue);
        }

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

        .section-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 26px 30px;
            margin-bottom: 16px;
            box-shadow: 0 1px 3px rgba(15, 23, 42, 0.03);
        }

        .section-card:last-of-type { margin-bottom: 0; }

        .section-heading {
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 22px;
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

        .form-label {
            display: block;
            font-family: var(--font-ui);
            font-weight: 500;
            font-size: 13px;
            color: var(--body-text);
            margin-bottom: 7px;
        }

        .required-star { color: var(--error-red); margin-left: 2px; }

        .form-control,
        .form-select {
            width: 100%;
            background: var(--input-bg);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            height: 44px;
            font-family: var(--font-ui);
            font-size: 14px;
            color: var(--body-text);
            padding: 0 14px;
            transition: border-color 0.15s ease, box-shadow 0.15s ease;
        }

        .form-control::placeholder { color: var(--placeholder); }

        .form-control:focus,
        .form-select:focus {
            outline: none;
            border-color: var(--action-blue);
            box-shadow: 0 0 0 2px rgba(23, 105, 168, 0.08);
        }

        .form-grid-3 {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 22px 26px;
            margin-bottom: 22px;
        }

        .form-grid-3:last-child { margin-bottom: 0; }
        .form-group { margin: 0; }

        .message-panel {
            border-radius: var(--radius);
            padding: 14px 20px;
            margin-bottom: 22px;
            font-family: var(--font-ui);
            font-weight: 500;
            font-size: 14px;
            border: none;
            border-left: 4px solid;
        }

        .message-panel.success {
            background: #DCFCE7;
            color: #166534;
            border-left-color: #22C55E;
        }

        .message-panel.error {
            background: #FEE2E2;
            color: #991B1B;
            border-left-color: var(--error-red);
        }

        .validation-summary {
            color: var(--error-red);
            font-family: var(--font-ui);
            font-weight: 500;
            font-size: 13px;
            padding: 12px 16px;
            background: #FEE2E2;
            border-radius: var(--radius);
            border-left: 4px solid var(--error-red);
            margin-top: 20px;
            list-style: none;
        }

        .validation-summary ul {
            margin: 0;
            padding-left: 18px;
        }

        .save-wrap {
            display: flex;
            justify-content: flex-end;
            margin-top: 32px;
            padding-top: 4px;
        }

        .btn-save {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: var(--action-blue);
            color: #FFFFFF;
            border: none;
            border-radius: var(--radius);
            height: 46px;
            padding: 0 30px;
            font-family: var(--font-ui);
            font-weight: 600;
            font-size: 14px;
            letter-spacing: 0.2px;
            cursor: pointer;
            transition: background 0.15s ease;
        }

        .btn-save:hover { background: var(--action-blue-hover); }

        @media (max-width: 900px) {
            .page-wrap { padding: 24px 24px 40px; }
            .form-grid-3 { grid-template-columns: repeat(2, 1fr); }
            .main-heading { font-size: 34px; }
        }

        @media (max-width: 640px) {
            .page-wrap { padding: 20px 16px 40px; }
            .main-heading { font-size: 28px; }
            .form-grid-3 { grid-template-columns: 1fr; }
            .section-heading h3 { font-size: 18px; }
            .btn-save { width: 100%; justify-content: center; }
            .save-wrap { justify-content: stretch; }
        }
    </style>

</head>

<body>

<form id="form1" runat="server">

    <div class="page-wrap">

        <div class="page-header">
            <img src="Images/bu_logo.png" alt="Bahria University" class="logo" />
            <div>
                <div class="uni-name">Bahria University</div>
                <div class="hr-portal">HR Portal</div>
            </div>
        </div>

        <a href="AdminDashboard.aspx" class="back-link" title="Back to Dashboard">
            <i class="bi bi-arrow-left"></i>
        </a>

        <!-- HEADING: icon and badge removed -->
        <h1 class="main-heading">Create Teaching Job</h1>
        <p class="main-subtitle">Publish a new teaching position for candidates to apply.</p>

        <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="message-panel">
            <asp:Label ID="lblMessage" runat="server"></asp:Label>
        </asp:Panel>

        <div class="section-card">
            <div class="section-heading">
                <h3>Job Information</h3>
            </div>

            <div class="form-grid-3">
                <div class="form-group">
                    <label class="form-label">Job Title <span class="required-star">*</span></label>
                    <asp:TextBox ID="txtJobTitle" runat="server" CssClass="form-control" placeholder="Enter Job Title"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="form-label">Job ID <span class="required-star">*</span></label>
                    <asp:TextBox ID="txtJobID" runat="server" CssClass="form-control" placeholder="Enter Job ID"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="form-label">Reference No <span class="required-star">*</span></label>
                    <asp:TextBox ID="txtReferenceNo" runat="server" CssClass="form-control" placeholder="Enter Reference No"></asp:TextBox>
                </div>
            </div>

            <div class="form-grid-3">
                <div class="form-group">
                    <label class="form-label">Campus <span class="required-star">*</span></label>
                    <asp:TextBox ID="txtCampus" runat="server" CssClass="form-control" placeholder="Enter Campus"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="form-label">Department <span class="required-star">*</span></label>
                    <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-control" placeholder="Enter Department"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="form-label">Specialization <span class="required-star">*</span></label>
                    <asp:TextBox ID="txtSpecialization" runat="server" CssClass="form-control" placeholder="Enter Specialization"></asp:TextBox>
                </div>
            </div>

            <div class="form-grid-3">
                <div class="form-group">
                    <label class="form-label">Education Required <span class="required-star">*</span></label>
                    <asp:DropDownList ID="ddlEducation" runat="server" CssClass="form-select">
                        <asp:ListItem Value="">-- Select Education --</asp:ListItem>
                        <asp:ListItem Value="PhD">PhD</asp:ListItem>
                        <asp:ListItem Value="MS/MPhil">MS/MPhil</asp:ListItem>
                        <asp:ListItem Value="MS/MPhil (PhD in Progress)">MS/MPhil (PhD in Progress)</asp:ListItem>
                        <asp:ListItem Value="Master's Degree">Master's Degree</asp:ListItem>
                        <asp:ListItem Value="Bachelor's Degree">Bachelor's Degree</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label class="form-label">Experience Required <span class="required-star">*</span></label>
                    <asp:DropDownList ID="ddlExperience" runat="server" CssClass="form-select">
                        <asp:ListItem Value="">-- Select Experience --</asp:ListItem>
                        <asp:ListItem Value="Fresh">Fresh (No Experience)</asp:ListItem>
                        <asp:ListItem Value="1-2 Years">1-2 Years</asp:ListItem>
                        <asp:ListItem Value="3-5 Years">3-5 Years</asp:ListItem>
                        <asp:ListItem Value="5-10 Years">5-10 Years</asp:ListItem>
                        <asp:ListItem Value="10+ Years">10+ Years</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label class="form-label">Hiring Type <span class="required-star">*</span></label>
                    <asp:DropDownList ID="ddlHiringType" runat="server" CssClass="form-select">
                        <asp:ListItem Value="">-- Select Hiring Type --</asp:ListItem>
                        <asp:ListItem Value="Permanent Faculty">Permanent Faculty</asp:ListItem>
                        <asp:ListItem Value="Visiting Faculty">Visiting Faculty</asp:ListItem>
                        <asp:ListItem Value="POP">POP</asp:ListItem>
                        <asp:ListItem Value="Adjunct">Adjunct</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>

            <div class="form-grid-3">
                <div class="form-group">
                    <label class="form-label">Qualification Level <span class="required-star">*</span></label>
                    <asp:DropDownList ID="ddlQualificationLevel" runat="server" CssClass="form-select">
                        <asp:ListItem Value="">-- Select Qualification --</asp:ListItem>
                        <asp:ListItem Value="PhD">PhD</asp:ListItem>
                        <asp:ListItem Value="Non-PhD">Non-PhD</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label class="form-label">Published Date <span class="required-star">*</span></label>
                    <asp:TextBox ID="txtPublishedDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="form-label">Deadline Date <span class="required-star">*</span></label>
                    <asp:TextBox ID="txtDeadlineDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                </div>
            </div>

            <asp:ValidationSummary ID="ValidationSummary1" runat="server"
                CssClass="validation-summary"
                DisplayMode="BulletList"
                ShowSummary="true" />
        </div>

        <div class="save-wrap">
            <asp:Button ID="btnSubmit" runat="server"
                Text="Create Teaching Job"
                CssClass="btn-save"
                OnClick="btnSubmit_Click" />
        </div>

    </div>

</form>

</body>

</html>