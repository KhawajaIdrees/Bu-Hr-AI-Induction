<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminCandidatesView.aspx.cs" Inherits="WebApplication4.AdminCandidatesView" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
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
        .sidebar.collapsed {
            width: 80px;
        }
        .sidebar.collapsed .nav-link span {
            display: none;
        }
        .sidebar.collapsed .nav-link i {
            width: 100%;
            min-width: unset;
        }
        .sidebar-header {
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-bottom: 1px solid rgba(255,255,255,.08);
            transition: all .35s ease;
            padding: 0 16px;
        }
        .sidebar-header .toggle-btn {
            background: none;
            border: none;
            color: #fff;
            font-size: 24px;
            cursor: pointer;
            padding: 8px;
            border-radius: 8px;
            transition: .25s;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .sidebar-header .toggle-btn:hover {
            background: rgba(255,255,255,.08);
        }
        .sidebar-header .toggle-btn i {
            font-size: 24px;
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
            display: none;
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
            transition: all .35s ease;
            display: flex;
            flex-direction: column;
        }
        .content.expanded {
            margin-left: 80px;
            width: calc(100% - 80px);
        }

        /* ============================================
           PIPELINE CONTAINER
        ============================================ */
        .pipeline-container {
            display: flex;
            flex: 1;
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
            align-items: center;
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
           PAGE SIZE DROPDOWN
        ============================================ */
        .page-size-selector {
            display: inline-block;
            margin-left: auto;
        }

        .page-size-dropdown {
            padding: 4px 12px;
            border-radius: 16px;
            font-size: 11px;
            font-weight: 600;
            border: 1px solid #e2e8f0;
            background: #ffffff;
            color: #64748b;
            cursor: pointer;
            transition: all 0.2s;
            height: 30px;
            min-width: 100px;
            outline: none;
        }

        .page-size-dropdown:hover {
            background: #f1f5f9;
        }

        .page-size-dropdown:focus {
            border-color: #1a3a7a;
            box-shadow: 0 0 0 3px rgba(26, 58, 122, 0.08);
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
        .candidate-card .avatar-img {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            object-fit: cover;
            background: #f8faff;
            flex-shrink: 0;
            cursor: pointer;
            transition: transform 0.2s ease;
        }
        .candidate-card .avatar-img:hover {
            transform: scale(1.05);
        }
        .candidate-card .avatar-placeholder {
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
            font-family: 'Segoe UI', Arial, sans-serif;
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
           CANDIDATE HEADER WITH PROFILE IMAGE
        ============================================ */
        .candidate-header {
            display: flex;
            align-items: flex-start;
            gap: 20px;
        }
        .candidate-header .profile-image-large {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            object-fit: cover;
            background: #f8faff;
            flex-shrink: 0;
            border: 3px solid #e8ecf1;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .candidate-header .profile-image-large:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        .candidate-header .profile-placeholder-large {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: #1a3a7a;
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 32px;
            flex-shrink: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
            border: 3px solid #e8ecf1;
        }
        .candidate-header .candidate-info {
            flex: 1;
        }
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
           CANDIDATE INFO GRID - Professional Layout (Desktop Only)
        ============================================ */
        .candidate-header .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px 30px;
            margin-top: 4px;
        }

        .candidate-header .info-item {
            display: flex;
            flex-direction: column;
        }

        .candidate-header .info-item .info-label {
            font-size: 10px;
            font-weight: 700;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 1px;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .candidate-header .info-item .info-label i {
            font-size: 11px;
        }

        .candidate-header .info-item .info-value {
            font-size: 14px;
            color: #0f172a;
            font-weight: 500;
        }

        /* Download CV Button */
        .btn-download-cv {
            background: #1a3a7a;
            color: #ffffff;
            border: none;
            border-radius: 6px;
            padding: 4px 14px;
            font-size: 12px;
            font-weight: 600;
            transition: all 0.25s ease;
            cursor: pointer;
            font-family: 'Segoe UI', Arial, sans-serif;
        }

        .btn-download-cv:hover {
            background: #2a5aaa;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(26, 58, 122, 0.3);
            color: #ffffff;
        }

        .btn-download-cv:active {
            transform: translateY(0);
        }

        /* Status Dropdown - Professional */
        .status-dropdown {
            border-radius: 8px;
            padding: 6px 14px;
            font-size: 13px;
            font-weight: 600;
            border: 1px solid #e2e8f0;
            background: #ffffff;
            min-width: 160px;
            color: #0f172a;
            cursor: pointer;
            transition: all 0.2s ease;
            font-family: 'Segoe UI', Arial, sans-serif;
        }

        .status-dropdown:hover {
            border-color: #1a3a7a;
        }

        .status-dropdown:focus {
            outline: none;
            border-color: #1a3a7a;
            box-shadow: 0 0 0 3px rgba(26, 58, 122, 0.08);
        }

        /* CV Status Label */
        .cv-status-available {
            color: #059669;
            font-weight: 600;
            font-size: 13px;
        }

        .cv-status-unavailable {
            color: #dc3545;
            font-weight: 600;
            font-size: 13px;
        }

        /* ============================================
           SECTION HEADERS
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
           SCORE BOXES
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
        .score-academic .score-label { color: #4F46E5; }
        .score-experience .score-label { color: #059669; }
        .score-publications .score-label { color: #E11D48; }

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

        .empty-message {
            color: #94a3b8;
            font-size: 13px;
            padding: 8px 0;
        }

        ::-webkit-scrollbar { width: 5px; }
        ::-webkit-scrollbar-track { background: #f1f4f9; }
        ::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 10px; }
        ::-webkit-scrollbar-thumb:hover { background: #94a3b8; }

        /* ============================================
           PHOTO VIEWER MODAL
        ============================================ */
        .photo-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.92);
            z-index: 9999;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
            backdrop-filter: blur(8px);
        }
        .photo-modal.active {
            display: flex;
            opacity: 1;
        }
        .photo-modal .modal-content {
            position: relative;
            max-width: 90%;
            max-height: 90%;
            display: flex;
            align-items: center;
            justify-content: center;
            animation: zoomIn 0.3s ease;
        }
        .photo-modal .modal-content img {
            max-width: 100%;
            max-height: 85vh;
            border-radius: 12px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.5);
            object-fit: contain;
            background: #1a1a2e;
            border: 2px solid rgba(255,255,255,0.1);
        }
        .photo-modal .modal-close {
            position: fixed;
            top: 20px;
            right: 30px;
            color: #fff;
            font-size: 40px;
            font-weight: 300;
            cursor: pointer;
            transition: transform 0.2s ease, color 0.2s ease;
            z-index: 10000;
            background: rgba(255,255,255,0.1);
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: none;
            line-height: 1;
        }
        .photo-modal .modal-close:hover {
            transform: rotate(90deg);
            color: #ff6b6b;
            background: rgba(255,255,255,0.2);
        }
        .photo-modal .modal-close i {
            font-size: 28px;
        }
        .photo-modal .modal-caption {
            position: fixed;
            bottom: 40px;
            left: 50%;
            transform: translateX(-50%);
            color: #fff;
            font-size: 16px;
            font-weight: 500;
            text-align: center;
            background: rgba(0,0,0,0.6);
            padding: 10px 24px;
            border-radius: 30px;
            backdrop-filter: blur(4px);
            max-width: 80%;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            border: 1px solid rgba(255,255,255,0.1);
        }
        .photo-modal .modal-caption i {
            margin-right: 10px;
            opacity: 0.7;
        }

        @keyframes zoomIn {
            from {
                transform: scale(0.8);
                opacity: 0;
            }
            to {
                transform: scale(1);
                opacity: 1;
            }
        }

        /* Mobile responsive for photo modal */
        @media only screen and (max-width: 768px) {
            .photo-modal .modal-close {
                top: 15px;
                right: 15px;
                width: 40px;
                height: 40px;
                font-size: 20px;
            }
            .photo-modal .modal-close i {
                font-size: 20px;
            }
            .photo-modal .modal-content img {
                max-height: 70vh;
                border-radius: 8px;
            }
            .photo-modal .modal-caption {
                bottom: 20px;
                font-size: 13px;
                padding: 8px 16px;
                max-width: 90%;
                white-space: normal;
            }
        }

        @media only screen and (max-width: 480px) {
            .photo-modal .modal-close {
                top: 10px;
                right: 10px;
                width: 35px;
                height: 35px;
                font-size: 16px;
            }
            .photo-modal .modal-close i {
                font-size: 16px;
            }
            .photo-modal .modal-content img {
                max-height: 60vh;
                border-radius: 6px;
            }
            .photo-modal .modal-caption {
                bottom: 15px;
                font-size: 12px;
                padding: 6px 14px;
            }
        }

        /* ============================================
           MOBILE HEADER
        ============================================ */
        .mobile-header {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: 56px;
            background: #ffffff;
            z-index: 1000;
            border-bottom: 1px solid #e2e8f0;
            align-items: center;
            justify-content: space-between;
            padding: 0 16px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
            width: 100%;
        }
        .mobile-header .mobile-title {
            font-size: 17px;
            font-weight: 700;
            color: #0f172a;
            letter-spacing: 0.3px;
            text-align: right;
        }

        .hamburger-btn {
            display: none;
            background: none !important;
            border: none;
            color: #1a3a7a;
            font-size: 28px;
            padding: 0;
            cursor: pointer;
            z-index: 1002;
            transition: all 0.3s ease;
            box-shadow: none !important;
            width: 40px;
            height: 40px;
            display: none;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        .hamburger-btn:hover {
            transform: scale(1.05);
        }
        .hamburger-btn:active {
            transform: scale(0.95);
        }
        .hamburger-btn i {
            font-size: 28px;
        }

        .mobile-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 999;
            opacity: 0;
            transition: opacity 0.3s ease;
            pointer-events: none;
        }
        .mobile-overlay.active {
            opacity: 1;
            pointer-events: auto;
        }

        /* Mobile Back Button */
        .mobile-back-btn {
            display: none;
            background: none;
            border: none;
            color: #1a3a7a;
            font-size: 16px;
            font-weight: 600;
            padding: 8px 0 12px 0;
            cursor: pointer;
            transition: all 0.2s;
            align-items: center;
            gap: 8px;
            width: 100%;
            text-align: left;
            margin-bottom: 8px;
            border-bottom: 1px solid #eef2f6;
        }
        .mobile-back-btn i {
            font-size: 20px;
        }
        .mobile-back-btn:hover {
            color: #0f1f4a;
        }
        .mobile-back-btn:active {
            transform: scale(0.97);
        }

        /* ============================================
           MOBILE RESPONSIVE
        ============================================ */
        @media only screen and (max-width: 768px) {
            body {
                overflow: hidden;
                position: relative;
            }

            .mobile-header {
                display: flex;
            }

            .hamburger-btn {
                display: flex !important;
                position: relative;
                top: auto;
                left: auto;
                transform: none;
                z-index: 1002;
                width: 40px;
                height: 40px;
                background: none !important;
                border: none;
                color: #1a3a7a;
                font-size: 28px;
                padding: 0;
                cursor: pointer;
                box-shadow: none !important;
                align-items: center;
                justify-content: center;
                flex-shrink: 0;
            }

            .sidebar {
                transform: translateX(-100%);
                width: 280px;
                transition: transform 0.35s ease;
                z-index: 1000;
                position: fixed;
                top: 0;
                left: 0;
            }
            .sidebar.mobile-open {
                transform: translateX(0);
            }
            .sidebar.collapsed {
                width: 280px;
            }
            .sidebar.collapsed .nav-link span {
                display: inline;
            }
            .sidebar.collapsed .nav-link i {
                width: 42px;
                min-width: 42px;
            }

            .sidebar-header .toggle-btn {
                display: none;
            }

            .content {
                margin-left: 0 !important;
                width: 100% !important;
                padding-top: 56px;
                height: 100vh;
            }
            .content.expanded {
                margin-left: 0 !important;
                width: 100% !important;
            }

            .pipeline-container {
                flex-direction: column;
                height: calc(100vh - 56px);
                overflow: hidden;
                position: relative;
            }

            .left-panel {
                width: 100% !important;
                min-width: unset !important;
                border-right: none !important;
                border-bottom: none !important;
                height: 100% !important;
                padding: 10px 14px 20px 14px;
                display: flex !important;
                flex-direction: column;
                background: #f5f7fb;
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                z-index: 1;
                transition: all 0.3s ease;
                overflow: hidden;
            }
            .left-panel.mobile-hidden {
                display: none !important;
            }
            .left-panel .pipeline-title {
                display: none;
            }
            .left-panel .search-box {
                font-size: 14px;
                padding: 10px 14px 10px 40px;
                background-size: 16px;
                border-radius: 10px;
                margin-top: 0;
                flex-shrink: 0;
                background-color: #ffffff;
                border: 1px solid #e2e8f0;
            }
            .left-panel .tabs {
                margin: 10px 0 12px 0;
                gap: 6px;
                flex-shrink: 0;
                padding-bottom: 8px;
                border-bottom: 1px solid #eef2f6;
                display: flex;
                flex-wrap: wrap;
                align-items: center;
            }
            .left-panel .tab-btn {
                font-size: 11px;
                padding: 5px 14px;
                border-radius: 20px;
            }
            
            .page-size-selector {
                margin-left: auto;
                flex-shrink: 0;
            }
            
            .page-size-dropdown {
                font-size: 10px;
                padding: 3px 10px;
                min-width: 80px;
                height: 26px;
            }
            
            .left-panel .candidate-list-container {
                flex: 1;
                overflow-y: auto;
                -webkit-overflow-scrolling: touch;
                padding-bottom: 120px;
                padding-top: 4px;
                min-height: 0;
                margin-bottom: 0;
            }

            .candidate-card {
                padding: 14px 16px;
                margin-bottom: 10px;
                border-radius: 12px;
                border: 1px solid #e2e8f0;
                background: #ffffff;
                box-shadow: 0 1px 3px rgba(0,0,0,0.04);
                min-height: 64px;
            }
            .candidate-card:active {
                transform: scale(0.98);
                background: #f8faff;
            }
            .candidate-card .avatar-img {
                width: 40px;
                height: 40px;
                font-size: 16px;
            }
            .candidate-card .avatar-placeholder {
                width: 40px;
                height: 40px;
                font-size: 16px;
            }
            .candidate-card .candidate-name {
                font-size: 15px;
                font-weight: 600;
            }
            .candidate-card .candidate-email {
                font-size: 12px;
                margin-top: 1px;
            }
            .candidate-card .score-badge {
                font-size: 12px;
                padding: 2px 12px;
            }
            .candidate-card .status-badge {
                font-size: 9px;
                padding: 2px 12px;
            }

            .right-panel {
                display: none !important;
                height: 100% !important;
                padding: 10px 12px 20px 12px;
                background: #f5f7fb;
                overflow-y: auto;
                -webkit-overflow-scrolling: touch;
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                z-index: 2;
                width: 100% !important;
            }
            .right-panel.mobile-show {
                display: block !important;
            }

            .detail-card {
                padding: 16px 16px 60px 16px;
                border-radius: 12px;
                margin-bottom: 10px;
            }

            .mobile-back-btn {
                display: flex !important;
                flex-shrink: 0;
            }

            /* ============================================
               CANDIDATE HEADER MOBILE - FIXED LAYOUT
            ============================================ */
            .candidate-header {
                flex-direction: column;
                align-items: center;
                text-align: center;
                gap: 12px;
                width: 100%;
            }
            
            .candidate-header .profile-image-large {
                width: 60px !important;
                height: 60px !important;
            }
            
            .candidate-header .profile-placeholder-large {
                width: 60px !important;
                height: 60px !important;
                font-size: 24px !important;
            }
            
            .candidate-header .candidate-info {
                width: 100%;
            }
            
            .candidate-header .candidate-info .d-flex {
                flex-direction: column;
                align-items: center !important;
                width: 100%;
            }
            
            .candidate-header .name {
                font-size: 20px !important;
                text-align: center;
                width: 100%;
            }
            
            .candidate-header .position {
                font-size: 13px !important;
                text-align: center;
                width: 100%;
            }
            
            .candidate-header .text-end {
                text-align: center !important;
                width: 100%;
                margin-top: 4px;
            }
            
            .candidate-header .total-score {
                font-size: 24px !important;
                text-align: center;
            }
            
            .candidate-header .total-score-label {
                font-size: 11px !important;
                text-align: center;
            }
            
            /* Info Grid - Single Column Centered on Mobile */
            .candidate-header .info-grid {
                display: block;
                margin-top: 8px;
                width: 100%;
            }
            
            .candidate-header .info-item {
                display: flex;
                flex-direction: column;
                align-items: center;
                margin-bottom: 10px;
                width: 100%;
                padding: 6px 0;
                border-bottom: 1px solid #f0f2f5;
            }
            
            .candidate-header .info-item:last-child {
                border-bottom: none;
            }
            
            .candidate-header .info-item .info-label {
                font-size: 9px;
                text-align: center;
                width: 100%;
                justify-content: center;
            }
            
            .candidate-header .info-item .info-value {
                font-size: 13px;
                text-align: center;
                width: 100%;
                justify-content: center;
            }
            
            .candidate-header .info-item .info-value.d-flex {
                justify-content: center;
                flex-wrap: wrap;
            }
            
            .candidate-header .total-score span {
                font-size: 14px !important;
            }

            .btn-download-cv {
                font-size: 11px;
                padding: 3px 12px;
            }

            .status-dropdown {
                font-size: 12px;
                padding: 5px 12px;
                min-width: 140px;
                width: 100%;
                max-width: 200px;
                margin: 0 auto;
                display: block;
            }
            
            .candidate-header .mt-3 {
                text-align: center;
                width: 100%;
            }

            .score-box {
                padding: 12px 8px;
            }
            .score-box .score-value {
                font-size: 1.6rem;
            }
            .score-box .score-label {
                font-size: 10px;
            }
            .score-box .score-max {
                font-size: 11px;
            }

            .section-header {
                font-size: 12px;
                margin-bottom: 8px;
                padding-bottom: 6px;
            }

            .edu-item, .exp-item, .pub-item {
                padding: 10px 14px;
                margin-bottom: 6px;
                border-radius: 8px;
            }
            .edu-item .edu-degree,
            .exp-item .exp-title,
            .pub-item .pub-title {
                font-size: 14px;
            }
            .edu-item .edu-institute,
            .exp-item .exp-org,
            .pub-item .pub-journal {
                font-size: 13px;
            }
            .edu-item .edu-year,
            .exp-item .exp-date,
            .pub-item .pub-year {
                font-size: 12px;
            }
            .edu-item .edu-percentage {
                font-size: 11px;
            }

            .empty-message {
                font-size: 12px;
            }

            .select-placeholder {
                min-height: 300px;
            }
            .select-placeholder i {
                font-size: 40px;
            }
            .select-placeholder h5 {
                font-size: 16px;
            }
            .select-placeholder p {
                font-size: 13px;
            }
        }

        /* Small phones (480px and below) */
        @media only screen and (max-width: 480px) {
            .mobile-header {
                height: 48px;
                padding: 0 12px;
            }
            .mobile-header .mobile-title {
                font-size: 15px;
            }
            .hamburger-btn {
                width: 32px;
                height: 32px;
                font-size: 22px;
            }
            .hamburger-btn i {
                font-size: 22px;
            }
            .content {
                padding-top: 48px;
            }
            .pipeline-container {
                height: calc(100vh - 48px);
            }
            .left-panel {
                padding: 8px 10px 16px 10px;
            }
            .left-panel .search-box {
                font-size: 12px;
                padding: 8px 12px 8px 34px;
                background-size: 14px;
            }
            .left-panel .tab-btn {
                font-size: 9px;
                padding: 4px 10px;
            }
            
            .page-size-dropdown {
                font-size: 9px;
                padding: 2px 8px;
                min-width: 70px;
                height: 24px;
            }
            
            .left-panel .candidate-list-container {
                padding-bottom: 100px;
            }
            .candidate-card {
                padding: 10px 12px;
                margin-bottom: 8px;
                min-height: 56px;
            }
            .candidate-card .avatar-img {
                width: 34px;
                height: 34px;
                font-size: 13px;
            }
            .candidate-card .avatar-placeholder {
                width: 34px;
                height: 34px;
                font-size: 13px;
            }
            .candidate-card .candidate-name {
                font-size: 13px;
            }
            .candidate-card .candidate-email {
                font-size: 11px;
            }
            .candidate-card .score-badge {
                font-size: 10px;
                padding: 1px 10px;
            }
            .candidate-card .status-badge {
                font-size: 8px;
                padding: 1px 10px;
            }
            .right-panel {
                padding: 6px 10px 16px 10px;
            }
            .detail-card {
                padding: 12px 12px 50px 12px;
            }
            
            /* Candidate Header Mobile Small */
            .candidate-header .profile-image-large {
                width: 50px !important;
                height: 50px !important;
            }
            .candidate-header .profile-placeholder-large {
                width: 50px !important;
                height: 50px !important;
                font-size: 20px !important;
            }
            .candidate-header .name {
                font-size: 17px !important;
            }
            .candidate-header .position {
                font-size: 12px !important;
            }
            .candidate-header .total-score {
                font-size: 20px !important;
            }
            .candidate-header .info-item .info-label {
                font-size: 8px;
            }
            .candidate-header .info-item .info-value {
                font-size: 12px;
            }

            .btn-download-cv {
                font-size: 10px;
                padding: 2px 10px;
            }

            .status-dropdown {
                font-size: 11px;
                padding: 4px 10px;
                min-width: 120px;
                width: 100%;
                max-width: 200px;
            }

            .candidate-header .total-score-label {
                font-size: 10px !important;
            }

            .candidate-header .total-score span {
                font-size: 13px !important;
            }
            
            .score-box .score-value {
                font-size: 1.3rem;
            }
        }

        /* Tablet */
        @media only screen and (min-width: 769px) and (max-width: 1024px) {
            .candidate-header .info-grid {
                grid-template-columns: 1fr 1fr;
                gap: 10px 25px;
            }
            .candidate-header .profile-image-large {
                width: 70px !important;
                height: 70px !important;
            }
        }

        @media (hover: none) and (pointer: coarse) {
            .candidate-card {
                min-height: 64px;
            }
            .candidate-card .candidate-name {
                font-size: 16px;
            }
            .tab-btn {
                padding: 6px 16px !important;
                font-size: 12px !important;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <!-- ==========================================
        PHOTO VIEWER MODAL
        ========================================== -->
        <div id="photoModal" class="photo-modal" onclick="closePhotoModal(event)">
            <button type="button" class="modal-close" onclick="closePhotoModal(event)">
                <i class="bi bi-x-lg"></i>
            </button>
            <div class="modal-content" onclick="event.stopPropagation();">
                <img id="modalPhotoImage" src="#" alt="Profile Photo" />
            </div>
            <div class="modal-caption" id="modalPhotoCaption">
                <i class="bi bi-person-circle"></i> <span id="modalPhotoName">Candidate</span>
            </div>
        </div>

        <!-- MOBILE HEADER -->
        <div id="mobileHeader" class="mobile-header">
            <button type="button" id="hamburgerBtn" class="hamburger-btn" aria-label="Toggle menu">
                <i class="bi bi-list"></i>
            </button>
            <span class="mobile-title">Candidate Pipeline</span>
        </div>

        <!-- Mobile Overlay -->
        <div id="mobileOverlay" class="mobile-overlay"></div>

        <!-- SIDEBAR -->
        <div id="sidebar" class="sidebar">
            <div class="sidebar-header">
                <button type="button" id="toggleSidebarBtn" class="toggle-btn">
                    <i class="bi bi-arrow-left-circle"></i>
                </button>
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
            </ul>
        </div>

        <!-- CONTENT -->
        <div id="content" class="content">
            <div class="pipeline-container">

                <!-- LEFT PANEL - Candidate List -->
                <div id="leftPanel" class="left-panel">
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
                            OnClick="btnTab_Click" CommandArgument="pending">Pending</asp:LinkButton>
                        <asp:LinkButton ID="btnShortlisted" runat="server" CssClass="tab-btn" 
                            OnClick="btnTab_Click" CommandArgument="shortlisted">Shortlisted</asp:LinkButton>
                        <asp:LinkButton ID="btnRejected" runat="server" CssClass="tab-btn" 
                            OnClick="btnTab_Click" CommandArgument="rejected">Rejected</asp:LinkButton>
                        <asp:LinkButton ID="btnHired" runat="server" CssClass="tab-btn" 
                            OnClick="btnTab_Click" CommandArgument="hired">Hired</asp:LinkButton>
                        
                        <!-- Page Size Dropdown -->
                        <div class="page-size-selector">
                            <asp:DropDownList ID="ddlPageSize" runat="server" 
                                CssClass="page-size-dropdown" 
                                AutoPostBack="true" 
                                OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
                                <asp:ListItem Value="10">Show 10</asp:ListItem>
                                <asp:ListItem Value="20">Show 20</asp:ListItem>
                                <asp:ListItem Value="50">Show 50</asp:ListItem>
                                <asp:ListItem Value="100">Show 100</asp:ListItem>
                                <asp:ListItem Value="all" Selected="True">Show All</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <!-- Candidate List -->
                    <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
                        <div class="text-center py-4">
                            <p class="text-muted small">No candidates found</p>
                        </div>
                    </asp:Panel>

                    <div class="candidate-list-container">
                        <asp:Repeater ID="rptCandidates" runat="server" OnItemDataBound="rptCandidates_ItemDataBound">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnCandidate" runat="server" 
                                    CssClass="candidate-card w-100 text-start text-decoration-none d-block"
                                    OnClick="btnCandidate_Click"
                                    CommandArgument='<%# Eval("Id") %>'>
                                    <div class="d-flex align-items-center gap-3">
                                        <asp:Image ID="imgAvatar" runat="server" 
                                            ImageUrl='<%# GetProfileImageUrl(Eval("Id")) %>'
                                            CssClass="avatar-img photo-trigger"
                                            AlternateText="Profile" />
                                        <div class="flex-grow-1" style="min-width:0;">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <span class="candidate-name"><%# Eval("FullName") %></span>
                                                <span class="score-badge"><%# Eval("TotalScore", "{0:F0}") %></span>
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

                <!-- RIGHT PANEL - Candidate Details -->
                <div id="rightPanel" class="right-panel">
                    <!-- Details View -->
                    <asp:Panel ID="pnlDetails" runat="server" Visible="false">
                        <div class="detail-card">

                            <!-- Mobile Back Button -->
                            <button type="button" id="mobileBackBtn" class="mobile-back-btn">
                                <i class="bi bi-arrow-left"></i> Back to Candidates
                            </button>

                            <div class="candidate-header">
                                <!-- Profile Image Large - Clickable to open modal -->
                                <asp:Image ID="imgProfileLarge" runat="server" 
                                    CssClass="profile-image-large photo-trigger"
                                    AlternateText="Profile" />
                                
                                <div class="candidate-info">
                                    <!-- Name and Position Row -->
                                    <div class="d-flex flex-wrap justify-content-between align-items-start gap-2 mb-3">
                                        <div>
                                            <div class="name"><asp:Label ID="lblFullName" runat="server" /></div>
                                            <div class="position">
                                                <asp:Label ID="lblPosition" runat="server" Text="Lecturer" />
                                                <span class="permanent">PERMANENT</span>
                                            </div>
                                        </div>
                                        <div class="text-end">
                                            <div class="total-score-label">Score Evaluation</div>
                                            <div class="total-score"><asp:Label ID="lblTotal" runat="server" /> <span style="font-size:16px; font-weight:600; color:#94a3b8;">/ 100 PTS</span></div>
                                        </div>
                                    </div>

                                    <!-- Info Grid - 2 Columns on Desktop, Stacked on Mobile -->
                                    <div class="info-grid">
                                        <div class="info-item">
                                            <div class="info-label"><i class="bi bi-envelope"></i> EMAIL ADDRESS</div>
                                            <div class="info-value"><asp:Label ID="lblEmail" runat="server" /></div>
                                        </div>
                                        <div class="info-item">
                                            <div class="info-label"><i class="bi bi-telephone"></i> PHONE</div>
                                            <div class="info-value"><asp:Label ID="lblPhone" runat="server" Text="Not provided" /></div>
                                        </div>
                                        <div class="info-item">
                                            <div class="info-label"><i class="bi bi-calendar3"></i> APPLIED ON</div>
                                            <div class="info-value"><asp:Label ID="lblSubmittedDate" runat="server" /></div>
                                        </div>
                                        <div class="info-item">
                                            <div class="info-label"><i class="bi bi-file-earmark-text"></i> CV / RESUME</div>
                                            <div class="info-value d-flex align-items-center gap-2 flex-wrap">
                                                <asp:Label ID="lblCVStatus" runat="server" Text="Loading..." Font-Bold="true" />
                                                <asp:Button ID="btnDownloadCV" runat="server" 
                                                    Text="Download CV" 
                                                    CssClass="btn btn-download-cv"
                                                    OnClick="btnDownloadCV_Click"
                                                    Visible="false" />
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Status Dropdown -->
                                    <div class="mt-3">
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

                            <hr class="my-4" />

                            <div class="row g-3 mb-4">
                                <div class="col-4">
                                    <div class="score-box score-academic">
                                        <div class="score-label">Academics</div>
                                        <div class="score-value"><asp:Label ID="lblAcademic" runat="server" /></div>
                                        <div class="score-max">/ 50</div>
                                    </div>
                                </div>
                                <div class="col-4">
                                    <div class="score-box score-experience">
                                        <div class="score-label">Experience</div>
                                        <div class="score-value"><asp:Label ID="lblExperience" runat="server" /></div>
                                        <div class="score-max">/ 25</div>
                                    </div>
                                </div>
                                <div class="col-4">
                                    <div class="score-box score-publications">
                                        <div class="score-label">Publications</div>
                                        <div class="score-value"><asp:Label ID="lblResearch" runat="server" /></div>
                                        <div class="score-max">/ 25</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Education -->
                            <h6 class="section-header"><i class="bi bi-mortarboard"></i> Education History</h6>
                            <asp:Repeater ID="rptEducation" runat="server">
                                <ItemTemplate>
                                    <div class="edu-item">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div class="edu-degree"><%# Eval("Degree") %></div>
                                            <span class="edu-percentage"><%# Eval("Percentage", "{0:F0}") %>%</span>
                                        </div>
                                        <div class="edu-institute"><%# Eval("Institute") %></div>
                                        <div class="edu-year"><%# Eval("StatusText") %> <%# Eval("Year") %></div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:Panel ID="pnlNoEducation" runat="server" Visible="false">
                                <p class="empty-message">No education records found.</p>
                            </asp:Panel>

                            <!-- Experience -->
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

                            <!-- Publications -->
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

                    <!-- Select Placeholder -->
                    <asp:Panel ID="pnlSelect" runat="server" Visible="true">
                        <div class="select-placeholder">
                            <i class="bi bi-search"></i>
                            <h5>Select a Candidate</h5>
                            <p>Choose a candidate from the list to view details</p>
                        </div>
                    </asp:Panel>
                </div>

            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // ============================================
        // PHOTO VIEWER MODAL
        // ============================================
        var photoModal = document.getElementById('photoModal');
        var modalPhotoImage = document.getElementById('modalPhotoImage');
        var modalPhotoName = document.getElementById('modalPhotoName');

        function openPhotoModal(element) {
            // Get the image source
            var imgSrc = element.src;

            // If the image is the default avatar, don't open the modal
            if (imgSrc.includes('default-avatar.png')) {
                return;
            }

            modalPhotoImage.src = imgSrc;

            // Get candidate name from the page
            var nameLabel = document.getElementById('lblFullName');
            if (nameLabel && nameLabel.textContent) {
                modalPhotoName.textContent = nameLabel.textContent;
            } else {
                // Try to get from the avatar's parent card
                var card = element.closest('.candidate-card');
                if (card) {
                    var nameSpan = card.querySelector('.candidate-name');
                    if (nameSpan) {
                        modalPhotoName.textContent = nameSpan.textContent;
                    }
                }
            }

            photoModal.classList.add('active');
            document.body.style.overflow = 'hidden';
        }

        function closePhotoModal(event) {
            if (event) {
                event.stopPropagation();
            }
            photoModal.classList.remove('active');
            document.body.style.overflow = '';
        }

        // Close modal on Escape key
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape' && photoModal.classList.contains('active')) {
                closePhotoModal(e);
            }
        });

        // ============================================
        // ATTACH CLICK EVENTS TO ALL CANDIDATE IMAGES
        // ============================================
        document.addEventListener('DOMContentLoaded', function () {
            // For all images with class 'photo-trigger'
            document.querySelectorAll('.photo-trigger').forEach(function (img) {
                img.addEventListener('click', function (e) {
                    // Stop the click from bubbling up to parent elements
                    e.stopPropagation();
                    e.preventDefault();

                    if (this.src && !this.src.includes('default-avatar.png')) {
                        openPhotoModal(this);
                    }
                });
            });

            // If user clicks on the modal background, close it
            photoModal.addEventListener('click', function (e) {
                if (e.target === this) {
                    closePhotoModal(e);
                }
            });
        });

        // ============================================
        // MOBILE NAVIGATION
        // ============================================
        (function () {
            var hamburgerBtn = document.getElementById('hamburgerBtn');
            var sidebar = document.getElementById('sidebar');
            var overlay = document.getElementById('mobileOverlay');
            var leftPanel = document.getElementById('leftPanel');
            var rightPanel = document.getElementById('rightPanel');
            var mobileBackBtn = document.getElementById('mobileBackBtn');
            var isMobile = window.innerWidth <= 768;

            function updateMobileState() {
                isMobile = window.innerWidth <= 768;
                if (!isMobile) {
                    sidebar.classList.remove('mobile-open');
                    overlay.classList.remove('active');
                    overlay.style.display = 'none';
                    leftPanel.classList.remove('mobile-hidden');
                    rightPanel.classList.remove('mobile-show');
                    leftPanel.style.position = '';
                    leftPanel.style.width = '';
                    leftPanel.style.zIndex = '';
                    rightPanel.style.position = '';
                    rightPanel.style.zIndex = '';
                    if (hamburgerBtn) {
                        hamburgerBtn.querySelector('i').className = 'bi bi-list';
                    }
                    leftPanel.style.display = '';
                    rightPanel.style.display = '';
                } else {
                    overlay.style.display = 'block';
                    leftPanel.style.display = '';
                    rightPanel.style.display = '';
                    leftPanel.classList.remove('mobile-hidden');
                    rightPanel.classList.remove('mobile-show');
                    var pnlDetails = document.querySelector('#pnlDetails');
                    if (pnlDetails && pnlDetails.style.display !== 'none') {
                        showDetailsView();
                    }
                }
            }

            function toggleMobileMenu(e) {
                e.stopPropagation();
                if (!isMobile) return;
                sidebar.classList.toggle('mobile-open');
                overlay.classList.toggle('active');
                var icon = hamburgerBtn.querySelector('i');
                if (sidebar.classList.contains('mobile-open')) {
                    icon.className = 'bi bi-x-lg';
                } else {
                    icon.className = 'bi bi-list';
                }
            }

            function closeMobileMenu() {
                if (isMobile) {
                    sidebar.classList.remove('mobile-open');
                    overlay.classList.remove('active');
                    if (hamburgerBtn) {
                        hamburgerBtn.querySelector('i').className = 'bi bi-list';
                    }
                }
            }

            function showDetailsView() {
                if (!isMobile) return;
                leftPanel.classList.add('mobile-hidden');
                leftPanel.style.display = 'none';
                rightPanel.classList.add('mobile-show');
                rightPanel.style.display = 'block';
                closeMobileMenu();
                rightPanel.scrollTop = 0;
            }

            function showListView() {
                if (!isMobile) return;
                leftPanel.classList.remove('mobile-hidden');
                leftPanel.style.display = '';
                rightPanel.classList.remove('mobile-show');
                rightPanel.style.display = '';
                var listContainer = leftPanel.querySelector('.candidate-list-container');
                if (listContainer) {
                    listContainer.scrollTop = 0;
                }
            }

            if (hamburgerBtn) {
                hamburgerBtn.addEventListener('click', toggleMobileMenu);
            }

            if (overlay) {
                overlay.addEventListener('click', closeMobileMenu);
            }

            document.querySelectorAll('.sidebar .nav-link').forEach(function (link) {
                link.addEventListener('click', function () {
                    if (isMobile) {
                        closeMobileMenu();
                    }
                });
            });

            if (mobileBackBtn) {
                mobileBackBtn.addEventListener('click', function (e) {
                    e.preventDefault();
                    showListView();
                });
            }

            document.querySelectorAll('.candidate-card').forEach(function (card) {
                card.addEventListener('click', function (e) {
                    // Check if the click was on the avatar image
                    if (e.target.closest('.photo-trigger')) {
                        return; // Don't navigate to details if clicking on avatar
                    }
                    if (isMobile) {
                        setTimeout(function () {
                            var pnlDetails = document.querySelector('#pnlDetails');
                            if (pnlDetails && pnlDetails.style.display !== 'none') {
                                showDetailsView();
                            }
                        }, 200);
                    }
                });
            });

            var toggleBtn = document.getElementById('toggleSidebarBtn');
            var content = document.getElementById('content');
            if (toggleBtn) {
                var toggleIcon = toggleBtn.querySelector('i');
                toggleBtn.addEventListener('click', function (e) {
                    e.stopPropagation();
                    if (window.innerWidth > 768) {
                        sidebar.classList.toggle('collapsed');
                        content.classList.toggle('expanded');
                        if (sidebar.classList.contains('collapsed')) {
                            toggleIcon.className = 'bi bi-arrow-right-circle';
                        } else {
                            toggleIcon.className = 'bi bi-arrow-left-circle';
                        }
                    } else {
                        toggleMobileMenu(e);
                    }
                });
            }

            var resizeTimer;
            window.addEventListener('resize', function () {
                clearTimeout(resizeTimer);
                resizeTimer = setTimeout(function () {
                    updateMobileState();
                }, 300);
            });

            updateMobileState();

            var selectedCard = document.querySelector('.candidate-card.active');
            if (selectedCard && window.innerWidth <= 768) {
                setTimeout(function () {
                    selectedCard.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }, 400);
            }

            setTimeout(function () {
                var pnlDetails = document.querySelector('#pnlDetails');
                if (pnlDetails && pnlDetails.style.display !== 'none' && window.innerWidth <= 768) {
                    showDetailsView();
                }
            }, 200);
        })();
    </script>
</body>
</html>