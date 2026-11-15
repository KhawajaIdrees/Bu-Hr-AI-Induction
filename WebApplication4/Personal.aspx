<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Personal.aspx.cs" Inherits="WebApplication4.RegisterUser" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Personal Information</title>

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Georgia&display=swap" rel="stylesheet" />

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

        .upload-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 22px;
        }

        .upload-box {
            display: flex;
            align-items: center;
            gap: 22px;
            border: 1px dashed #D5DFE8;
            background: #FFFFFF;
            border-radius: var(--radius);
            padding: 20px 24px;
            height: 100%;
        }

        .upload-preview {
            width: 88px;
            height: 88px;
            border-radius: 8px;
            background: #F1F5F9;
            border: 1px solid #D5DFE8;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            flex-shrink: 0;
            color: var(--secondary-navy);
            font-size: 26px;
        }

        .upload-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        .upload-info {
            flex: 1;
            min-width: 0;
        }

        .upload-title {
            font-family: var(--font-heading);
            font-weight: 600;
            font-size: 19px;
            color: var(--primary-navy);
            margin-bottom: 4px;
        }

        .upload-desc {
            font-family: var(--font-ui);
            font-weight: 400;
            font-size: 13px;
            color: var(--muted-text);
            margin-bottom: 12px;
        }

        .upload-info input[type="file"] {
            font-family: var(--font-ui);
            font-size: 13px;
            color: var(--body-text);
            width: 100%;
        }

        .upload-info input[type="file"]::file-selector-button {
            background: #FFFFFF;
            border: 1px solid #C9D6E2;
            color: var(--primary-navy);
            font-family: var(--font-ui);
            font-weight: 500;
            font-size: 13px;
            border-radius: var(--radius);
            padding: 7px 16px;
            cursor: pointer;
            transition: background 0.15s ease;
            margin-right: 12px;
        }

        .upload-info input[type="file"]::file-selector-button:hover {
            background: #F1F5F9;
        }

        .current-cv-box {
            background: #F0FDF4;
            border: 1px solid #BBF7D0;
            border-radius: var(--radius);
            padding: 10px 14px;
            margin-bottom: 12px;
            font-family: var(--font-ui);
            font-size: 13px;
            color: #166534;
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }

        .current-cv-box i {
            color: #16A34A;
            font-size: 15px;
            flex-shrink: 0;
        }

        .current-cv-box small {
            color: var(--muted-text);
            font-size: 12px;
        }

        .current-cv-link {
            color: var(--action-blue);
            font-weight: 600;
            text-decoration: none;
            word-break: break-all;
        }

        .current-cv-link:hover {
            text-decoration: underline;
        }

        .field-label {
            display: block;
            font-family: var(--font-ui);
            font-weight: 500;
            font-size: 13px;
            color: var(--body-text);
            margin-bottom: 7px;
        }

        .required-star { color: var(--error-red); margin-left: 2px; }

        .field-input,
        .field-select,
        textarea.field-input {
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

        textarea.field-input {
            height: auto;
            min-height: 90px;
            padding: 12px;
            resize: vertical;
        }

        .field-input::placeholder,
        textarea.field-input::placeholder {
            color: var(--placeholder);
            font-weight: 400;
        }

        .field-input:focus,
        .field-select:focus,
        textarea.field-input:focus {
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
        .form-row:last-child { margin-bottom: 0; }
        .form-group { margin: 0; }

        .radio-group {
            display: flex;
            gap: 48px;
            align-items: center;
            padding: 6px 0;
        }

        .radio-group label {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            font-family: var(--font-ui);
            font-size: 14px;
            color: var(--body-text);
            cursor: pointer;
            font-weight: 400;
        }

        .radio-group input[type="radio"] {
            width: 16px;
            height: 16px;
            margin: 0;
            accent-color: var(--action-blue);
            cursor: pointer;
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
            color: var(--error-red);
            font-size: 12px;
            font-weight: 500;
            margin-top: 5px;
            font-family: var(--font-ui);
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
            .upload-grid { grid-template-columns: 1fr; }
        }

        @media (max-width: 640px) {
            .page-wrap { padding: 20px 16px 40px; }
            .main-heading { font-size: 30px; }
            .form-row,
            .form-row.two-col { grid-template-columns: 1fr; }
            .section-heading h3 { font-size: 18px; }
            .btn-save { width: 100%; justify-content: center; }
            .save-wrap { justify-content: stretch; }
            .upload-box { flex-direction: column; text-align: center; }
            .radio-group { gap: 28px; flex-wrap: wrap; }
            .radio-group span:not(:last-child) { margin-right: 28px !important; }
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

        <h1 class="main-heading">Personal Information</h1>
        <p class="main-subtitle">Please provide accurate information as per your official documents.</p>

        <div class="section-card">
            <div class="section-heading">
                <h3>Profile Picture &amp; CV</h3>
            </div>

            <div class="upload-grid">

                <div class="upload-box">
                    <div class="upload-preview">
                        <img id="imgPicturePreview" runat="server" src="#" alt="Profile preview" style="display:none;" />
                        <i id="picturePlaceholder" runat="server" class="bi bi-person"></i>
                    </div>

                    <div class="upload-info">
                        <div class="upload-title">Upload your photo</div>
                        <div class="upload-desc">Clear passport-size photo (Max 10MB)</div>

                        <asp:FileUpload ID="fuPicture" runat="server"
                            onchange="previewPicture(this);"
                            accept="image/*" />

                        <asp:Label ID="picMsg" runat="server" CssClass="text-danger"></asp:Label>
                    </div>
                </div>

                <div class="upload-box">
                    <div class="upload-preview">
                        <i class="bi bi-file-earmark-text"></i>
                    </div>

                    <div class="upload-info">
                        <div class="upload-title">Upload your CV<span class="required-star">*</span></div>
                        <div class="upload-desc">PDF, DOC or DOCX (Max 15MB)</div>

                        <asp:Panel ID="pnlCurrentCV" runat="server" Visible="false" CssClass="current-cv-box">
                            <i class="bi bi-file-earmark-check-fill"></i>
                            <span>Current CV:</span>
                            <asp:HyperLink ID="lnkCurrentCV" runat="server" Target="_blank" CssClass="current-cv-link"></asp:HyperLink>
                            <small>(upload a new file to replace)</small>
                        </asp:Panel>

                        <asp:FileUpload ID="fuResume" runat="server" />

                        <asp:Label ID="cvMsg" runat="server" CssClass="text-danger"></asp:Label>
                    </div>
                </div>

            </div>
        </div>

        <div class="section-card">
            <div class="section-heading">
                <h3>Identity Details</h3>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label class="field-label">First Name<span class="required-star">*</span></label>
                    <asp:TextBox ID="txtFirstName" runat="server" CssClass="field-input" placeholder="Enter First Name" />
                    <asp:RequiredFieldValidator ID="rfvFirstName" runat="server"
                        ControlToValidate="txtFirstName"
                        ErrorMessage="First name is required."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="PersonalForm" />
                </div>

                <div class="form-group">
                    <label class="field-label">Middle Name</label>
                    <asp:TextBox ID="txtMiddleName" runat="server" CssClass="field-input" placeholder="Enter Middle Name" />
                </div>

                <div class="form-group">
                    <label class="field-label">Last Name<span class="required-star">*</span></label>
                    <asp:TextBox ID="txtLastName" runat="server" CssClass="field-input" placeholder="Enter Last Name" />
                    <asp:RequiredFieldValidator ID="rfvLastName" runat="server"
                        ControlToValidate="txtLastName"
                        ErrorMessage="Last name is required."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="PersonalForm" />
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label class="field-label">Father's Name<span class="required-star">*</span></label>
                    <asp:TextBox ID="txtFatherName" runat="server" CssClass="field-input" placeholder="Enter Father's Name" />
                    <asp:RequiredFieldValidator ID="rfvFatherName" runat="server"
                        ControlToValidate="txtFatherName"
                        ErrorMessage="Father's name is required."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="PersonalForm" />
                </div>

                <div class="form-group">
                    <label class="field-label">CNIC Number<span class="required-star">*</span></label>
                    <asp:TextBox ID="txtCnic" runat="server" CssClass="field-input" placeholder="CNIC / Passport Number" />
                    <asp:RequiredFieldValidator ID="rfvCnic" runat="server"
                        ControlToValidate="txtCnic"
                        ErrorMessage="CNIC number is required."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="PersonalForm" />
                </div>

                <div class="form-group">
                    <label class="field-label">Gender<span class="required-star">*</span></label>
                    <asp:DropDownList ID="ddlGender" runat="server" CssClass="field-select">
                        <asp:ListItem Text="-- Select Gender --" Value="" />
                        <asp:ListItem Text="Male" Value="Male" />
                        <asp:ListItem Text="Female" Value="Female" />
                        <asp:ListItem Text="Other" Value="Other" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvGender" runat="server"
                        ControlToValidate="ddlGender"
                        InitialValue=""
                        ErrorMessage="Please select a gender."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="PersonalForm" />
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label class="field-label">Cell Number<span class="required-star">*</span></label>
                    <asp:TextBox ID="txtCellNumber" runat="server" CssClass="field-input" placeholder="e.g. 03001234567" />
                    <asp:RequiredFieldValidator ID="rfvCellNumber" runat="server"
                        ControlToValidate="txtCellNumber"
                        ErrorMessage="Cell number is required."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="PersonalForm" />
                </div>

                <div class="form-group">
                    <label class="field-label">Birth Date<span class="required-star">*</span></label>
                    <asp:TextBox ID="txtBirthDate" runat="server" CssClass="field-input" TextMode="Date" />
                    <asp:RequiredFieldValidator ID="rfvBirthDate" runat="server"
                        ControlToValidate="txtBirthDate"
                        ErrorMessage="Birth date is required."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="PersonalForm" />
                </div>

                <div class="form-group">
                    <label class="field-label">Marital Status<span class="required-star">*</span></label>
                    <asp:DropDownList ID="ddlMaritalStatus" runat="server" CssClass="field-select">
                        <asp:ListItem Text="-- Select Marital Status --" Value="" />
                        <asp:ListItem Text="Single" Value="Single" />
                        <asp:ListItem Text="Married" Value="Married" />
                        <asp:ListItem Text="Divorced" Value="Divorced" />
                        <asp:ListItem Text="Widowed" Value="Widowed" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvMaritalStatus" runat="server"
                        ControlToValidate="ddlMaritalStatus"
                        InitialValue=""
                        ErrorMessage="Please select a marital status."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="PersonalForm" />
                </div>
            </div>
        </div>

        <div class="section-card">
            <div class="section-heading">
                <h3>Background</h3>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label class="field-label">Nationality<span class="required-star">*</span></label>
                    <asp:TextBox ID="txtNationality" runat="server" CssClass="field-input" placeholder="Enter Nationality" />
                    <asp:RequiredFieldValidator ID="rfvNationality" runat="server"
                        ControlToValidate="txtNationality"
                        ErrorMessage="Nationality is required."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="PersonalForm" />
                </div>

                <div class="form-group">
                    <label class="field-label">Religion<span class="required-star">*</span></label>
                    <asp:TextBox ID="txtReligion" runat="server" CssClass="field-input" placeholder="Enter Religion" />
                    <asp:RequiredFieldValidator ID="rfvReligion" runat="server"
                        ControlToValidate="txtReligion"
                        ErrorMessage="Religion is required."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="PersonalForm" />
                </div>

                <div class="form-group">
                    <label class="field-label">Sect<span class="required-star">*</span></label>
                    <asp:TextBox ID="txtSect" runat="server" CssClass="field-input" placeholder="Enter Sect" />
                    <asp:RequiredFieldValidator ID="rfvSect" runat="server"
                        ControlToValidate="txtSect"
                        ErrorMessage="Sect is required."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="PersonalForm" />
                </div>
            </div>
        </div>

        <div class="section-card">
            <div class="section-heading">
                <h3>Address</h3>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label class="field-label">Country<span class="required-star">*</span></label>
                    <asp:TextBox ID="txtCountry" runat="server" CssClass="field-input" placeholder="Enter Country" />
                    <asp:RequiredFieldValidator ID="rfvCountry" runat="server"
                        ControlToValidate="txtCountry"
                        ErrorMessage="Country is required."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="PersonalForm" />
                </div>

                <div class="form-group">
                    <label class="field-label">State/Province<span class="required-star">*</span></label>
                    <asp:TextBox ID="txtStateProvince" runat="server" CssClass="field-input" placeholder="Enter State/Province" />
                    <asp:RequiredFieldValidator ID="rfvStateProvince" runat="server"
                        ControlToValidate="txtStateProvince"
                        ErrorMessage="State/Province is required."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="PersonalForm" />
                </div>

                <div class="form-group">
                    <label class="field-label">City<span class="required-star">*</span></label>
                    <asp:TextBox ID="txtCity" runat="server" CssClass="field-input" placeholder="Enter City" />
                    <asp:RequiredFieldValidator ID="rfvCity" runat="server"
                        ControlToValidate="txtCity"
                        ErrorMessage="City is required."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="PersonalForm" />
                </div>
            </div>

            <div class="form-row two-col">
                <div class="form-group">
                    <label class="field-label">Current Address<span class="required-star">*</span></label>
                    <asp:TextBox ID="txtCurrentAddress" runat="server" CssClass="field-input" TextMode="MultiLine" placeholder="Enter your current address" />
                    <asp:RequiredFieldValidator ID="rfvCurrentAddress" runat="server"
                        ControlToValidate="txtCurrentAddress"
                        ErrorMessage="Current address is required."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="PersonalForm" />
                </div>

                <div class="form-group">
                    <label class="field-label">Permanent Address<span class="required-star">*</span></label>
                    <asp:TextBox ID="txtPermanentAddress" runat="server" CssClass="field-input" TextMode="MultiLine" placeholder="Enter your permanent address" />
                    <asp:RequiredFieldValidator ID="rfvPermanentAddress" runat="server"
                        ControlToValidate="txtPermanentAddress"
                        ErrorMessage="Permanent address is required."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="PersonalForm" />
                </div>
            </div>
        </div>

        <div class="section-card">
            <div class="section-heading">
                <h3>Online Profiles</h3>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label class="field-label">Google Scholar Profile</label>
                    <asp:TextBox ID="txtGoogleScholar" runat="server" CssClass="field-input"
                        placeholder="https://scholar.google.com/citations?user=..." />
                </div>

                <div class="form-group">
                    <label class="field-label">LinkedIn Profile</label>
                    <asp:TextBox ID="txtLinkedIn" runat="server" CssClass="field-input"
                        placeholder="https://www.linkedin.com/in/..." />
                </div>

                <div class="form-group">
                    <label class="field-label">ORCID iD</label>
                    <asp:TextBox ID="txtORCID" runat="server" CssClass="field-input"
                        placeholder="https://orcid.org/0000-0000-0000-0000" />
                </div>
            </div>
        </div>

        <div class="section-card">
            <div class="section-heading">
                <h3>Additional Information</h3>
            </div>

            <div class="form-group">
                <label class="field-label">
                    Have you previously applied to Bahria University?<span class="required-star">*</span>
                </label>

                <div class="radio-group">
                    <asp:RadioButtonList ID="rblPreviouslyApplied" runat="server"
                        RepeatDirection="Horizontal"
                        RepeatLayout="Flow">
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                    </asp:RadioButtonList>
                </div>

                <asp:RequiredFieldValidator ID="rfvPreviouslyApplied" runat="server"
                    ControlToValidate="rblPreviouslyApplied"
                    ErrorMessage="Please select Yes or No."
                    CssClass="text-danger"
                    Display="Dynamic"
                    ValidationGroup="PersonalForm" />
            </div>
        </div>

        <div class="save-wrap">
            <asp:Button ID="BtnSaveContinue" runat="server"
                Text="Save and Continue  →"
                CssClass="btn-save"
                ValidationGroup="PersonalForm"
                OnClick="BtnRegister_Click" />
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" style="display:block; margin-top:14px;"></asp:Label>

    </div>

</form>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" />

<script>
    function previewPicture(input) {
        var previewImg = document.getElementById('<%= imgPicturePreview.ClientID %>');
        var placeholder = document.getElementById('<%= picturePlaceholder.ClientID %>');

        if (input.files && input.files[0]) {
            var file = input.files[0];

            if (!file.type.startsWith('image/')) {
                alert('❌ Please select only image files (JPEG, PNG, GIF, etc.)');
                input.value = '';
                if (previewImg) previewImg.style.display = 'none';
                if (placeholder) placeholder.style.display = '';
                return;
            }

            if (file.size > 10 * 1024 * 1024) {
                alert('❌ File size must be less than 10MB');
                input.value = '';
                if (previewImg) previewImg.style.display = 'none';
                if (placeholder) placeholder.style.display = '';
                return;
            }

            var reader = new FileReader();
            reader.onload = function (e) {
                if (previewImg) {
                    previewImg.src = e.target.result;
                    previewImg.style.display = 'block';
                }
                if (placeholder) placeholder.style.display = 'none';
            };
            reader.readAsDataURL(file);
        } else {
            if (previewImg) previewImg.style.display = 'none';
            if (placeholder) placeholder.style.display = '';
        }
    }
</script>

</body>

</html>