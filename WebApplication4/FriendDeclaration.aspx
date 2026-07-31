<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FriendDeclaration.aspx.cs" Inherits="WebApplication4.FriendDeclaration" %>

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

        <div class="section-title"><i class="bi bi-person-hearts"></i>Friend / Close Acquaintance Declaration</div>

        <!-- ============ LEFT / RIGHT TWO COLUMN LAYOUT ============ -->
        <div class="row">

            <!-- LEFT COLUMN -->
            <div class="col-md-6">
                <div class="mb-3">
                    <label class="form-label">
                        Do you have any friend or close acquaintance currently working at Bahria University?
                        <span class="required-asterisk">*</span>
                    </label>

                    <div class="radio-group">
                        <asp:RadioButtonList ID="rblHasFriend" runat="server"
                            RepeatDirection="Horizontal"
                            RepeatLayout="Flow"
                            AutoPostBack="false"
                            onclick="toggleFriendDetails();">
                            <asp:ListItem Text="Yes" Value="Yes" />
                            <asp:ListItem Text="No" Value="No" />
                        </asp:RadioButtonList>
                    </div>

                    <asp:RequiredFieldValidator ID="rfvHasFriend" runat="server"
                        ControlToValidate="rblHasFriend"
                        ErrorMessage="Please select Yes or No."
                        CssClass="text-danger d-block mt-1"
                        Display="Static"
                        ValidationGroup="DeclarationForm" />
                </div>
            </div>

            <!-- RIGHT COLUMN -->
            <div class="col-md-6 col-divider ps-md-4">
                <div id="pnlFriendDetailsWrapper" runat="server" visible="true">
                    <div class="section-subtitle">If Yes, please provide:</div>

                    <asp:Panel ID="pnlFriendDetails" runat="server" CssClass="relative-details">

                        <!-- Name -->
                        <div class="mb-3">
                            <label for="<%= txtName.ClientID %>" class="form-label">
                                Name
                                <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter full name" />
                    <asp:RequiredFieldValidator ID="rfvName" runat="server"
             ControlToValidate="txtName"
            ErrorMessage="Name is required."
            CssClass="text-danger d-block mt-1"
            Display="Static"
            ValidationGroup="DeclarationForm" />
                            <!-- Nature of Relationship -->
                    <div class="mb-3">
                    <label for="<%= ddlRelationship.ClientID %>" class="form-label">
                    Nature of Relationship
                    <span class="required-asterisk">*</span>
                    </label>
                    <asp:DropDownList ID="ddlRelationship" runat="server" CssClass="form-select">
                    <asp:ListItem Text="--Select--" Value="" />
                    <asp:ListItem Text="Friend" Value="Friend" />
                    <asp:ListItem Text="Close Acquaintance" Value="Close Acquaintance" />
                    <asp:ListItem Text="Former Colleague" Value="Former Colleague" />
                    <asp:ListItem Text="Classmate" Value="Classmate" />
                    <asp:ListItem Text="Other" Value="Other" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvRelationship" runat="server"
                    ControlToValidate="ddlRelationship"
                    InitialValue=""
                    ErrorMessage="Please select the nature of relationship."
                    CssClass="text-danger d-block mt-1"
                    Display="Static"
                    ValidationGroup="DeclarationForm" />
                    </div>        
                    
                        </div>

                        <!-- Department -->
                        <div class="mb-3">
                            <label for="<%= txtDepartment.ClientID %>" class="form-label">
                                Department
                                <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-control" placeholder="Enter department" />
                            <asp:RequiredFieldValidator ID="rfvDepartment" runat="server"
                                ControlToValidate="txtDepartment"
                                ErrorMessage="Department is required."
                                CssClass="text-danger d-block mt-1"
                                Display="Static"
                                ValidationGroup="DeclarationForm" />
                        </div>

                        <!-- Designation -->
                        <div class="mb-3">
                            <label for="<%= txtDesignation.ClientID %>" class="form-label">
                                Designation
                                <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtDesignation" runat="server" CssClass="form-control" placeholder="Enter designation" />
                            <asp:RequiredFieldValidator ID="rfvDesignation" runat="server"
                                ControlToValidate="txtDesignation"
                                ErrorMessage="Designation is required."
                                CssClass="text-danger d-block mt-1"
                                Display="Static"
                                ValidationGroup="DeclarationForm" />
                        </div>

                        

                    </asp:Panel>
                </div>
            </div>

        </div>
        <!-- ============ END TWO COLUMN LAYOUT ============ -->

        <hr class="mt-2 mb-3" />

        <div class="text-end">
            <asp:Button ID="btnSubmit" runat="server" Text="Save and Continue" CssClass="btn btn-bu-blue" ValidationGroup="DeclarationForm" OnClick="BtnSubmit_Click" />
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="d-block mt-3"></asp:Label>

    </div>

</div>

</form>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Show/hide the right-hand "If Yes" detail fields based on the radio selection
        function toggleFriendDetails() {
            var radios = document.getElementsByName('<%= rblHasFriend.UniqueID %>');
            var wrapper = document.getElementById('<%= pnlFriendDetailsWrapper.ClientID %>');
            var selectedValue = "";

            for (var i = 0; i < radios.length; i++) {
                if (radios[i].checked) {
                    selectedValue = radios[i].value;
                }
            }

            wrapper.style.display = (selectedValue === "Yes") ? "block" : "none";
            // Enable/disable validators in the DeclarationForm group depending on selection
            setValidatorsEnabled('DeclarationForm', selectedValue === 'Yes');
        }

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

        // Run once on page load to set the correct initial state.
        // Use both DOMContentLoaded and window.onload and retry in case Page_Validators
        // hasn't been initialized yet by ASP.NET validation scripts.
        function ensureToggleFriendDetails(attempt) {
            attempt = attempt || 0;
            toggleFriendDetails();
            // If validators are not yet available, retry a few times
            if (typeof(Page_Validators) === 'undefined' && attempt < 10) {
                setTimeout(function () { ensureToggleFriendDetails(attempt + 1); }, 100);
            }
        }

        document.addEventListener('DOMContentLoaded', function () {
            ensureToggleFriendDetails(0);
        });

        // Also run on full load as a fallback
        window.addEventListener('load', function () {
            ensureToggleFriendDetails(0);
        });
    </script>
</body>

</html>
