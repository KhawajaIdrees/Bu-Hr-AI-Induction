<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Apply.aspx.cs" Inherits="WebApplication4.Apply" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Apply for Position</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Georgia&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" />

    <style>
        :root {
            --page-bg:#F8F7F3; --card-bg:#FFFFFF;
            --primary-navy:#12304A; --action-blue:#1769A8;
            --action-blue-hover:#125789; --body-text:#334155;
            --muted-text:#718096; --border:#D9E1E8;
            --divider:#E2E6EA; --radius:6px; --radius-lg:8px;
        }
        * { box-sizing: border-box; }
        html, body { margin:0; padding:0; }
        body {
            background: var(--page-bg);
            font-family: 'Inter', -apple-system, sans-serif;
            font-size:14px; color: var(--body-text);
            -webkit-font-smoothing: antialiased;
        }
        .page-wrap { max-width: 1100px; margin: 0 auto; padding: 32px 48px 60px; }
        .page-header { display:flex; align-items:center; gap:14px; margin-bottom:36px; }
        .page-header .logo { height: 56px; width: auto; }
        .page-header .uni-name { font-weight:600; font-size:24px; color:var(--primary-navy); line-height:1.2; }
        .page-header .hr-portal { font-size:14px; color: var(--muted-text); margin-top:2px; }

        .main-heading {
            font-family: Georgia, serif; font-weight:600; font-size:40px;
            color: var(--primary-navy); margin: 0 0 8px 0; letter-spacing:-0.3px;
        }
        .main-subtitle { font-size:16px; color: var(--muted-text); margin: 0 0 32px 0; }

        .card {
            background: var(--card-bg); border: 1px solid var(--border);
            border-radius: var(--radius-lg); padding: 24px 28px;
            margin-bottom: 16px; box-shadow: 0 1px 3px rgba(15,23,42,0.03);
        }

        .job-title { font-family: Georgia, serif; font-weight: 600; font-size: 24px; color: var(--primary-navy); margin: 0 0 18px 0; }

        .detail-grid {
            display: grid; grid-template-columns: repeat(2, 1fr);
            gap: 14px 32px;
        }
        .detail-item { display: flex; flex-direction: column; gap: 3px; }
        .detail-label { font-size: 11px; font-weight: 700; color: var(--muted-text); text-transform: uppercase; letter-spacing: 0.5px; }
        .detail-value { font-size: 14px; color: var(--body-text); font-weight: 500; }

        .badge { display:inline-block; padding: 4px 12px; border-radius: 14px; font-size: 11px; font-weight: 700; letter-spacing: 0.3px; }
        .badge-teaching { background:#DBEAFE; color:#1E40AF; }
        .badge-nonteaching { background:#FEF3C7; color:#92400E; }

        .choice-heading {
            font-family: Georgia, serif; font-weight: 600; font-size: 22px;
            color: var(--primary-navy); margin: 4px 0 20px 0;
        }

        .choice-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }

        .choice-card {
            background: var(--card-bg); border: 2px solid var(--border);
            border-radius: var(--radius-lg); padding: 28px 24px;
            text-align: center; cursor: pointer;
            transition: all .2s ease;
            text-decoration: none; color: inherit;
            display: flex; flex-direction: column; align-items: center; gap: 12px;
        }
        .choice-card:hover {
            border-color: var(--action-blue);
            box-shadow: 0 8px 24px rgba(23,105,168,0.12);
            transform: translateY(-2px);
        }
        .choice-icon {
            width: 60px; height: 60px; border-radius: 50%;
            background: #EFF6FF; color: var(--action-blue);
            display: flex; align-items: center; justify-content: center;
            font-size: 28px;
        }
        .choice-title { font-family: Georgia, serif; font-weight: 600; font-size: 20px; color: var(--primary-navy); }
        .choice-desc { font-size: 13px; color: var(--muted-text); line-height: 1.5; }

        .error-box {
            background: #FEE2E2; border-left: 5px solid #DC2626;
            color: #991B1B; padding: 16px 20px; border-radius: var(--radius);
            font-weight: 500;
        }

        @media (max-width: 800px) {
            .page-wrap { padding: 20px 16px 40px; }
            .main-heading { font-size: 30px; }
            .detail-grid { grid-template-columns: 1fr; gap: 12px; }
            .choice-row { grid-template-columns: 1fr; }
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

            <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="card">
                <div class="error-box">
                    <asp:Label ID="lblError" runat="server"></asp:Label>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlContent" runat="server" Visible="false">

                <h1 class="main-heading">Apply for Position</h1>
                <p class="main-subtitle">Review the job details below, then choose how you'd like to apply.</p>

                <div class="card">
                    <h2 class="job-title">
                        <asp:Label ID="lblJobTitle" runat="server"></asp:Label>
                    </h2>

                    <div class="detail-grid">
                        <div class="detail-item">
                            <span class="detail-label">Reference No</span>
                            <span class="detail-value"><asp:Label ID="lblReferenceNo" runat="server"></asp:Label></span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Job Type</span>
                            <span class="detail-value"><asp:Label ID="lblJobType" runat="server"></asp:Label></span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Campus</span>
                            <span class="detail-value"><asp:Label ID="lblCampus" runat="server"></asp:Label></span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Department</span>
                            <span class="detail-value"><asp:Label ID="lblDepartment" runat="server"></asp:Label></span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Specialization</span>
                            <span class="detail-value"><asp:Label ID="lblSpecialization" runat="server"></asp:Label></span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Deadline</span>
                            <span class="detail-value"><asp:Label ID="lblDeadline" runat="server"></asp:Label></span>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <h2 class="choice-heading">How would you like to apply?</h2>

                    <div class="choice-row">

                        <asp:LinkButton ID="btnApplyManual" runat="server"
                            CssClass="choice-card"
                            OnClick="ApplyManual_Click">
                            <div class="choice-icon"><i class="bi bi-pencil-square"></i></div>
                            <div class="choice-title">Apply Manually</div>
                            <div class="choice-desc">Fill out your profile information step by step through the portal.</div>
                        </asp:LinkButton>

                        <asp:LinkButton ID="btnApplyCV" runat="server"
                            CssClass="choice-card"
                            OnClick="ApplyCV_Click">
                            <div class="choice-icon"><i class="bi bi-file-earmark-person"></i></div>
                            <div class="choice-title">Apply with CV</div>
                            <div class="choice-desc">Use your saved CV from your profile (upload coming soon).</div>
                        </asp:LinkButton>

                    </div>
                </div>

            </asp:Panel>

        </div>
    </form>
</body>
</html>