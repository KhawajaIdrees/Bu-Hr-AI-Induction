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

        .sub-section-title {
            font-size:15px;
            font-weight:700;
            color:#2D398D;
            text-transform:uppercase;
            letter-spacing:.3px;
            border-bottom:1px solid #eef1f8;
            padding-bottom:8px;
            margin-top:8px;
            margin-bottom:18px;
        }

        .sub-section-title:first-child {
            margin-top:0;
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

        .table th {
            background-color:#f8faff;
            color:#2D398D;
            font-weight:700;
            font-size:13px;
            text-transform:uppercase;
            letter-spacing:.5px;
            border-bottom:1px solid #eef1f8;
            white-space:nowrap;
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

        .table-responsive-wrap {
            overflow-x:auto;
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
                <h4 class="fw-bold">Research Publications</h4>
                <h5 class="text-secondary fw-normal">Bahria University HR Portal</h5>
                <hr />
            </div>

            <div class="form-card">

                <!-- SECTION: Publication -->
                <div class="form-section">
                    <div class="section-title"><i class="bi bi-journal-text"></i>Publication</div>

                    <!-- Impact Factor 1 -->
                    <div class="sub-section-title">Impact Factor</div>

                    <div class="row">
                        <div class="col-md-12 form-group">
                            <label for="<%= ddlImpactFactor.ClientID %>" class="form-label">
                                Last 05 Year (HEC/ISI Impact Factor)
                            </label>
                            <asp:DropDownList ID="ddlImpactFactor" runat="server" CssClass="form-select">
                                <asp:ListItem Value="">Select</asp:ListItem>
                                <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                <asp:ListItem Value="No">No</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-md-6 form-group">
                            <label for="<%= txtHECPublications.ClientID %>" class="form-label">
                                HEC Recognized Publications
                            </label>
                            <asp:TextBox ID="txtHECPublications" runat="server" CssClass="form-control" placeholder="Count" />
                        </div>

                        <div class="col-md-6 form-group">
                            <label for="<%= ddlConferencePaper.ClientID %>" class="form-label">
                                Conference Paper
                            </label>
                            <asp:DropDownList ID="ddlConferencePaper" runat="server" CssClass="form-select">
                                <asp:ListItem Value="">Select</asp:ListItem>
                                <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                <asp:ListItem Value="No">No</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <!-- Impact Factor 2 -->
                    <div class="sub-section-title">Impact Factor</div>

                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label for="<%= ddlImpactFactor2.ClientID %>" class="form-label">
                                Last 05 Year (HEC/ISI Impact Factor)
                            </label>
                            <asp:DropDownList ID="ddlImpactFactor2" runat="server" CssClass="form-select">
                                <asp:ListItem Value="">Select</asp:ListItem>
                                <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                <asp:ListItem Value="No">No</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-md-6 form-group">
                            <label for="<%= ddlConferencePaper2.ClientID %>" class="form-label">
                                Conference Paper
                            </label>
                            <asp:DropDownList ID="ddlConferencePaper2" runat="server" CssClass="form-select">
                                <asp:ListItem Value="">Select</asp:ListItem>
                                <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                <asp:ListItem Value="No">No</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <!-- Category of Publication -->
                    <div class="sub-section-title">Category of Publication</div>

                    <div class="row">
                        <div class="col-md-4 form-group">
                            <label for="<%= txtWCount.ClientID %>" class="form-label">W</label>
                            <asp:TextBox ID="txtWCount" runat="server" TextMode="Number" CssClass="form-control" />
                        </div>

                        <div class="col-md-4 form-group">
                            <label for="<%= txtXCount.ClientID %>" class="form-label">X</label>
                            <asp:TextBox ID="txtXCount" runat="server" TextMode="Number" CssClass="form-control" />
                        </div>

                        <div class="col-md-4 form-group">
                            <label for="<%= txtYCount.ClientID %>" class="form-label">Y</label>
                            <asp:TextBox ID="txtYCount" runat="server" TextMode="Number" CssClass="form-control" />
                        </div>
                    </div>

                    <!-- Funded / Foreign Projects -->
                    <div class="sub-section-title">Funded / Foreign Projects</div>

                    <div class="row">
                        <div class="col-md-4 form-group">
                            <label for="<%= txtTotalFundedProjects.ClientID %>" class="form-label">
                                Number of Funded Projects
                            </label>
                            <asp:TextBox ID="txtTotalFundedProjects" runat="server" TextMode="Number" CssClass="form-control" />
                        </div>

                        <div class="col-md-4 form-group">
                            <label for="<%= txtPIProjects.ClientID %>" class="form-label">
                                Number of Projects as Principal Investigator (PI)
                            </label>
                            <asp:TextBox ID="txtPIProjects" runat="server" TextMode="Number" CssClass="form-control" />
                        </div>

                        <div class="col-md-4 form-group">
                            <label for="<%= txtCoPIProjects.ClientID %>" class="form-label">
                                Number of Projects as Co-Principal Investigator (Co-PI)
                            </label>
                            <asp:TextBox ID="txtCoPIProjects" runat="server" TextMode="Number" CssClass="form-control" />
                        </div>
                    </div>

                    <!-- Supervision Produced -->
                    <div class="sub-section-title">Number of MS/M.Phil/PhD Produced</div>

                    <div class="row">
                        <div class="col-md-4 form-group">
                            <label for="<%= txtMSStudents.ClientID %>" class="form-label">
                                Number of MS Produced
                            </label>
                            <asp:TextBox ID="txtMSStudents" runat="server" TextMode="Number" CssClass="form-control" />
                        </div>

                        <div class="col-md-4 form-group">
                            <label for="<%= txtMPhilStudents.ClientID %>" class="form-label">
                                Number of M.Phil Produced
                            </label>
                            <asp:TextBox ID="txtMPhilStudents" runat="server" TextMode="Number" CssClass="form-control" />
                        </div>

                        <div class="col-md-4 form-group">
                            <label for="<%= txtPhDStudents.ClientID %>" class="form-label">
                                Number of PhD Produced
                            </label>
                            <asp:TextBox ID="txtPhDStudents" runat="server" TextMode="Number" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="form-group mb-0">
                        <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn btn-add" OnClick="BtnAdd_Click" />
                        <asp:Label ID="lblMessage" runat="server" CssClass="ms-3" />
                    </div>
                </div>

      <!-- SECTION: Publications List -->
<div class="form-section">
    <div class="section-title"><i class="bi bi-list-columns-reverse"></i>Publications List</div>

    <div class="table-responsive-wrap">
        <asp:GridView ID="gvPublications" runat="server" AutoGenerateColumns="false"
            CssClass="table table-hover mb-0" GridLines="None"
            EmptyDataText="No publications added yet." EmptyDataRowStyle-CssClass="empty-row" OnSelectedIndexChanged="gvPublications_SelectedIndexChanged">
            <Columns>
                <asp:BoundField DataField="ImpactFactor" HeaderText="Impact Factor" />
                <asp:BoundField DataField="HECPublications" HeaderText="HEC Publications" />
                <asp:BoundField DataField="ConferencePaper" HeaderText="Conference Paper" />
                <asp:BoundField DataField="ImpactFactor2" HeaderText="Impact Factor 2" />
                <asp:BoundField DataField="ConferencePaper2" HeaderText="Conference Paper 2" />
                <asp:BoundField DataField="WCount" HeaderText="W" />
                <asp:BoundField DataField="XCount" HeaderText="X" />
                <asp:BoundField DataField="YCount" HeaderText="Y" />
                <asp:BoundField DataField="TotalFundedProjects" HeaderText="Funded Projects" />
                <asp:BoundField DataField="PIProjects" HeaderText="PI" />
                <asp:BoundField DataField="CoPIProjects" HeaderText="Co-PI" />
                <asp:BoundField DataField="MSStudents" HeaderText="MS" />
                <asp:BoundField DataField="MPhilStudents" HeaderText="M.Phil" />
                <asp:BoundField DataField="PhDStudents" HeaderText="PhD" />
            </Columns>
        </asp:GridView>
    </div>
</div>
                <!-- SECTION: Submit -->
                <div class="form-section text-center">
                    <asp:Button ID="BtnSaveContinue" runat="server" Text="Save and Continue" CssClass="btn btn-save" OnClick="BtnRegister_Click" />
                    <asp:Label ID="Label1" runat="server" CssClass="d-block mt-3"></asp:Label>
                </div>
            </div>

        </div>

    </form>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>