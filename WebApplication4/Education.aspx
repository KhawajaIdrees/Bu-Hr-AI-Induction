<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Education.aspx.cs" Inherits="WebApplication4.candDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Educational Information</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <style>
        /* ============================================
           BASE STYLES
           ============================================ */
        * {
            box-sizing: border-box;
        }

        body {
            background: #f0f4f8;
            font-family: 'Segoe UI', Arial, sans-serif;
            font-size: 17px;
            min-height: 100vh;
        }

        /* ============================================
           PAGE HEADER
           ============================================ */
        .page-title h4 {
            color: #1a3a7a;
            font-weight: 700;
            font-size: clamp(20px, 3vw, 28px);
        }

        .page-title h5 {
            color: #6c757d;
            font-size: clamp(14px, 1.5vw, 18px);
        }

        .page-title hr {
            border-top: 3px solid #1a3a7a;
            opacity: 0.2;
            width: 100%;
            margin-top: 5px;
        }

        /* ============================================
           CARDS
           ============================================ */
        .card-main {
            border-radius: 16px;
            border: none;
            box-shadow: 0 8px 30px rgba(26, 58, 122, 0.10);
            overflow: hidden;
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
            font-size: clamp(16px, 1.8vw, 20px);
        }

        .card-header-blue i {
            margin-right: 10px;
        }

        .card-body {
            padding: 25px 30px;
        }

        /* ============================================
           TABLES - FIXED FOR MOBILE
           ============================================ */
        .education-table th {
            background: #e8edf5;
            color: #1a3a7a;
            font-weight: 700;
            font-size: clamp(12px, 1vw, 13px);
            text-align: center;
            vertical-align: middle;
            border-bottom: 2px solid #1a3a7a;
            white-space: nowrap;
            padding: 10px 12px;
        }

        .education-table td {
            vertical-align: middle;
            text-align: center;
            padding: 10px 8px;
            min-width: 70px;
        }

        .education-table td:first-child {
            font-weight: 600;
            color: #1a3a7a;
            background: #f8faff;
            text-align: left;
            padding-left: 15px;
            min-width: 100px;
            white-space: nowrap;
        }

        /* ============================================
           INPUTS - BIGGER ON MOBILE
           ============================================ */
        .education-table input,
        .other-table input {
            border-radius: 6px;
            border: 1px solid #d0d7e6;
            padding: 8px 12px;
            font-size: clamp(14px, 1vw, 15px);
            transition: all 0.2s;
            width: 100%;
            background: #f8faff;
            color: #1a2332;
            box-sizing: border-box;
            min-height: 40px;
        }

        .education-table input:focus,
        .education-table select:focus,
        .other-table input:focus {
            border-color: #1a3a7a;
            box-shadow: 0 0 0 0.2rem rgba(26, 58, 122, 0.15);
            outline: none;
        }

        .education-table select {
            border-radius: 6px;
            border: 1px solid #d0d7e6;
            padding: 8px 12px;
            font-size: clamp(14px, 1vw, 15px);
            transition: all 0.2s;
            width: 100%;
            background: #f8faff;
            color: #1a3a7a;
            box-sizing: border-box;
            min-height: 40px;
            font-weight: 600;
            cursor: pointer;
        }

        /* ============================================
           INPUT WIDTHS - FIXED
           ============================================ */
        
        /* Duration */
        .education-table input[id$="_duration"] {
            min-width: 70px;
            max-width: 120px;
            text-align: center;
        }

        /* BS/BSc Dropdown */
        .education-table select[id$="_type"] {
            min-width: 120px;
            max-width: 180px;
            text-align: center;
        }

        /* Specialization - LONG */
        .education-table input[id$="_specialization"] {
            min-width: 120px;
            max-width: none;
            text-align: left;
            white-space: normal;
            word-wrap: break-word;
        }

        /* Year */
        .education-table input[id$="_year"] {
            min-width: 70px;
            max-width: 95px;
            text-align: center;
        }

        /* Percentage/CGPA */
        .education-table input[id$="_cgpa"], 
        .education-table input[id$="per"] {
            min-width: 70px;
            max-width: 95px;
            text-align: center;
        }

        /* Institute - LONG */
        .education-table input[id$="_uni"] {
            min-width: 140px;
            max-width: none;
            text-align: left;
            white-space: normal;
            word-wrap: break-word;
        }

        /* Country */
        .education-table input[id$="_country"] {
            min-width: 120px;
            max-width: none;
            text-align: left;
            white-space: normal;
            word-wrap: break-word;
        }

        /* ============================================
           DEGREE LABEL
           ============================================ */
        .degree-label {
            display: flex;
            align-items: center;
            gap: 4px;
            flex-wrap: wrap;
        }

        .degree-label .required-star {
            color: #dc3545;
            font-weight: 700;
            font-size: clamp(14px, 1.2vw, 16px);
            flex-shrink: 0;
        }

        .degree-label select {
            border: none;
            background: transparent;
            font-weight: 700;
            font-size: clamp(14px, 1.2vw, 15px);
            color: #1a3a7a;
            padding: 0;
            width: auto;
            min-width: 130px;
            cursor: pointer;
            font-family: inherit;
            min-height: auto;
        }

        .degree-label select:focus {
            outline: none;
            box-shadow: none;
        }

        /* ============================================
           OTHER QUALIFICATIONS
           ============================================ */
        .other-table th {
            background: #e8edf5;
            color: #1a3a7a;
            font-weight: 700;
            font-size: clamp(12px, 1vw, 13px);
            text-align: center;
            vertical-align: middle;
            border-bottom: 2px solid #1a3a7a;
            white-space: nowrap;
            padding: 10px 12px;
        }

        .other-table td {
            vertical-align: middle;
            text-align: center;
            padding: 8px 6px;
            min-width: 60px;
        }

        .other-table input {
            min-width: 70px;
            max-width: none;
            text-align: left;
            white-space: normal;
            word-wrap: break-word;
            min-height: 36px;
            font-size: clamp(13px, 0.9vw, 14px);
            padding: 6px 10px;
        }

        /* ============================================
           BUTTONS
           ============================================ */
        .btn-add-blue {
            background: #1a3a7a;
            color: white;
            border: none;
            border-radius: 8px;
            padding: clamp(10px, 1vw, 12px) clamp(20px, 2vw, 25px);
            font-weight: 600;
            font-size: clamp(14px, 1vw, 16px);
            transition: all 0.2s;
        }

        .btn-add-blue:hover {
            background: #2a5aaa;
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(26, 58, 122, 0.3);
        }

        .btn-remove {
            background: transparent;
            color: #dc3545;
            border: none;
            font-size: clamp(18px, 1.2vw, 20px);
            cursor: pointer;
            padding: 0 5px;
            transition: all 0.2s;
        }

        .btn-remove:hover {
            color: #a71d2a;
            transform: scale(1.2);
        }

        .btn-save-blue {
            background: #1a3a7a;
            color: white;
            border: none;
            border-radius: 8px;
            padding: clamp(14px, 1.2vw, 16px) clamp(40px, 4vw, 55px);
            font-size: clamp(17px, 1.2vw, 19px);
            font-weight: 600;
            transition: all 0.2s;
            width: auto;
        }

        .btn-save-blue:hover {
            background: #2a5aaa;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(26, 58, 122, 0.35);
        }

        /* ============================================
           REQUIRED STAR
           ============================================ */
        .required-star {
            color: #dc3545;
            font-weight: 700;
            font-size: clamp(14px, 1.2vw, 16px);
            flex-shrink: 0;
        }

        /* ============================================
           DEGREE YEARS TEXT
           ============================================ */
        .degree-years {
            color: #6c757d;
            font-size: clamp(11px, 0.8vw, 12px);
            font-weight: 400;
            display: block;
            line-height: 1.2;
        }

        /* ============================================
           RESPONSIVE: TABLET & MOBILE - BIGGER TEXT
           ============================================ */
        @media (max-width: 992px) {
            .card-body {
                padding: 20px 24px;
            }

            .education-table td {
                padding: 8px 6px;
                min-width: 60px;
            }

            .education-table td:first-child {
                min-width: 90px;
                padding-left: 12px;
                white-space: normal;
                font-size: clamp(12px, 0.9vw, 13px);
            }

            .education-table input,
            .education-table select {
                font-size: clamp(13px, 0.9vw, 14px);
                padding: 6px 10px;
                min-height: 36px;
            }

            .education-table input[id$="_duration"] {
                min-width: 60px;
                max-width: 100px;
            }

            .education-table select[id$="_type"] {
                min-width: 100px;
                max-width: 140px;
            }

            .education-table input[id$="_specialization"] {
                min-width: 100px;
            }

            .education-table input[id$="_year"] {
                min-width: 60px;
                max-width: 80px;
            }

            .education-table input[id$="_cgpa"],
            .education-table input[id$="per"] {
                min-width: 60px;
                max-width: 80px;
            }

            .education-table input[id$="_uni"] {
                min-width: 110px;
            }

            .education-table input[id$="_country"] {
                min-width: 100px;
            }

            .other-table td {
                padding: 6px 4px;
                min-width: 50px;
            }

            .other-table input {
                min-width: 60px;
                font-size: clamp(12px, 0.8vw, 13px);
                padding: 6px 8px;
                min-height: 34px;
            }

            .other-table th {
                font-size: clamp(11px, 0.8vw, 12px);
                padding: 8px 6px;
                white-space: normal;
            }

            .degree-label select {
                font-size: clamp(13px, 1vw, 14px);
                min-width: 110px;
            }
        }

        @media (max-width: 768px) {
            .container {
                padding-left: 10px;
                padding-right: 10px;
            }

            .card-body {
                padding: 16px 14px;
            }

            .card-header-blue {
                padding: 14px 18px;
            }

            .card-header-blue h5 {
                font-size: 17px;
            }

            /* BIGGER TABLE ON MOBILE */
            .education-table td {
                padding: 8px 5px;
                min-width: 70px;
                font-size: 14px;
            }

            .education-table td:first-child {
                min-width: 80px;
                font-size: 13px;
                padding-left: 8px;
            }

            .education-table input,
            .education-table select {
                font-size: 14px;
                padding: 6px 8px;
                min-height: 36px;
                border-radius: 5px;
            }

            .education-table input[id$="_duration"] {
                min-width: 55px;
                max-width: 80px;
            }

            .education-table select[id$="_type"] {
                min-width: 90px;
                max-width: 130px;
                font-size: 13px;
                padding: 5px 8px;
            }

            .education-table input[id$="_specialization"] {
                min-width: 80px;
            }

            .education-table input[id$="_year"] {
                min-width: 55px;
                max-width: 75px;
            }

            .education-table input[id$="_cgpa"],
            .education-table input[id$="per"] {
                min-width: 55px;
                max-width: 75px;
            }

            .education-table input[id$="_uni"] {
                min-width: 90px;
            }

            .education-table input[id$="_country"] {
                min-width: 80px;
            }

            .education-table th {
                font-size: 11px;
                padding: 8px 5px;
                white-space: normal;
            }

            .other-table td {
                padding: 6px 4px;
                min-width: 50px;
            }

            .other-table input {
                min-width: 50px;
                font-size: 13px;
                padding: 5px 6px;
                min-height: 32px;
            }

            .other-table th {
                font-size: 11px;
                padding: 8px 5px;
                white-space: normal;
            }

            .degree-label select {
                font-size: 14px;
                min-width: 100px;
            }

            .degree-label .required-star {
                font-size: 15px;
            }

            .btn-save-blue {
                width: 100%;
                padding: 14px 20px;
                font-size: 17px;
                justify-content: center;
            }

            .btn-add-blue {
                padding: 10px 18px;
                font-size: 15px;
                width: 100%;
            }

            .section-divider {
                margin: 20px 0;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding-left: 6px;
                padding-right: 6px;
            }

            .card-body {
                padding: 12px 10px;
            }

            /* EVEN BIGGER ON SMALL MOBILE */
            .education-table td {
                padding: 6px 4px;
                min-width: 60px;
                font-size: 13px;
            }

            .education-table td:first-child {
                min-width: 65px;
                font-size: 12px;
                padding-left: 6px;
            }

            .education-table input,
            .education-table select {
                font-size: 13px;
                padding: 5px 6px;
                min-height: 32px;
                border-radius: 4px;
            }

            .education-table input[id$="_duration"] {
                min-width: 50px;
                max-width: 70px;
            }

            .education-table select[id$="_type"] {
                min-width: 80px;
                max-width: 110px;
                font-size: 12px;
                padding: 4px 6px;
            }

            .education-table input[id$="_specialization"] {
                min-width: 70px;
            }

            .education-table input[id$="_year"] {
                min-width: 50px;
                max-width: 65px;
            }

            .education-table input[id$="_cgpa"],
            .education-table input[id$="per"] {
                min-width: 50px;
                max-width: 65px;
            }

            .education-table input[id$="_uni"] {
                min-width: 75px;
            }

            .education-table input[id$="_country"] {
                min-width: 70px;
            }

            .education-table th {
                font-size: 10px;
                padding: 6px 4px;
                white-space: normal;
            }

            .other-table td {
                padding: 4px 3px;
                min-width: 40px;
            }

            .other-table input {
                min-width: 40px;
                font-size: 12px;
                padding: 4px 5px;
                min-height: 28px;
            }

            .other-table th {
                font-size: 10px;
                padding: 6px 4px;
                white-space: normal;
            }

            .degree-label select {
                font-size: 13px;
                min-width: 80px;
            }

            .degree-label .required-star {
                font-size: 13px;
            }

            .card-header-blue {
                padding: 12px 14px;
            }

            .card-header-blue h5 {
                font-size: 15px;
            }

            .btn-save-blue {
                font-size: 15px;
                padding: 12px 18px;
            }

            .btn-add-blue {
                font-size: 13px;
                padding: 8px 14px;
            }

            .page-title h4 {
                font-size: 18px;
            }

            .page-title h5 {
                font-size: 13px;
            }
        }

        /* ============================================
           SCROLLABLE TABLE FOR SMALL SCREENS
           ============================================ */
        .table-responsive {
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            border-radius: 10px;
            border: 1px solid #eef1f8;
        }

        .table-responsive::-webkit-scrollbar {
            height: 6px;
        }

        .table-responsive::-webkit-scrollbar-track {
            background: #f0f2f5;
            border-radius: 10px;
        }

        .table-responsive::-webkit-scrollbar-thumb {
            background: #1a3a7a;
            border-radius: 10px;
        }

        /* ============================================
           SECTION DIVIDER
           ============================================ */
        .section-divider {
            border-top: 3px dashed #1a3a7a;
            margin: 30px 0;
            opacity: 0.3;
        }

        .text-primary-custom {
            color: #1a3a7a;
        }

        .text-muted {
            color: #6c757d !important;
        }

        .text-center {
            text-align: center;
        }

        .mt-3 {
            margin-top: 1rem;
        }
        .mt-4 {
            margin-top: 1.5rem;
        }
        .mb-0 {
            margin-bottom: 0;
        }
        .mb-4 {
            margin-bottom: 1.5rem;
        }
        .me-1 {
            margin-right: 0.25rem;
        }
        .me-2 {
            margin-right: 0.5rem;
        }
        .ms-3 {
            margin-left: 1rem;
        }
        .py-4 {
            padding-top: 1.5rem;
            padding-bottom: 1.5rem;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container py-4">

            <!-- Page Title -->
            <div class="text-left mb-4 page-title">
                <h4><i class="bi bi-mortarboard-fill text-primary-custom me-2"></i>Educational Information</h4>
                <h5>Bahria University HR Portal</h5>
                <hr />
            </div>

            <!-- Main Card -->
            <div class="card card-main">
                <div class="card-header-blue">
                    <h5><i class="bi bi-journal-bookmark-fill"></i> Academic Qualifications</h5>
                </div>
                <div class="card-body">

                    <div class="table-responsive">
                        <table class="table table-bordered table-hover align-middle education-table">
                            <thead>
                                <tr>
                                    <th style="min-width: 100px;">Certificate/Degree</th>
                                    <th style="min-width: 70px;">Duration</th>
                                    <th style="min-width: 100px;">Specialization</th>
                                    <th style="min-width: 70px;">Year</th>
                                    <th style="min-width: 70px;">Percentage</th>
                                    <th style="min-width: 120px;">Institute</th>
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
                                    <td>Masters/MPhil</td>
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
            </div>

            <!-- Other Qualifications Section -->
            <div class="card card-main mt-4">
                <div class="card-header-blue">
                    <h5><i class="bi bi-plus-circle-fill"></i> Other Qualifications / Certifications</h5>
                </div>
                <div class="card-body">

                    <p class="text-muted"><i class="bi bi-info-circle"></i> Add any additional certifications, diplomas, or professional qualifications.</p>

                    <div class="table-responsive">
                        <table class="table table-bordered table-hover align-middle other-table" id="otherTable">
                            <thead>
                                <tr>
                                    <th style="width: 45px;">#</th>
                                    <th style="min-width: 100px;">Qualification</th>
                                    <th style="min-width: 70px;">Duration</th>
                                    <th style="min-width: 90px;">Specialization</th>
                                    <th style="min-width: 65px;">Year</th>
                                    <th style="min-width: 65px;">Percentage</th>
                                    <th style="min-width: 100px;">Institute</th>
                                    <th style="min-width: 90px;">Country</th>
                                    <th style="width: 50px;">Action</th>
                                </tr>
                            </thead>
                            <tbody id="otherBody">
                            </tbody>
                        </table>
                    </div>

                    <div class="mt-3">
                        <button type="button" class="btn btn-add-blue" onclick="addOtherRow()">
                            <i class="bi bi-plus-circle me-1"></i> Add Qualification
                        </button>
                    </div>

                </div>
            </div>

            <!-- Submit Button -->
            <div class="text-center mt-4">
                <asp:Button ID="btnSubmit" runat="server" Text="Save and Continue" CssClass="btn btn-save-blue" OnClick="BtnSubmit_Click" />
                <div class="mt-3">
                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                </div>
            </div>

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

        // =========================================
        // OTHER QUALIFICATIONS FUNCTIONS
        // =========================================
        let otherCounter = 0;

        function addOtherRow() {
            otherCounter++;
            const tbody = document.getElementById('otherBody');
            const tr = document.createElement('tr');
            tr.id = 'other_row_' + otherCounter;

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
                    <button type="button" class="btn-remove" onclick="removeOtherRow('other_row_${otherCounter}')">
                        <i class="bi bi-trash3"></i>
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