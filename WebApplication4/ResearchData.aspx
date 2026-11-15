<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResearchData.aspx.cs" Inherits="WebApplication4.ResearchData" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Research Publications</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Georgia&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" />

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

        .sub-section-title {
            font-family: var(--font-ui);
            font-size: 13px;
            font-weight: 600;
            color: var(--secondary-navy);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding-bottom: 8px;
            margin-top: 8px;
            margin-bottom: 16px;
            border-bottom: 1px solid var(--divider);
        }

        .sub-section-title:first-child { margin-top: 0; }

        .form-label {
            display: block;
            font-family: var(--font-ui);
            font-weight: 500;
            font-size: 13px;
            color: var(--body-text);
            margin-bottom: 7px;
        }

        .required-asterisk { color: var(--error-red); margin-left: 2px; }

        .form-control,
        .form-select {
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

        .form-control::placeholder {
            color: var(--placeholder);
            font-weight: 400;
        }

        .form-control:focus,
        .form-select:focus {
            outline: none;
            border-color: var(--action-blue);
            box-shadow: 0 0 0 2px rgba(23, 105, 168, 0.08);
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 22px 26px;
            margin-bottom: 22px;
        }

        .form-row.three-col { grid-template-columns: repeat(3, 1fr); }
        .form-row.four-col { grid-template-columns: repeat(4, 1fr); }
        .form-row.one-col { grid-template-columns: 1fr; }
        .form-row:last-child { margin-bottom: 0; }
        .form-group { margin: 0; }

        .btn-add {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: var(--action-blue);
            color: #FFFFFF;
            border: none;
            border-radius: var(--radius);
            height: 44px;
            padding: 0 24px;
            font-family: var(--font-ui);
            font-weight: 600;
            font-size: 14px;
            letter-spacing: 0.2px;
            cursor: pointer;
            transition: background 0.15s ease;
        }

        .btn-add:hover { background: var(--action-blue-hover); }

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

        /* Delete button — exact copy from Experience page */
        .btn-delete {
            background: var(--error-red);
            color: white;
            border: none;
            border-radius: var(--radius);
            padding: 6px 14px;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            font-family: var(--font-ui);
            transition: background 0.15s ease;
        }

        .btn-delete:hover { background: #A71D2A; }

        .text-danger {
            display: block;
            color: var(--error-red) !important;
            font-size: 12px;
            font-weight: 500;
            margin-top: 5px;
            font-family: var(--font-ui);
        }

        /* Table */
        .table-responsive-wrap { overflow-x: auto; }

        .table {
            width: 100%;
            border-collapse: collapse;
            font-family: var(--font-ui);
            table-layout: auto;
        }

        /* Headers — force uniform style */
        .table th {
            background: #F8FAFC !important;
            color: var(--muted-text) !important;
            font-weight: 700 !important;
            font-size: 11px !important;
            text-transform: uppercase !important;
            letter-spacing: .5px !important;
            border-bottom: 1px solid var(--border) !important;
            text-align: left !important;
            padding: 12px 14px !important;
            vertical-align: middle !important;
            white-space: nowrap;
        }

        /* Cells — left aligned */
        .table td {
            font-size: 13px !important;
            color: var(--body-text) !important;
            padding: 12px 14px !important;
            border-bottom: 1px solid #F1F4F9 !important;
            vertical-align: middle !important;
            text-align: left !important;
        }

        /* Last column — right aligned for Delete button */
        .table th:last-child,
        .table td:last-child {
            text-align: right !important;
        }

        .table-hover tbody tr:hover { background-color: #F8FAFC; }

        .empty-row {
            text-align: center !important;
            color: var(--placeholder);
            padding: 30px 0;
        }

        .save-wrap {
            display: flex;
            justify-content: flex-end;
            margin-top: 32px;
            padding-top: 4px;
        }

        .add-wrap {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-top: 20px;
        }

        /* Delete button fallback — targets ASP.NET rendered input[type=submit] inside the table,
           but ONLY the delete buttons, not other form controls. Use high specificity. */
        .table input[type="submit"] {
            background: var(--error-red) !important;
            color: #FFFFFF !important;
            border: none !important;
            border-radius: var(--radius) !important;
            padding: 6px 14px !important;
            font-size: 12px !important;
            line-height: 1.2 !important;
            font-weight: 600 !important;
            font-family: var(--font-ui) !important;
            cursor: pointer !important;
            transition: background 0.15s ease !important;
            height: auto !important;
            width: auto !important;
            min-width: 0 !important;
        }

        .table input[type="submit"]:hover {
            background: #A71D2A !important;
        }

        @media (max-width: 900px) {
            .page-wrap { padding: 24px 24px 40px; }
            .form-row.four-col { grid-template-columns: repeat(2, 1fr); }
            .form-row.three-col { grid-template-columns: repeat(2, 1fr); }
        }

        @media (max-width: 640px) {
            .page-wrap { padding: 20px 16px 40px; }
            .main-heading { font-size: 30px; }
            .form-row,
            .form-row.two-col,
            .form-row.three-col,
            .form-row.four-col,
            .form-row.one-col { grid-template-columns: 1fr; }
            .section-heading h3 { font-size: 18px; }
            .btn-save { width: 100%; justify-content: center; }
            .save-wrap { justify-content: stretch; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <div class="page-wrap">

            <!-- HEADER -->
            <div class="page-header">
                <img src="Images/bu_logo.png" alt="Bahria University" class="logo" />
                <div>
                    <div class="uni-name">Bahria University</div>
                    <div class="hr-portal">HR Portal</div>
                </div>
            </div>

            <!-- MAIN HEADING -->
            <h1 class="main-heading">Research Publications</h1>
            <p class="main-subtitle">Record your research output and academic contributions.</p>

            <!-- ============================================================
                 RESEARCH SUMMARY
                 ============================================================ -->
            <div class="section-card">
                <div class="section-heading">
                    <h3>Research Summary</h3>
                </div>

                <div class="form-row two-col">
                    <div class="form-group">
                        <label for="<%= txtTotalPublications.ClientID %>" class="form-label">
                            Total Research Publications <span class="required-asterisk">*</span>
                        </label>
                        <asp:TextBox ID="txtTotalPublications" runat="server" TextMode="Number" CssClass="form-control" placeholder="0" />
                    </div>

                    <div class="form-group">
                        <label for="<%= txtHECPublications.ClientID %>" class="form-label">
                            HEC Recognized Publications <span class="required-asterisk">*</span>
                        </label>
                        <asp:TextBox ID="txtHECPublications" runat="server" TextMode="Number" CssClass="form-control" placeholder="0" />
                    </div>
                </div>

                <div class="sub-section-title">Number of MS/M.Phil/PhD Produced (for PhD Candidates)</div>

                <div class="form-row two-col">
                    <div class="form-group">
                        <label for="<%= txtMSMPhilStudents.ClientID %>" class="form-label">
                            Number of MS/M.Phil Produced
                        </label>
                        <asp:TextBox ID="txtMSMPhilStudents" runat="server" TextMode="Number" CssClass="form-control" placeholder="0" />
                    </div>

                    <div class="form-group">
                        <label for="<%= txtPhDStudents.ClientID %>" class="form-label">
                            Number of PhD Produced
                        </label>
                        <asp:TextBox ID="txtPhDStudents" runat="server" TextMode="Number" CssClass="form-control" placeholder="0" />
                    </div>
                </div>

                <div class="sub-section-title">Number of National/International Funded Projects</div>

                <div class="form-row two-col">
                    <div class="form-group">
                        <label for="<%= txtPIProjects.ClientID %>" class="form-label">
                            As Principal Investigator (PI)
                        </label>
                        <asp:TextBox ID="txtPIProjects" runat="server" TextMode="Number" CssClass="form-control" placeholder="0" />
                    </div>

                    <div class="form-group">
                        <label for="<%= txtCoPIProjects.ClientID %>" class="form-label">
                            As Co-Principal Investigator (Co-PI)
                        </label>
                        <asp:TextBox ID="txtCoPIProjects" runat="server" TextMode="Number" CssClass="form-control" placeholder="0" />
                    </div>
                </div>

                <div class="sub-section-title">Consultancy Details</div>

                <div class="form-row one-col">
                    <div class="form-group">
                        <label for="<%= txtConsultancyAmount.ClientID %>" class="form-label">
                            Consultancy Amount (If any)
                        </label>
                        <asp:TextBox ID="txtConsultancyAmount" runat="server" CssClass="form-control" placeholder="Enter amount in PKR (e.g., 500,000)" />
                    </div>
                </div>
            </div>

            <!-- ============================================================
                 PUBLICATION DETAILS
                 ============================================================ -->
            <div class="section-card">
                <div class="section-heading">
                    <h3>Publication Details</h3>
                </div>

                <div class="form-row four-col">
                    <div class="form-group">
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

                    <div class="form-group">
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

                    <div class="form-group">
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

                    <div class="form-group">
                        <label for="<%= ddlAuthorType.ClientID %>" class="form-label">
                            Author Type <span class="required-asterisk">*</span>
                        </label>
                        <asp:DropDownList ID="ddlAuthorType" runat="server" CssClass="form-select">
                            <asp:ListItem Value="">-- Select Author Type --</asp:ListItem>
                            <asp:ListItem Value="First Author">First Author</asp:ListItem>
                            <asp:ListItem Value="Second Author">Second Author</asp:ListItem>
                            <asp:ListItem Value="Corresponding Author">Corresponding Author</asp:ListItem>
                            <asp:ListItem Value="Others">Others</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="sub-section-title">Article Details</div>

                <div class="form-row two-col">
                    <div class="form-group">
                        <label for="<%= txtArticleTitle.ClientID %>" class="form-label">
                            Article Title <span class="required-asterisk">*</span>
                        </label>
                        <asp:TextBox ID="txtArticleTitle" runat="server" CssClass="form-control" placeholder="Enter article title" />
                    </div>

                    <div class="form-group">
                        <label for="<%= txtAuthors.ClientID %>" class="form-label">
                            Authors <span class="required-asterisk">*</span>
                        </label>
                        <asp:TextBox ID="txtAuthors" runat="server" CssClass="form-control" placeholder="Enter author names" />
                    </div>
                </div>

                <div class="form-row three-col">
                    <div class="form-group">
                        <label for="<%= txtJournalName.ClientID %>" class="form-label">
                            Journal/Conference Name <span class="required-asterisk">*</span>
                        </label>
                        <asp:TextBox ID="txtJournalName" runat="server" CssClass="form-control" placeholder="Enter journal or conference name" />
                    </div>

                    <div class="form-group">
                        <label for="<%= txtPublicationDate.ClientID %>" class="form-label">
                            Publication Date
                        </label>
                        <asp:TextBox ID="txtPublicationDate" runat="server" TextMode="Date" CssClass="form-control" />
                    </div>

                    <div class="form-group">
                        <label for="<%= txtPublicationYear.ClientID %>" class="form-label">
                            Publication Year <span class="required-asterisk">*</span>
                        </label>
                        <asp:TextBox ID="txtPublicationYear" runat="server" TextMode="Number" CssClass="form-control" placeholder="YYYY" />
                    </div>
                </div>

                <div class="form-row one-col">
                    <div class="form-group">
                        <label for="<%= txtDOI.ClientID %>" class="form-label">
                            DOI (if available)
                        </label>
                        <asp:TextBox ID="txtDOI" runat="server" CssClass="form-control" placeholder="Enter DOI (e.g., 10.1234/abcd1234)" />
                    </div>
                </div>

                <div class="add-wrap">
                    <asp:Button ID="btnAdd" runat="server" Text="Add Publication" CssClass="btn-add" OnClick="BtnAdd_Click" />
                    <asp:Label ID="lblMessage" runat="server" />
                </div>
            </div>

            <!-- ============================================================
                 PUBLICATIONS LIST
                 ============================================================ -->
            <div class="section-card">
                <div class="section-heading">
                    <h3>Publications List</h3>
                </div>

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
                            <asp:BoundField DataField="AuthorType" HeaderText="Author Type" />
                            <asp:BoundField DataField="ArticleTitle" HeaderText="Article Title" />
                            <asp:BoundField DataField="Authors" HeaderText="Authors" />
                            <asp:BoundField DataField="JournalName" HeaderText="Journal/Conference" />
                            <asp:BoundField DataField="PublicationYear" HeaderText="Year" />
                            <asp:BoundField DataField="DOI" HeaderText="DOI" />
                            <asp:ButtonField Text="Delete" CommandName="DeletePublication" ButtonType="Button" ControlStyle-CssClass="btn-delete" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <!-- SAVE AND CONTINUE -->
            <div class="save-wrap">
                <asp:Button ID="BtnSaveContinue" runat="server" Text="Save and Continue  →"
                    CssClass="btn-save" OnClick="BtnRegister_Click" />
            </div>

            <asp:Label ID="Label1" runat="server" CssClass="text-danger" style="display:block; margin-top:14px;"></asp:Label>

        </div>

    </form>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var numberInputs = document.querySelectorAll('input[type="number"]');

            numberInputs.forEach(function (input) {
                input.addEventListener('input', function () {
                    if (this.value !== '' && this.value !== '-') {
                        var val = parseInt(this.value);
                        if (val < 0) { this.value = 0; }
                    }
                });

                input.addEventListener('change', function () {
                    if (this.value !== '' && this.value !== '-') {
                        var val = parseInt(this.value);
                        if (val < 0) { this.value = 0; }
                    }
                });

                input.addEventListener('blur', function () {
                    if (this.value === '' || this.value === '-' || this.value === null) {
                        this.value = '';
                    } else {
                        var val = parseInt(this.value);
                        if (val < 0) { this.value = 0; }
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>