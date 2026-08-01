<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplicationSummary.aspx.cs" Inherits="WebApplication4.ApplicationSummary" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Application Summary</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .declaration-box {
            border: 1px solid #ddd;
            padding: 20px;
            background: #fff;
        }

        .declaration-title {
            font-size: 32px;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 15px;
        }

        .form-check-label {
            font-size: 16px;
            line-height: 1.8;
            text-align: justify;
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
        }

        .submit-btn {
            min-width: 120px;
        }
    </style>
</head>
<body>

    <form id="form1" runat="server">

        <div class="container mt-5">
            <div class="card-body">

                <div class="container mt-4">

                    <h2 class="text-center text-primary mb-4">
                        Employment Application Form
                    </h2>

                    <!-- Personal Information -->
                    <div class="card mb-4">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0">Personal Information</h5>
                        </div>

                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <label class="form-label">Full Name</label>
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                </div>

                                <div class="col-md-4">
                                    <label class="form-label">CNIC</label>
                                    <asp:TextBox ID="txtIdentity" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                </div>

                                <div class="col-md-4">
                                    <label class="form-label">Date of Birth</label>
                                    <asp:TextBox ID="txtBirthDate" runat="server" TextMode="Date" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>

                            <div class="row mt-3">
                                <div class="col-md-4">
                                    <label class="form-label">Nationality</label>
                                    <asp:TextBox ID="txtNationality" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                </div>

                                <div class="col-md-4">
                                    <label class="form-label">Mobile Number</label>
                                    <asp:TextBox ID="txtCell" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                </div>

                                <div class="col-md-4">
                                    <label class="form-label">Gender</label><br />
                                    <asp:RadioButton ID="rbMale" runat="server" GroupName="Gender" Text="Male" Enabled="false" />
                                    &nbsp;&nbsp;
                                    <asp:RadioButton ID="rbFemale" runat="server" GroupName="Gender" Text="Female" Enabled="false" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Educational Information -->
                    <div class="card mb-4">
                        <div class="card-header bg-success text-white">
                            <h5 class="mb-0">Educational Information</h5>
                        </div>

                        <div class="card-body">
                            <div class="row">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-striped align-middle education-table">
                                        <thead class="table-dark">
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
                    </div>

                    <!-- Work Experience -->
                    <div class="card mb-4">
                        <div class="card-header bg-warning">
                            <h5 class="mb-0">Work Experience</h5>
                        </div>

                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="txtHIndex" class="form-label">H-Index</label>
                                    <asp:TextBox ID="txtHIndex" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label for="txtExperienceBeforePhD" class="form-label">Years of Work Experience Before PhD</label>
                                    <asp:TextBox ID="txtExperienceBeforePhD" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label for="txtExperienceAfterPhD" class="form-label">Years of Work Experience After PhD</label>
                                    <asp:TextBox ID="txtExperienceAfterPhD" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label for="txtMSStudents" class="form-label">Have you supervised MS students?</label>
                                    <asp:TextBox ID="txtMSStudents" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label for="txtPhDStudents" class="form-label">Have you supervised PhD students?</label>
                                    <asp:TextBox ID="txtPhDStudents" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Information Navigation Buttons -->
                    <div class="container">
                        <div class="info-buttons">
                            <asp:Button ID="btnPersonalInfo" runat="server" Text="Enter/Edit Personal Information" CssClass="btn btn-outline-primary" OnClick="BtnPersonalInfo_Click" />
                            <asp:Button ID="btnEducationalInfo" runat="server" Text="Enter/Edit Educational Information" CssClass="btn btn-outline-success" OnClick="BtnEducationalInfo_Click" />
                            <asp:Button ID="btnExperienceInfo" runat="server" Text="Enter/Edit Research and Work Experience" CssClass="btn btn-outline-warning" OnClick="BtnExperienceInfo_Click" />
                        </div>
                    </div>

                    <!-- Declaration -->
                    <div class="container mt-5">
                        <div class="declaration-box">
                            <h3 class="declaration-title">Declaration</h3>
                            <hr />

                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" id="agreeDeclaration" />
                                <label class="form-check-label" for="agreeDeclaration">
                                    <strong>I certify that the information given in this application form for admission is complete and accurate to the best of my knowledge.</strong>
                                </label>
                            </div>

                            <div class="text-center mt-4">
                                <button id="submitBtn" class="btn btn-primary submit-btn" disabled="disabled">
                                    Submit
                                </button>
                            </div>
                        </div>
                    </div>

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

                    <div class="mt-3 text-center">
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>
                    </div>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

                </div> 
            </div> 
        </div> 

    </form> 

</body>
</html>