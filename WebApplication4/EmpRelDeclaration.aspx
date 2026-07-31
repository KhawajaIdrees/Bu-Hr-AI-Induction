<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmpRelDeclaration.aspx.cs" Inherits="WebApplication4.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>Employment Relationship Declaration</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<style>

    body {
        background:#f4f7fb;
        font-family:'Segoe UI', Arial, sans-serif;
        font-size:17px;
    }

    .page-title h4 {
        color:#2D398D;
    }

    .page-title hr {
        border-top:2px solid #2D398D;
        opacity:.15;
     
        margin:.75rem 0 0;
    }

    /* Main Form Card */
    .form-card {
        max-width:1100px;
        margin:30px auto 60px;
        background:white;
        padding:45px 50px;
        border-radius:16px;
        box-shadow:0px 8px 30px rgba(45,57,141,.10);
    }

    /* Section Titles */
    .section-title {
        display:flex;
        align-items:center;
        gap:10px;
        font-size:19px;
        font-weight:700;
        color:#2D398D;
        border-bottom:2px solid #eef1f8;
        padding-bottom:15px;
        margin-bottom:30px;
        text-transform:uppercase;
        letter-spacing:.4px;
    }

    .section-title i {
        font-size:20px;
    }

    /* Labels */
    .form-label {
        font-size:15px;
        font-weight:600;
        color:#44496b;
        margin-bottom:8px;
    }

    .required-asterisk {
        color:#dc3545;
        font-size:15px;
    }

    /* Input Fields */
    .form-control,
    .form-select {
        height:48px;
        font-size:15px;
        border-radius:8px;
        border:1px solid #ced4da;
        padding:10px 14px;
        transition:all .2s ease-in-out;
    }

    .form-control:focus,
    .form-select:focus {
        border-color:#2D398D;
        box-shadow:0 0 0 .2rem rgba(45,57,141,.15);
    }

    textarea.form-control {
        min-height:120px;
    }

    /* Placeholder text */
    .form-control::placeholder {
        font-size:14px;
        color:#a3a9bd;
    }

    /* Radio Buttons */
    .radio-group {
        font-size:16px;
        margin-top:10px;
    }

    .radio-group input[type="radio"] {
        width:18px;
        height:18px;
        margin-right:8px;
        vertical-align:middle;
        cursor:pointer;
    }

    .radio-group input[type="radio"]:checked {
        background-color:#2D398D;
        border-color:#2D398D;
    }

    .radio-group label {
        margin-right:35px;
        margin-bottom:0;
        cursor:pointer;
        font-weight:500;
        color:#44496b;
    }

    /* Right Detail Panel */
    .relative-details {
        background:#f8faff;
        border:1px solid #cddcff;
        padding:28px;
        border-radius:12px;
    }

    /* Column Divider */
    .col-divider {
        border-left:2px solid #eef1f8;
    }

    /* Validation Text */
    .text-danger {
        font-size:13px;
        font-weight:600;
    }

    /* Buttons */
    .btn-bu-blue {
        background:#2D398D;
        color:white;
        border:none;
        font-size:16px;
        padding:12px 40px;
        border-radius:8px;
        font-weight:600;
        transition:all .2s ease-in-out;
    }

    .btn-bu-blue:hover {
        background:#232c70;
        color:white;
        transform:translateY(-1px);
        box-shadow:0 6px 16px rgba(45,57,141,.3);
    }

    .btn-outline-secondary {
        border-radius:8px;
        font-size:16px;
        padding:12px 30px;
        font-weight:600;
    }

    /* Field spacing */
    .mb-3 {
        margin-bottom:24px !important;
    }

    /* Responsive adjustment */
    @media(max-width:768px){
        body { font-size:15px; }
        .form-card { padding:25px; }
        .section-title { font-size:17px; }
        .form-label { font-size:14px; }
        .form-control, .form-select { font-size:14px; height:44px; }
    }

    .text-bu-blue {
        color: #2D398D !important;
    }

    .bg-bu-blue {
        background-color: #2D398D !important;
        color: #ffffff;
        border-color: #2D398D;
    }
</style>

