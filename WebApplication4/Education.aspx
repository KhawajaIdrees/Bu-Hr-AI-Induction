<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Education.aspx.cs" Inherits="WebApplication4.candDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Educational Information</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <style>
        body {
            background: #f0f4f8;
            font-family: 'Segoe UI', Arial, sans-serif;
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

        .education-table th {
            background: #e8edf5;
            color: #1a3a7a;
            font-weight: 700;
            font-size: 13px;
            text-align: center;
            vertical-align: middle;
            border-bottom: 2px solid #1a3a7a;
            white-space: nowrap;
        }

        .education-table td {
            vertical-align: middle;
            text-align: center;
            padding: 8px 6px;
            min-width: 80px;
        }

        .education-table td:first-child {
            font-weight: 600;
            color: #1a3a7a;
            background: #f8faff;
            text-align: left;
            padding-left: 15px;
            min-width: 120px;
            white-space: nowrap;
        }

        /* ============================================
           INPUT WIDTHS: SHORT for numbers, LONG for text
           ============================================ */
        
        /* Duration - Medium (Desktop) */
        .education-table input[id$="_duration"] {
            min-width: 80px;
            max-width: 120px;
            border-radius: 6px;
            border: 1px solid #d0d7e6;
            padding: 6px 10px;
            font-size: 14px;
            transition: all 0.2s;
            width: 100%;
            text-align: center;
            background: #f8faff;
            color: #1a2332;
            box-sizing: border-box;
        }

        /* Specialization - LONG */
        .education-table input[id$="_specialization"] {
            min-width: 140px;
            max-width: none;
            border-radius: 6px;
            border: 1px solid #d0d7e6;
            padding: 6px 10px;
            font-size: 14px;
            transition: all 0.2s;
            width: 100%;
            text-align: left;
            background: #f8faff;
            color: #1a2332;
            box-sizing: border-box;
            white-space: normal;
            word-wrap: break-word;
        }

        /* Year - Slightly bigger to show 4 digits */
        .education-table input[id$="_year"] {
            min-width: 75px;
            max-width: 95px;
            border-radius: 6px;
            border: 1px solid #d0d7e6;
            padding: 6px 8px;
            font-size: 14px;
            transition: all 0.2s;
            width: 100%;
            text-align: center;
            background: #f8faff;
            color: #1a2332;
            box-sizing: border-box;
        }

        /* Percentage/CGPA - SHORT */
        .education-table input[id$="_cgpa"], 
        .education-table input[id$="per"] {
            min-width: 70px;
            max-width: 90px;
            border-radius: 6px;
            border: 1px solid #d0d7e6;
            padding: 6px 8px;
            font-size: 14px;
            transition: all 0.2s;
            width: 100%;
            text-align: center;
            background: #f8faff;
            color: #1a2332;
            box-sizing: border-box;
        }

        /* Institute - LONG */
        .education-table input[id$="_uni"] {
            min-width: 150px;
            max-width: none;
            border-radius: 6px;
            border: 1px solid #d0d7e6;
            padding: 6px 10px;
            font-size: 14px;
            transition: all 0.2s;
            width: 100%;
            text-align: left;
            background: #f8faff;
            color: #1a2332;
            box-sizing: border-box;
            white-space: normal;
            word-wrap: break-word;
        }

        /* Country - LONG */
        .education-table input[id$="_country"] {
            min-width: 120px;
            max-width: none;
            border-radius: 6px;
            border: 1px solid #d0d7e6;
            padding: 6px 10px;
            font-size: 14px;
            transition: all 0.2s;
            width: 100%;
            text-align: left;
            background: #f8faff;
            color: #1a2332;
            box-sizing: border-box;
            white-space: normal;
            word-wrap: break-word;
        }

        .education-table input:focus {
            border-color: #1a3a7a;
            box-shadow: 0 0 0 0.2rem rgba(26, 58, 122, 0.15);
            outline: none;
        }

        .section-divider {
            border-top: 3px dashed #1a3a7a;
            margin: 30px 0;
            opacity: 0.3;
        }

        /* Other Qualifications */
        .other-table th {
            background: #e8edf5;
            color: #1a3a7a;
            font-weight: 700;
            font-size: 13px;
            text-align: center;
            vertical-align: middle;
            border-bottom: 2px solid #1a3a7a;
            white-space: nowrap;
        }

        .other-table td {
            vertical-align: middle;
            text-align: center;
            padding: 6px 4px;
            min-width: 60px;
        }

        /* Other table - Qualification (LONG) */
        .other-table input[name^="other_name"] {
            min-width: 120px;
            max-width: none;
            border-radius: 6px;
            border: 1px solid #d0d7e6;
            padding: 5px 8px;
            font-size: 13px;
            transition: all 0.2s;
            width: 100%;
            text-align: left;
            background: #f8faff;
            color: #1a2332;
            box-sizing: border-box;
            white-space: normal;
            word-wrap: break-word;
        }

        /* Other table - Duration (SHORT) */
        .other-table input[name^="other_duration"] {
            min-width: 70px;
            max-width: 100px;
            border-radius: 6px;
            border: 1px solid #d0d7e6;
            padding: 5px 8px;
            font-size: 13px;
            transition: all 0.2s;
            width: 100%;
            text-align: center;
            background: #f8faff;
            color: #1a2332;
            box-sizing: border-box;
        }

        /* Other table - Specialization (LONG) */
        .other-table input[name^="other_specialization"] {
            min-width: 100px;
            max-width: none;
            border-radius: 6px;
            border: 1px solid #d0d7e6;
            padding: 5px 8px;
            font-size: 13px;
            transition: all 0.2s;
            width: 100%;
            text-align: left;
            background: #f8faff;
            color: #1a2332;
            box-sizing: border-box;
            white-space: normal;
            word-wrap: break-word;
        }

        /* Other table - Year (SHORT) */
        .other-table input[name^="other_year"] {
            min-width: 60px;
            max-width: 80px;
            border-radius: 6px;
            border: 1px solid #d0d7e6;
            padding: 5px 6px;
            font-size: 13px;
            transition: all 0.2s;
            width: 100%;
            text-align: center;
            background: #f8faff;
            color: #1a2332;
            box-sizing: border-box;
        }

        /* Other table - Percentage (SHORT) */
        .other-table input[name^="other_percentage"] {
            min-width: 65px;
            max-width: 85px;
            border-radius: 6px;
            border: 1px solid #d0d7e6;
            padding: 5px 6px;
            font-size: 13px;
            transition: all 0.2s;
            width: 100%;
            text-align: center;
            background: #f8faff;
            color: #1a2332;
            box-sizing: border-box;
        }

        /* Other table - Institute (LONG) */
        .other-table input[name^="other_institute"] {
            min-width: 120px;
            max-width: none;
            border-radius: 6px;
            border: 1px solid #d0d7e6;
            padding: 5px 8px;
            font-size: 13px;
            transition: all 0.2s;
            width: 100%;
            text-align: left;
            background: #f8faff;
            color: #1a2332;
            box-sizing: border-box;
            white-space: normal;
            word-wrap: break-word;
        }

        /* Other table - Country (LONG) */
        .other-table input[name^="other_country"] {
            min-width: 100px;
            max-width: none;
            border-radius: 6px;
            border: 1px solid #d0d7e6;
            padding: 5px 8px;
            font-size: 13px;
            transition: all 0.2s;
            width: 100%;
            text-align: left;
            background: #f8faff;
            color: #1a2332;
            box-sizing: border-box;
            white-space: normal;
            word-wrap: break-word;
        }

        .other-table input:focus {
            border-color: #1a3a7a;
            box-shadow: 0 0 0 0.2rem rgba(26, 58, 122, 0.15);
            outline: none;
        }

        .btn-add-blue {
            background: #1a3a7a;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 25px;
            font-weight: 600;
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
            font-size: 18px;
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
            padding: 14px 55px;
            font-size: 18px;
            font-weight: 600;
            transition: all 0.2s;
        }

        .btn-save-blue:hover {
            background: #2a5aaa;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(26, 58, 122, 0.35);
        }

        .text-primary-custom {
            color: #1a3a7a;
        }

        /* Required star */
        .required-star {
            color: #dc3545;
            font-weight: 700;
        }

        /* Degree years text */
        .degree-years {
            color: #6c757d;
            font-size: 12px;
            font-weight: 400;
            display: block;
            line-height: 1.2;
        }

        @media (max-width: 768px) {
            /* Duration - SMALLER on mobile */
            .education-table input[id$="_duration"] {
                min-width: 50px;
                max-width: 70px;
                font-size: 12px;
                padding: 4px 6px;
            }
            
            .education-table input[id$="_specialization"] {
                min-width: 80px;
                font-size: 12px;
                padding: 4px 6px;
            }
            
            /* Year - Slightly bigger on mobile too */
            .education-table input[id$="_year"] {
                min-width: 60px;
                max-width: 75px;
                font-size: 12px;
                padding: 4px 6px;
            }
            
            .education-table input[id$="_cgpa"], 
            .education-table input[id$="per"] {
                min-width: 55px;
                max-width: 70px;
                font-size: 12px;
                padding: 4px 6px;
            }
            
            .education-table input[id$="_uni"] {
                min-width: 90px;
                font-size: 12px;
                padding: 4px 6px;
            }
            
            .education-table input[id$="_country"] {
                min-width: 80px;
                font-size: 12px;
                padding: 4px 6px;
            }
            
            .education-table td {
                padding: 4px 4px;
                min-width: 50px;
            }
            .education-table td:first-child {
                min-width: 80px;
                white-space: normal;
                font-size: 12px;
                padding-left: 8px;
            }
            .education-table th {
                font-size: 11px;
                padding: 6px 4px;
                white-space: normal;
            }
            
            /* Other table mobile */
            .other-table input[name^="other_name"] {
                min-width: 80px;
                font-size: 12px;
                padding: 4px 6px;
            }
            .other-table input[name^="other_duration"] {
                min-width: 45px;
                max-width: 65px;
                font-size: 12px;
                padding: 4px 4px;
            }
            .other-table input[name^="other_specialization"] {
                min-width: 70px;
                font-size: 12px;
                padding: 4px 6px;
            }
            .other-table input[name^="other_year"] {
                min-width: 50px;
                max-width: 65px;
                font-size: 12px;
                padding: 4px 4px;
            }
            .other-table input[name^="other_percentage"] {
                min-width: 50px;
                max-width: 65px;
                font-size: 12px;
                padding: 4px 4px;
            }
            .other-table input[name^="other_institute"] {
                min-width: 80px;
                font-size: 12px;
                padding: 4px 6px;
            }
            .other-table input[name^="other_country"] {
                min-width: 70px;
                font-size: 12px;
                padding: 4px 6px;
            }
            .other-table td {
                padding: 4px 3px;
                min-width: 40px;
            }
            .other-table th {
                font-size: 11px;
                padding: 6px 4px;
                white-space: normal;
            }
            .card-body {
                padding: 15px;
            }
        }

        @media (max-width: 480px) {
            /* Duration - EVEN SMALLER on small mobile */
            .education-table input[id$="_duration"] {
                min-width: 40px;
                max-width: 55px;
                font-size: 11px;
                padding: 3px 4px;
            }
            
            .education-table input[id$="_specialization"] {
                min-width: 60px;
                font-size: 11px;
                padding: 3px 4px;
            }
            
            .education-table input[id$="_year"] {
                min-width: 50px;
                max-width: 60px;
                font-size: 11px;
                padding: 3px 4px;
            }
            
            .education-table input[id$="_cgpa"], 
            .education-table input[id$="per"] {
                min-width: 45px;
                max-width: 55px;
                font-size: 11px;
                padding: 3px 4px;
            }
            
            .education-table input[id$="_uni"] {
                min-width: 60px;
                font-size: 11px;
                padding: 3px 4px;
            }
            
            .education-table input[id$="_country"] {
                min-width: 55px;
                font-size: 11px;
                padding: 3px 4px;
            }
            
            .education-table td {
                padding: 3px 3px;
                min-width: 35px;
            }
            .education-table td:first-child {
                min-width: 60px;
                font-size: 11px;
                padding-left: 5px;
            }
            .education-table th {
                font-size: 10px;
                padding: 4px 3px;
            }
            
            /* Other table small mobile */
            .other-table input[name^="other_name"] {
                min-width: 60px;
                font-size: 11px;
                padding: 3px 4px;
            }
            .other-table input[name^="other_duration"] {
                min-width: 35px;
                max-width: 50px;
                font-size: 11px;
                padding: 3px 3px;
            }
            .other-table input[name^="other_specialization"] {
                min-width: 50px;
                font-size: 11px;
                padding: 3px 4px;
            }
            .other-table input[name^="other_year"] {
                min-width: 40px;
                max-width: 50px;
                font-size: 11px;
                padding: 3px 3px;
            }
            .other-table input[name^="other_percentage"] {
                min-width: 40px;
                max-width: 50px;
                font-size: 11px;
                padding: 3px 3px;
            }
            .other-table input[name^="other_institute"] {
                min-width: 55px;
                font-size: 11px;
                padding: 3px 4px;
            }
            .other-table input[name^="other_country"] {
                min-width: 50px;
                font-size: 11px;
                padding: 3px 4px;
            }
            .other-table td {
                padding: 3px 2px;
                min-width: 30px;
            }
            .other-table th {
                font-size: 10px;
                padding: 4px 3px;
            }
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
                                    <th style="min-width: 120px;">Certificate/Degree</th>
                                    <th style="min-width: 80px;">Duration</th>
                                    <th style="min-width: 140px;">Specialization</th>
                                    <th style="min-width: 75px;">Year</th>
                                    <th style="min-width: 70px;">Percentage</th>
                                    <th style="min-width: 150px;">Institute</th>
                                    <th style="min-width: 120px;">Country</th>
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
                                        <span class="required-star">*</span> Bachelor
                                        <br />
                                        <span class="degree-years" style="padding-left: 11px;">(14-16 Years)</span>
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
                                    <th style="width: 50px;">#</th>
                                    <th style="min-width: 120px;">Qualification</th>
                                    <th style="min-width: 70px;">Duration</th>
                                    <th style="min-width: 100px;">Specialization</th>
                                    <th style="min-width: 60px;">Year</th>
                                    <th style="min-width: 65px;">Percentage</th>
                                    <th style="min-width: 120px;">Institute</th>
                                    <th style="min-width: 100px;">Country</th>
                                    <th style="width: 60px;">Action</th>
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
            // Get all number inputs
            var numberInputs = document.querySelectorAll('input[type="number"]');

            numberInputs.forEach(function (input) {
                // Handle input event (when user types or uses spinner)
                input.addEventListener('input', function () {
                    if (this.value !== '' && this.value !== '-') {
                        var val = parseInt(this.value);
                        // If value is negative, set to 0
                        if (val < 0) {
                            this.value = 0;
                        }
                    }
                });

                // Handle change event (when spinner arrows are clicked)
                input.addEventListener('change', function () {
                    if (this.value !== '' && this.value !== '-') {
                        var val = parseInt(this.value);
                        if (val < 0) {
                            this.value = 0;
                        }
                    }
                });

                // Handle blur - if empty or negative, set to 0
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

                // Prevent negative values from being entered via keyboard
                input.addEventListener('keydown', function (e) {
                    // Allow: backspace, delete, tab, escape, enter, home, end, left, right
                    if (e.keyCode === 8 || e.keyCode === 46 || e.keyCode === 9 ||
                        e.keyCode === 27 || e.keyCode === 13 || e.keyCode === 35 ||
                        e.keyCode === 36 || e.keyCode === 37 || e.keyCode === 39) {
                        return;
                    }

                    // Allow: Ctrl+A, Ctrl+C, Ctrl+V, Ctrl+X
                    if ((e.ctrlKey || e.metaKey) && (e.keyCode === 65 || e.keyCode === 67 ||
                        e.keyCode === 86 || e.keyCode === 88)) {
                        return;
                    }

                    // Prevent the minus sign
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

                // Re-number remaining rows starting from 1
                rows.forEach((row, index) => {
                    row.cells[0].textContent = index + 1;
                });

                // Reset counter if no rows left
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