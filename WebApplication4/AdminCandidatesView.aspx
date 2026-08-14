<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminCandidatesView.aspx.cs" Inherits="WebApplication4.AdminCandidatesView" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Candidate Pipeline</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <style>
        /* ============================================
           GLOBAL
        ============================================ */
        * {
            box-sizing: border-box;
        }
        body {
            background: #f5f7fb;
            font-family: 'Segoe UI', Arial, sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh;
            overflow: hidden;
        }

        /* ============================================
           SIDEBAR
        ============================================ */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            height: 100vh;
            background: #101827;
            color: #fff;
            display: flex;
            flex-direction: column;
            overflow: hidden;
            transition: all .35s ease;
            z-index: 1000;
        }
        .sidebar-header {
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-bottom: 1px solid rgba(255,255,255,.08);
            font-size: 18px;
            font-weight: 700;
        }
        .sidebar-header i {
            margin-right: 10px;
        }
        .sidebar .nav {
            margin-top: 18px;
            padding: 0;
        }
        .sidebar .nav-item {
            margin-bottom: 8px;
        }
        .sidebar .nav-link {
            display: flex;
            align-items: center;
            height: 52px;
            margin: 0 12px;
            padding: 0 16px;
            border-radius: 12px;
            color: #d7dce6;
            text-decoration: none;
            transition: .25s;
            white-space: nowrap;
        }
        .sidebar .nav-link:hover {
            background: #233c87;
            color: #fff;
        }
        .sidebar .nav-link.active {
            background: #3557b7;
            color: #fff;
        }
        .sidebar .nav-link i {
            width: 42px;
            min-width: 42px;
            text-align: center;
            font-size: 20px;
        }
        .logout {
            margin-top: auto;
            padding: 20px 0;
            border-top: 1px solid rgba(255,255,255,.08);
        }

        /* ============================================
           CONTENT
        ============================================ */
        .content {
            margin-left: 250px;
            width: calc(100% - 250px);
            height: 100vh;
            overflow: hidden;
            background: #f5f7fb;
        }

        /* ============================================
           PIPELINE CONTAINER
        ============================================ */
        .pipeline-container {
            display: flex;
            height: 100vh;
            gap: 0;
            overflow: hidden;
        }

        /* ============================================
           LEFT PANEL
        ============================================ */
        .left-panel {
            width: 320px;
            min-width: 320px;
            background: #ffffff;
            border-right: 1px solid #e2e8f0;
            padding: 16px;
            overflow-y: auto;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .left-panel .pipeline-title {
            font-size: 16px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 12px;
        }
        .left-panel .search-box {
            width: 100%;
            padding: 8px 12px 8px 36px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 13px;
            background: #f8fafc url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="%2394a3b8" stroke-width="2"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>') no-repeat 10px center;
            background-size: 14px;
            transition: all 0.2s;
        }
        .left-panel .search-box:focus {
            outline: none;
            border-color: #1a3a7a;
            background-color: #ffffff;
            box-shadow: 0 0 0 3px rgba(26, 58, 122, 0.08);
        }
        .left-panel .tabs {
            display: flex;
            gap: 4px;
            margin: 12px 0;
            flex-wrap: wrap;
        }
        .left-panel .tab-btn {
            padding: 4px 14px;
            border-radius: 16px;
            font-size: 11px;
            font-weight: 600;
            border: 1px solid #e2e8f0;
            background: #ffffff;
            color: #64748b;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-block;
        }
        .left-panel .tab-btn:hover {
            background: #f1f5f9;
        }
        .left-panel .tab-btn.active {
            background: #1a3a7a;
            color: #ffffff;
            border-color: #1a3a7a;
        }

        /* ============================================
           CANDIDATE CARD
        ============================================ */
        .candidate-card {
            cursor: pointer;
            padding: 12px 14px;
            border: 1px solid #e8ecf1;
            border-radius: 10px;
            margin-bottom: 8px;
            transition: all 0.2s ease;
            background: #ffffff;
            display: block;
            text-decoration: none;
            color: inherit;
            width: 100%;
            text-align: left;
        }
        .candidate-card:hover {
            border-color: #1a3a7a;
            box-shadow: 0 2px 8px rgba(26, 58, 122, 0.08);
        }
        .candidate-card.active {
            border-color: #1a3a7a;
            background: #f0f4ff;
            box-shadow: 0 2px 8px rgba(26, 58, 122, 0.1);
        }
        .candidate-card .avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: #1a3a7a;
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 14px;
            flex-shrink: 0;
        }
        .candidate-card .candidate-name {
            font-weight: 600;
            font-size: 14px;
            color: #0f172a;
        }
        .candidate-card .candidate-email {
            font-size: 12px;
            color: #64748b;
        }
        .candidate-card .score-badge {
            background: #eef2f6;
            padding: 2px 10px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 700;
            color: #1e293b;
        }
        .candidate-card .status-badge {
            font-size: 9px;
            font-weight: 700;
            padding: 2px 10px;
            border-radius: 12px;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            display: inline-block;
        }
        .status-pending { background: #fef3c7; color: #92400e; }
        .status-shortlisted { background: #d1fae5; color: #065f46; }
        .status-rejected { background: #fee2e2; color: #991b1b; }
        .status-hired { background: #e0e7ff; color: #3730a3; }

        /* ============================================
           RIGHT PANEL
        ============================================ */
        .right-panel {
            flex: 1;
            background: #f5f7fb;
            padding: 20px;
            overflow-y: auto;
            height: 100%;
        }

        /* ============================================
           DETAIL CARD
        ============================================ */
        .detail-card {
            background: #ffffff;
            border-radius: 12px;
            padding: 24px 28px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.06);
        }

        /* ============================================
           CANDIDATE HEADER
        ============================================ */
        .candidate-header .name {
            font-size: 1.5rem;
            font-weight: 800;
            color: #0f172a;
        }
        .candidate-header .position {
            font-size: 14px;
            font-weight: 500;
            color: #475569;
        }
        .candidate-header .position .permanent {
            color: #2563eb;
            font-weight: 600;
        }
        .candidate-header .info-label {
            font-size: 11px;
            font-weight: 700;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-top: 12px;
            margin-bottom: 2px;
        }
        .candidate-header .info-value {
            font-size: 14px;
            color: #0f172a;
            font-weight: 500;
        }
        .candidate-header .total-score-label {
            font-size: 13px;
            font-weight: 600;
            color: #475569;
        }
        .candidate-header .total-score {
            font-size: 28px;
            font-weight: 700;
            color: #0f172a;
        }

        /* ============================================
           SECTION HEADERS - FONT WEIGHT 800 WITH ICONS
        ============================================ */
        .section-header {
            font-size: 13px;
            font-weight: 800;
            color: #1e293b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 12px;
            border-bottom: 2px solid #eef2f6;
            padding-bottom: 8px;
        }
        .section-header i {
            margin-right: 8px;
            font-size: 14px;
        }

        /* ============================================
           SCORE BOXES - HEADINGS COLORED FONT WEIGHT 800, SCORES BLACK BOLD
        ============================================ */
        .score-box {
            background: #f8fafc;
            border-radius: 10px;
            padding: 14px 16px;
            text-align: center;
            border: 1px solid #eef2f6;
        }
        .score-box .score-label {
            font-size: 12px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .score-box .score-value {
            font-size: 2.25rem;
            font-weight: 900;
            color: #0f172a;
        }
        .score-box .score-max {
            font-size: 13px;
            color: #94a3b8;
            font-weight: 600;
        }

        /* Academic - INDIGO */
        .score-academic .score-label {
            color: #4F46E5;
        }

        /* Experience - GREEN */
        .score-experience .score-label {
            color: #059669;
        }

        /* Publications - ROSE/RED */
        .score-publications .score-label {
            color: #E11D48;
        }

        /* ============================================
           EDUCATION / EXPERIENCE / RESEARCH ITEMS
        ============================================ */
        .edu-item, .exp-item, .pub-item {
            padding: 10px 14px;
            background: #f8fafc;
            border-radius: 8px;
            margin-bottom: 8px;
            border: 1px solid #eef2f6;
        }
        .edu-item .edu-degree {
            font-weight: 700;
            color: #0f172a;
            font-size: 14px;
        }
        .edu-item .edu-institute {
            color: #64748b;
            font-size: 13px;
        }
        .edu-item .edu-year {
            color: #94a3b8;
            font-size: 12px;
        }
        .edu-item .edu-percentage {
            font-size: 11px;
            font-weight: 600;
            color: #0f172a;
            background: #eef2f6;
            padding: 1px 10px;
            border-radius: 10px;
        }
        .exp-item .exp-title {
            font-weight: 700;
            color: #0f172a;
            font-size: 14px;
        }
        .exp-item .exp-org {
            color: #64748b;
            font-size: 13px;
        }
        .exp-item .exp-date {
            color: #94a3b8;
            font-size: 12px;
        }
        .pub-item .pub-title {
            font-weight: 700;
            color: #0f172a;
            font-size: 14px;
        }
        .pub-item .pub-journal {
            color: #64748b;
            font-size: 13px;
        }
        .pub-item .pub-year {
            color: #94a3b8;
            font-size: 12px;
        }
        .pub-item .pub-category {
            display: inline-block;
            background: #e0e7ff;
            color: #3730a3;
            font-size: 10px;
            font-weight: 700;
            padding: 1px 10px;
            border-radius: 10px;
        }

        /* ============================================
           STATUS DROPDOWN
        ============================================ */
        .status-dropdown {
            border-radius: 8px;
            padding: 6px 14px;
            font-size: 13px;
            font-weight: 600;
            border: 1px solid #e2e8f0;
            background: #ffffff;
            min-width: 140px;
        }
        .status-dropdown:focus {
            outline: none;
            border-color: #1a3a7a;
            box-shadow: 0 0 0 3px rgba(26, 58, 122, 0.08);
        }

        /* ============================================
           SELECT PLACEHOLDER
        ============================================ */
        .select-placeholder {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100%;
            flex-direction: column;
            color: #94a3b8;
        }
        .select-placeholder i {
            font-size: 48px;
        }
        .select-placeholder h5 {
            margin-top: 16px;
            color: #64748b;
        }
        .select-placeholder p {
            font-size: 14px;
        }

        /* ============================================
           EMPTY MESSAGE
        ============================================ */
        .empty-message {
            color: #94a3b8;
            font-size: 13px;
            padding: 8px 0;
        }

        /* ============================================
           SCROLLBAR
        ============================================ */
        ::-webkit-scrollbar {
            width: 5px;
        }
        ::-webkit-scrollbar-track {
            background: #f1f4f9;
        }
        ::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 10px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #94a3b8;
        }

        /* ============================================
           RESPONSIVE
        ============================================ */
        @media (max-width: 768px) {
            .sidebar {
                width: 60px;
            }
            .sidebar .nav-link span {
                display: none;
            }
            .sidebar .nav-link i {
                width: 100%;
                min-width: unset;
            }
            .sidebar .sidebar-header {
                font-size: 0;
            }
            .sidebar .sidebar-header i {
                font-size: 20px;
            }
            .content {
                margin-left: 60px;
                width: calc(100% - 60px);
            }
            .left-panel {
                width: 100%;
                min-width: unset;
                border-right: none;
                border-bottom: 1px solid #e2e8f0;
                height: 45vh;
            }
            .right-panel {
                height: 55vh;
                padding: 10px;
            }
            .pipeline-container {
                flex-direction: column;
            }
            .detail-card {
                padding: 16px;
            }
            .candidate-header .name {
                font-size: 1.25rem;
            }
            .score-box .score-value {
                font-size: 1.75rem;
            }
            .candidate-header .total-score {
                font-size: 22px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <!-- ==========================================
        SIDEBAR (ASIDE)
        ========================================== -->
        <div class="sidebar">
            <div class="sidebar-header">
                <i class="bi bi-building"></i> <span>Faculty ATS</span>
            </div>

            <ul class="nav flex-column">
                <li class="nav-item">
                    <a href="AdminDashboard.aspx" class="nav-link">
                        <i class="bi bi-grid-fill"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="AdminCandidatesView.aspx" class="nav-link active">
                        <i class="bi bi-people-fill"></i>
                        <span>Candidates</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="Settings.aspx" class="nav-link">
                        <i class="bi bi-gear-fill"></i>
                        <span>Settings</span>
                    </a>
                </li>
            </ul>

            <div class="logout">
                <a href="Logout.aspx" class="nav-link">
                    <i class="bi bi-box-arrow-right"></i>
                    <span>Logout</span>
                </a>
            </div>
        </div>

        <!-- ==========================================
        CONTENT
        ========================================== -->
        <div class="content">
            <div class="pipeline-container">

                <!-- ==========================================
                LEFT PANEL
                ========================================== -->
                <div class="left-panel">
                    <div class="pipeline-title">Candidate Pipeline</div>

                    <!-- Search -->
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="search-box" 
                        placeholder="Search candidates..." 
                        AutoPostBack="true" 
                        OnTextChanged="txtSearch_TextChanged" />

                    <!-- Tabs -->
                    <div class="tabs">
                        <asp:LinkButton ID="btnAll" runat="server" CssClass="tab-btn active" 
                            OnClick="btnTab_Click" CommandArgument="all">All</asp:LinkButton>
                        <asp:LinkButton ID="btnPending" runat="server" CssClass="tab-btn" 
                            OnClick="btnTab_Click" CommandArgument="pending">Pending Review</asp:LinkButton>
                        <asp:LinkButton ID="btnShortlisted" runat="server" CssClass="tab-btn" 
                            OnClick="btnTab_Click" CommandArgument="shortlisted">Shortlisted</asp:LinkButton>
                        <asp:LinkButton ID="btnRejected" runat="server" CssClass="tab-btn" 
                            OnClick="btnTab_Click" CommandArgument="rejected">Rejected</asp:LinkButton>
                        <asp:LinkButton ID="btnHired" runat="server" CssClass="tab-btn" 
                            OnClick="btnTab_Click" CommandArgument="hired">Hired</asp:LinkButton>
                    </div>

                    <!-- Candidate List -->
                    <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
                        <div class="text-center py-4">
                            <p class="text-muted small">No candidates found</p>
                        </div>
                    </asp:Panel>

                    <div style="flex: 1; overflow-y: auto;">
                        <asp:Repeater ID="rptCandidates" runat="server" OnItemDataBound="rptCandidates_ItemDataBound">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnCandidate" runat="server" 
                                    CssClass="candidate-card w-100 text-start text-decoration-none d-block"
                                    OnClick="btnCandidate_Click"
                                    CommandArgument='<%# Eval("Id") %>'>
                                    <div class="d-flex align-items-center gap-3">
                                        <div class="avatar"><%# Eval("Initials") %></div>
                                        <div class="flex-grow-1" style="min-width:0;">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <span class="candidate-name"><%# Eval("FullName") %></span>
                                                <span class="score-badge"><%# Eval("TotalScore", "{0:F1}") %></span>
                                            </div>
                                            <div class="candidate-email"><%# Eval("Email") %></div>
                                            <div class="mt-1">
                                                <span class='status-badge status-<%# Eval("StatusClass") %>'><%# Eval("Status") %></span>
                                            </div>
                                        </div>
                                    </div>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>

                <!-- ==========================================
                RIGHT PANEL
                ========================================== -->
                <div class="right-panel">
                    <!-- Details View -->
                    <asp:Panel ID="pnlDetails" runat="server" Visible="false">
                        <div class="detail-card">

                            <!-- ==========================================
                            CANDIDATE HEADER
                            ========================================== -->
                            <div class="candidate-header">
                                <div class="d-flex justify-content-between align-items-start flex-wrap gap-3">
                                    <div>
                                        <div class="name"><asp:Label ID="lblFullName" runat="server" /></div>

                                        <div class="position">
                                            <asp:Label ID="lblPosition" runat="server" Text="Lecturer" />
                                            <span class="permanent">PERMANENT</span>
                                        </div>

                                        <div class="info-label">EMAIL ADDRESS</div>
                                        <div class="info-value"><asp:Label ID="lblEmail" runat="server" /></div>

                                        <div class="info-label">PHONE</div>
                                        <div class="info-value"><asp:Label ID="lblPhone" runat="server" Text="Not provided" /></div>

                                        <div class="info-label">APPLIED ON</div>
                                        <div class="info-value"><asp:Label ID="lblSubmittedDate" runat="server" /></div>
                                    </div>

                                    <div class="text-end">
                                        <div class="total-score-label">Score Evaluation</div>
                                        <div class="total-score"><asp:Label ID="lblTotal" runat="server" /> <span style="font-size:16px; font-weight:600; color:#94a3b8;">/ 100 PTS</span></div>
                                        <div class="mt-2">
                                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="status-dropdown" 
                                                AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                                                <asp:ListItem Value="Pending">Pending Review</asp:ListItem>
                                                <asp:ListItem Value="Shortlisted">Shortlisted</asp:ListItem>
                                                <asp:ListItem Value="Rejected">Rejected</asp:ListItem>
                                                <asp:ListItem Value="Hired">Hired</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <hr class="my-4" />

                            <!-- ==========================================
                            SCORE EVALUATION
                            ========================================== -->
                            <div class="row g-3 mb-4">
                                <div class="col-md-4">
                                    <div class="score-box score-academic">
                                        <div class="score-label">Academics</div>
                                        <div class="score-value"><asp:Label ID="lblAcademic" runat="server" /></div>
                                        <div class="score-max">/ 50</div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="score-box score-experience">
                                        <div class="score-label">Experience</div>
                                        <div class="score-value"><asp:Label ID="lblExperience" runat="server" /></div>
                                        <div class="score-max">/ 25</div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="score-box score-publications">
                                        <div class="score-label">Publications</div>
                                        <div class="score-value"><asp:Label ID="lblResearch" runat="server" /></div>
                                        <div class="score-max">/ 25</div>
                                    </div>
                                </div>
                            </div>

                            <!-- ==========================================
                            EDUCATION HISTORY - SSC & HSSC ONLY
                            ========================================== -->
                            <h6 class="section-header"><i class="bi bi-mortarboard"></i> Education History</h6>
                            <asp:Repeater ID="rptEducation" runat="server">
                                <ItemTemplate>
                                    <div class="edu-item">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div class="edu-degree"><%# Eval("Degree") %></div>
                                            <span class="edu-percentage"><%# Eval("Percentage", "{0:F1}") %>%</span>
                                        </div>
                                        <div class="edu-institute"><%# Eval("Institute") %></div>
                                        <div class="edu-year">
                                            <%# Eval("StatusText") %>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:Panel ID="pnlNoEducation" runat="server" Visible="false">
                                <p class="empty-message">No education records found.</p>
                            </asp:Panel>

                            <!-- ==========================================
                            EXPERIENCE DETAILS
                            ========================================== -->
                            <h6 class="section-header mt-4"><i class="bi bi-briefcase"></i> Experience Details</h6>
                            <asp:Repeater ID="rptExperience" runat="server">
                                <ItemTemplate>
                                    <div class="exp-item">
                                        <div class="exp-title"><%# Eval("Position") %></div>
                                        <div class="exp-org"><%# Eval("Organization") %></div>
                                        <div class="exp-date"><i class="bi bi-calendar3 me-1"></i> <%# Eval("StartDate", "{0:MMM yyyy}") %> → <%# Eval("EndDate", "{0:MMM yyyy}") %></div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:Panel ID="pnlNoExperience" runat="server" Visible="false">
                                <p class="empty-message">No experience records found.</p>
                            </asp:Panel>

                            <!-- ==========================================
                            RESEARCH PAPERS
                            ========================================== -->
                            <h6 class="section-header mt-4"><i class="bi bi-file-text"></i> Research Papers</h6>
                            <asp:Repeater ID="rptPublications" runat="server">
                                <ItemTemplate>
                                    <div class="pub-item">
                                        <div class="pub-title"><%# Eval("Title") %></div>
                                        <div class="pub-journal">Published in: <%# Eval("JournalName") %></div>
                                        <div class="d-flex justify-content-between align-items-center mt-1">
                                            <span class="pub-year"><%# Eval("Year") %></span>
                                            <span class="pub-category">Type: <%# Eval("Category") %></span>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:Panel ID="pnlNoPublications" runat="server" Visible="false">
                                <p class="empty-message">No research papers found.</p>
                            </asp:Panel>

                        </div>
                    </asp:Panel>

                    <!-- Select Candidate Placeholder -->
                    <asp:Panel ID="pnlSelect" runat="server" Visible="true">
                        <div class="select-placeholder">
                            <i class="bi bi-search"></i>
                            <h5>Select a Candidate</h5>
                            <p>Choose a candidate from the left panel to view details</p>
                        </div>
                    </asp:Panel>
                </div>

            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>