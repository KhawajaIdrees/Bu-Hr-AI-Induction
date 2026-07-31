<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Personal.aspx.cs" Inherits="WebApplication4.RegisterUser" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Personal Data Form</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        body {
            background: #f0f4f8;
            font-family: 'Segoe UI', Arial, sans-serif;
            font-size: 17px;
        }

        .page-title h4 {
            color: #1a3a7a;
        }

        .page-title hr {
            border-top: 3px solid #1a3a7a;
            opacity: 0.2;
            margin: .75rem 0 0;
        }

        .form-card {
            max-width: 1100px;
            margin: 30px auto 60px;
            background: white;
            padding: 0;
            border-radius: 16px;
            box-shadow: 0 8px 30px rgba(26, 58, 122, 0.10);
            overflow: hidden;
        }

        .form-section {
            padding: 36px 45px;
            border-bottom: 1px solid #eef1f8;
        }

        .form-section:last-of-type {
            border-bottom: none;
        }

        .section-title {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #1a3a7a;
            font-size: 19px;
            font-weight: 700;
            margin-bottom: 24px;
            text-transform: uppercase;
            letter-spacing: .4px;
        }

        .section-title i {
            font-size: 20px;
        }

        .form-label {
            font-size: 15px;
            font-weight: 600;
            color: #44496b;
            margin-bottom: 6px;
        }

        .required-asterisk {
            color: #dc3545;
            font-size: 15px;
        }

        .form-control,
        .form-select {
            font-size: 15px;
            height: 48px;
            border-radius: 8px;
            border: 1px solid #ced4da;
            padding: 10px 14px;
            transition: all .2s ease-in-out;
        }

        .form-control::placeholder {
            font-size: 14px;
            color: #a3a9bd;
        }

        .form-control:focus,
        .form-select:focus {
            border-color: #1a3a7a;
            box-shadow: 0 0 0 .2rem rgba(26, 58, 122, 0.15);
        }

        textarea.form-control {
            min-height: 100px;
            height: auto;
            resize: vertical;
        }

        .form-group {
            margin-bottom: 24px;
        }

        .btn-save {
            background: #1a3a7a;
            color: white;
            border-radius: 8px;
            padding: 14px 55px;
            font-size: 17px;
            font-weight: 600;
            border: none;
            transition: all .2s ease-in-out;
        }

        .btn-save:hover {
            background: #2a5aaa;
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(26, 58, 122, 0.35);
        }

        .text-danger {
            font-size: 13px;
        }

        .picture-upload-box {
            display: flex;
            align-items: center;
            gap: 20px;
            background: #f8faff;
            border: 1px dashed #cddcff;
            border-radius: 12px;
            padding: 18px 20px;
        }

        .picture-preview {
            width: 90px;
            height: 90px;
            object-fit: cover;
            border-radius: 10px;
            border: 2px solid #cddcff;
            background: #ffffff;
            flex-shrink: 0;
        }

        .picture-placeholder {
            width: 90px;
            height: 90px;
            border-radius: 10px;
            border: 2px dashed #cddcff;
            background: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #a3b3e0;
            font-size: 28px;
            flex-shrink: 0;
        }

        @media(max-width:768px) {
            body {
                font-size: 15px;
            }

            .form-section {
                padding: 24px 22px;
            }

            .form-label {
                font-size: 14px;
            }

            .form-control,
            .form-select {
                font-size: 14px;
                height: 44px;
            }
        }

        .radio-group {
            display: flex;
            align-items: center;
        }

        .radio-group span {
            display: inline-flex;
            align-items: center;
        }

        .radio-group span:not(:last-child) {
            margin-right: 40px;
        }

        .radio-group input[type="radio"] {
            margin-right: 8px;
            width: 18px;
            height: 18px;
            cursor: pointer;
            accent-color: #1a3a7a;
        }

        .radio-group label {
            margin-bottom: 0;
            margin-right: 30px;
            cursor: pointer;
            font-weight: 500;
            color: #44496b;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <div class="container">

            <div class="text-left mb-3 mt-4 page-title">
                <h4 class="fw-bold">Personal Information</h4>
                <h5 class="text-secondary fw-normal">Bahria University HR Portal</h5>
                <hr />
            </div>

            <div class="form-card">

                <!-- SECTION: Photo -->
                <div class="form-section">
                    <div class="section-title"><i class="bi bi-person-badge-fill"></i>Profile Picture</div>

                    <div class="form-group mb-0">
                        <label class="form-label">
                            Upload Picture <span class="required-asterisk">*</span>
                        </label>
                        <div class="picture-upload-box flex-wrap">
                            <img id="imgPicturePreview"
                                runat="server"
                                src="#"
                                alt="Picture preview"
                                class="picture-preview"
                                style="display:none;" />
                            <div id="picturePlaceholder"
                                runat="server"
                                class="picture-placeholder">
                                <i class="bi bi-camera-fill"></i>
                            </div>
                            <asp:FileUpload ID="fuPicture" runat="server" CssClass="form-control" style="max-width:350px;" onchange="previewPicture(this);" />
                            <asp:Label ID="picMsg" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                </div>

                <!-- SECTION: Identity -->
                <div class="form-section">
                    <div class="section-title"><i class="bi bi-person-vcard-fill"></i>Identity Details</div>

                    <div class="row">
                        <div class="col-md-4 form-group">
                            <label for="<%= txtFirstName.ClientID %>" class="form-label">
                                First Name <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" placeholder="Enter First Name" />
                            <asp:RequiredFieldValidator ID="rfvFirstName" runat="server"
                                ControlToValidate="txtFirstName"
                                ErrorMessage="First name is required."
                                CssClass="text-danger d-block mt-1"
                                Display="Static"
                                ValidationGroup="PersonalForm" />
                        </div>
                        <div class="col-md-4 form-group">
                            <label for="<%= txtMiddleName.ClientID %>" class="form-label">
                                Middle Name
                            </label>
                            <asp:TextBox ID="txtMiddleName" runat="server" CssClass="form-control" placeholder="Enter Middle Name" />
                        </div>
                        <div class="col-md-4 form-group">
                            <label for="<%= txtLastName.ClientID %>" class="form-label">
                                Last Name <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" placeholder="Enter Last Name" />
                            <asp:RequiredFieldValidator ID="rfvLastName" runat="server"
                                ControlToValidate="txtLastName"
                                ErrorMessage="Last name is required."
                                CssClass="text-danger d-block mt-1"
                                Display="Static"
                                ValidationGroup="PersonalForm" />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4 form-group">
                            <label for="<%= txtFatherName.ClientID %>" class="form-label">
                                Father's Name <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtFatherName" runat="server" CssClass="form-control" placeholder="Enter Father's Name" />
                            <asp:RequiredFieldValidator ID="rfvFatherName" runat="server"
                                ControlToValidate="txtFatherName"
                                ErrorMessage="Father's name is required."
                                CssClass="text-danger d-block mt-1"
                                Display="Static"
                                ValidationGroup="PersonalForm" />
                        </div>
                        <div class="col-md-4 form-group">
                            <label for="<%= txtCnic.ClientID %>" class="form-label">
                                CNIC Number <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtCnic" runat="server" CssClass="form-control" placeholder="CNIC / Passport Number" />
                            <asp:RequiredFieldValidator ID="rfvCnic" runat="server"
                                ControlToValidate="txtCnic"
                                ErrorMessage="CNIC number is required."
                                CssClass="text-danger d-block mt-1"
                                Display="Static"
                                ValidationGroup="PersonalForm" />
                        </div>
                        <div class="col-md-4 form-group">
                            <label for="<%= ddlGender.ClientID %>" class="form-label">
                                Gender <span class="required-asterisk">*</span>
                            </label>
                            <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-select">
                                <asp:ListItem Text="-- Select Gender --" Value="" />
                                <asp:ListItem Text="Male" Value="Male" />
                                <asp:ListItem Text="Female" Value="Female" />
                                <asp:ListItem Text="Other" Value="Other" />
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvGender" runat="server"
                                ControlToValidate="ddlGender"
                                InitialValue=""
                                ErrorMessage="Please select a gender."
                                CssClass="text-danger d-block mt-1"
                                Display="Static"
                                ValidationGroup="PersonalForm" />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4 form-group">
                            <label for="<%= txtCellNumber.ClientID %>" class="form-label">
                                Cell Number <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtCellNumber" runat="server" CssClass="form-control" placeholder="e.g. 03001234567" />
                            <asp:RequiredFieldValidator ID="rfvCellNumber" runat="server"
                                ControlToValidate="txtCellNumber"
                                ErrorMessage="Cell number is required."
                                CssClass="text-danger d-block mt-1"
                                Display="Static"
                                ValidationGroup="PersonalForm" />
                        </div>
                        <div class="col-md-4 form-group">
                            <label for="<%= txtBirthDate.ClientID %>" class="form-label">
                                Birth Date <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtBirthDate" runat="server" CssClass="form-control" TextMode="Date" />
                            <asp:RequiredFieldValidator ID="rfvBirthDate" runat="server"
                                ControlToValidate="txtBirthDate"
                                ErrorMessage="Birth date is required."
                                CssClass="text-danger d-block mt-1"
                                Display="Static"
                                ValidationGroup="PersonalForm" />
                        </div>
                        <div class="col-md-4 form-group">
                            <label for="<%= ddlMaritalStatus.ClientID %>" class="form-label">
                                Marital Status <span class="required-asterisk">*</span>
                            </label>
                            <asp:DropDownList ID="ddlMaritalStatus" runat="server" CssClass="form-select">
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
                                CssClass="text-danger d-block mt-1"
                                Display="Static"
                                ValidationGroup="PersonalForm" />
                        </div>
                    </div>
                </div>

                <!-- SECTION: Background -->
                <div class="form-section">
                    <div class="section-title"><i class="bi bi-globe-asia-australia"></i>Background</div>

                    <div class="row">
                        <div class="col-md-4 form-group">
                            <label for="<%= txtNationality.ClientID %>" class="form-label">
                                Nationality <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtNationality" runat="server" CssClass="form-control" placeholder="Enter Nationality" />
                            <asp:RequiredFieldValidator ID="rfvNationality" runat="server"
                                ControlToValidate="txtNationality"
                                ErrorMessage="Nationality is required."
                                CssClass="text-danger d-block mt-1"
                                Display="Static"
                                ValidationGroup="PersonalForm" />
                        </div>
                        <div class="col-md-4 form-group">
                            <label for="<%= txtReligion.ClientID %>" class="form-label">
                                Religion <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtReligion" runat="server" CssClass="form-control" placeholder="Enter Religion" />
                            <asp:RequiredFieldValidator ID="rfvReligion" runat="server"
                                ControlToValidate="txtReligion"
                                ErrorMessage="Religion is required."
                                CssClass="text-danger d-block mt-1"
                                Display="Static"
                                ValidationGroup="PersonalForm" />
                        </div>
                        <div class="col-md-4 form-group">
                            <label for="<%= txtSect.ClientID %>" class="form-label">
                                Sect <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtSect" runat="server" CssClass="form-control" placeholder="Enter Sect" />
                            <asp:RequiredFieldValidator ID="rfvSect" runat="server"
                                ControlToValidate="txtSect"
                                ErrorMessage="Sect is required."
                                CssClass="text-danger d-block mt-1"
                                Display="Static"
                                ValidationGroup="PersonalForm" />
                        </div>
                    </div>
                </div>

                <!-- SECTION: Address -->
                <div class="form-section">
                    <div class="section-title"><i class="bi bi-geo-alt-fill"></i>Address</div>

                    <div class="row">
                        <div class="col-md-4 form-group">
                            <label for="<%= txtCountry.ClientID %>" class="form-label">
                                Country <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtCountry" runat="server" CssClass="form-control" placeholder="Enter Country" />
                            <asp:RequiredFieldValidator ID="rfvCountry" runat="server"
                                ControlToValidate="txtCountry"
                                ErrorMessage="Country is required."
                                CssClass="text-danger d-block mt-1"
                                Display="Static"
                                ValidationGroup="PersonalForm" />
                        </div>
                        <div class="col-md-4 form-group">
                            <label for="<%= txtStateProvince.ClientID %>" class="form-label">
                                State/Province <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtStateProvince" runat="server" CssClass="form-control" placeholder="Enter State/Province" />
                            <asp:RequiredFieldValidator ID="rfvStateProvince" runat="server"
                                ControlToValidate="txtStateProvince"
                                ErrorMessage="State/Province is required."
                                CssClass="text-danger d-block mt-1"
                                Display="Static"
                                ValidationGroup="PersonalForm" />
                        </div>
                        <div class="col-md-4 form-group">
                            <label for="<%= txtCity.ClientID %>" class="form-label">
                                City <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="Enter City" />
                            <asp:RequiredFieldValidator ID="rfvCity" runat="server"
                                ControlToValidate="txtCity"
                                ErrorMessage="City is required."
                                CssClass="text-danger d-block mt-1"
                                Display="Static"
                                ValidationGroup="PersonalForm" />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label for="<%= txtCurrentAddress.ClientID %>" class="form-label">
                                Current Address <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtCurrentAddress" runat="server" CssClass="form-control" TextMode="MultiLine" placeholder="Enter your current address" />
                            <asp:RequiredFieldValidator ID="rfvCurrentAddress" runat="server"
                                ControlToValidate="txtCurrentAddress"
                                ErrorMessage="Current address is required."
                                CssClass="text-danger d-block mt-1"
                                Display="Static"
                                ValidationGroup="PersonalForm" />
                        </div>
                        <div class="col-md-6 form-group">
                            <label for="<%= txtPermanentAddress.ClientID %>" class="form-label">
                                Permanent Address <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtPermanentAddress" runat="server" CssClass="form-control" TextMode="MultiLine" placeholder="Enter your permanent address" />
                            <asp:RequiredFieldValidator ID="rfvPermanentAddress" runat="server"
                                ControlToValidate="txtPermanentAddress"
                                ErrorMessage="Permanent address is required."
                                CssClass="text-danger d-block mt-1"
                                Display="Static"
                                ValidationGroup="PersonalForm" />
                        </div>
                    </div>
                </div>

                <!-- SECTION: Declaration -->
                <div class="form-section">
                    <div class="section-title"><i class="bi bi-clipboard-check-fill"></i>Declaration</div>

                    <div class="form-group mb-0">
                        <label class="form-label">
                            Have you previously applied to Bahria University? <span class="required-asterisk">*</span>
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
                            CssClass="text-danger d-block mt-1"
                            Display="Static"
                            ValidationGroup="DeclarationForm" />
                    </div>
                </div>

                <!-- SECTION: Submit -->
                <div class="form-section text-center">
                    <asp:Button ID="BtnSaveContinue" runat="server" Text="Save and Continue" CssClass="btn btn-save" ValidationGroup="PersonalForm" OnClick="BtnRegister_Click" />
                    <asp:Label ID="lblMessage" runat="server" CssClass="d-block mt-3"></asp:Label>
                </div>

            </div>

        </div>

    </form>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function previewPicture(input) {
            var preview = document.getElementById('imgPicturePreview');
            var placeholder = document.getElementById('picturePlaceholder');

            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    preview.src = e.target.result;
                    preview.style.display = 'inline-block';
                    placeholder.style.display = 'none';
                };
                reader.readAsDataURL(input.files[0]);
            } else {
                preview.src = '#';
                preview.style.display = 'none';
                placeholder.style.display = 'flex';
            }
        }
    </script>
</body>
</html>