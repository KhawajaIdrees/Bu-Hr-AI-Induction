<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Experience.aspx.cs" Inherits="WebApplication4.ExperiencePhd" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Work Experience</title>

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

        .form-card {
            max-width:1100px;
            margin:30px auto 60px;
            background:white;
            padding:0;
            border-radius:16px;
            box-shadow:0px 8px 30px rgba(45,57,141,.10);
            overflow:hidden;
        }

        /* Section styling */
        .form-section {
            padding:36px 45px;
            border-bottom:1px solid #eef1f8;
        }

        .form-section:last-of-type {
            border-bottom:none;
        }

        .section-title {
            display:flex;
            align-items:center;
            gap:10px;
            color:#2D398D;
            font-size:19px;
            font-weight:700;
            margin-bottom:24px;
            text-transform:uppercase;
            letter-spacing:.4px;
        }

        .section-title i {
            font-size:20px;
        }

        .form-label {
            font-size:15px;
            font-weight:600;
            color:#44496b;
            margin-bottom:6px;
        }

        .required-asterisk {
            color:#dc3545;
            font-size:15px;
        }

        .form-control,
        .form-select {
            font-size:15px;
            height:48px;
            border-radius:8px;
            border:1px solid #ced4da;
            padding:10px 14px;
            transition:all .2s ease-in-out;
        }

        .form-control::placeholder {
            font-size:14px;
            color:#a3a9bd;
        }

        .form-control:focus,
        .form-select:focus {
            border-color:#2D398D;
            box-shadow:0 0 0 .2rem rgba(45,57,141,.15);
        }

        .form-group {
            margin-bottom:24px;
        }

        .btn-save {
            background:#2D398D;
            color:white;
            border-radius:8px;
            padding:14px 55px;
            font-size:17px;
            font-weight:600;
            border:none;
            transition:all .2s ease-in-out;
        }

        .btn-save:hover {
            background:#232c70;
            color:white;
            transform:translateY(-1px);
            box-shadow:0 6px 16px rgba(45,57,141,.3);
        }

        .btn-add {
            background:#2D398D;
            color:white;
            border-radius:8px;
            padding:12px 34px;
            font-size:16px;
            font-weight:600;
            border:none;
            transition:all .2s ease-in-out;
        }

        .btn-add:hover {
            background:#232c70;
            color:white;
            transform:translateY(-1px);
            box-shadow:0 6px 16px rgba(45,57,141,.3);
        }

        .text-danger {
            font-size:13px;
        }

        /* Checkbox row */
        .form-check {
            display:flex;
            align-items:center;
            gap:10px;
        }

        .form-check-input {
            width:18px;
            height:18px;
            cursor:pointer;
            margin-top:0;
        }

        .form-check-input:focus {
            border-color:#2D398D;
            box-shadow:0 0 0 .2rem rgba(45,57,141,.15);
        }

        .form-check-input:checked {
            background-color:#2D398D;
            border-color:#2D398D;
        }

        .form-check-label {
            font-size:15px;
            font-weight:500;
            color:#44496b;
            cursor:pointer;
        }

        /* Work history table */
        .table th {
            background-color:#f8faff;
            color:#2D398D;
            font-weight:700;
            font-size:13px;
            text-transform:uppercase;
            letter-spacing:.5px;
            border-bottom:1px solid #eef1f8;
        }

        .table td {
            font-size:15px;
            color:#44496b;
            vertical-align:middle;
        }

        .table-hover tbody tr:hover {
            background-color:#f8faff;
        }

        .empty-row {
            text-align:center;
            color:#a3a9bd;
            padding:30px 0;
        }

        /* Responsive adjustment */
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

            .form-control, .form-select {
                font-size: 14px;
                height: 44px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

    <div class="container">
        <div class="text-left mb-3 mt-4 page-title">
        <h4 class="fw-bold">Work Experience</h4>
        <h5 class="text-secondary fw-normal">Bahria University HR Portal</h5>
        <hr />
    </div>


        <div class="form-card">

            <!-- SECTION: Add New Experience -->
            <div class="form-section">
                <div class="section-title"><i class="bi bi-briefcase-fill"></i>Add New Experience</div>

                <div class="row">
                    <div class="col-md-6 form-group">
                        <label for="<%= txtOrganization.ClientID %>" class="form-label">
                            Organization Name <span class="required-asterisk">*</span>
                        </label>
                        <asp:TextBox ID="txtOrganization" runat="server" CssClass="form-control" placeholder="e.g., Bahria University" />
                        <asp:RequiredFieldValidator ID="rfvOrganization" runat="server"
                            ControlToValidate="txtOrganization"
                            ErrorMessage="Organization name is required."
                            CssClass="text-danger d-block mt-1"
                            Display="Static"
                            ValidationGroup="ExperienceForm" />
                    </div>
                    <div class="col-md-6 form-group">
                        <label for="<%= txtPosition.ClientID %>" class="form-label">
                            Position Title <span class="required-asterisk">*</span>
                        </label>
                        <asp:TextBox ID="txtPosition" runat="server" CssClass="form-control" placeholder="e.g., Assistant Professor" />
                        <asp:RequiredFieldValidator ID="rfvPosition" runat="server"
                            ControlToValidate="txtPosition"
                            ErrorMessage="Position title is required."
                            CssClass="text-danger d-block mt-1"
                            Display="Static"
                            ValidationGroup="ExperienceForm" />
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 form-group">
                        <label for="<%= txtStartDate.ClientID %>" class="form-label">
                            Start Date <span class="required-asterisk">*</span>
                        </label>
                        <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="rfvStartDate" runat="server"
                            ControlToValidate="txtStartDate"
                            ErrorMessage="Start date is required."
                            CssClass="text-danger d-block mt-1"
                            Display="Static"
                            ValidationGroup="ExperienceForm" />
                    </div>
                    <div class="col-md-6 form-group">
                        <label for="<%= txtEndDate.ClientID %>" class="form-label">
                            End Date
                        </label>
                        <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date" CssClass="form-control" />
                        <%-- No RequiredFieldValidator here: end date is intentionally optional
                             when "I currently work here" is checked. Add a CustomValidator
                             server-side if you want to enforce End Date when the checkbox is unchecked. --%>
                    </div>
                </div>

                <div class="form-group mb-3">
                    <div class="form-check">
                        <asp:CheckBox ID="chkCurrentJob" runat="server" CssClass="form-check-input" />
                        <label class="form-check-label" for="chkCurrentJob">I currently work here</label>
                    </div>
                </div>

                <div class="form-group mb-0">
                    <asp:Button ID="btnAdd" runat="server" Text="Add Experience" CssClass="btn btn-add" OnClick="BtnAdd_Click" ValidationGroup="ExperienceForm" />
                    <asp:Label ID="lblMessage" runat="server" CssClass="ms-3" />
                </div>
            </div>

            <!-- SECTION: Work History -->
            <div class="form-section">
                <div class="section-title"><i class="bi bi-clock-history"></i>Work History</div>

                <asp:GridView ID="gvExperiences" runat="server" AutoGenerateColumns="false"
                    CssClass="table table-hover mb-0" GridLines="None"
                    EmptyDataText="No work experience added yet." EmptyDataRowStyle-CssClass="empty-row">
                    <Columns>
                        <asp:BoundField DataField="OrganizationName" HeaderText="Organization" />
                        <asp:BoundField DataField="PositionTitle" HeaderText="Position" />
                        <asp:BoundField DataField="StartDate" HeaderText="Start Date" DataFormatString="{0:MMM yyyy}" />
                        <asp:BoundField DataField="EndDate" HeaderText="End Date" DataFormatString="{0:MMM yyyy}" />
                        <asp:BoundField DataField="Duration" HeaderText="Duration" />
                    </Columns>
                </asp:GridView>
            </div>

            <!-- SECTION: Next -->
            <div class="form-section text-end">
                <asp:Button ID="btnNext" runat="server" Text="Save and Continue" CssClass="btn btn-save" OnClick="BtnNext_Click" />
            </div>

        </div>

    </div>

</form>


    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>