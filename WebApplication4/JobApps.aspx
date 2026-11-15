<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="JobApps.aspx.cs" Inherits="WebApplication4.JobApps" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Open Positions</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Georgia&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" />

    <style>
        :root {
            --page-bg: #F8F7F3;
            --card-bg: #FFFFFF;
            --primary-navy: #12304A;
            --action-blue: #1769A8;
            --action-blue-hover: #125789;
            --body-text: #334155;
            --muted-text: #718096;
            --border: #D9E1E8;
            --divider: #E2E6EA;
            --error-red: #DC3B3B;
            --success-green: #16A34A;
            --radius: 6px;
            --radius-lg: 8px;
        }
        * { box-sizing: border-box; }
        html, body { margin: 0; padding: 0; }
        body {
            background: var(--page-bg);
            font-family: 'Inter', -apple-system, sans-serif;
            font-size: 14px;
            color: var(--body-text);
            -webkit-font-smoothing: antialiased;
        }
        .page-wrap { max-width: 1440px; margin: 0 auto; padding: 32px 48px 60px; }

        .page-header { display:flex; align-items:center; gap:14px; margin-bottom:36px; }
        .page-header .logo { height: 56px; width: auto; }
        .page-header .uni-name { font-weight: 600; font-size: 24px; color: var(--primary-navy); line-height: 1.2; }
        .page-header .hr-portal { font-weight: 400; font-size: 14px; color: var(--muted-text); margin-top: 2px; }

        .main-heading {
            font-family: Georgia, serif;
            font-weight: 600; font-size: 42px;
            color: var(--primary-navy);
            margin: 0 0 8px 0;
            letter-spacing: -0.3px;
        }
        .main-subtitle { font-size: 16px; color: var(--muted-text); margin: 0 0 32px 0; }

        .section-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 22px 26px;
            margin-bottom: 16px;
            box-shadow: 0 1px 3px rgba(15,23,42,0.03);
        }

        .table-responsive-wrap { overflow-x: auto; }
        .table { width:100%; border-collapse: collapse; font-family: 'Inter', sans-serif; }
        .table th {
            background: #F8FAFC;
            color: var(--muted-text);
            font-weight: 700; font-size: 11px;
            text-transform: uppercase; letter-spacing: .5px;
            border-bottom: 1px solid var(--border);
            text-align: left; padding: 12px 14px;
            white-space: nowrap;
        }
        .table td {
            font-size: 13px; color: var(--body-text);
            padding: 14px;
            border-bottom: 1px solid #F1F4F9;
            vertical-align: middle;
        }
        .table-hover tbody tr:hover { background: #F8FAFC; }
        .empty-row { text-align:center; color:#94A3B8; padding: 40px 0; }

        .btn-apply {
            display: inline-flex; align-items: center; gap:6px;
            background: var(--action-blue); color:#FFF;
            border: none; border-radius: var(--radius);
            height: 36px; padding: 0 18px;
            font-weight: 600; font-size: 13px;
            cursor: pointer; text-decoration: none;
            transition: background .15s ease;
        }
        .btn-apply:hover { background: var(--action-blue-hover); }

        .btn-applied {
            display: inline-flex; align-items: center; gap:6px;
            background: #E5E7EB; color:#6B7280;
            border: none; border-radius: var(--radius);
            height: 36px; padding: 0 18px;
            font-weight: 600; font-size: 13px;
            cursor: not-allowed;
        }

        .badge {
            display: inline-block; padding: 3px 10px;
            border-radius: 12px; font-size: 11px;
            font-weight: 600; letter-spacing: 0.3px;
        }
        .badge-teaching { background: #DBEAFE; color: #1E40AF; }
        .badge-nonteaching { background: #FEF3C7; color: #92400E; }
        .badge-open { background: #DCFCE7; color: #166534; }

        @media (max-width: 640px) {
            .page-wrap { padding: 20px 16px 40px; }
            .main-heading { font-size: 30px; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-wrap">

            <div class="page-header">
                <img src="Images/bu_logo.png" alt="Bahria University" class="logo" />
                <div>
                    <div class="uni-name">Bahria University</div>
                    <div class="hr-portal">HR Portal</div>
                </div>
            </div>

            <h1 class="main-heading">Open Positions</h1>
            <p class="main-subtitle">Browse and apply for currently open job postings.</p>

            <div class="section-card">
                <div class="table-responsive-wrap">
                    <asp:GridView ID="gvJobs" runat="server"
                        AutoGenerateColumns="false"
                        CssClass="table table-hover"
                        GridLines="None"
                        EmptyDataText="No open positions at the moment."
                        EmptyDataRowStyle-CssClass="empty-row"
                        OnRowCommand="gvJobs_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="JobTitle" HeaderText="Job Title" />
                            <asp:BoundField DataField="ReferenceNo" HeaderText="Reference #" />
                            <asp:BoundField DataField="Campus" HeaderText="Campus" />
                            <asp:BoundField DataField="Department" HeaderText="Department" />
                            <asp:BoundField DataField="Specialization" HeaderText="Specialization" />
                            <asp:TemplateField HeaderText="Type">
                                <ItemTemplate>
                                    <span class='<%# Eval("JobType").ToString() == "Teaching" ? "badge badge-teaching" : "badge badge-nonteaching" %>'>
                                        <%# Eval("JobType") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="DeadlineDate" HeaderText="Deadline" DataFormatString="{0:MMM dd, yyyy}" />
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:PlaceHolder ID="phApply" runat="server" Visible='<%# !(bool)Eval("HasApplied") %>'>
                                        <asp:LinkButton ID="btnApply" runat="server"
                                            CssClass="btn-apply"
                                            CommandName="ApplyJob"
                                            CommandArgument='<%# Eval("JobPostingID") %>'
                                            Text="Apply →" />
                                    </asp:PlaceHolder>
                                    <asp:PlaceHolder ID="phApplied" runat="server" Visible='<%# (bool)Eval("HasApplied") %>'>
                                        <span class="btn-applied"><i class="bi bi-check2-circle"></i> Already Applied</span>
                                    </asp:PlaceHolder>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

        </div>
    </form>
</body>
</html>