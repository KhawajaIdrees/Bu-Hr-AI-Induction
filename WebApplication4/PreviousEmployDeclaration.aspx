<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PreviousEmployDeclaration.aspx.cs" Inherits="WebApplication4.PreviousEmployment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Previous Employment at Bahria University</title>

   <link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous" />
<link href="https://fonts.googleapis.com/css2?family=Inter..." rel="stylesheet" />
<link rel="stylesheet" href="...bootstrap-icons.css" />
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

        .field-label {
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

        .text-danger {
            display: block;
            color: var(--error-red) !important;
            font-size: 12px;
            font-weight: 500;
            margin-top: 5px;
            font-family: var(--font-ui);
        }

        .field-error {
            color: var(--error-red);
            font-size: 12px;
            font-weight: 500;
            display: none;
            margin-top: 5px;
            font-family: var(--font-ui);
        }

        .suspension-box {
            background: #FAFBFD;
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 20px 22px;
        }

        .suspension-box .question {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            font-family: var(--font-ui);
            font-weight: 500;
            font-size: 14px;
            color: var(--primary-navy);
            margin-bottom: 12px;
            line-height: 1.5;
        }

        .suspension-box .question i {
            color: var(--error-red);
            font-size: 16px;
            margin-top: 2px;
            flex-shrink: 0;
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
            padding: 0 26px;
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
            .btn-save { width: 100%; justify-content: center; }
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
            <p class="main-subtitle">Details of previous employment or association with Bahria University.</p>

            <!-- ============================================================
                 SECTION: PREVIOUS EMPLOYMENT
                 ============================================================ -->
            <div class="section-card">
                <div class="section-heading">
                    <h3>Previous Employment</h3>
                </div>

                <div class="form-row one-col">
                    <div class="form-group">
                        <label class="field-label">
                            Have you previously worked at or been associated with Bahria University?<span class="required-asterisk">*</span>
                        </label>

                        <div class="radio-group">
                            <asp:RadioButtonList ID="rblPreviouslyWorked" runat="server"
                                RepeatDirection="Horizontal" RepeatLayout="Flow" AutoPostBack="false">
                                <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                <asp:ListItem Text="No" Value="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </div>

                        <asp:RequiredFieldValidator ID="rfvPreviouslyWorked" runat="server"
                            ControlToValidate="rblPreviouslyWorked"
                            ErrorMessage="Please select Yes or No."
                            CssClass="text-danger d-block mt-1"
                            Display="Static"
                            ValidationGroup="DeclarationForm" />
                    </div>
                </div>

                <div id="pnlPreviousEmploymentWrapper" runat="server">
                    <div class="inner-details">
                        <div class="inner-heading">If Yes, please provide:</div>

                        <asp:Panel ID="pnlPreviousEmploymentDetails" runat="server">

                            <div class="form-row two-col">
                                <div class="form-group">
                                    <label for="<%= ddlCampus.ClientID %>" class="field-label">
                                        Campus <span class="required-asterisk">*</span>
                                    </label>
                                    <asp:DropDownList ID="ddlCampus" runat="server" CssClass="form-select">
                                        <asp:ListItem Text="-- Select Campus --" Value=""></asp:ListItem>
                                        <asp:ListItem Text="Islamabad" Value="Islamabad"></asp:ListItem>
                                        <asp:ListItem Text="Lahore" Value="Lahore"></asp:ListItem>
                                        <asp:ListItem Text="Karachi" Value="Karachi"></asp:ListItem>
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator ID="rfvCampus" runat="server"
                                        ControlToValidate="ddlCampus" InitialValue=""
                                        ErrorMessage="Please select a campus."
                                        CssClass="text-danger" Display="Static"
                                        ValidationGroup="DeclarationForm" />
                                </div>

                                <div class="form-group">
                                    <label for="<%= txtDepartment.ClientID %>" class="field-label">
                                        Department <span class="required-asterisk">*</span>
                                    </label>
                                    <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-control" placeholder="Enter department" />

                                    <asp:RequiredFieldValidator ID="rfvDepartment" runat="server"
                                        ControlToValidate="txtDepartment"
                                        ErrorMessage="Please enter the department."
                                        CssClass="text-danger d-block mt-1" Display="Static"
                                        ValidationGroup="DeclarationForm" />
                                </div>
                            </div>

                            <div class="form-row two-col">
                                <div class="form-group">
                                    <label for="<%= txtDesignation.ClientID %>" class="field-label">
                                        Designation <span class="required-asterisk">*</span>
                                    </label>
                                    <asp:TextBox ID="txtDesignation" runat="server" CssClass="form-control" placeholder="Enter designation" />

                                    <asp:RequiredFieldValidator ID="rfvDesignation" runat="server"
                                        ControlToValidate="txtDesignation"
                                        ErrorMessage="Please enter the designation."
                                        CssClass="text-danger d-block mt-1" Display="Static"
                                        ValidationGroup="DeclarationForm" />
                                </div>

                                <div class="form-group">
                                    <label for="<%= txtDuration.ClientID %>" class="field-label">
                                        Duration <span class="required-asterisk">*</span>
                                    </label>
                                    <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control" placeholder="e.g. Jan 2021 - Dec 2023" />

                                    <asp:RequiredFieldValidator ID="rfvDuration" runat="server"
                                        ControlToValidate="txtDuration"
                                        ErrorMessage="Please enter the duration."
                                        CssClass="text-danger d-block mt-1" Display="Static"
                                        ValidationGroup="DeclarationForm" />
                                </div>
                            </div>

                            <div class="form-row one-col">
                                <div class="form-group">
                                    <label for="<%= ddlReasonForLeaving.ClientID %>" class="field-label">
                                        Reason for Leaving Bahria University <span class="required-asterisk">*</span>
                                    </label>
                                    <asp:DropDownList ID="ddlReasonForLeaving" runat="server" CssClass="form-select">
                                        <asp:ListItem Text="-- Select Reason --" Value=""></asp:ListItem>
                                        <asp:ListItem Text="Better Career Opportunity" Value="Better Career Opportunity"></asp:ListItem>
                                        <asp:ListItem Text="Better Compensation" Value="Better Compensation"></asp:ListItem>
                                        <asp:ListItem Text="Career Advancement" Value="Career Advancement"></asp:ListItem>
                                        <asp:ListItem Text="Personal Reasons" Value="Personal Reasons"></asp:ListItem>
                                        <asp:ListItem Text="Relocation" Value="Relocation"></asp:ListItem>
                                        <asp:ListItem Text="Work-Life Balance" Value="Work-Life Balance"></asp:ListItem>
                                        <asp:ListItem Text="Higher Education" Value="Higher Education"></asp:ListItem>
                                        <asp:ListItem Text="Health Issues" Value="Health Issues"></asp:ListItem>
                                        <asp:ListItem Text="Work Environment" Value="Work Environment"></asp:ListItem>
                                        <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator ID="rfvReasonForLeaving" runat="server"
                                        ControlToValidate="ddlReasonForLeaving" InitialValue=""
                                        ErrorMessage="Please select a reason for leaving."
                                        CssClass="text-danger d-block mt-1" Display="Static"
                                        ValidationGroup="DeclarationForm" />
                                </div>
                            </div>

                        </asp:Panel>
                    </div>
                </div>
            </div>

            <!-- ============================================================
                 SECTION: SUSPENSION / TERMINATION
                 ============================================================ -->
            <div class="section-card">
                <div class="section-heading">
                    <h3>Suspension &amp; Termination</h3>
                </div>

                <div class="suspension-box">
                    <div class="question">
                        <i class="bi bi-exclamation-circle"></i>
                        <span>
                            Have you ever been suspended or terminated from Bahria University, any Higher Education Institution (HEI), or any other organization during your employment?
                            <span class="required-asterisk">*</span>
                        </span>
                    </div>

                    <div class="radio-group">
                        <asp:RadioButtonList ID="rblSuspensionTermination" runat="server"
                            RepeatDirection="Horizontal" RepeatLayout="Flow">
                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                        </asp:RadioButtonList>
                    </div>

                    <asp:Label ID="lblSuspensionError" runat="server"
                        CssClass="text-danger d-block mt-1"
                        Visible="false">
                        Please select Yes or No.
                    </asp:Label>
                </div>

                <div id="pnlSuspensionDetailsWrapper" runat="server" style="display:none;">
                    <div class="inner-details">
                        <div class="inner-heading">If Yes, please provide:</div>

                        <div class="form-row two-col">
                            <div class="form-group">
                                <label for="<%= txtSuspensionOrg.ClientID %>" class="field-label">
                                    Organization Name <span class="required-asterisk">*</span>
                                </label>
                                <asp:TextBox ID="txtSuspensionOrg" runat="server" CssClass="form-control" placeholder="Enter organization name" />
                                <span id="errSuspensionOrg" class="field-error">Please enter organization name.</span>
                            </div>

                            <div class="form-group">
                                <label for="<%= txtSuspensionDesignation.ClientID %>" class="field-label">
                                    Designation <span class="required-asterisk">*</span>
                                </label>
                                <asp:TextBox ID="txtSuspensionDesignation" runat="server" CssClass="form-control" placeholder="Enter designation" />
                                <span id="errSuspensionDesignation" class="field-error">Please enter designation.</span>
                            </div>
                        </div>

                        <div class="form-row one-col">
                            <div class="form-group">
                                <label for="<%= txtSuspensionDetails.ClientID %>" class="field-label">
                                    If yes, please provide details and the reasons thereof:
                                    <span class="required-asterisk">*</span>
                                </label>
                                <asp:TextBox ID="txtSuspensionDetails" runat="server" CssClass="form-control"
                                    TextMode="MultiLine" Rows="4"
                                    placeholder="Please provide detailed reasons for suspension or termination..." />
                                <span id="errSuspensionDetails" class="field-error">Please provide details and reasons.</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- SAVE AND CONTINUE -->
            <div class="save-wrap">
                <asp:Button ID="btnSubmit" runat="server" Text="Save and Continue  →"
                    CssClass="btn-save" ValidationGroup="DeclarationForm"
                    OnClientClick="return validateSuspensionFields();"
                    OnClick="BtnSubmit_Click" />
            </div>

            <asp:Label ID="lblMessage" runat="server" CssClass="d-block mt-3"></asp:Label>

        </div>

    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        (function () {
            function setValidatorsEnabled(group, enabled) {
                if (typeof (Page_Validators) === 'undefined') return;
                for (var i = 0; i < Page_Validators.length; i++) {
                    var v = Page_Validators[i];
                    if (v.validationGroup === group) {
                        v.enabled = enabled;
                        var span = document.getElementById(v.id);
                        if (span) {
                            span.style.display = enabled ? '' : 'none';
                        }
                    }
                }
            }

            function togglePreviousEmploymentDetails() {
                var wrapper = document.getElementById('<%= pnlPreviousEmploymentWrapper.ClientID %>');
                if (!wrapper) return;

                var checkedRadio = document.querySelector(
                    "input[name='<%= rblPreviouslyWorked.UniqueID %>']:checked"
                );

                var selectedValue = checkedRadio ? checkedRadio.value : "";
                wrapper.style.display = (selectedValue === "Yes") ? "block" : "none";

                setValidatorsEnabled('DeclarationForm', selectedValue === 'Yes');
            }

            function toggleSuspensionDetails() {
                var wrapper = document.getElementById('<%= pnlSuspensionDetailsWrapper.ClientID %>');
                if (!wrapper) return;

                var checkedRadio = document.querySelector(
                    "input[name='<%= rblSuspensionTermination.UniqueID %>']:checked"
                );

                var selectedValue = checkedRadio ? checkedRadio.value : "";
                wrapper.style.display = (selectedValue === "Yes") ? "block" : "none";

                hideAllInlineErrors();

                var lblMsg = document.getElementById('<%= lblMessage.ClientID %>');
                if (lblMsg) lblMsg.innerHTML = '';
            }

            function hideAllInlineErrors() {
                var ids = ['errSuspensionOrg', 'errSuspensionDesignation', 'errSuspensionDetails'];
                for (var i = 0; i < ids.length; i++) {
                    var el = document.getElementById(ids[i]);
                    if (el) el.style.display = 'none';
                }
            }

            function showInlineError(id) {
                var el = document.getElementById(id);
                if (el) el.style.display = 'block';
            }

            function validateSuspensionFields() {
                hideAllInlineErrors();

                var rblSusp = document.querySelector(
                    "input[name='<%= rblSuspensionTermination.UniqueID %>']:checked"
                );
                var suspValue = rblSusp ? rblSusp.value : "";

                if (suspValue !== "Yes") {
                    return true;
                }

                var org = document.getElementById('<%= txtSuspensionOrg.ClientID %>');
                var desig = document.getElementById('<%= txtSuspensionDesignation.ClientID %>');
                var det = document.getElementById('<%= txtSuspensionDetails.ClientID %>');

                var hasError = false;

                if (!org || org.value.trim() === "") {
                    showInlineError('errSuspensionOrg');
                    hasError = true;
                }
                if (!desig || desig.value.trim() === "") {
                    showInlineError('errSuspensionDesignation');
                    hasError = true;
                }
                if (!det || det.value.trim() === "") {
                    showInlineError('errSuspensionDetails');
                    hasError = true;
                }

                if (hasError) {
                    return false;
                }
                return true;
            }

            document.addEventListener("DOMContentLoaded", function () {
                function ensureToggle(attempt) {
                    attempt = attempt || 0;
                    togglePreviousEmploymentDetails();
                    toggleSuspensionDetails();
                    if (typeof (Page_Validators) === 'undefined' && attempt < 10) {
                        setTimeout(function () { ensureToggle(attempt + 1); }, 100);
                    }
                }

                ensureToggle(0);

                document.getElementById("form1").addEventListener("click", function (e) {
                    if (e.target && e.target.matches("input[type='radio'][name='<%= rblPreviouslyWorked.UniqueID %>']")) {
                        togglePreviousEmploymentDetails();
                    }
                    if (e.target && e.target.matches("input[type='radio'][name='<%= rblSuspensionTermination.UniqueID %>']")) {
                        toggleSuspensionDetails();
                    }
                });
            });

            window.togglePreviousEmploymentDetails = togglePreviousEmploymentDetails;
            window.toggleSuspensionDetails = toggleSuspensionDetails;
            window.setValidatorsEnabled = setValidatorsEnabled;
            window.validateSuspensionFields = validateSuspensionFields;
        })();
    </script>
</body>
</html>