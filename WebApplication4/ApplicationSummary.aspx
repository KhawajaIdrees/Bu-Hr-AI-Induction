<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplicationSummary.aspx.cs" Inherits="WebApplication4.ApplicationSummary" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Application Summary</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Georgia&display=swap" rel="stylesheet">
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

        /* HEADER */
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

        /* SECTION CARD */
        .section-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 22px 26px;
            margin-bottom: 16px;
            box-shadow: 0 1px 3px rgba(15, 23, 42, 0.03);
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

        /* PROFILE IMAGE — SQUARE (rounded corners) */
        .profile-img-wrapper {
            display: flex;
            justify-content: center;
            margin-bottom: 22px;
        }

        .profile-img-wrapper img {
            width: 110px;
            height: 110px;
            object-fit: cover;
            border-radius: var(--radius-lg);
            border: 2px solid var(--border);
            background: #F8FAFC;
        }

        /* FORM LABEL */
        .form-label {
            display: block;
            font-family: var(--font-ui);
            font-weight: 500;
            font-size: 13px;
            color: var(--body-text);
            margin-bottom: 7px;
        }

        /* INPUTS */
        .form-control {
            width: 100%;
            background: var(--input-bg);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            height: 44px;
            font-family: var(--font-ui);
            font-size: 14px;
            color: var(--body-text);
            padding: 0 12px;
            transition: border-color 0.15s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--action-blue);
            box-shadow: 0 0 0 2px rgba(23, 105, 168, 0.08);
        }

        .form-control[readonly] {
            background: #F8FAFC;
            color: var(--body-text);
            font-weight: 500;
            cursor: default;
        }

        /* GRID */
        .form-row {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px 22px;
            margin-bottom: 22px;
        }

        .form-row.two-col { grid-template-columns: 1fr 1fr; }
        .form-row:last-child { margin-bottom: 0; }
        .form-group { margin: 0; }

        /* RADIO GROUP */
        .radio-group {
            display: flex;
            gap: 32px;
            align-items: center;
            padding: 6px 0;
        }

        .radio-group input[type="radio"] {
            width: 16px;
            height: 16px;
            margin-right: 8px;
            vertical-align: middle;
            accent-color: var(--action-blue);
            cursor: not-allowed;
        }

        .radio-group label {
            font-family: var(--font-ui);
            font-size: 14px;
            color: var(--body-text);
            font-weight: 400;
        }

        /* EDUCATION TABLE */
        .table-responsive { overflow-x: auto; }

        .education-table {
            width: 100%;
            border-collapse: collapse;
            font-family: var(--font-ui);
        }

        .education-table th {
            background: #F8FAFC !important;
            color: var(--muted-text) !important;
            font-weight: 700 !important;
            font-size: 11px !important;
            text-transform: uppercase !important;
            letter-spacing: .5px !important;
            border-bottom: 1px solid var(--border) !important;
            text-align: left !important;
            padding: 12px 14px !important;
            white-space: nowrap;
        }

        .education-table td {
            font-size: 13px !important;
            color: var(--body-text) !important;
            padding: 12px 14px !important;
            border-bottom: 1px solid #F1F4F9 !important;
            vertical-align: middle !important;
            text-align: left !important;
        }

        .education-table td:first-child {
            font-weight: 600;
            color: var(--primary-navy);
        }

        .education-table input {
            width: 100%;
            background: #F8FAFC;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            height: 38px;
            font-family: var(--font-ui);
            font-size: 13px;
            color: var(--body-text);
            padding: 0 10px;
            font-weight: 500;
        }

        .education-table input[readonly] {
            cursor: default;
            outline: none;
        }

        /* INFO BUTTONS (Edit navigation) */
        .info-buttons {
            display: flex;
            justify-content: center;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 4px;
        }

        .info-buttons .btn-edit-nav {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            background: #FFFFFF;
            color: var(--action-blue);
            border: 1px solid var(--action-blue);
            border-radius: var(--radius);
            height: 42px;
            padding: 0 20px;
            font-family: var(--font-ui);
            font-weight: 600;
            font-size: 13px;
            letter-spacing: 0.2px;
            cursor: pointer;
            transition: all 0.15s ease;
            text-decoration: none;
        }

        .info-buttons .btn-edit-nav:hover {
            background: var(--action-blue);
            color: #FFFFFF;
        }

        /* DECLARATION CARD */
        .declaration-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 22px 26px;
            margin-top: 16px;
            box-shadow: 0 1px 3px rgba(15, 23, 42, 0.03);
        }

        .declaration-card .form-check {
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }

        .declaration-card .form-check-input {
            width: 18px;
            height: 18px;
            margin: 2px 0 0 0;
            accent-color: var(--action-blue);
            cursor: pointer;
            flex-shrink: 0;
        }

        .declaration-card .form-check-label {
            font-family: var(--font-ui);
            font-size: 14px;
            color: var(--body-text);
            line-height: 1.6;
            cursor: pointer;
            text-align: justify;
        }

        .declaration-card .form-check-label strong {
            color: var(--primary-navy);
        }

        /* SUBMIT BUTTON */
        .submit-wrap {
            display: flex;
            justify-content: flex-end;
            margin-top: 24px;
        }

        .submit-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: var(--action-blue);
            color: #FFFFFF;
            border: none;
            border-radius: var(--radius);
            height: 46px;
            padding: 0 26px;
            font-family: var(--font-ui);
            font-weight: 600;
            font-size: 14px;
            letter-spacing: 0.2px;
            cursor: pointer;
            transition: background 0.15s ease;
        }

        .submit-btn:hover:not(:disabled) { background: var(--action-blue-hover); }

        .submit-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        /* MESSAGE */
        .text-danger {
            color: var(--error-red) !important;
            font-size: 13px;
            font-weight: 500;
            font-family: var(--font-ui);
            display: block;
            margin-top: 14px;
            text-align: center;
        }

        /* RESPONSIVE */
        @media (max-width: 900px) {
            .page-wrap { padding: 24px 24px 40px; }
            .form-row { grid-template-columns: repeat(2, 1fr); }
        }

        @media (max-width: 640px) {
            .page-wrap { padding: 20px 16px 40px; }
            .main-heading { font-size: 30px; }
            .form-row,
            .form-row.two-col { grid-template-columns: 1fr; }
            .section-heading h3 { font-size: 18px; }
            .submit-btn { width: 100%; justify-content: center; }
            .submit-wrap { justify-content: stretch; }
            .info-buttons { flex-direction: column; }
            .info-buttons .btn-edit-nav { width: 100%; }
            .radio-group { gap: 20px; flex-wrap: wrap; }
        }
    </style>
