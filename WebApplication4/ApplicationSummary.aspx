<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplicationSummary.aspx.cs" Inherits="WebApplication4.ApplicationSummary" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Application Summary</title>

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
            font-weight: 700;
        }

        .page-title h5 {
            color: #6c757d;
        }

        .page-title hr {
            border-top: 3px solid #1a3a7a;
            opacity: 0.2;
            width: 100%;
            margin-top: 5px;
        }

        .form-card {
            max-width: 1100px;
            margin: 30px auto 30px;
            background: white;
            padding: 0;
            border-radius: 16px;
            box-shadow: 0 8px 30px rgba(26, 58, 122, 0.10);
            overflow: hidden;
        }

        .card-header-blue {
            background: linear-gradient(135deg, #1a3a7a 0%, #2a5aaa 100%);
            color: white;
            padding: 18px 25px;
            border: none;
        }

        .card-header-blue h5 {
            margin: 0;
            font-weight: 600;
            font-size: 20px;
        }

        .card-header-blue i {
            margin-right: 10px;
        }

        .card-main {
            border-radius: 16px;
            border: none;
            box-shadow: 0 8px 30px rgba(26, 58, 122, 0.10);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .card-body {
            padding: 25px 30px;
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-label {
            font-size: 15px;
            font-weight: 600;
            color: #44496b;
            margin-bottom: 6px;
        }

        .form-control {
            font-size: 15px;
            height: 48px;
            border-radius: 8px;
            border: 1px solid #ced4da;
            padding: 10px 14px;
            transition: all .2s ease-in-out;
            background: #f8faff;
        }

        .form-control:focus {
            border-color: #1a3a7a;
            box-shadow: 0 0 0 .2rem rgba(26, 58, 122, 0.15);
        }

        .education-table th {
            background: #e8edf5;
            color: #1a3a7a;
            font-weight: 700;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: .5px;
            border-bottom: 2px solid #1a3a7a;
            text-align: center;
            vertical-align: middle;
        }

        .education-table td {
            vertical-align: middle;
            text-align: center;
            font-size: 15px;
            color: #44496b;
        }

        .education-table input {
            border: 1px solid #d0d7e6;
            border-radius: 6px;
            padding: 6px 10px;
            font-size: 14px;
            background: #f8faff;
        }

        /* Declaration - Separate Container */
        .declaration-container {
            max-width: 1100px;
            margin: 0 auto 60px;
            border: 2px solid #1a3a7a;
            border-radius: 12px;
            background: #ffffff;
            overflow: hidden;
            box-shadow: 0 8px 30px rgba(26, 58, 122, 0.10);
        }

        .declaration-header {
            background: linear-gradient(135deg, #1a3a7a 0%, #2a5aaa 100%);
            color: white;
            padding: 15px 25px;
        }

        .declaration-header h3 {
            margin: 0;
            font-weight: 700;
            font-size: 22px;
        }

        .declaration-header i {
            margin-right: 10px;
        }

        .declaration-body {
            padding: 25px 30px 10px 30px;
        }

        .declaration-body .form-check-label {
            font-size: 16px;
            line-height: 1.8;
            text-align: justify;
        }

        .form-check-input:checked {
            background-color: #1a3a7a;
            border-color: #1a3a7a;
        }

        .form-check-input:focus {
            border-color: #1a3a7a;
            box-shadow: 0 0 0 .2rem rgba(26, 58, 122, 0.15);
        }

        .info-buttons {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
            margin-top: 30px;
            margin-bottom: 30px;
        }

        .info-buttons .btn {
            min-width: 260px;
            height: 45px;
            font-weight: 600;
            border-radius: 8px;
            transition: all .2s ease-in-out;
            border: 2px solid #1a3a7a;
            color: #1a3a7a;
            background: transparent;
        }

        .info-buttons .btn:hover {
            background: #1a3a7a;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(26, 58, 122, 0.3);
            border-color: #1a3a7a;
        }

        .info-buttons .btn:focus {
            box-shadow: 0 0 0 .2rem rgba(26, 58, 122, 0.25);
            border-color: #1a3a7a;
        }

        .submit-btn {
            background: linear-gradient(135deg, #1a3a7a 0%, #2a5aaa 100%);
            color: white;
            border: none;
            padding: 12px 40px;
            border-radius: 8px;
            font-size: 17px;
            font-weight: 600;
            transition: all .2s ease-in-out;
            min-width: 120px;
        }

        .submit-btn:hover:not(:disabled) {
            background: #2a5aaa;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(26, 58, 122, 0.35);
        }

        .submit-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .radio-group {
            display: flex;
            align-items: center;
            gap: 30px;
            margin-top: 8px;
        }

        .radio-group input[type="radio"] {
            width: 18px;
            height: 18px;
            margin-right: 8px;
            cursor: pointer;
            accent-color: #1a3a7a;
            position: relative;
            top: 4px;  
        }

        .radio-group label {
            margin-bottom: 0;
            cursor: pointer;
            font-weight: 500;
            color: #44496b;
        }

        .text-danger {
            font-size: 13px;
        }

        @media(max-width:768px) {
            body {
                font-size: 15px;
            }

            .form-card {
                padding: 0;
                margin: 30px 15px;
            }

            .card-body {
                padding: 15px;
            }

            .form-label {
                font-size: 14px;
            }

            .form-control {
                font-size: 14px;
                height: 44px;
            }

            .info-buttons .btn {
                min-width: 100%;
            }

            .declaration-container {
                margin: 0 15px 30px;
            }

            .declaration-body {
                padding: 15px 15px 5px 15px;
            }
        }
    </style>
</head>
<body>

    <form id="form1" runat="server">

        <div class="container py-4">

            <div class="text-left mb-4 page-title">
                <h4><i class="bi bi-file-text-fill me-2"></i>Application Summary</h4>
                <h5 class="text-secondary fw-normal">Bahria University HR Portal</h5>
                <hr />
            </div>

            <!-- Main Form Card -->
            <div class="form-card">

                <!-- Personal Information -->
                <div class="card-main">
                    <div class="card-header-blue">
                        <h5><i class="bi bi-person-badge-fill"></i> Personal Information</h5>
                    </div>

                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4 form-group">
                                <label class="form-label">Full Name</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>

                            <div class="col-md-4 form-group">
                                <label class="form-label">CNIC</label>
                                <asp:TextBox ID="txtIdentity" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>

                            <div class="col-md-4 form-group">
                                <label class="form-label">Date of Birth</label>
                                <asp:TextBox ID="txtBirthDate" runat="server" TextMode="Date" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4 form-group">
                                <label class="form-label">Nationality</label>
                                <asp:TextBox ID="txtNationality" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>

                            <div class="col-md-4 form-group">
                                <label class="form-label">Mobile Number</label>
                                <asp:TextBox ID="txtCell" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>

                            <div class="col-md-4 form-group">
                                <label class="form-label">Gender</label>
                                <div class="radio-group">
                                    <asp:RadioButton ID="rbMale" runat="server" GroupName="Gender" Text="Male" Enabled="false" />
                                    <asp:RadioButton ID="rbFemale" runat="server" GroupName="Gender" Text="Female" Enabled="false" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Educational Information -->
                <div class="card-main">
                    <div class="card-header-blue">
                        <h5><i class="bi bi-mortarboard-fill"></i> Educational Information</h5>
                    </div>

                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped align-middle education-table">
                                <thead>
                                    <tr>
                                        <th>Qualification</th>
                                        <th>Major</th>
                                        <th>Board / University</th>
                                        <th>Passing Year</th>
                                        <th>Result (%)</th>
                                        <th>GPA / Grade / Division</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>SSC/Matric/Equivalent*</td>
                                        <td><input type="text" id="ssc_subject" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="text" id="ssc_board" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="number" id="ssc_year" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="number" id="ssc_result" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="text" id="ssc_grade" runat="server" class="form-control" readonly="readonly" /></td>
                                    </tr>

                                    <tr>
                                        <td>HSSC/Intermediate*</td>
                                        <td><input type="text" id="hssc_subject" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="text" id="hssc_board" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="number" id="hssc_year" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="number" id="hssc_result" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="text" id="hssc_grade" runat="server" class="form-control" readonly="readonly" /></td>
                                    </tr>

                                    <tr>
                                        <td>BS Degree*</td>
                                        <td><input type="text" id="bs_subject" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="text" id="bs_board" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="number" id="bs_year" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="number" id="bs_result" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="text" id="bs_grade" runat="server" class="form-control" readonly="readonly" /></td>
                                    </tr>

                                    <tr>
                                        <td>MS/MPhil Degree (if applicable)</td>
                                        <td><input type="text" id="ms_subject" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="text" id="ms_board" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="number" id="ms_year" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="number" id="ms_result" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="text" id="ms_grade" runat="server" class="form-control" readonly="readonly" /></td>
                                    </tr>

                                    <tr>
                                        <td>PhD (if applicable)</td>
                                        <td><input type="text" id="phd_subject" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="text" id="phd_board" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="number" id="phd_year" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="text" id="phd_result" runat="server" class="form-control" readonly="readonly" /></td>
                                        <td><input type="text" id="phd_grade" runat="server" class="form-control" readonly="readonly" /></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Work Experience -->
                <div class="card-main">
                    <div class="card-header-blue">
                        <h5><i class="bi bi-briefcase-fill"></i> Work Experience</h5>
                    </div>

                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 form-group">
                                <label for="txtHIndex" class="form-label">H-Index</label>
                                <asp:TextBox ID="txtHIndex" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>

                            <div class="col-md-6 form-group">
                                <label for="txtExperienceBeforePhD" class="form-label">Years of Work Experience Before PhD</label>
                                <asp:TextBox ID="txtExperienceBeforePhD" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>

                            <div class="col-md-6 form-group">
                                <label for="txtExperienceAfterPhD" class="form-label">Years of Work Experience After PhD</label>
                                <asp:TextBox ID="txtExperienceAfterPhD" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>

                            <div class="col-md-6 form-group">
                                <label for="txtMSStudents" class="form-label">Have you supervised MS students?</label>
                                <asp:TextBox ID="txtMSStudents" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>

                            <div class="col-md-6 form-group">
                                <label for="txtPhDStudents" class="form-label">Have you supervised PhD students?</label>
                                <asp:TextBox ID="txtPhDStudents" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Information Navigation Buttons -->
                <div class="text-center">
                    <div class="info-buttons">
                        <asp:Button ID="btnPersonalInfo" runat="server" Text="Enter/Edit Personal Information" CssClass="btn" OnClick="BtnPersonalInfo_Click" />
                        <asp:Button ID="btnEducationalInfo" runat="server" Text="Enter/Edit Educational Information" CssClass="btn" OnClick="BtnEducationalInfo_Click" />
                        <asp:Button ID="btnExperienceInfo" runat="server" Text="Enter/Edit Research and Work Experience" CssClass="btn" OnClick="BtnExperienceInfo_Click" />
                    </div>
                </div>

            </div>
            <!-- End Main Form Card -->

            <!-- Declaration - Separate Container -->
            <div class="declaration-container">
                <div class="declaration-header">
                    <h3><i class="bi bi-clipboard-check-fill"></i>Declaration</h3>
                </div>
                <div class="declaration-body">
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" id="agreeDeclaration" />
                        <label class="form-check-label" for="agreeDeclaration">
                            <strong>I certify that the information given in this application form for admission is complete and accurate to the best of my knowledge.</strong>
                        </label>
                    </div>

                    <div class="text-center mt-4">
                        <button id="submitBtn" class="submit-btn" disabled="disabled">
                            <i class="bi bi-check-circle me-2"></i>Submit
                        </button>
                    </div>
                </div>
            </div>

            <div class="mt-3 text-center">
                <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>
            </div>

        </div>

    </form>

    <script>
        const checkbox = document.getElementById('agreeDeclaration');
        const submitBtn = document.getElementById('submitBtn');

        checkbox.addEventListener('change', function () {
            submitBtn.disabled = !this.checked;
        });

        submitBtn.addEventListener('click', function () {
            if (checkbox.checked) {
                alert("Declaration accepted. Form submitted.");
                // document.getElementById("yourForm").submit();
            }
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>