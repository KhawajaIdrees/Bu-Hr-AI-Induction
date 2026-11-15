<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserReference.aspx.cs" Inherits="WebApplication4.UserReference" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>References</title>

    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Georgia&display=swap" rel="stylesheet" />
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

        .form-label {
            display: block;
            font-family: var(--font-ui);
            font-weight: 500;
            font-size: 13px;
            color: var(--body-text);
            margin-bottom: 7px;
        }

        .required-asterisk { color: var(--error-red); margin-left: 2px; }

        .form-control {
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

        .form-control:focus {
            outline: none;
            border-color: var(--action-blue);
            box-shadow: 0 0 0 2px rgba(23, 105, 168, 0.08);
        }

        .ref-form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 22px 26px;
            margin-bottom: 22px;
        }

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
            text-decoration: none;
        }

        .btn-add:hover { background: var(--action-blue-hover); color: #FFFFFF; }

        .btn-save {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: var(--action-blue) !important;
            color: #FFFFFF !important;
            border: none !important;
            outline: none !important;
            border-radius: var(--radius);
            height: 46px;
            padding: 0 26px;
            font-family: var(--font-ui);
            font-weight: 600;
            font-size: 14px;
            letter-spacing: 0.2px;
            cursor: pointer;
            transition: background 0.15s ease;
            box-shadow: none !important;
        }

        .btn-save:hover { background: var(--action-blue-hover) !important; color: #FFFFFF !important; }

        .btn-save:focus,
        .btn-save:active {
            outline: none !important;
            border: none !important;
            box-shadow: none !important;
        }

        .btn-edit {
            background: var(--action-blue);
            color: white;
            border: none;
            border-radius: var(--radius);
            padding: 6px 14px;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            font-family: var(--font-ui);
            transition: background 0.15s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
        }

        .btn-edit:hover { background: var(--action-blue-hover); color: white; }

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
            text-decoration: none;
            display: inline-flex;
            align-items: center;
        }

        .btn-delete:hover { background: #A71D2A; color: white; }

        .reference-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 16px;
        }

        .reference-card {
            background: #FFFFFF;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 18px 20px 16px;
            transition: all 0.15s ease;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .reference-card:hover {
            border-color: var(--action-blue);
            box-shadow: 0 4px 16px rgba(23, 105, 168, 0.08);
        }

        .reference-card .ref-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 12px;
            border-bottom: 1px solid var(--divider);
        }

        .reference-card .ref-title {
            font-family: var(--font-ui);
            font-weight: 600;
            font-size: 14px;
            color: var(--primary-navy);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .reference-card .ref-number {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 26px;
            height: 26px;
            border-radius: 50%;
            background: #EEF4FB;
            color: var(--action-blue);
            font-weight: 700;
            font-size: 12px;
            flex-shrink: 0;
        }

        .reference-card .ref-name {
            font-family: var(--font-ui);
            font-weight: 600;
            font-size: 15px;
            color: var(--primary-navy);
            margin: 0;
        }

        .reference-card .ref-role {
            font-family: var(--font-ui);
            font-size: 13px;
            color: var(--muted-text);
            margin: 2px 0 0 0;
        }

        .reference-card .ref-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px 14px;
        }

        .reference-card .ref-detail {
            font-family: var(--font-ui);
            font-size: 12px;
            color: var(--body-text);
            line-height: 1.4;
            word-break: break-word;
        }

        .reference-card .ref-detail strong {
            display: block;
            color: var(--muted-text);
            font-weight: 500;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            margin-bottom: 2px;
        }

        .ref-body {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .ref-top {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }

        .alert {
            border-radius: var(--radius);
            padding: 12px 16px;
            font-size: 13px;
            font-family: var(--font-ui);
            margin-bottom: 16px;
            border: 1px solid;
        }

        .alert-warning {
            background: #FFF7ED;
            border-color: #FED7AA;
            color: #9A3412;
        }

        .alert-success {
            background: #F0FDF4;
            border-color: #BBF7D0;
            color: #166534;
        }

        .save-wrap {
            display: flex;
            justify-content: flex-end;
            margin-top: 32px;
            padding-top: 4px;
        }

        .section-divider {
            border-top: 1px solid var(--divider);
            margin: 24px 0;
        }

        .subsection-title {
            font-family: var(--font-ui);
            font-weight: 600;
            font-size: 13px;
            color: var(--secondary-navy);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 14px;
        }

        @media (max-width: 900px) {
            .page-wrap { padding: 24px 24px 40px; }
            .reference-list { grid-template-columns: 1fr; }
        }

        @media (max-width: 640px) {
            .page-wrap { padding: 20px 16px 40px; }
            .main-heading { font-size: 30px; }
            .section-heading h3 { font-size: 18px; }
            .ref-form-grid { grid-template-columns: 1fr; }
            .btn-save { width: 100%; justify-content: center; }
            .btn-add { width: 100%; justify-content: center; }
            .save-wrap { justify-content: stretch; }
            .reference-card .ref-details { grid-template-columns: 1fr; }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server" defaultbutton="btnSaveContinue">
        <div class="page-wrap">

            <div class="page-header">
                <img src="Images/bu_logo.png" alt="Bahria University" class="logo" />
                <div>
                    <div class="uni-name">Bahria University</div>
                    <div class="hr-portal">HR Portal</div>
                </div>
            </div>

            <h1 class="main-heading">References</h1>
            <p class="main-subtitle">Add professional references to complete your application.</p>

            <div class="section-card">
                <div class="section-heading">
                    <h3>Add Reference</h3>
                </div>

                <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert alert-warning">
                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                </asp:Panel>

                <div class="ref-form-grid">
                    <div class="form-group">
                        <label class="form-label">Reference Name</label>
                        <asp:TextBox ID="txtReferenceName" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group">
                        <label class="form-label">Relationship</label>
                        <asp:TextBox ID="txtRelationship" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group">
                        <label class="form-label">Organization / Company</label>
                        <asp:TextBox ID="txtOrganization" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group">
                        <label class="form-label">Job Title</label>
                        <asp:TextBox ID="txtJobTitle" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group">
                        <label class="form-label">Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" />
                    </div>

                    <div class="form-group">
                        <label class="form-label">Phone Number</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" MaxLength="20" oninput="validatePhone(this)" />
                    </div>

                    <div class="form-group">
                        <label class="form-label">Work Address</label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group">
                        <label class="form-label">Years Known</label>
                        <asp:TextBox ID="txtYearsKnown" runat="server" TextMode="Number" CssClass="form-control" />
                    </div>
                </div>

                <div style="display:flex; justify-content:flex-end;">
                    <asp:Button ID="btnAddReference" runat="server" Text="Add Reference"
                        CssClass="btn-add"
                        OnClick="btnAddReference_Click"
                        CausesValidation="false" />
                </div>

                <div class="section-divider"></div>

                <div class="subsection-title">References List</div>

                <asp:Repeater ID="rptReferences" runat="server" OnItemCommand="rptReferences_ItemCommand">
                    <HeaderTemplate>
                        <div class="reference-list">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <div class="reference-card">
                            <div class="ref-card-header">
                                <div class="ref-title">
                                    <span class="ref-number"><%# Container.ItemIndex + 1 %></span>
                                    Reference
                                </div>
                                <div class="ref-card-actions">
                                    <asp:LinkButton ID="btnEdit" runat="server"
                                        CssClass="btn-edit"
                                        CommandName="EditReference"
                                        CommandArgument='<%# Container.ItemIndex %>'
                                        CausesValidation="false">
                                        Edit
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server"
                                        CssClass="btn-delete"
                                        CommandName="DeleteReference"
                                        CommandArgument='<%# Container.ItemIndex %>'
                                        CausesValidation="false"
                                        OnClientClick="return confirm('Delete this reference?');">
                                        Delete
                                    </asp:LinkButton>
                                </div>
                            </div>

                            <div class="ref-body">
                                <div class="ref-top">
                                    <div class="ref-name"><%# Eval("ReferenceName") %></div>
                                    <div class="ref-role">
                                        <%# Eval("JobTitle") %> &nbsp;·&nbsp; <%# Eval("Organization") %>
                                    </div>
                                </div>

                                <div class="ref-details">
                                    <div class="ref-detail">
                                        <strong>Relationship</strong>
                                        <%# Eval("Relationship") %>
                                    </div>
                                    <div class="ref-detail">
                                        <strong>Years Known</strong>
                                        <%# Eval("YearsKnown") %>
                                    </div>
                                    <div class="ref-detail">
                                        <strong>Email</strong>
                                        <%# Eval("Email") %>
                                    </div>
                                    <div class="ref-detail">
                                        <strong>Phone</strong>
                                        <%# Eval("Phone") %>
                                    </div>
                                    <div class="ref-detail" style="grid-column: 1 / -1;">
                                        <strong>Address</strong>
                                        <%# Eval("Address") %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                        </div>
                    </FooterTemplate>
                </asp:Repeater>
            </div>

            <div class="save-wrap">
                <asp:Button ID="btnSaveContinue" runat="server" Text="Save and Continue  →"
                    CssClass="btn-save"
                    OnClick="btnSaveContinue_Click"
                    CausesValidation="false" />
            </div>

        </div>
    </form>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const inputs = document.querySelectorAll("input");
            inputs.forEach(function (input) {
                input.addEventListener("keypress", function (e) {
                    if (e.key === "Enter") {
                        e.preventDefault();
                    }
                });
            });
        });

        function validatePhone(input) {
            input.value = input.value.replace(/[^\d+]/g, '');
            if (input.value.indexOf('+') > 0) {
                input.value = input.value.replace(/\+/g, '');
                input.value = '+' + input.value;
            }
            const plusCount = (input.value.match(/\+/g) || []).length;
            if (plusCount > 1) {
                input.value = '+' + input.value.replace(/\+/g, '');
            }
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>