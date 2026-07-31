<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PreviousEmployDeclaration.aspx.cs" Inherits="WebApplication4.PreviousEmployment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Previous Employment at Bahria University</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />

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

                <div class="section-title"><i class="bi bi-briefcase-fill"></i>Previous Employment at Bahria University</div>

                <!-- ============ LEFT / RIGHT TWO COLUMN LAYOUT ============ -->
                <div class="row">

                    <!-- LEFT COLUMN -->
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">
                                Have you previously worked at Bahria University?
                                <span class="required-asterisk">*</span>
                            </label>

                            <div class="radio-group">
                               <asp:RadioButtonList 
                                ID="rblPreviouslyWorked" 
                                runat="server"
                                RepeatDirection="Horizontal"
                                RepeatLayout="Flow"
                                AutoPostBack="false">

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

                    <!-- RIGHT COLUMN -->
                    <div class="col-md-6 col-divider ps-md-4">
                        <div id="pnlPreviousEmploymentWrapper" runat="server">
                            <div class="form-label" style="font-size:16px;color:#2D398D;">If Yes, please provide:</div>

                            <asp:Panel ID="pnlPreviousEmploymentDetails" runat="server" CssClass="relative-details">

                                <div class="mb-3">
                                    <label for="<%= ddlCampus.ClientID %>" class="form-label">
                                    Campus
                                    </label>
                                     <asp:DropDownList
                                    ID="ddlCampus"
                                    runat="server"
                                    CssClass="form-select">

                                    <asp:ListItem Text="-- Select Campus --" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Islamabad" Value="Islamabad"></asp:ListItem>
                                    <asp:ListItem Text="Lahore" Value="Lahore"></asp:ListItem>
                                    <asp:ListItem Text="Karachi" Value="Karachi"></asp:ListItem>

                                    </asp:DropDownList>

                                <asp:RequiredFieldValidator
                                ID="rfvCampus"
                                runat="server"
                                ControlToValidate="ddlCampus"
                                InitialValue=""
                                ErrorMessage="Please select a campus."
                                CssClass="text-danger"
                                Display="Static"
                                ValidationGroup="DeclarationForm">
                                </asp:RequiredFieldValidator>
                                </div>

                                <div class="mb-3">
    <label for="<%= txtDepartment.ClientID %>" class="form-label">
        Department
    </label>

    <asp:TextBox
        ID="txtDepartment"
        runat="server"
        CssClass="form-control"
        placeholder="Enter department" />

                <asp:RequiredFieldValidator
                ID="rfvDepartment"
                runat="server"
                ControlToValidate="txtDepartment"
                ErrorMessage="Please enter the department."
                CssClass="text-danger d-block mt-1"
                Display="Static"
                ValidationGroup="DeclarationForm">
                </asp:RequiredFieldValidator>
                </div>

                               <div class="mb-3">
    <label for="<%= txtDesignation.ClientID %>" class="form-label">
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
        ErrorMessage="Please enter the designation."
        CssClass="text-danger d-block mt-1"
        Display="Static"
        ValidationGroup="DeclarationForm">
    </asp:RequiredFieldValidator>
</div>

                                <div class="mb-3">
    <label for="<%= txtDuration.ClientID %>" class="form-label">
        Duration
    </label>

    <asp:TextBox
        ID="txtDuration"
        runat="server"
        CssClass="form-control"
        placeholder="e.g. Jan 2021 - Dec 2023" />

    <asp:RequiredFieldValidator
        ID="rfvDuration"
        runat="server"
        ControlToValidate="txtDuration"
        ErrorMessage="Please enter the duration."
        CssClass="text-danger d-block mt-1"
        Display="Static"
        ValidationGroup="DeclarationForm">
    </asp:RequiredFieldValidator>
</div>

                            </asp:Panel>
                        </div>
                    </div>

                </div>
                <!-- ============ END TWO COLUMN LAYOUT ============ -->

                <hr class="mt-2 mb-3" />

                <div class="d-flex justify-content-end gap-2">
                     <asp:Button ID="btnSubmit" runat="server" Text="Save and Continue" CssClass="btn btn-bu-blue" ValidationGroup="DeclarationForm" OnClick="BtnSubmit_Click" />
                </div>

                <asp:Label ID="lblMessage" runat="server" CssClass="d-block mt-3"></asp:Label>

            </div>

        </div>

    </form>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

 <script>
     (function () {
         function togglePreviousEmploymentDetails() {
             var wrapper = document.getElementById('<%= pnlPreviousEmploymentWrapper.ClientID %>');
            if (!wrapper) {
                console.error("pnlPreviousEmploymentWrapper not found in DOM");
                return;
            }

            var checkedRadio = document.querySelector(
                "input[name='<%= rblPreviouslyWorked.UniqueID %>']:checked"
            );

            var selectedValue = checkedRadio ? checkedRadio.value : "";
            console.log("Selected value:", selectedValue);

            wrapper.style.display = (selectedValue === "Yes") ? "block" : "none";
        }

        document.addEventListener("DOMContentLoaded", function () {
            // Use a resilient initializer in case ASP.NET validation scripts
            // haven't finished loading yet.
            function ensureToggle(attempt) {
                attempt = attempt || 0;
                togglePreviousEmploymentDetails();
                if (typeof(Page_Validators) === 'undefined' && attempt < 10) {
                    setTimeout(function () { ensureToggle(attempt + 1); }, 100);
                }
            }

            ensureToggle(0);

            // Delegate from the form so this keeps working even if the
            // radio inputs are re-rendered (e.g. inside an UpdatePanel)
            document.getElementById("form1").addEventListener("click", function (e) {
                if (e.target && e.target.matches("input[type='radio'][name='<%= rblPreviouslyWorked.UniqueID %>']")) {
                    togglePreviousEmploymentDetails();
                }
            });
        });

         // expose globally in case you want to call it inline elsewhere
         window.togglePreviousEmploymentDetails = togglePreviousEmploymentDetails;

        // Enable/disable validators for DeclarationForm so selecting No will allow postback
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

        // Keep validator state in sync when toggling
        (function () {
            var original = togglePreviousEmploymentDetails;
            togglePreviousEmploymentDetails = function () {
                original();
                var checked = document.querySelector("input[name='<%= rblPreviouslyWorked.UniqueID %>']:checked");
                var value = checked ? checked.value : '';
                setValidatorsEnabled('DeclarationForm', value === 'Yes');
            };
        })();
     })();
 </script>
</body>


</html>