</head>
<body>
    <form id="form1" runat="server">

        <div class="container">

            <div class="text-left mb-3 mt-4 page-title">
                <h4 class="fw-bold">Declaration</h4>
                <h5 class="text-secondary fw-normal">Bahria University HR Portal</h5>
                <hr />
            </div>

            <div class="form-card">

                <div class="section-title">
                    <i class="bi bi-people-fill"></i>
                    Employment Relationship Declaration
                </div>

                <div class="row">

                    <!-- LEFT COLUMN -->
                    <div class="col-md-6">

                        <div class="mb-3">

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

                    <!-- RIGHT COLUMN -->
                    <div class="col-md-6 col-divider ps-md-4">

                        <div id="pnlRelativeDetailsWrapper"
                             runat="server"
                             style="display:none;">

                            <div class="form-label"
                                 style="font-size:16px;color:#2D398D;">
                                If Yes, please provide:
                            </div>

                            <asp:Panel
                                ID="pnlRelativeDetails"
                                runat="server"
                                CssClass="relative-details">

                                <!-- Name -->
                                <div class="mb-3">

                                    <label class="form-label">
                                        Name
                                    </label>

                                    <asp:TextBox
                                        ID="txtName"
                                        runat="server"
                                        CssClass="form-control"
                                        placeholder="Enter full name" />

                                    <asp:RequiredFieldValidator
                                        ID="rfvName"
                                        runat="server"
                                        ControlToValidate="txtName"
                                        ErrorMessage="Please enter the name."
                                        CssClass="text-danger"
                                        Display="Static"
                                        ValidationGroup="RelativeForm" />

                                </div>

                                <!-- Relationship -->
                                <div class="mb-3">

                                    <label class="form-label">
                                        Relationship
                                    </label>

                                    <asp:DropDownList
    ID="ddlRelationship"
    runat="server"
    CssClass="form-select">

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

                                <!-- Department -->
                                <div class="mb-3">

                                    <label class="form-label">
                                        Department / Campus
                                    </label>

                                    <asp:TextBox
                                        ID="txtDepartment"
                                        runat="server"
                                        CssClass="form-control"
                                        placeholder="Enter department/campus" />

                                    <asp:RequiredFieldValidator
                                        ID="rfvDepartment"
                                        runat="server"
                                        ControlToValidate="txtDepartment"
                                        ErrorMessage="Please enter department."
                                        CssClass="text-danger"
                                        Display="Static"
                                        ValidationGroup="RelativeForm" />

                                </div>

                                <!-- Designation -->
                                <div class="mb-3">

                                    <label class="form-label">
                                        Designation
                                    </label>

                                    <asp:TextBox
                                        ID="txtDesignation"
                                        runat="server"
                                        CssClass="form-control"
                                        placeholder="Enter designation" />

                                    <asp:RequiredFieldValidator
                                        ID="rfvDesignation"
                                        runat="server"
                                        ControlToValidate="txtDesignation"
                                        ErrorMessage="Please enter designation."
                                        CssClass="text-danger"
                                        Display="Static"
                                        ValidationGroup="RelativeForm" />

                                </div>

                            </asp:Panel>

                        </div>

                    </div>

                </div>

                <hr />

                <div class="text-end">

                    <asp:Button
                        ID="btnSubmit"
                        runat="server"
                        Text="Save and Continue"
                        CssClass="btn btn-bu-blue"
                        ValidationGroup="RelativeForm"
                        OnClick="BtnSubmit_Click" />

                </div>

                <asp:Label
                    ID="lblMessage"
                    runat="server"
                    CssClass="d-block mt-3">
                </asp:Label>

            </div>

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
            // Toggle server validators for RelativeForm so "No" can postback
            setValidatorsEnabled('RelativeForm', selected === 'Yes');
        }

        window.onload = function () {

            // Ensure validators are toggled even if the ASP.NET scripts load later
            function ensureToggle(attempt) {
                attempt = attempt || 0;
                toggleRelativeDetails();
                if (typeof(Page_Validators) === 'undefined' && attempt < 10) {
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
            if (typeof(Page_Validators) === 'undefined') return;
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
