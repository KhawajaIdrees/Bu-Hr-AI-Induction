<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResearchData.aspx.cs" Inherits="WebApplication4.ResearchData" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Research Publications</title>

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

        .card-main {
            border-radius: 16px;
            border: none;
            box-shadow: 0 8px 30px rgba(26, 58, 122, 0.10);
            overflow: hidden;
            margin-bottom: 30px;
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

        .card-body {
            padding: 25px 30px;
        }

        .sub-section-title {
            font-size: 15px;
            font-weight: 700;
            color: #1a3a7a;
            text-transform: uppercase;
            letter-spacing: .3px;
            border-bottom: 1px solid #eef1f8;
            padding-bottom: 8px;
            margin-top: 8px;
            margin-bottom: 18px;
        }

        .sub-section-title:first-child {
            margin-top: 0;
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
            outline: none;
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

        .btn-add {
            background: #1a3a7a;
            color: white;
            border-radius: 8px;
            padding: 12px 34px;
            font-size: 16px;
            font-weight: 600;
            border: none;
            transition: all .2s ease-in-out;
        }

        .btn-add:hover {
            background: #2a5aaa;
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(26, 58, 122, 0.3);
        }

        .text-danger {
            font-size: 13px;
        }

        .table th {
            background-color: #e8edf5;
            color: #1a3a7a;
            font-weight: 700;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: .5px;
            border-bottom: 2px solid #1a3a7a;
            text-align: center;
            vertical-align: middle;
        }

        .table td {
            font-size: 15px;
            color: #44496b;
            vertical-align: middle;
            text-align: center;
        }

        .table-hover tbody tr:hover {
            background-color: #f8faff;
        }

        .empty-row {
            text-align: center;
            color: #a3a9bd;
            padding: 30px 0;
        }

        .table-responsive-wrap {
            overflow-x: auto;
        }

        .form-group .form-control,
        .form-group .form-select {
            width: 100%;
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

            .card-body {
                padding: 15px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <div class="container py-4">

            <!-- Page Title -->
            <div class="text-left mb-4 page-title">
                <h4><i class="bi bi-journal-text text-primary-custom me-2"></i>Research Publications</h4>
                <h5>Bahria University HR Portal</h5>
                <hr />
            </div>

            <!-- Main Card -->
            <div class="card card-main">
                <div class="card-header-blue">
                    <h5><i class="bi bi-journal-bookmark-fill"></i> Research Summary</h5>
                </div>
                <div class="card-body">

                    <!-- Total Research Publications -->
                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label for="<%= txtTotalPublications.ClientID %>" class="form-label">
                                Total Research Publications <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtTotalPublications" runat="server" TextMode="Number" CssClass="form-control" placeholder="0" />
                        </div>

                        <div class="col-md-6 form-group">
                            <label for="<%= txtHECPublications.ClientID %>" class="form-label">
                                HEC Recognized Publications <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtHECPublications" runat="server" TextMode="Number" CssClass="form-control" placeholder="0" />
                        </div>
                    </div>

                    <!-- Number of MS/M.Phil/PhD Produced (for PhD Candidates) -->
                    <div class="sub-section-title">Number of MS/M.Phil/PhD Produced (for PhD Candidates)</div>

                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label for="<%= txtMSMPhilStudents.ClientID %>" class="form-label">
                                Number of MS/M.Phil Produced
                            </label>
                            <asp:TextBox ID="txtMSMPhilStudents" runat="server" TextMode="Number" CssClass="form-control" placeholder="0" />
                        </div>

                        <div class="col-md-6 form-group">
                            <label for="<%= txtPhDStudents.ClientID %>" class="form-label">
                                Number of PhD Produced
                            </label>
                            <asp:TextBox ID="txtPhDStudents" runat="server" TextMode="Number" CssClass="form-control" placeholder="0" />
                        </div>
                    </div>

                    <!-- Funded Projects -->
                    <div class="sub-section-title">Number of National/International Funded Projects</div>

                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label for="<%= txtPIProjects.ClientID %>" class="form-label">
                                As Principal Investigator (PI)
                            </label>
                            <asp:TextBox ID="txtPIProjects" runat="server" TextMode="Number" CssClass="form-control" placeholder="0" />
                        </div>

                        <div class="col-md-6 form-group">
                            <label for="<%= txtCoPIProjects.ClientID %>" class="form-label">
                                As Co-Principal Investigator (Co-PI)
                            </label>
                            <asp:TextBox ID="txtCoPIProjects" runat="server" TextMode="Number" CssClass="form-control" placeholder="0" />
                        </div>
                    </div>

                    <!-- Consultancy Amount -->
                    <div class="sub-section-title">Consultancy Details</div>

                    <div class="row">
                        <div class="col-md-12 form-group">
                            <label for="<%= txtConsultancyAmount.ClientID %>" class="form-label">
                                Consultancy Amount (If any)
                            </label>
                            <asp:TextBox ID="txtConsultancyAmount" runat="server" CssClass="form-control" placeholder="Enter amount in PKR (e.g., 500,000)" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Publication Details Card -->
            <div class="card card-main">
                <div class="card-header-blue">
                    <h5><i class="bi bi-journal-bookmark-fill"></i> Publication Details</h5>
                </div>
                <div class="card-body">

                    <!-- Publication Type -->
                    <div class="row">
                        <div class="col-md-4 form-group">
                            <label for="<%= ddlPublicationType.ClientID %>" class="form-label">
                                Publication Type <span class="required-asterisk">*</span>
                            </label>
                            <asp:DropDownList ID="ddlPublicationType" runat="server" CssClass="form-select">
                                <asp:ListItem Value="">-- Select Publication Type --</asp:ListItem>
                                <asp:ListItem Value="Journal Article">Journal Article</asp:ListItem>
                                <asp:ListItem Value="Conference Paper">Conference Paper</asp:ListItem>
                                <asp:ListItem Value="Book Chapter">Book Chapter</asp:ListItem>
                                <asp:ListItem Value="Case Study">Case Study</asp:ListItem>
                                <asp:ListItem Value="Technical Note">Technical Note</asp:ListItem>
                                <asp:ListItem Value="Patent">Patent</asp:ListItem>
                                <asp:ListItem Value="Other">Other</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <!-- Category of Publication -->
                        <div class="col-md-4 form-group">
                            <label for="<%= ddlCategory.ClientID %>" class="form-label">
                                Categories of Publication <span class="required-asterisk">*</span>
                            </label>
                            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select">
                                <asp:ListItem Value="">-- Select Category --</asp:ListItem>
                                <asp:ListItem Value="W">W</asp:ListItem>
                                <asp:ListItem Value="X">X</asp:ListItem>
                                <asp:ListItem Value="Y">Y</asp:ListItem>
                                <asp:ListItem Value="Other">Other</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <!-- Publication Status -->
                        <div class="col-md-4 form-group">
                            <label for="<%= ddlPublicationStatus.ClientID %>" class="form-label">
                                Publication Status <span class="required-asterisk">*</span>
                            </label>
                            <asp:DropDownList ID="ddlPublicationStatus" runat="server" CssClass="form-select">
                                <asp:ListItem Value="">-- Select Status --</asp:ListItem>
                                <asp:ListItem Value="Published">Published</asp:ListItem>
                                <asp:ListItem Value="Accepted">Accepted</asp:ListItem>
                                <asp:ListItem Value="Submitted">Submitted</asp:ListItem>
                                <asp:ListItem Value="Under Review">Under Review</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <!-- Article Details -->
                    <div class="sub-section-title">Article Details</div>

                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label for="<%= txtArticleTitle.ClientID %>" class="form-label">
                                Article Title <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtArticleTitle" runat="server" CssClass="form-control" placeholder="Enter article title" />
                        </div>

                        <div class="col-md-6 form-group">
                            <label for="<%= txtAuthors.ClientID %>" class="form-label">
                                Authors <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtAuthors" runat="server" CssClass="form-control" placeholder="Enter author names" />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label for="<%= txtJournalName.ClientID %>" class="form-label">
                                Journal/Conference Name <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtJournalName" runat="server" CssClass="form-control" placeholder="Enter journal or conference name" />
                        </div>

                        <div class="col-md-3 form-group">
                            <label for="<%= txtPublicationDate.ClientID %>" class="form-label">
                                Publication Date
                            </label>
                            <asp:TextBox ID="txtPublicationDate" runat="server" TextMode="Date" CssClass="form-control" />
                        </div>

                        <div class="col-md-3 form-group">
                            <label for="<%= txtPublicationYear.ClientID %>" class="form-label">
                                Publication Year <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtPublicationYear" runat="server" TextMode="Number" CssClass="form-control" placeholder="YYYY" />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12 form-group">
                            <label for="<%= txtDOI.ClientID %>" class="form-label">
                                DOI (if available)
                            </label>
                            <asp:TextBox ID="txtDOI" runat="server" CssClass="form-control" placeholder="Enter DOI (e.g., 10.1234/abcd1234)" />
                        </div>
                    </div>

                    <div class="form-group mb-0">
                        <asp:Button ID="btnAdd" runat="server" Text="Add Publication" CssClass="btn btn-add" OnClick="BtnAdd_Click" />
                        <asp:Label ID="lblMessage" runat="server" CssClass="ms-3" />
                    </div>
                </div>
            </div>

            <!-- Publications List Card -->
            <div class="card card-main">
                <div class="card-header-blue">
                    <h5><i class="bi bi-list-columns-reverse"></i> Publications List</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive-wrap">
                        <asp:GridView ID="gvPublications" runat="server" AutoGenerateColumns="false"
                            CssClass="table table-hover mb-0" GridLines="None"
                            EmptyDataText="No publications added yet." EmptyDataRowStyle-CssClass="empty-row"
                            OnRowCommand="gvPublications_RowCommand">
                            <Columns>
                                <asp:BoundField DataField="PublicationID" HeaderText="S.No" />
                                <asp:BoundField DataField="PublicationType" HeaderText="Type" />
                                <asp:BoundField DataField="Category" HeaderText="Category" />
                                <asp:BoundField DataField="Status" HeaderText="Status" />
                                <asp:BoundField DataField="ArticleTitle" HeaderText="Article Title" />
                                <asp:BoundField DataField="Authors" HeaderText="Authors" />
                                <asp:BoundField DataField="JournalName" HeaderText="Journal/Conference" />
                                <asp:BoundField DataField="PublicationYear" HeaderText="Year" />
                                <asp:BoundField DataField="DOI" HeaderText="DOI" />
                                <asp:ButtonField Text="Delete" CommandName="DeletePublication" ButtonType="Button" ControlStyle-CssClass="btn btn-danger btn-sm" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>

            <!-- Submit Button -->
            <div class="text-center">
                <asp:Button ID="BtnSaveContinue" runat="server" Text="Save and Continue" CssClass="btn btn-save" OnClick="BtnRegister_Click" />
                <div class="mt-3">
                    <asp:Label ID="Label1" runat="server"></asp:Label>
                </div>
            </div>

        </div>

    </form>

    <!-- JavaScript to control spinner behavior - stops at 0 -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var numberInputs = document.querySelectorAll('input[type="number"]');

            numberInputs.forEach(function (input) {
                input.addEventListener('input', function () {
                    if (this.value !== '' && this.value !== '-') {
                        var val = parseInt(this.value);
                        if (val < 0) {
                            this.value = 0;
                        }
                    }
                });

                input.addEventListener('change', function () {
                    if (this.value !== '' && this.value !== '-') {
                        var val = parseInt(this.value);
                        if (val < 0) {
                            this.value = 0;
                        }
                    }
                });

                input.addEventListener('blur', function () {
                    if (this.value === '' || this.value === '-' || this.value === null) {
                        this.value = '';
                    } else {
                        var val = parseInt(this.value);
                        if (val < 0) {
                            this.value = 0;
                        }
                    }
                });

                input.addEventListener('keydown', function (e) {
                    if (e.keyCode === 8 || e.keyCode === 46 || e.keyCode === 9 ||
                        e.keyCode === 27 || e.keyCode === 13 || e.keyCode === 35 ||
                        e.keyCode === 36 || e.keyCode === 37 || e.keyCode === 39) {
                        return;
                    }

                    if ((e.ctrlKey || e.metaKey) && (e.keyCode === 65 || e.keyCode === 67 ||
                        e.keyCode === 86 || e.keyCode === 88)) {
                        return;
                    }

                    if (e.key === '-' || e.keyCode === 189) {
                        e.preventDefault();
                        return false;
                    }
                });
            });
        });
    </script>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>