</head>
<body>

    <form id="form1" runat="server">

        <div class="page-wrap">

            <!-- HEADER -->
            <div class="page-header">
                <img src="Images/bu_logo.png" alt="Bahria University" class="logo" />
                <div>
                    <div class="uni-name">Bahria University</div>
                    <div class="hr-portal">HR Portal</div>
                </div>
            </div>

            <!-- MAIN HEADING -->
            <h1 class="main-heading">Application Summary</h1>
            <p class="main-subtitle">Review your submitted information before final submission.</p>

            <!-- ============================================================
                 PERSONAL INFORMATION
                 ============================================================ -->
            <div class="section-card">
                <div class="section-heading">
                    <h3>Personal Information</h3>
                </div>

                <div class="profile-img-wrapper">
                    <asp:Image ID="imgProfile" runat="server"
                        ImageUrl="~/Images/default-avatar.png"
                        AlternateText="Profile Image" />
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Full Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">CNIC</label>
                        <asp:TextBox ID="txtIdentity" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Date of Birth</label>
                        <asp:TextBox ID="txtBirthDate" runat="server" TextMode="Date" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Nationality</label>
                        <asp:TextBox ID="txtNationality" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Mobile Number</label>
                        <asp:TextBox ID="txtCell" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Gender</label>
                        <div class="radio-group">
                            <asp:RadioButton ID="rbMale" runat="server" GroupName="Gender" Text="Male" Enabled="false" />
                            <asp:RadioButton ID="rbFemale" runat="server" GroupName="Gender" Text="Female" Enabled="false" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- ============================================================
                 EDUCATIONAL INFORMATION
                 ============================================================ -->
            <div class="section-card">
                <div class="section-heading">
                    <h3>Educational Information</h3>
                </div>

                <div class="table-responsive">
                    <table class="education-table">
                        <thead>
                            <tr>
                                <th style="min-width:100px;">Qualification</th>
                                <th style="min-width:130px;">Major</th>
                                <th style="min-width:150px;">Institute</th>
                                <th style="min-width:65px;">Year</th>
                                <th style="min-width:85px;">Result (%)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>SSC / Matric *</td>
                                <td><input type="text" id="ssc_subject" runat="server" readonly="readonly" /></td>
                                <td><input type="text" id="ssc_board" runat="server" readonly="readonly" /></td>
                                <td><input type="number" id="ssc_year" runat="server" readonly="readonly" /></td>
                                <td><input type="text" id="ssc_result" runat="server" readonly="readonly" /></td>
                            </tr>
                            <tr>
                                <td>HSSC / Inter *</td>
                                <td><input type="text" id="hssc_subject" runat="server" readonly="readonly" /></td>
                                <td><input type="text" id="hssc_board" runat="server" readonly="readonly" /></td>
                                <td><input type="number" id="hssc_year" runat="server" readonly="readonly" /></td>
                                <td><input type="text" id="hssc_result" runat="server" readonly="readonly" /></td>
                            </tr>
                            <tr>
                                <td>BS Degree *</td>
                                <td><input type="text" id="bs_subject" runat="server" readonly="readonly" /></td>
                                <td><input type="text" id="bs_board" runat="server" readonly="readonly" /></td>
                                <td><input type="number" id="bs_year" runat="server" readonly="readonly" /></td>
                                <td><input type="text" id="bs_result" runat="server" readonly="readonly" /></td>
                            </tr>
                            <tr>
                                <td>MS / MPhil</td>
                                <td><input type="text" id="ms_subject" runat="server" readonly="readonly" /></td>
                                <td><input type="text" id="ms_board" runat="server" readonly="readonly" /></td>
                                <td><input type="number" id="ms_year" runat="server" readonly="readonly" /></td>
                                <td><input type="text" id="ms_result" runat="server" readonly="readonly" /></td>
                            </tr>
                            <tr>
                                <td>PhD</td>
                                <td><input type="text" id="phd_subject" runat="server" readonly="readonly" /></td>
                                <td><input type="text" id="phd_board" runat="server" readonly="readonly" /></td>
                                <td><input type="number" id="phd_year" runat="server" readonly="readonly" /></td>
                                <td><input type="text" id="phd_result" runat="server" readonly="readonly" /></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- ============================================================
                 WORK EXPERIENCE
                 ============================================================ -->
            <div class="section-card">
                <div class="section-heading">
                    <h3>Work Experience</h3>
                </div>

                <div class="form-row two-col">
                    <div class="form-group">
                        <label class="form-label">H-Index</label>
                        <asp:TextBox ID="txtHIndex" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Experience Before PhD</label>
                        <asp:TextBox ID="txtExperienceBeforePhD" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Experience After PhD</label>
                        <asp:TextBox ID="txtExperienceAfterPhD" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">MS Students Supervised</label>
                        <asp:TextBox ID="txtMSStudents" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">PhD Students Supervised</label>
                        <asp:TextBox ID="txtPhDStudents" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                </div>
            </div>

            <!-- ============================================================
                 EDIT NAVIGATION BUTTONS
                 ============================================================ -->
            <div class="section-card">
                <div class="section-heading">
                    <h3>Edit Your Information</h3>
                </div>

                <div class="info-buttons">
                    <asp:Button ID="btnPersonalInfo" runat="server" Text="Edit Personal Information"
                        CssClass="btn-edit-nav" OnClick="BtnPersonalInfo_Click" />

                    <asp:Button ID="btnEducationalInfo" runat="server" Text="Edit Educational Information"
                        CssClass="btn-edit-nav" OnClick="BtnEducationalInfo_Click" />

                    <asp:Button ID="btnExperienceInfo" runat="server" Text="Edit Research &amp; Work Experience"
                        CssClass="btn-edit-nav" OnClick="BtnExperienceInfo_Click" />
                </div>
            </div>

            <!-- ============================================================
                 TERMS & CONDITIONS
                 ============================================================ -->
            <div class="declaration-card">
                <div class="section-heading">
                    <h3>Terms &amp; Conditions</h3>
                </div>

                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="agreeDeclaration" />
                    <label class="form-check-label" for="agreeDeclaration">
                        <strong>I certify that the information given in this application form for admission is complete and accurate to the best of my knowledge.</strong>
                    </label>
                </div>

                <div class="submit-wrap">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit Application"
                        CssClass="submit-btn" OnClick="BtnSubmit_Click" />
                </div>
            </div>

            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>

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