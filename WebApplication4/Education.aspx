<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Education.aspx.cs" Inherits="WebApplication4.candDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Educational Information</title>

    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Georgia&display=swap" rel="stylesheet"/>
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
            margin-bottom: 18px;
            flex-wrap: wrap;
        }

        .section-heading h3 {
            font-family: var(--font-heading);
            font-weight: 700;
            font-size: 22px;
            color: var(--primary-navy);
            margin: 0;
            white-space: normal;
            word-break: break-word;
            line-height: 1.3;
            letter-spacing: -0.2px;
            flex: 0 1 auto;
        }

        .section-heading .divider-line {
            flex: 1 1 40px;
            height: 1px;
            background: var(--divider);
            min-width: 20px;
        }

        .info-text {
            font-family: var(--font-ui);
            font-size: 13px;
            color: var(--muted-text);
            margin: 0 0 18px 0;
        }

        .table-responsive {
            overflow-x: auto;
            border-radius: var(--radius);
            border: 1px solid var(--border);
        }

        .table-responsive::-webkit-scrollbar { height: 8px; }
        .table-responsive::-webkit-scrollbar-track { background: #F0F2F5; border-radius: 10px; }
        .table-responsive::-webkit-scrollbar-thumb { background: var(--action-blue); border-radius: 10px; }

        .edu-table,
        .other-table {
            width: 100%;
            border-collapse: collapse;
            font-family: var(--font-ui);
            margin: 0;
            table-layout: fixed;
        }

        .edu-table th,
        .other-table th {
            background: #F8FAFC !important;
            color: var(--muted-text) !important;
            font-weight: 700 !important;
            font-size: 11px !important;
            text-transform: uppercase !important;
            letter-spacing: .5px !important;
            border-bottom: 1px solid var(--border) !important;
            text-align: center !important;
            vertical-align: middle !important;
            padding: 12px 8px !important;
            white-space: normal;
            word-break: break-word;
            line-height: 1.3;
        }

        .edu-table td,
        .other-table td {
            vertical-align: middle !important;
            text-align: center !important;
            padding: 10px 6px !important;
            border-bottom: 1px solid #F1F4F9 !important;
            font-size: 13px !important;
            color: var(--body-text) !important;
        }

        .edu-table td:first-child,
        .other-table td:first-child {
            font-weight: 600;
            color: var(--primary-navy);
            background: #FAFBFD;
            text-align: left !important;
            padding-left: 14px !important;
            white-space: normal;
            word-break: break-word;
            line-height: 1.3;
        }

        .edu-table tbody tr:hover,
        .other-table tbody tr:hover {
            background-color: #F8FAFC;
        }

        .edu-table input,
        .edu-table select,
        .other-table input {
            width: 100%;
            background: var(--input-bg);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            height: 40px;
            font-family: var(--font-ui);
            font-size: 13px;
            color: var(--body-text);
            padding: 0 10px;
            transition: border-color 0.15s ease, box-shadow 0.15s ease;
            min-width: 0;
        }

        .edu-table input:focus,
        .edu-table select:focus,
        .other-table input:focus {
            outline: none;
            border-color: var(--action-blue);
            box-shadow: 0 0 0 2px rgba(23, 105, 168, 0.08);
        }

        .edu-table input::placeholder,
        .other-table input::placeholder {
            color: var(--placeholder);
            font-weight: 400;
        }

        /* ===== VALIDATION STATES ===== */
        .edu-table input.is-invalid,
        .edu-table select.is-invalid,
        .other-table input.is-invalid,
        .other-table select.is-invalid {
            border-color: var(--error-red) !important;
            background: #FEF2F2 !important;
            box-shadow: 0 0 0 2px rgba(220, 59, 59, 0.10) !important;
        }

        .field-error {
            display: none;
            color: var(--error-red);
            font-size: 11px;
            font-weight: 500;
            margin-top: 4px;
            line-height: 1.3;
            text-align: left;
        }

        .field-error.show { display: block; }

        .input-cell {
            display: flex;
            flex-direction: column;
            gap: 4px;
            text-align: left;
        }

        .degree-label {
            display: flex;
            align-items: center;
            gap: 6px;
            flex-wrap: nowrap;
        }

        .degree-label .required-star {
            color: var(--error-red);
            font-weight: 700;
            font-size: 14px;
            flex-shrink: 0;
        }

        .degree-label select {
            border: none !important;
            background: transparent !important;
            font-weight: 700;
            font-size: 13px;
            color: var(--primary-navy);
            padding: 0 !important;
            width: auto;
            cursor: pointer;
            box-shadow: none !important;
            height: auto !important;
        }

        .degree-label select:focus { outline: none; box-shadow: none !important; }

        .btn-add {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: var(--action-blue);
            color: #FFFFFF;
            border: none;
            border-radius: var(--radius);
            height: 42px;
            padding: 0 22px;
            font-family: var(--font-ui);
            font-weight: 600;
            font-size: 14px;
            letter-spacing: 0.2px;
            cursor: pointer;
            transition: background 0.15s ease;
            margin-top: 16px;
        }

        .btn-add:hover { background: var(--action-blue-hover); }

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

        .save-wrap {
            display: flex;
            justify-content: flex-end;
            margin-top: 32px;
            padding-top: 4px;
        }

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

        .required-star {
            color: var(--error-red);
            font-weight: 700;
            font-size: 14px;
            margin-right: 4px;
        }

        .text-danger {
            color: var(--error-red) !important;
            font-size: 13px;
            font-weight: 500;
            margin-top: 14px;
            display: block;
            font-family: var(--font-ui);
        }

        /* ============ MOBILE-ONLY ROW TOGGLE ============ */
        .row-toggle {
            display: none;
            align-items: center;
            justify-content: center;
            width: 26px;
            height: 26px;
            border-radius: 50%;
            background: #E7EFF6;
            color: var(--action-blue);
            font-size: 12px;
            flex-shrink: 0;
            transition: transform 0.25s ease, background 0.15s ease;
            border: none;
            cursor: pointer;
            margin-left: auto;
        }

        .row-toggle:focus-visible {
            outline: 2px solid var(--action-blue);
            outline-offset: 2px;
        }

        /* ============ COLUMN WIDTHS (DESKTOP) ============ */
        .edu-table .col-degree    { width: 150px; }
        .edu-table .col-regno     { width: 150px; }
        .edu-table .col-duration  { width: 100px; }
        .edu-table .col-spec      { width: 140px; }
        .edu-table .col-year      { width: 80px; }
        .edu-table .col-perc      { width: 100px; }
        .edu-table .col-inst      { width: 170px; }
        .edu-table .col-country   { width: 120px; }

        /* ============ TABLET (≤900px) ============ */
        @media (max-width: 900px) {
            .page-wrap { padding: 24px 24px 40px; }

            .section-card { padding: 18px 18px; }
            .section-heading h3 { font-size: 20px; }

            .edu-table input,
            .edu-table select,
            .other-table input {
                font-size: 12px;
                padding: 0 8px;
                height: 38px;
            }

            .edu-table th,
            .other-table th {
                font-size: 10px !important;
                padding: 10px 6px !important;
            }

            .edu-table td,
            .other-table td {
                padding: 8px 5px !important;
                font-size: 12px !important;
            }

            .edu-table td:first-child,
            .other-table td:first-child {
                padding-left: 10px !important;
                font-size: 12px !important;
            }

            .degree-label select { font-size: 12px; }

            .row-toggle { display: inline-flex; }

            .edu-table, .other-table { table-layout: auto; }
            .edu-table thead, .other-table thead { display: none; }

            .edu-table, .edu-table tbody, .edu-table tr, .edu-table td,
            .other-table, .other-table tbody, .other-table tr, .other-table td {
                display: block;
                width: 100%;
            }

            .edu-table tr, .other-table tr {
                border: 1px solid var(--border);
                border-radius: var(--radius);
                margin-bottom: 14px;
                padding: 10px 12px;
                background: #FFFFFF;
                position: relative;
            }

            .edu-table tr.row-collapsed td:not(.cell-head),
            .other-table tr.row-collapsed td:not(.cell-head) {
                display: none;
            }

            .edu-table td, .other-table td {
                border: none !important;
                padding: 6px 0 !important;
                text-align: left !important;
                display: grid;
                grid-template-columns: 130px 1fr;
                align-items: center;
                gap: 10px;
                background: transparent !important;
            }

            .edu-table td:first-child, .other-table td:first-child {
                background: transparent !important;
                padding-left: 0 !important;
                border-bottom: 1px solid #F1F4F9 !important;
                font-size: 14px !important;
                padding-bottom: 8px !important;
                margin-bottom: 4px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                gap: 8px;
            }

            .edu-table td[data-label]::before,
            .other-table td[data-label]::before {
                content: attr(data-label);
                font-size: 11px;
                font-weight: 700;
                color: var(--muted-text);
                text-transform: uppercase;
                letter-spacing: .5px;
            }

            .edu-table td:first-child::before,
            .other-table td:first-child::before { content: none; }

            .table-responsive { border: none; overflow: visible; }
        }

        @media (max-width: 640px) {
            .page-wrap { padding: 20px 16px 40px; }
            .main-heading { font-size: 30px; }
            .section-card { padding: 16px 14px; }

            .section-heading {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .section-heading h3 {
                font-size: 18px;
                line-height: 1.35;
                width: 100%;
            }

            .section-heading .divider-line {
                flex: 0 0 100%;
                width: 100%;
            }

            .btn-save { width: 100%; justify-content: center; }
            .save-wrap { justify-content: stretch; }
            .btn-add { width: 100%; justify-content: center; }

            .edu-table td, .other-table td {
                grid-template-columns: 115px 1fr;
                font-size: 12px !important;
            }
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

            <h1 class="main-heading">Educational Information</h1>
            <p class="main-subtitle">Provide your academic qualifications.</p>

            <!-- ============================================================
                 ACADEMIC QUALIFICATIONS
                 ============================================================ -->
            <div class="section-card">
                <div class="section-heading">
                    <h3>Academic Qualifications</h3>
                    <span class="divider-line"></span>
                </div>

                <div class="table-responsive">
                    <table class="edu-table" id="eduTable">
                        <thead>
                            <tr>
                                <th class="col-degree">Certificate / Degree</th>
                                <th class="col-regno">Registration No.</th>
                                <th class="col-duration">Duration</th>
                                <th class="col-spec">Specialization</th>
                                <th class="col-year">Year</th>
                                <th class="col-perc">Percentage</th>
                                <th class="col-inst">Institute</th>
                                <th class="col-country">Country</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- SSC -->
                            <tr id="row_ssc" data-degree="ssc" data-required="always">
                                <td class="cell-head" data-label="Degree">
                                    <span><span class="required-star">*</span> SSC/O'Level</span>
                                    <button type="button" class="row-toggle" aria-expanded="true"
                                            aria-controls="row_ssc" onclick="toggleRow('row_ssc')">
                                        <i class="bi bi-chevron-down"></i>
                                    </button>
                                </td>
                                <td data-label="Registration No.">
                                    <div class="input-cell">
                                        <input type="text" id="ssc_regno" runat="server" class="form-control" placeholder="e.g. 12345-2020" data-req="ssc" />
                                        <span class="field-error" data-for="ssc">Required</span>
                                    </div>
                                </td>
                                <td data-label="Duration">
                                    <div class="input-cell">
                                        <input type="text" id="ssc_duration" runat="server" class="form-control" data-req="ssc" />
                                        <span class="field-error" data-for="ssc">Required</span>
                                    </div>
                                </td>
                                <td data-label="Specialization">
                                    <div class="input-cell">
                                        <input type="text" id="ssc_specialization" runat="server" class="form-control" data-req="ssc" />
                                        <span class="field-error" data-for="ssc">Required</span>
                                    </div>
                                </td>
                                <td data-label="Year">
                                    <div class="input-cell">
                                        <input type="number" id="ssc_year" runat="server" class="form-control" data-req="ssc" />
                                        <span class="field-error" data-for="ssc">Required</span>
                                    </div>
                                </td>
                                <td data-label="Percentage">
                                    <div class="input-cell">
                                        <input type="number" id="sscper" runat="server" class="form-control" step="any" data-req="ssc" />
                                        <span class="field-error" data-for="ssc">Required</span>
                                    </div>
                                </td>
                                <td data-label="Institute">
                                    <div class="input-cell">
                                        <input type="text" id="ssc_uni" runat="server" class="form-control" data-req="ssc" />
                                        <span class="field-error" data-for="ssc">Required</span>
                                    </div>
                                </td>
                                <td data-label="Country">
                                    <div class="input-cell">
                                        <input type="text" id="ssc_country" runat="server" class="form-control" data-req="ssc" />
                                        <span class="field-error" data-for="ssc">Required</span>
                                    </div>
                                </td>
                            </tr>

                            <!-- HSSC -->
                            <tr id="row_hssc" data-degree="hssc" data-required="always">
                                <td class="cell-head" data-label="Degree">
                                    <span><span class="required-star">*</span> HSSC/A'Level</span>
                                    <button type="button" class="row-toggle" aria-expanded="true"
                                            aria-controls="row_hssc" onclick="toggleRow('row_hssc')">
                                        <i class="bi bi-chevron-down"></i>
                                    </button>
                                </td>
                                <td data-label="Registration No.">
                                    <div class="input-cell">
                                        <input type="text" id="hssc_regno" runat="server" class="form-control" placeholder="e.g. 12345-2020" data-req="hssc" />
                                        <span class="field-error" data-for="hssc">Required</span>
                                    </div>
                                </td>
                                <td data-label="Duration">
                                    <div class="input-cell">
                                        <input type="text" id="hssc_duration" runat="server" class="form-control" data-req="hssc" />
                                        <span class="field-error" data-for="hssc">Required</span>
                                    </div>
                                </td>
                                <td data-label="Specialization">
                                    <div class="input-cell">
                                        <input type="text" id="hssc_specialization" runat="server" class="form-control" data-req="hssc" />
                                        <span class="field-error" data-for="hssc">Required</span>
                                    </div>
                                </td>
                                <td data-label="Year">
                                    <div class="input-cell">
                                        <input type="number" id="hssc_year" runat="server" class="form-control" data-req="hssc" />
                                        <span class="field-error" data-for="hssc">Required</span>
                                    </div>
                                </td>
                                <td data-label="Percentage">
                                    <div class="input-cell">
                                        <input type="number" id="hsscper" runat="server" class="form-control" step="any" data-req="hssc" />
                                        <span class="field-error" data-for="hssc">Required</span>
                                    </div>
                                </td>
                                <td data-label="Institute">
                                    <div class="input-cell">
                                        <input type="text" id="hssc_uni" runat="server" class="form-control" data-req="hssc" />
                                        <span class="field-error" data-for="hssc">Required</span>
                                    </div>
                                </td>
                                <td data-label="Country">
                                    <div class="input-cell">
                                        <input type="text" id="hssc_country" runat="server" class="form-control" data-req="hssc" />
                                        <span class="field-error" data-for="hssc">Required</span>
                                    </div>
                                </td>
                            </tr>

                            <!-- BS -->
                            <tr id="row_bs" data-degree="bs" data-required="always">
                                <td class="cell-head" data-label="Degree">
                                    <div class="degree-label">
                                        <span class="required-star">*</span>
                                        <select id="bs_type" runat="server" data-req="bs">
                                            <option value="">-- Select Type --</option>
                                            <option value="BS - 16 Years">BS - 16 Years</option>
                                            <option value="BSc - 14 Years">BSc - 14 Years</option>
                                        </select>
                                    </div>
                                    <button type="button" class="row-toggle" aria-expanded="true"
                                            aria-controls="row_bs" onclick="toggleRow('row_bs')">
                                        <i class="bi bi-chevron-down"></i>
                                    </button>
                                </td>
                                <td data-label="Registration No.">
                                    <div class="input-cell">
                                        <input type="text" id="bs_regno" runat="server" class="form-control" placeholder="e.g. 12345-2020" data-req="bs" />
                                        <span class="field-error" data-for="bs">Required</span>
                                    </div>
                                </td>
                                <td data-label="Duration">
                                    <div class="input-cell">
                                        <input type="text" id="bs_duration" runat="server" class="form-control" data-req="bs" />
                                        <span class="field-error" data-for="bs">Required</span>
                                    </div>
                                </td>
                                <td data-label="Specialization">
                                    <div class="input-cell">
                                        <input type="text" id="bs_specialization" runat="server" class="form-control" data-req="bs" />
                                        <span class="field-error" data-for="bs">Required</span>
                                    </div>
                                </td>
                                <td data-label="Year">
                                    <div class="input-cell">
                                        <input type="number" id="bs_year" runat="server" class="form-control" data-req="bs" />
                                        <span class="field-error" data-for="bs">Required</span>
                                    </div>
                                </td>
                                <td data-label="Percentage">
                                    <div class="input-cell">
                                        <input type="number" id="bs_cgpa" runat="server" class="form-control" step="any" data-req="bs" />
                                        <span class="field-error" data-for="bs">Required</span>
                                    </div>
                                </td>
                                <td data-label="Institute">
                                    <div class="input-cell">
                                        <input type="text" id="bs_uni" runat="server" class="form-control" data-req="bs" />
                                        <span class="field-error" data-for="bs">Required</span>
                                    </div>
                                </td>
                                <td data-label="Country">
                                    <div class="input-cell">
                                        <input type="text" id="bs_country" runat="server" class="form-control" data-req="bs" />
                                        <span class="field-error" data-for="bs">Required</span>
                                    </div>
                                </td>
                            </tr>

                            <!-- MS -->
                            <tr id="row_ms" data-degree="ms" data-required="conditional">
                                <td class="cell-head" data-label="Degree">
                                    <span>Masters / MPhil</span>
                                    <button type="button" class="row-toggle" aria-expanded="true"
                                            aria-controls="row_ms" onclick="toggleRow('row_ms')">
                                        <i class="bi bi-chevron-down"></i>
                                    </button>
                                </td>
                                <td data-label="Registration No.">
                                    <div class="input-cell">
                                        <input type="text" id="ms_regno" runat="server" class="form-control" placeholder="e.g. 12345-2020" data-req="ms" data-cond="ms" />
                                        <span class="field-error" data-for="ms">Required</span>
                                    </div>
                                </td>
                                <td data-label="Duration">
                                    <div class="input-cell">
                                        <input type="text" id="ms_duration" runat="server" class="form-control" data-req="ms" data-cond="ms" />
                                        <span class="field-error" data-for="ms">Required</span>
                                    </div>
                                </td>
                                <td data-label="Specialization">
                                    <div class="input-cell">
                                        <input type="text" id="ms_specialization" runat="server" class="form-control" data-req="ms" data-cond="ms" />
                                        <span class="field-error" data-for="ms">Required</span>
                                    </div>
                                </td>
                                <td data-label="Year">
                                    <div class="input-cell">
                                        <input type="number" id="ms_year" runat="server" class="form-control" data-req="ms" data-cond="ms" />
                                        <span class="field-error" data-for="ms">Required</span>
                                    </div>
                                </td>
                                <td data-label="Percentage">
                                    <div class="input-cell">
                                        <input type="number" id="ms_cgpa" runat="server" class="form-control" step="any" data-req="ms" data-cond="ms" />
                                        <span class="field-error" data-for="ms">Required</span>
                                    </div>
                                </td>
                                <td data-label="Institute">
                                    <div class="input-cell">
                                        <input type="text" id="ms_uni" runat="server" class="form-control" data-req="ms" data-cond="ms" />
                                        <span class="field-error" data-for="ms">Required</span>
                                    </div>
                                </td>
                                <td data-label="Country">
                                    <div class="input-cell">
                                        <input type="text" id="ms_country" runat="server" class="form-control" data-req="ms" data-cond="ms" />
                                        <span class="field-error" data-for="ms">Required</span>
                                    </div>
                                </td>
                            </tr>

                            <!-- PhD -->
                            <tr id="row_phd" data-degree="phd" data-required="conditional">
                                <td class="cell-head" data-label="Degree">
                                    <span>PhD</span>
                                    <button type="button" class="row-toggle" aria-expanded="true"
                                            aria-controls="row_phd" onclick="toggleRow('row_phd')">
                                        <i class="bi bi-chevron-down"></i>
                                    </button>
                                </td>
                                <td data-label="Registration No.">
                                    <div class="input-cell">
                                        <input type="text" id="phd_regno" runat="server" class="form-control" placeholder="e.g. 12345-2020" data-req="phd" data-cond="phd" />
                                        <span class="field-error" data-for="phd">Required</span>
                                    </div>
                                </td>
                                <td data-label="Duration">
                                    <div class="input-cell">
                                        <input type="text" id="phd_duration" runat="server" class="form-control" data-req="phd" data-cond="phd" />
                                        <span class="field-error" data-for="phd">Required</span>
                                    </div>
                                </td>
                                <td data-label="Specialization">
                                    <div class="input-cell">
                                        <input type="text" id="phd_specialization" runat="server" class="form-control" data-req="phd" data-cond="phd" />
                                        <span class="field-error" data-for="phd">Required</span>
                                    </div>
                                </td>
                                <td data-label="Year">
                                    <div class="input-cell">
                                        <input type="number" id="phd_year" runat="server" class="form-control" data-req="phd" data-cond="phd" />
                                        <span class="field-error" data-for="phd">Required</span>
                                    </div>
                                </td>
                                <td data-label="Percentage">
                                    <div class="input-cell">
                                        <input type="number" id="phd_cgpa" runat="server" class="form-control" step="any" data-req="phd" data-cond="phd" />
                                        <span class="field-error" data-for="phd">Required</span>
                                    </div>
                                </td>
                                <td data-label="Institute">
                                    <div class="input-cell">
                                        <input type="text" id="phd_uni" runat="server" class="form-control" data-req="phd" data-cond="phd" />
                                        <span class="field-error" data-for="phd">Required</span>
                                    </div>
                                </td>
                                <td data-label="Country">
                                    <div class="input-cell">
                                        <input type="text" id="phd_country" runat="server" class="form-control" data-req="phd" data-cond="phd" />
                                        <span class="field-error" data-for="phd">Required</span>
                                    </div>
                                </td>
                            </tr>

                            <!-- PostDoc -->
                            <tr id="row_postdoc" data-degree="postdoc" data-required="conditional">
                                <td class="cell-head" data-label="Degree">
                                    <span>Post Doctorate</span>
                                    <button type="button" class="row-toggle" aria-expanded="true"
                                            aria-controls="row_postdoc" onclick="toggleRow('row_postdoc')">
                                        <i class="bi bi-chevron-down"></i>
                                    </button>
                                </td>
                                <td data-label="Registration No.">
                                    <div class="input-cell">
                                        <input type="text" id="postdoc_regno" runat="server" class="form-control" placeholder="e.g. 12345-2020" data-req="postdoc" data-cond="postdoc" />
                                        <span class="field-error" data-for="postdoc">Required</span>
                                    </div>
                                </td>
                                <td data-label="Duration">
                                    <div class="input-cell">
                                        <input type="text" id="postdoc_duration" runat="server" class="form-control" data-req="postdoc" data-cond="postdoc" />
                                        <span class="field-error" data-for="postdoc">Required</span>
                                    </div>
                                </td>
                                <td data-label="Specialization">
                                    <div class="input-cell">
                                        <input type="text" id="postdoc_specialization" runat="server" class="form-control" data-req="postdoc" data-cond="postdoc" />
                                        <span class="field-error" data-for="postdoc">Required</span>
                                    </div>
                                </td>
                                <td data-label="Year">
                                    <div class="input-cell">
                                        <input type="number" id="postdoc_year" runat="server" class="form-control" data-req="postdoc" data-cond="postdoc" />
                                        <span class="field-error" data-for="postdoc">Required</span>
                                    </div>
                                </td>
                                <td data-label="Percentage">
                                    <div class="input-cell">
                                        <input type="number" id="postdoc_cgpa" runat="server" class="form-control" step="any" data-req="postdoc" data-cond="postdoc" />
                                        <span class="field-error" data-for="postdoc">Required</span>
                                    </div>
                                </td>
                                <td data-label="Institute">
                                    <div class="input-cell">
                                        <input type="text" id="postdoc_uni" runat="server" class="form-control" data-req="postdoc" data-cond="postdoc" />
                                        <span class="field-error" data-for="postdoc">Required</span>
                                    </div>
                                </td>
                                <td data-label="Country">
                                    <div class="input-cell">
                                        <input type="text" id="postdoc_country" runat="server" class="form-control" data-req="postdoc" data-cond="postdoc" />
                                        <span class="field-error" data-for="postdoc">Required</span>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- ============================================================
                 OTHER QUALIFICATIONS
                 ============================================================ -->
            <div class="section-card">
                <div class="section-heading">
                    <h3>Other Qualifications / Certifications</h3>
                    <span class="divider-line"></span>
                </div>

                <p class="info-text">
                    Add any additional certifications, diplomas, or professional qualifications.
                </p>

                <div class="table-responsive">
                    <table class="other-table" id="otherTable">
                        <thead>
                            <tr>
                                <th style="width: 45px;">#</th>
                                <th style="min-width: 110px;">Qualification</th>
                                <th style="min-width: 70px;">Duration</th>
                                <th style="min-width: 100px;">Specialization</th>
                                <th style="min-width: 65px;">Year</th>
                                <th style="min-width: 80px;">Percentage</th>
                                <th style="min-width: 110px;">Institute</th>
                                <th style="min-width: 90px;">Country</th>
                                <th style="width: 90px;">Action</th>
                            </tr>
                        </thead>
                        <tbody id="otherBody">
                        </tbody>
                    </table>
                </div>

                <button type="button" class="btn-add" onclick="addOtherRow()">
                    <i class="bi bi-plus-circle"></i> Add Qualification
                </button>
            </div>

            <!-- SAVE AND CONTINUE -->
            <div class="save-wrap">
                <asp:Button ID="btnSubmit" runat="server" Text="Save and Continue  →"
                    CssClass="btn-save" OnClick="BtnSubmit_Click"
                    OnClientClick="return validateBeforeSubmit();" />
            </div>

            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>

        </div>

    </form>

    <script>
        // =========================================
        // ROW TOGGLE (visible only ≤900px)
        // =========================================
        function toggleRow(rowId) {
            var row = document.getElementById(rowId);
            if (!row) return;

            var isCollapsed = row.classList.toggle('row-collapsed');

            var btn = row.querySelector('.row-toggle');
            if (btn) {
                btn.setAttribute('aria-expanded', isCollapsed ? 'false' : 'true');
                var icon = btn.querySelector('i');
                if (icon) {
                    icon.style.transform = isCollapsed ? 'rotate(-90deg)' : 'rotate(0deg)';
                    icon.style.transition = 'transform 0.25s ease';
                    icon.style.display = 'inline-block';
                }
            }
        }

        // =========================================
        // VALIDATION
        // =========================================
        function degreeHasAnyValue(degree) {
            var inputs = document.querySelectorAll('input[data-cond="' + degree + '"], select[data-cond="' + degree + '"]');
            for (var i = 0; i < inputs.length; i++) {
                if (inputs[i].value && inputs[i].value.trim() !== '') return true;
            }
            return false;
        }

        function setFieldState(input, invalid) {
            if (!input) return;
            if (invalid) input.classList.add('is-invalid');
            else input.classList.remove('is-invalid');

            var cell = input.closest('.input-cell') || input.closest('td');
            if (cell) {
                var err = cell.querySelector('.field-error');
                if (err) {
                    if (invalid) err.classList.add('show');
                    else err.classList.remove('show');
                }
            }
        }

        function validateDegree(degree, alwaysRequired) {
            var require = alwaysRequired || degreeHasAnyValue(degree);
            var inputs = document.querySelectorAll('input[data-req="' + degree + '"], select[data-req="' + degree + '"]');
            var firstInvalid = null;

            for (var i = 0; i < inputs.length; i++) {
                var inp = inputs[i];
                var empty = !inp.value || inp.value.trim() === '';
                var invalid = require && empty;

                setFieldState(inp, invalid);

                if (invalid && !firstInvalid) firstInvalid = inp;
            }

            return { valid: !firstInvalid, firstInvalid: firstInvalid };
        }

        function validateAllDegrees() {
            var degrees = [
                { key: 'ssc', always: true },
                { key: 'hssc', always: true },
                { key: 'bs', always: true },
                { key: 'ms', always: false },
                { key: 'phd', always: false },
                { key: 'postdoc', always: false }
            ];

            var firstBad = null;
            var badDegree = null;

            for (var i = 0; i < degrees.length; i++) {
                var d = degrees[i];
                var res = validateDegree(d.key, d.always);
                if (!res.valid) {
                    if (!firstBad) {
                        firstBad = res.firstInvalid;
                        badDegree = d.key;
                    }
                }
            }

            if (firstBad) {
                var row = firstBad.closest('tr');
                if (row && row.classList.contains('row-collapsed')) {
                    row.classList.remove('row-collapsed');
                    var toggle = row.querySelector('.row-toggle');
                    if (toggle) {
                        toggle.setAttribute('aria-expanded', 'true');
                        var ic = toggle.querySelector('i');
                        if (ic) ic.style.transform = 'rotate(0deg)';
                    }
                }

                setTimeout(function () {
                    firstBad.focus();
                    firstBad.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }, 50);

                return { ok: false, degree: badDegree };
            }

            return { ok: true };
        }

        function validateBeforeSubmit() {
            var result = validateAllDegrees();

            var lbl = document.getElementById('<%= lblMessage.ClientID %>');

            if (!result.ok) {
                var names = { ssc: "SSC/O'Level", hssc: "HSSC/A'Level", bs: "BS/BSc", ms: "Masters/MPhil", phd: "PhD", postdoc: "Post Doctorate" };
                var label = names[result.degree] || result.degree;
                if (lbl) {
                    lbl.textContent = "Please fill all required fields for " + label + " (or clear all fields in this degree if you don't have it).";
                }
                return false;
            }

            // Other Qualifications: if a row has anything filled, all fields required
            var otherRows = document.querySelectorAll('#otherBody tr');
            var otherNames = ["Name", "Duration", "Specialization", "Year", "Percentage", "Institute", "Country"];
            var otherInputs;
            for (var r = 0; r < otherRows.length; r++) {
                var row = otherRows[r];
                var inputs = row.querySelectorAll('input');
                var hasAny = false;
                for (var j = 0; j < inputs.length; j++) {
                    if (inputs[j].value && inputs[j].value.trim() !== '') { hasAny = true; break; }
                }

                if (!hasAny) continue;

                for (var j2 = 0; j2 < inputs.length; j2++) {
                    var inp = inputs[j2];
                    var empty = !inp.value || inp.value.trim() === '';
                    if (empty) {
                        inp.classList.add('is-invalid');
                        if (lbl) {
                            lbl.textContent = "In Other Qualification Q" + (r + 1) + ", the " + otherNames[j2] + " field is required because you filled other fields in that row.";
                        }
                        setTimeout(function () {
                            inp.focus();
                            inp.scrollIntoView({ behavior: 'smooth', block: 'center' });
                        }, 50);
                        return false;
                    } else {
                        inp.classList.remove('is-invalid');
                    }
                }
            }

            return true;
        }

        // =========================================
        // LIVE VALIDATION
        // =========================================
        document.addEventListener('DOMContentLoaded', function () {
            document.querySelectorAll('input[data-req], select[data-req]').forEach(function (inp) {
                inp.addEventListener('input', function () {
                    var req = inp.getAttribute('data-req');
                    if (!req) return;
                    var row = inp.closest('tr');
                    var cond = row && row.getAttribute('data-required') === 'conditional';
                    var require = !cond || degreeHasAnyValue(req);

                    var empty = !inp.value || inp.value.trim() === '';
                    setFieldState(inp, require && empty);
                });
                inp.addEventListener('change', function () {
                    var req = inp.getAttribute('data-req');
                    if (!req) return;
                    var row = inp.closest('tr');
                    var cond = row && row.getAttribute('data-required') === 'conditional';
                    var require = !cond || degreeHasAnyValue(req);

                    var empty = !inp.value || inp.value.trim() === '';
                    setFieldState(inp, require && empty);
                });
            });

            var numberInputs = document.querySelectorAll('input[type="number"]');
            numberInputs.forEach(function (input) {
                input.addEventListener('input', function () {
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
                    if (e.key === '-' || e.keyCode === 189) {
                        e.preventDefault();
                        return false;
                    }
                });
            });
        });

        // =========================================
        // OTHER QUALIFICATIONS
        // =========================================
        let otherCounter = 0;

        function addOtherRow() {
            otherCounter++;
            const tbody = document.getElementById('otherBody');
            const tr = document.createElement('tr');
            tr.id = 'other_row_' + otherCounter;

            tr.innerHTML = `
                <td class="cell-head" data-label="#">
                    <span>Q${otherCounter}</span>
                    <button type="button" class="row-toggle" aria-expanded="true"
                            aria-controls="other_row_${otherCounter}"
                            onclick="toggleRow('other_row_${otherCounter}')">
                        <i class="bi bi-chevron-down"></i>
                    </button>
                </td>
                <td data-label="Qualification"><input type="text" name="other_name_${otherCounter}" class="form-control" /></td>
                <td data-label="Duration"><input type="text" name="other_duration_${otherCounter}" class="form-control" /></td>
                <td data-label="Specialization"><input type="text" name="other_specialization_${otherCounter}" class="form-control" /></td>
                <td data-label="Year"><input type="number" name="other_year_${otherCounter}" class="form-control" /></td>
                <td data-label="Percentage"><input type="number" name="other_percentage_${otherCounter}" class="form-control" step="any" /></td>
                <td data-label="Institute"><input type="text" name="other_institute_${otherCounter}" class="form-control" /></td>
                <td data-label="Country"><input type="text" name="other_country_${otherCounter}" class="form-control" /></td>
                <td data-label="Action">
                    <button type="button" class="btn-delete" onclick="removeOtherRow('other_row_${otherCounter}')">
                        Delete
                    </button>
                </td>
            `;

            tbody.appendChild(tr);
        }

        function removeOtherRow(rowId) {
            const row = document.getElementById(rowId);
            if (row) {
                row.remove();
                const rows = document.querySelectorAll('#otherBody tr');

                rows.forEach((row, index) => {
                    var headCell = row.querySelector('.cell-head span');
                    if (headCell) headCell.textContent = 'Q' + (index + 1);
                    else row.cells[0].textContent = index + 1;
                });

                if (rows.length === 0) {
                    otherCounter = 0;
                }
            }
        }

        window.onload = function () {
            otherCounter = 0;
            addOtherRow();
        };
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>