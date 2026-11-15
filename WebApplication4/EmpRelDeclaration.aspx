<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmpRelDeclaration.aspx.cs" Inherits="WebApplication4.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Employment Relationship Declaration</title>

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

        /* MAIN HEADING */
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

        /* INNER PANEL */
        .inner-details {
            background: #F8FAFC;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 20px 22px;
            margin-top: 12px;
        }

        .inner-details .inner-heading {
            font-family: var(--font-ui);
            font-weight: 600;
            font-size: 13px;
            color: var(--secondary-navy);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 16px;
        }

        /* LABELS */
        .form-label {
            display: block;
            font-family: var(--font-ui);
            font-weight: 500;
            font-size: 13px;
            color: var(--body-text);
            margin-bottom: 7px;
        }

        .required-asterisk { color: var(--error-red); margin-left: 2px; }

        /* INPUTS */
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

        textarea.form-control {
            height: auto;
            min-height: 90px;
            padding: 12px;
            resize: vertical;
        }

        .form-control::placeholder,
        textarea.form-control::placeholder {
            color: var(--placeholder);
            font-weight: 400;
        }

        .form-control:focus,
        .form-select:focus,
        textarea.form-control:focus {
            outline: none;
            border-color: var(--action-blue);
            box-shadow: 0 0 0 2px rgba(23, 105, 168, 0.08);
        }

        /* FORM GRID */
        .form-row {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 22px 26px;
            margin-bottom: 22px;
        }

        .form-row.two-col { grid-template-columns: 1fr 1fr; }
        .form-row.one-col { grid-template-columns: 1fr; }
        .form-row:last-child { margin-bottom: 0; }
        .form-group { margin: 0; }

        /* RADIO GROUP */
        .radio-group {
            display: flex;
            gap: 48px;
            align-items: center;
            padding: 6px 0;
        }

        .radio-group span {
            display: inline-flex !important;
            align-items: center;
            gap: 10px;
        }

        .radio-group span:not(:last-child) {
            margin-right: 48px !important;
        }

        .radio-group span input[type="radio"] {
            width: 16px;
            height: 16px;
            margin: 0;
            accent-color: var(--action-blue);
            cursor: pointer;
        }

        .radio-group span label {
            margin: 0;
            font-family: var(--font-ui);
            font-size: 14px;
            color: var(--body-text);
            font-weight: 400;
            cursor: pointer;
        }

        /* VALIDATION */
        .text-danger {
            display: block;
            color: var(--error-red) !important;
            font-size: 12px;
            font-weight: 500;
            margin-top: 5px;
            font-family: var(--font-ui);
        }

        /* SAVE BUTTON */
        .save-wrap {
            display: flex;
            justify-content: flex-end;
            margin-top: 32px;
            padding-top: 4px;
        }

        .btn-bu-blue {
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

        .btn-bu-blue:hover { background: var(--action-blue-hover); }

        /* RESPONSIVE */
        @media (max-width: 900px) {
            .page-wrap { padding: 24px 24px 40px; }
            .form-row { grid-template-columns: repeat(2, 1fr); }
            .form-row.one-col { grid-template-columns: 1fr; }
        }

        @media (max-width: 640px) {
            .page-wrap { padding: 20px 16px 40px; }
            .main-heading { font-size: 30px; }
            .form-row,
            .form-row.two-col,
            .form-row.one-col { grid-template-columns: 1fr; }
            .section-heading h3 { font-size: 18px; }
            .btn-bu-blue { width: 100%; justify-content: center; }
            .save-wrap { justify-content: stretch; }
            .radio-group { gap: 28px; flex-wrap: wrap; }
            .radio-group span:not(:last-child) { margin-right: 28px !important; }
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
            <h1 class="main-heading">Additional Information</h1>
            <p class="main-subtitle">Details of near/blood relatives associated with Bahria University.</p>

            <!-- ============================================================
                 SECTION: EMPLOYMENT RELATIONSHIP
                 ============================================================ -->
            <div class="section-card">
                <div class="section-heading">
                    <h3>Employment Relationship</h3>
                </div>

                <div class="form-row one-col">
                    <div class="form-group">
                        <label class="form-label">
                            Do you have any blood relative currently employed at Bahria University?
                            <span class="required-asterisk">*</span>
                        </label>

                        <div class="radio-group">
                            <asp:RadioButtonList
                                ID="rblHasRelative"
                                runat="server"
                                RepeatDirection="Horizontal"
                                RepeatLayout="Flow">

                                <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                <asp:ListItem Text="No" Value="No"></asp:ListItem>

                            </asp:RadioButtonList>
                        </div>

                        <asp:RequiredFieldValidator
                            ID="rfvHasRelative"
                            runat="server"
                            ControlToValidate="rblHasRelative"
                            ErrorMessage="Please select Yes or No."
                            CssClass="text-danger d-block mt-1"
                            Display="Static"
                            ValidationGroup="RelativeForm" />
                    </div>
                </div>

                <div id="pnlRelativeDetailsWrapper" runat="server" style="display:none;">
                    <div class="inner-details">
                        <div class="inner-heading">If Yes, please provide:</div>

                        <asp:Panel ID="pnlRelativeDetails" runat="server">

                            <div class="form-row two-col">
                                <div class="form-group">
                                    <label for="<%= txtName.ClientID %>" class="form-label">
                                        Name <span class="required-asterisk">*</span>
                                    </label>
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter full name" />

                                    <asp:RequiredFieldValidator
                                        ID="rfvName"
                                        runat="server"
                                        ControlToValidate="txtName"
                                        ErrorMessage="Please enter the name."
                                        CssClass="text-danger d-block mt-1"
                                        Display="Static"
                                        ValidationGroup="RelativeForm" />
                                </div>

                                <div class="form-group">
                                    <label for="<%= ddlRelationship.ClientID %>" class="form-label">
                                        Relationship <span class="required-asterisk">*</span>
                                    </label>
                                    <asp:DropDownList ID="ddlRelationship" runat="server" CssClass="form-select">
                                        <asp:ListItem Text="--Select--" Value=""></asp:ListItem>
                                        <asp:ListItem Text="Father" Value="Father"></asp:ListItem>
                                        <asp:ListItem Text="Mother" Value="Mother"></asp:ListItem>
                                        <asp:ListItem Text="Spouse" Value="Spouse"></asp:ListItem>
                                        <asp:ListItem Text="Son" Value="Son"></asp:ListItem>
                                        <asp:ListItem Text="Daughter" Value="Daughter"></asp:ListItem>
                                        <asp:ListItem Text="Brother" Value="Brother"></asp:ListItem>
                                        <asp:ListItem Text="Sister" Value="Sister"></asp:ListItem>
                                        <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator
                                        ID="rfvRelationship"
                                        runat="server"
                                        ControlToValidate="ddlRelationship"
                                        InitialValue=""
                                        ErrorMessage="Please select relationship."
                                        CssClass="text-danger d-block mt-1"
                                        Display="Static"
                                        ValidationGroup="RelativeForm">
                                    </asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="form-row two-col">
                                <div class="form-group">
                                    <label for="<%= txtCampus.ClientID %>" class="form-label">
                                        Campus <span class="required-asterisk">*</span>
                                    </label>
                                    <asp:TextBox ID="txtCampus" runat="server" CssClass="form-control" placeholder="Enter campus" />

                                    <asp:RequiredFieldValidator
                                        ID="rfvCampus"
                                        runat="server"
                                        ControlToValidate="txtCampus"
                                        ErrorMessage="Please enter campus."
                                        CssClass="text-danger d-block mt-1"
                                        Display="Static"
                                        ValidationGroup="RelativeForm" />
                                </div>

                                <div class="form-group">
                                    <label for="<%= txtDepartment.ClientID %>" class="form-label">
                                        Department <span class="required-asterisk">*</span>
                                    </label>
                                    <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-control" placeholder="Enter department" />

                                    <asp:RequiredFieldValidator
                                        ID="rfvDepartment"
                                        runat="server"
                                        ControlToValidate="txtDepartment"
                                        ErrorMessage="Please enter department."
                                        CssClass="text-danger d-block mt-1"
                                        Display="Static"
                                        ValidationGroup="RelativeForm" />
                                </div>
                            </div>

                            <div class="form-row one-col">
                                <div class="form-group">
                                    <label for="<%= txtDesignation.ClientID %>" class="form-label">
                                        Designation <span class="required-asterisk">*</span>
                                    </label>
                                    <asp:TextBox ID="txtDesignation" runat="server" CssClass="form-control" placeholder="Enter designation" />

                                    <asp:RequiredFieldValidator
                                        ID="rfvDesignation"
                                        runat="server"
                                        ControlToValidate="txtDesignation"
                                        ErrorMessage="Please enter designation."
                                        CssClass="text-danger d-block mt-1"
                                        Display="Static"
                                        ValidationGroup="RelativeForm" />
                                </div>
                            </div>

                        </asp:Panel>
                    </div>
                </div>
            </div>

            <!-- SAVE AND CONTINUE -->
            <div class="save-wrap">
                <asp:Button
                    ID="btnSubmit"
                    runat="server"
                    Text="Save and Continue  →"
                    CssClass="btn-bu-blue"
                    ValidationGroup="RelativeForm"
                    OnClick="BtnSubmit_Click" />
            </div>

            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="text-danger"
                style="display:block; margin-top:14px;">
            </asp:Label>

        </div>

    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function toggleRelativeDetails() {

            var wrapper = document.getElementById("<%= pnlRelativeDetailsWrapper.ClientID %>");

            var radios = document.getElementsByName("<%= rblHasRelative.UniqueID %>");

            var selected = "";

            for (var i = 0; i < radios.length; i++) {

                if (radios[i].checked) {

                    selected = radios[i].value;
                    break;
                }

            }

            wrapper.style.display = (selected === "Yes") ? "block" : "none";
            setValidatorsEnabled('RelativeForm', selected === 'Yes');
        }

        window.onload = function () {

            function ensureToggle(attempt) {
                attempt = attempt || 0;
                toggleRelativeDetails();
                if (typeof (Page_Validators) === 'undefined' && attempt < 10) {
                    setTimeout(function () { ensureToggle(attempt + 1); }, 100);
                }
            }

            ensureToggle(0);

            var radios = document.getElementsByName("<%= rblHasRelative.UniqueID %>");

            for (var i = 0; i < radios.length; i++) {

                radios[i].onclick = toggleRelativeDetails;

            }

        };

        function setValidatorsEnabled(group, enabled) {
            if (typeof (Page_Validators) === 'undefined') return;
            for (var i = 0; i < Page_Validators.length; i++) {
                var v = Page_Validators[i];
                if (v.validationGroup === group) {
                    v.enabled = enabled;
                    var span = document.getElementById(v.id);
                    if (span) span.style.display = enabled ? '' : 'none';
                }
            }
        }
    </script>

</body>
</html>