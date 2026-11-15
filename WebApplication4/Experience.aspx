<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Experience.aspx.cs" Inherits="WebApplication4.ExperiencePhd" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Work Experience</title>

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

        .form-label {
            display: block;
            font-family: var(--font-ui);
            font-weight: 500;
            font-size: 13px;
            color: var(--body-text);
            margin-bottom: 7px;
        }

        .required-asterisk { color: var(--error-red); margin-left: 2px; }

        .form-control,
        .form-select,
        textarea.form-control {
            width: 100%;
            background: var(--input-bg);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            height: 44px;
            font-family: var(--font-ui);
            font-size: 14px;
            color: var(--body-text);
            padding: 0 12px;
            transition: border-color 0.15s ease, box-shadow 0.15s ease;
        }

        .form-control::placeholder {
            color: var(--placeholder);
            font-weight: 400;
        }

        .form-control:focus,
        .form-select:focus {
            outline: none;
            border-color: var(--action-blue);
            box-shadow: 0 0 0 2px rgba(23, 105, 168, 0.08);
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 22px 26px;
            margin-bottom: 22px;
        }

        .form-row.one-col { grid-template-columns: 1fr; }
        .form-row:last-child { margin-bottom: 0; }
        .form-group { margin: 0; }

        /* Checkbox */
        .form-check {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-check-input {
            width: 16px;
            height: 16px;
            margin: 0;
            accent-color: var(--action-blue);
            cursor: pointer;
        }

        .form-check-label {
            font-family: var(--font-ui);
            font-size: 14px;
            font-weight: 400;
            color: var(--body-text);
            cursor: pointer;
            margin: 0;
        }

        /* Buttons */
        .btn-add {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: var(--action-blue);
            color: #FFFFFF;
            border: none;
            border-radius: var(--radius);
            height: 44px;
            padding: 0 24px;
            font-family: var(--font-ui);
            font-weight: 600;
            font-size: 14px;
            letter-spacing: 0.2px;
            cursor: pointer;
            transition: background 0.15s ease;
        }

        .btn-add:hover { background: var(--action-blue-hover); }

        .btn-delete {
            background: var(--error-red);
            color: white;
            border: none;
            border-radius: var(--radius);
            padding: 6px 14px;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            font-family: var(--font-ui);
            transition: background 0.15s ease;
        }

        .btn-delete:hover { background: #A71D2A; }

        .btn-save {
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

        .btn-save:hover { background: var(--action-blue-hover); }

        /* Table */
        .table-responsive { overflow-x: auto; }

        .table {
            width: 100%;
            border-collapse: collapse;
            font-family: var(--font-ui);
        }

        .table th {
            background: #F8FAFC;
            color: var(--muted-text);
            font-weight: 700;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: .5px;
            border-bottom: 1px solid var(--border);
            text-align: left;
            padding: 12px 14px;
        }

        .table td {
            font-size: 13px;
            color: var(--body-text);
            padding: 12px 14px;
            border-bottom: 1px solid #F1F4F9;
            vertical-align: middle;
        }

        .table-hover tbody tr:hover {
            background-color: #F8FAFC;
        }

        .empty-row {
            text-align: center;
            color: var(--placeholder);
            padding: 30px 0;
        }

        /* Validation */
        .text-danger {
            display: block;
            color: var(--error-red) !important;
            font-size: 12px;
            font-weight: 500;
            margin-top: 5px;
            font-family: var(--font-ui);
        }

        /* Save wrapper */
        .save-wrap {
            display: flex;
            justify-content: flex-end;
            margin-top: 32px;
            padding-top: 4px;
        }

        @media (max-width: 900px) {
            .page-wrap { padding: 24px 24px 40px; }
        }

        @media (max-width: 640px) {
            .page-wrap { padding: 20px 16px 40px; }
            .main-heading { font-size: 30px; }
            .form-row,
            .form-row.one-col { grid-template-columns: 1fr; }
            .section-heading h3 { font-size: 18px; }
            .btn-save { width: 100%; justify-content: center; }
            .save-wrap { justify-content: stretch; }
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
            <h1 class="main-heading">Work Experience</h1>
            <p class="main-subtitle">Add your professional experience to complete your profile.</p>

            <!-- ============================================================
                 ADD NEW EXPERIENCE
                 ============================================================ -->
            <div class="section-card">
                <div class="section-heading">
                    <h3>Add New Experience</h3>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="<%= txtOrganization.ClientID %>" class="form-label">
                            Organization Name <span class="required-asterisk">*</span>
                        </label>
                        <asp:TextBox ID="txtOrganization" runat="server" CssClass="form-control" placeholder="e.g., Bahria University" />
                        <asp:RequiredFieldValidator ID="rfvOrganization" runat="server"
                            ControlToValidate="txtOrganization"
                            ErrorMessage="Organization name is required."
                            CssClass="text-danger"
                            Display="Dynamic"
                            ValidationGroup="ExperienceForm" />
                    </div>

                    <div class="form-group">
                        <label for="<%= txtPosition.ClientID %>" class="form-label">
                            Position Title <span class="required-asterisk">*</span>
                        </label>
                        <asp:TextBox ID="txtPosition" runat="server" CssClass="form-control" placeholder="e.g., Assistant Professor" />
                        <asp:RequiredFieldValidator ID="rfvPosition" runat="server"
                            ControlToValidate="txtPosition"
                            ErrorMessage="Position title is required."
                            CssClass="text-danger"
                            Display="Dynamic"
                            ValidationGroup="ExperienceForm" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="<%= txtStartDate.ClientID %>" class="form-label">
                            Start Date <span class="required-asterisk">*</span>
                        </label>
                        <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="rfvStartDate" runat="server"
                            ControlToValidate="txtStartDate"
                            ErrorMessage="Start date is required."
                            CssClass="text-danger"
                            Display="Dynamic"
                            ValidationGroup="ExperienceForm" />
                    </div>

                    <div class="form-group">
                        <label for="<%= txtEndDate.ClientID %>" class="form-label">
                            End Date
                        </label>
                        <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date" CssClass="form-control" />
                    </div>
                </div>

                <div class="form-row one-col">
                    <div class="form-group" style="margin-bottom:16px;">
                        <div class="form-check">
                            <asp:CheckBox ID="chkCurrentJob" runat="server" CssClass="form-check-input" />
                            <label class="form-check-label" for="chkCurrentJob">I currently work here</label>
                        </div>
                    </div>
                </div>

                <div style="display:flex; align-items:center; gap:12px;">
                    <asp:Button ID="btnAdd" runat="server" Text="Add Experience"
                        CssClass="btn-add" OnClick="BtnAdd_Click"
                        ValidationGroup="ExperienceForm" />
                    <asp:Label ID="lblMessage" runat="server" />
                </div>
            </div>

            <!-- ============================================================
                 WORK HISTORY
                 ============================================================ -->
            <div class="section-card">
                <div class="section-heading">
                    <h3>Work History</h3>
                </div>

                <div class="table-responsive">
                    <asp:GridView ID="gvExperiences" runat="server" AutoGenerateColumns="false"
                        CssClass="table table-hover mb-0" GridLines="None"
                        DataKeyNames="ExperienceId"
                        EmptyDataText="No work experience added yet." EmptyDataRowStyle-CssClass="empty-row"
                        OnRowCommand="gvExperiences_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="ExperienceId" HeaderText="ID" Visible="false" />
                            <asp:BoundField DataField="OrganizationName" HeaderText="Organization" />
                            <asp:BoundField DataField="PositionTitle" HeaderText="Position" />
                            <asp:BoundField DataField="StartDate" HeaderText="Start Date" DataFormatString="{0:MMM yyyy}" />
                            <asp:BoundField DataField="EndDate" HeaderText="End Date" DataFormatString="{0:MMM yyyy}" />
                            <asp:BoundField DataField="Duration" HeaderText="Duration" />
                            <asp:TemplateField HeaderText="Action" ItemStyle-Width="80px">
                                <ItemTemplate>
                                    <asp:Button ID="btnDelete" runat="server"
                                        CommandName="DeleteExperience"
                                        CommandArgument='<%# Container.DataItemIndex %>'
                                        Text="Delete"
                                        CssClass="btn-delete"
                                        OnClientClick="return confirm('Are you sure you want to delete this experience?');" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <!-- SAVE AND CONTINUE -->
            <div class="save-wrap">
                <asp:Button ID="btnNext" runat="server" Text="Save and Continue  →"
                    CssClass="btn-save" OnClick="BtnNext_Click" />
            </div>

        </div>

    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>