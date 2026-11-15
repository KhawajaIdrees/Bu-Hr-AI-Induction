<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Education.aspx.cs" Inherits="WebApplication4.candDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Educational Information</title>

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

        .info-text {
            font-family: var(--font-ui);
            font-size: 13px;
            color: var(--muted-text);
            margin: 0 0 18px 0;
        }

        /* TABLE WRAPPER */
        .table-responsive {
            overflow-x: auto;
            border-radius: var(--radius);
            border: 1px solid var(--border);
        }

        .table-responsive::-webkit-scrollbar { height: 6px; }
        .table-responsive::-webkit-scrollbar-track { background: #F0F2F5; border-radius: 10px; }
        .table-responsive::-webkit-scrollbar-thumb { background: var(--action-blue); border-radius: 10px; }

        .edu-table,
        .other-table {
            width: 100%;
            border-collapse: collapse;
            font-family: var(--font-ui);
            margin: 0;
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
            padding: 12px 10px !important;
            white-space: nowrap;
        }

        .edu-table td,
        .other-table td {
            vertical-align: middle !important;
            text-align: center !important;
            padding: 10px 8px !important;
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
            white-space: nowrap;
        }

        .edu-table tbody tr:hover,
        .other-table tbody tr:hover {
            background-color: #F8FAFC;
        }

        /* INPUTS inside tables */
        .edu-table input,
        .edu-table select,
        .other-table input {
            width: 100%;
            background: var(--input-bg);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            height: 38px;
            font-family: var(--font-ui);
            font-size: 13px;
            color: var(--body-text);
            padding: 0 10px;
            transition: border-color 0.15s ease, box-shadow 0.15s ease;
            min-width: 60px;
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

        /* Degree label wrapper */
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
            min-width: 130px;
            cursor: pointer;
            box-shadow: none !important;
            height: auto !important;
        }

        .degree-label select:focus { outline: none; box-shadow: none !important; }

        /* ADD BUTTON */
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

        /* DELETE BUTTON — SAME as Publications / Experience */
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

        /* SAVE BUTTON */
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

        @media (max-width: 900px) {
            .page-wrap { padding: 24px 24px 40px; }

            .edu-table input,
            .edu-table select,
            .other-table input {
                font-size: 12px;
                padding: 0 8px;
                height: 36px;
                min-width: 55px;
            }

            .edu-table th,
            .other-table th {
                font-size: 10px !important;
                padding: 10px 8px !important;
            }

            .edu-table td,
            .other-table td {
                padding: 8px 6px !important;
                font-size: 12px !important;
            }

            .edu-table td:first-child,
            .other-table td:first-child {
                padding-left: 10px !important;
                font-size: 12px !important;
            }

            .degree-label select {
                font-size: 12px;
                min-width: 110px;
            }
        }

        @media (max-width: 640px) {
            .page-wrap { padding: 20px 16px 40px; }
            .main-heading { font-size: 30px; }
            .section-heading h3 { font-size: 18px; }

            .btn-save { width: 100%; justify-content: center; }
            .save-wrap { justify-content: stretch; }
            .btn-add { width: 100%; justify-content: center; }

            .edu-table input,
            .edu-table select,
            .other-table input {
                font-size: 12px;
                padding: 0 6px;
                height: 34px;
                min-width: 50px;
            }

            .edu-table th,
            .other-table th {
                font-size: 9px !important;
                padding: 8px 6px !important;
            }

            .edu-table td,
            .other-table td {
                padding: 6px 5px !important;
                font-size: 11px !important;
            }

            .degree-label select {
                font-size: 11px;
                min-width: 100px;
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
            <p class="main-subtitle">Provide your academic qualifications starting from SSC/O'Level.</p>

            <!-- ============================================================
                 ACADEMIC QUALIFICATIONS
                 ============================================================ -->
            <div class="section-card">
                <div class="section-heading">
                    <h3>Academic Qualifications</h3>
                </div>

                <div class="table-responsive">
                    <table class="edu-table">
                        <thead>
                            <tr>
                                <th style="min-width: 130px;">Certificate / Degree</th>
                                <th style="min-width: 70px;">Duration</th>
                                <th style="min-width: 110px;">Specialization</th>
                                <th style="min-width: 70px;">Year</th>
                                <th style="min-width: 80px;">Percentage</th>
                                <th style="min-width: 130px;">Institute</th>
                                <th style="min-width: 100px;">Country</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><span class="required-star">*</span> SSC/O'Level</td>
                                <td><input type="text" id="ssc_duration" runat="server" class="form-control" /></td>
                                <td><input type="text" id="ssc_specialization" runat="server" class="form-control" /></td>
                                <td><input type="number" id="ssc_year" runat="server" class="form-control" /></td>
                                <td><input type="number" id="sscper" runat="server" class="form-control" step="any" /></td>
                                <td><input type="text" id="ssc_uni" runat="server" class="form-control" /></td>
                                <td><input type="text" id="ssc_country" runat="server" class="form-control" /></td>
                            </tr>
                            <tr>
                                <td><span class="required-star">*</span> HSSC/A'Level</td>
                                <td><input type="text" id="hssc_duration" runat="server" class="form-control" /></td>
                                <td><input type="text" id="hssc_specialization" runat="server" class="form-control" /></td>
                                <td><input type="number" id="hssc_year" runat="server" class="form-control" /></td>
                                <td><input type="number" id="hsscper" runat="server" class="form-control" step="any" /></td>
                                <td><input type="text" id="hssc_uni" runat="server" class="form-control" /></td>
                                <td><input type="text" id="hssc_country" runat="server" class="form-control" /></td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="degree-label">
                                        <span class="required-star">*</span>
                                        <select id="bs_type" runat="server">
                                            <option value="BS - 16 Years">BS - 16 Years</option>
                                            <option value="BSc - 14 Years">BSc - 14 Years</option>
                                        </select>
                                    </div>
                                </td>
                                <td><input type="text" id="bs_duration" runat="server" class="form-control" /></td>
                                <td><input type="text" id="bs_specialization" runat="server" class="form-control" /></td>
                                <td><input type="number" id="bs_year" runat="server" class="form-control" /></td>
                                <td><input type="number" id="bs_cgpa" runat="server" class="form-control" step="any" /></td>
                                <td><input type="text" id="bs_uni" runat="server" class="form-control" /></td>
                                <td><input type="text" id="bs_country" runat="server" class="form-control" /></td>
                            </tr>
                            <tr>
                                <td>Masters / MPhil</td>
                                <td><input type="text" id="ms_duration" runat="server" class="form-control" /></td>
                                <td><input type="text" id="ms_specialization" runat="server" class="form-control" /></td>
                                <td><input type="number" id="ms_year" runat="server" class="form-control" /></td>
                                <td><input type="number" id="ms_cgpa" runat="server" class="form-control" step="any" /></td>
                                <td><input type="text" id="ms_uni" runat="server" class="form-control" /></td>
                                <td><input type="text" id="ms_country" runat="server" class="form-control" /></td>
                            </tr>
                            <tr>
                                <td>PhD</td>
                                <td><input type="text" id="phd_duration" runat="server" class="form-control" /></td>
                                <td><input type="text" id="phd_specialization" runat="server" class="form-control" /></td>
                                <td><input type="number" id="phd_year" runat="server" class="form-control" /></td>
                                <td><input type="number" id="phd_cgpa" runat="server" class="form-control" step="any" /></td>
                                <td><input type="text" id="phd_uni" runat="server" class="form-control" /></td>
                                <td><input type="text" id="phd_country" runat="server" class="form-control" /></td>
                            </tr>
                            <tr>
                                <td>Post Doctorate</td>
                                <td><input type="text" id="postdoc_duration" runat="server" class="form-control" /></td>
                                <td><input type="text" id="postdoc_specialization" runat="server" class="form-control" /></td>
                                <td><input type="number" id="postdoc_year" runat="server" class="form-control" /></td>
                                <td><input type="number" id="postdoc_cgpa" runat="server" class="form-control" step="any" /></td>
                                <td><input type="text" id="postdoc_uni" runat="server" class="form-control" /></td>
                                <td><input type="text" id="postdoc_country" runat="server" class="form-control" /></td>
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
                    CssClass="btn-save" OnClick="BtnSubmit_Click" />
            </div>

            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>

        </div>

    </form>

    <script>
        // =========================================
        // CONTROL SPINNER BEHAVIOR - STOPS AT 0
        // =========================================
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

        // =========================================
        // OTHER QUALIFICATIONS FUNCTIONS
        // =========================================
        let otherCounter = 0;

        function addOtherRow() {
            otherCounter++;
            const tbody = document.getElementById('otherBody');
            const tr = document.createElement('tr');
            tr.id = 'other_row_' + otherCounter;

            // Delete button now uses the same .btn-delete class as Publications / Experience pages
            tr.innerHTML = `
                <td>${otherCounter}</td>
                <td><input type="text" name="other_name_${otherCounter}" class="form-control" /></td>
                <td><input type="text" name="other_duration_${otherCounter}" class="form-control" /></td>
                <td><input type="text" name="other_specialization_${otherCounter}" class="form-control" /></td>
                <td><input type="number" name="other_year_${otherCounter}" class="form-control" /></td>
                <td><input type="number" name="other_percentage_${otherCounter}" class="form-control" step="any" /></td>
                <td><input type="text" name="other_institute_${otherCounter}" class="form-control" /></td>
                <td><input type="text" name="other_country_${otherCounter}" class="form-control" /></td>
                <td>
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
                    row.cells[0].textContent = index + 1;
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