<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminCandidatesView.aspx.cs" Inherits="WebApplication4.AdminCandidatesView" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>Candidate Pipeline</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Georgia&display=swap" rel="stylesheet" />

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

        body {
            background: var(--page-bg);
            font-family: var(--font-ui);
            color: var(--body-text);
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
            top: 0; left: 0;
            width: 250px;
            height: 100vh;
            background: var(--primary-navy);
            color: #fff;
            display: flex;
            flex-direction: column;
            overflow: hidden;
            transition: all .35s ease;
            z-index: 1000;
            border-right: 1px solid rgba(255,255,255,0.06);
        }
        .sidebar.collapsed { width: 80px; }
        .sidebar.collapsed .nav-link span { display: none; }
        .sidebar.collapsed .nav-link i { width: 100%; min-width: unset; }
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
            font-size: 22px;
            cursor: pointer;
            padding: 8px;
            border-radius: var(--radius);
            transition: background .2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .sidebar-header .toggle-btn:hover { background: rgba(255,255,255,.08); }
        .sidebar-header .toggle-btn i { font-size: 22px; }
        .sidebar .nav { margin-top: 18px; padding: 0; list-style: none; }
        .sidebar .nav-item { margin-bottom: 6px; }
        .sidebar .nav-link {
            display: flex;
            align-items: center;
            height: 50px;
            margin: 0 12px;
            padding: 0 16px;
            border-radius: var(--radius);
            color: #d7dce6;
            text-decoration: none;
            transition: background .2s ease, color .2s ease;
            white-space: nowrap;
            font-family: var(--font-ui);
            font-size: 14px;
            font-weight: 500;
        }
        .sidebar .nav-link:hover { background: var(--secondary-navy); color: #fff; }
        .sidebar .nav-link.active { background: var(--action-blue); color: #fff; }
        .sidebar .nav-link i {
            width: 42px; min-width: 42px;
            text-align: center;
            font-size: 18px;
        }
        .logout { display: none; }

        /* ============================================
           CONTENT WRAPPER (layout unchanged)
        ============================================ */
        .content {
            margin-left: 250px;
            width: calc(100% - 250px);
            height: 100vh;
            overflow: hidden;
            background: var(--page-bg);
            transition: all .35s ease;
            display: flex;
            flex-direction: column;
        }
        .content.expanded {
            margin-left: 80px;
            width: calc(100% - 80px);
        }

        /* ============================================
           PIPELINE CONTAINER (layout unchanged)
        ============================================ */
        .pipeline-container {
            display: flex;
            flex: 1;
            gap: 0;
            overflow: hidden;
        }

        /* ============================================
           LEFT PANEL — candidate list
        ============================================ */
        .left-panel {
            width: 320px;
            min-width: 320px;
            background: var(--card-bg);
            border-right: 1px solid var(--border);
            padding: 16px;
            overflow-y: auto;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .left-panel .pipeline-title {
            font-family: var(--font-heading);
            font-size: 20px;
            font-weight: 600;
            color: var(--primary-navy);
            margin-bottom: 12px;
        }
        .left-panel .search-box {
            width: 100%;
            padding: 10px 14px 10px 38px;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            font-family: var(--font-ui);
            font-size: 13px;
            background: var(--input-bg) url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="%23718096" stroke-width="2"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>') no-repeat 12px center;
            background-size: 14px;
            color: var(--body-text);
            transition: border-color 0.15s ease, box-shadow 0.15s ease;
        }
        .left-panel .search-box::placeholder { color: var(--placeholder); }
        .left-panel .search-box:focus {
            outline: none;
            border-color: var(--action-blue);
            background-color: #ffffff;
            box-shadow: 0 0 0 2px rgba(23, 105, 168, 0.08);
        }
        .left-panel .tabs {
            display: flex;
            gap: 6px;
            margin: 12px 0;
            flex-wrap: wrap;
            align-items: center;
        }
        .left-panel .tab-btn {
            padding: 5px 14px;
            border-radius: 20px;
            font-family: var(--font-ui);
            font-size: 11px;
            font-weight: 600;
            border: 1px solid var(--border);
            background: #ffffff;
            color: var(--muted-text);
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-block;
        }
        .left-panel .tab-btn:hover {
            background: #F1F5F9;
            border-color: var(--action-blue);
            color: var(--action-blue);
        }
        .left-panel .tab-btn.active {
            background: var(--action-blue);
            color: #ffffff;
            border-color: var(--action-blue);
        }

        /* Page size dropdown */
        .page-size-selector { display: inline-block; margin-left: auto; }
        .page-size-dropdown {
            padding: 5px 12px;
            border-radius: 20px;
            font-family: var(--font-ui);
            font-size: 11px;
            font-weight: 600;
            border: 1px solid var(--border);
            background: #ffffff;
            color: var(--muted-text);
            cursor: pointer;
            transition: all 0.2s;
            height: 30px;
            min-width: 100px;
            outline: none;
        }
        .page-size-dropdown:hover { background: #F1F5F9; }
        .page-size-dropdown:focus {
            border-color: var(--action-blue);
            box-shadow: 0 0 0 2px rgba(23, 105, 168, 0.08);
        }

        /* ============================================
           CANDIDATE CARD
        ============================================ */
        .candidate-card {
            cursor: pointer;
            padding: 12px 14px;
            border: 1px solid var(--border);
            border-radius: var(--radius);
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
            border-color: var(--action-blue);
            box-shadow: 0 2px 8px rgba(23, 105, 168, 0.08);
        }
        .candidate-card.active {
            border-color: var(--action-blue);
            background: #EFF6FF;
            box-shadow: 0 2px 8px rgba(23, 105, 168, 0.10);
        }
        .candidate-card .avatar-img {
            width: 36px; height: 36px;
            border-radius: 50%;
            object-fit: cover;
            background: #F1F5F9;
            flex-shrink: 0;
            cursor: pointer;
            transition: transform 0.2s ease;
            border: 1px solid var(--border);
        }
        .candidate-card .avatar-img:hover { transform: scale(1.05); }
        .candidate-card .avatar-placeholder {
            width: 36px; height: 36px;
            border-radius: 50%;
            background: var(--action-blue);
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: var(--font-ui);
            font-weight: 700;
            font-size: 14px;
            flex-shrink: 0;
        }
        .candidate-card .candidate-name {
            font-family: var(--font-ui);
            font-weight: 600;
            font-size: 14px;
            color: var(--primary-navy);
        }
        .candidate-card .candidate-email {
            font-family: var(--font-ui);
            font-size: 12px;
            color: var(--muted-text);
        }
        .candidate-card .score-badge {
            background: #EEF2F6;
            padding: 2px 10px;
            border-radius: 12px;
            font-family: var(--font-ui);
            font-size: 13px;
            font-weight: 700;
            color: var(--primary-navy);
        }
        .candidate-card .status-badge {
            font-family: var(--font-ui);
            font-size: 9px;
            font-weight: 700;
            padding: 2px 10px;
            border-radius: 12px;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            display: inline-block;
        }
        .status-pending { background: #FEF3C7; color: #92400E; }
        .status-shortlisted { background: #D1FAE5; color: #065F46; }
        .status-rejected { background: #FEE2E2; color: #991B1B; }
        .status-hired { background: #E0E7FF; color: #3730A3; }

        /* ============================================
           RIGHT PANEL
        ============================================ */
        .right-panel {
            flex: 1;
            background: var(--page-bg);
            padding: 20px;
            overflow-y: auto;
            height: 100%;
        }

        /* ============================================
           DETAIL CARD
        ============================================ */
        .detail-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 24px 28px;
            box-shadow: 0 1px 3px rgba(15,23,42,0.03);
        }

        /* ============================================
           CANDIDATE HEADER
        ============================================ */
        .candidate-header {
            display: flex;
            align-items: flex-start;
            gap: 20px;
        }
        .candidate-header .profile-image-large {
            width: 80px; height: 80px;
            border-radius: 50%;
            object-fit: cover;
            background: #F1F5F9;
            flex-shrink: 0;
            border: 3px solid var(--border);
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .candidate-header .profile-image-large:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 12px rgba(23,105,168,0.15);
        }
        .candidate-header .profile-placeholder-large {
            width: 80px; height: 80px;
            border-radius: 50%;
            background: var(--action-blue);
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: var(--font-ui);
            font-weight: 700;
            font-size: 32px;
            flex-shrink: 0;
            border: 3px solid var(--border);
        }
        .candidate-header .candidate-info { flex: 1; }
        .candidate-header .name {
            font-family: var(--font-heading);
            font-size: 1.6rem;
            font-weight: 700;
            color: var(--primary-navy);
            letter-spacing: -0.2px;
        }
        .candidate-header .position {
            font-family: var(--font-ui);
            font-size: 14px;
            font-weight: 500;
            color: var(--body-text);
        }
        .candidate-header .position .permanent {
            color: var(--action-blue);
            font-weight: 600;
        }
        .candidate-header .info-label {
            font-family: var(--font-ui);
            font-size: 11px;
            font-weight: 700;
            color: var(--muted-text);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-top: 12px;
            margin-bottom: 2px;
        }
        .candidate-header .info-value {
            font-family: var(--font-ui);
            font-size: 14px;
            color: var(--body-text);
            font-weight: 500;
        }
        .candidate-header .total-score-label {
            font-family: var(--font-ui);
            font-size: 13px;
            font-weight: 600;
            color: var(--muted-text);
        }
        .candidate-header .total-score {
            font-family: var(--font-heading);
            font-size: 28px;
            font-weight: 700;
            color: var(--primary-navy);
        }

        /* ============================================
           INFO GRID
        ============================================ */
        .candidate-header .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px 30px;
            margin-top: 4px;
        }
        .candidate-header .info-item { display: flex; flex-direction: column; }
        .candidate-header .info-item .info-label {
            font-family: var(--font-ui);
            font-size: 10px;
            font-weight: 700;
            color: var(--muted-text);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 1px;
            display: flex;
            align-items: center;
            gap: 4px;
        }
        .candidate-header .info-item .info-label i { font-size: 11px; }
        .candidate-header .info-item .info-value {
            font-family: var(--font-ui);
            font-size: 14px;
            color: var(--body-text);
            font-weight: 500;
        }

        /* Download CV Button */
        .btn-download-cv {
            background: var(--action-blue);
            color: #ffffff;
            border: none;
            border-radius: var(--radius);
            padding: 5px 14px;
            font-family: var(--font-ui);
            font-size: 12px;
            font-weight: 600;
            transition: all 0.2s ease;
            cursor: pointer;
        }
        .btn-download-cv:hover {
            background: var(--action-blue-hover);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(23,105,168,0.25);
            color: #ffffff;
        }
        .btn-download-cv:active { transform: translateY(0); }

        /* Status Dropdown */
        .status-dropdown {
            border-radius: var(--radius);
            padding: 7px 14px;
            font-family: var(--font-ui);
            font-size: 13px;
            font-weight: 600;
            border: 1px solid var(--border);
            background: #ffffff;
            min-width: 160px;
            color: var(--body-text);
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .status-dropdown:hover { border-color: var(--action-blue); }
        .status-dropdown:focus {
            outline: none;
            border-color: var(--action-blue);
            box-shadow: 0 0 0 2px rgba(23,105,168,0.08);
        }

        /* CV status */
        .cv-status-available {
            color: #059669;
            font-family: var(--font-ui);
            font-weight: 600;
            font-size: 13px;
        }
        .cv-status-unavailable {
            color: var(--error-red);
            font-family: var(--font-ui);
            font-weight: 600;
            font-size: 13px;
        }

        /* ============================================
           SECTION HEADERS
        ============================================ */
        .section-header {
            font-family: var(--font-heading);
            font-size: 20px;
            font-weight: 600;
            color: var(--primary-navy);
            letter-spacing: -0.2px;
            margin-bottom: 12px;
            border-bottom: 1px solid var(--divider);
            padding-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .section-header i {
            color: var(--action-blue);
            font-size: 16px;
        }

        /* ============================================
           SCORE BOXES
        ============================================ */
        .score-box {
            background: #F8FAFC;
            border-radius: var(--radius);
            padding: 14px 16px;
            text-align: center;
            border: 1px solid var(--divider);
        }
        .score-box .score-label {
            font-family: var(--font-ui);
            font-size: 12px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .score-box .score-value {
            font-family: var(--font-heading);
            font-size: 2.25rem;
            font-weight: 700;
            color: var(--primary-navy);
            line-height: 1.1;
        }
        .score-box .score-max {
            font-family: var(--font-ui);
            font-size: 13px;
            color: var(--muted-text);
            font-weight: 600;
        }
        .score-academic .score-label { color: #4F46E5; }
        .score-experience .score-label { color: #059669; }
        .score-publications .score-label { color: #E11D48; }

        /* ============================================
           EDUCATION / EXPERIENCE / PUBLICATION ITEMS
        ============================================ */
        .edu-item, .exp-item, .pub-item {
            padding: 12px 14px;
            background: #F8FAFC;
            border-radius: var(--radius);
            margin-bottom: 8px;
            border: 1px solid var(--divider);
        }
        .edu-item .edu-degree,
        .exp-item .exp-title,
        .pub-item .pub-title {
            font-family: var(--font-ui);
            font-weight: 700;
            color: var(--primary-navy);
            font-size: 14px;
        }
        .edu-item .edu-institute,
        .exp-item .exp-org,
        .pub-item .pub-journal {
            font-family: var(--font-ui);
            color: var(--muted-text);
            font-size: 13px;
        }
        .edu-item .edu-year,
        .exp-item .exp-date,
        .pub-item .pub-year {
            font-family: var(--font-ui);
            color: var(--placeholder);
            font-size: 12px;
        }
        .edu-item .edu-percentage {
            font-family: var(--font-ui);
            font-size: 11px;
            font-weight: 600;
            color: var(--primary-navy);
            background: #EEF2F6;
            padding: 2px 10px;
            border-radius: 10px;
        }
        .pub-item .pub-category {
            display: inline-block;
            background: #E0E7FF;
            color: #3730A3;
            font-family: var(--font-ui);
            font-size: 10px;
            font-weight: 700;
            padding: 2px 10px;
            border-radius: 10px;
        }

        .select-placeholder {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100%;
            flex-direction: column;
            color: var(--placeholder);
        }
        .select-placeholder i {
            font-size: 48px;
            color: var(--border);
        }
        .select-placeholder h5 {
            margin-top: 16px;
            font-family: var(--font-heading);
            font-weight: 600;
            color: var(--primary-navy);
            font-size: 20px;
        }
        .select-placeholder p {
            font-family: var(--font-ui);
            font-size: 14px;
            color: var(--muted-text);
        }

        .empty-message {
            font-family: var(--font-ui);
            color: var(--placeholder);
            font-size: 13px;
            padding: 8px 0;
        }

        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: #F1F4F9; }
        ::-webkit-scrollbar-thumb { background: #CBD5E1; border-radius: 10px; }
        ::-webkit-scrollbar-thumb:hover { background: #94A3B8; }

        /* ============================================
           PHOTO VIEWER MODAL
        ============================================ */
        .photo-modal {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(18, 48, 74, 0.92);
            z-index: 9999;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
            backdrop-filter: blur(8px);
        }
        .photo-modal.active { display: flex; opacity: 1; }
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
            border-radius: var(--radius-lg);
            box-shadow: 0 20px 60px rgba(0,0,0,0.5);
            object-fit: contain;
            background: var(--primary-navy);
            border: 2px solid rgba(255,255,255,0.1);
        }
        .photo-modal .modal-close {
            position: fixed;
            top: 20px; right: 30px;
            color: #fff;
            font-size: 40px;
            font-weight: 300;
            cursor: pointer;
            transition: transform 0.2s ease, color 0.2s ease;
            z-index: 10000;
            background: rgba(255,255,255,0.1);
            width: 50px; height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: none;
            line-height: 1;
        }
        .photo-modal .modal-close:hover {
            transform: rotate(90deg);
            color: #ff8080;
            background: rgba(255,255,255,0.2);
        }
        .photo-modal .modal-close i { font-size: 28px; }
        .photo-modal .modal-caption {
            position: fixed;
            bottom: 40px;
            left: 50%;
            transform: translateX(-50%);
            color: #fff;
            font-family: var(--font-ui);
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
        .photo-modal .modal-caption i { margin-right: 10px; opacity: 0.7; }

        @keyframes zoomIn {
            from { transform: scale(0.8); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }

        @media only screen and (max-width: 768px) {
            .photo-modal .modal-close { top: 15px; right: 15px; width: 40px; height: 40px; }
            .photo-modal .modal-close i { font-size: 20px; }
            .photo-modal .modal-content img { max-height: 70vh; border-radius: var(--radius); }
            .photo-modal .modal-caption { bottom: 20px; font-size: 13px; padding: 8px 16px; max-width: 90%; white-space: normal; }
        }
        @media only screen and (max-width: 480px) {
            .photo-modal .modal-close { top: 10px; right: 10px; width: 35px; height: 35px; }
            .photo-modal .modal-close i { font-size: 16px; }
            .photo-modal .modal-content img { max-height: 60vh; border-radius: var(--radius); }
            .photo-modal .modal-caption { bottom: 15px; font-size: 12px; padding: 6px 14px; }
        }

        /* ============================================
           MOBILE / TABLET (<=965px) — behavior preserved
        ============================================ */
        @media only screen and (max-width: 965px) {
            body { overflow: hidden; position: relative; }
            .mobile-header { display: flex !important; }
            .hamburger-btn {
                display: flex !important;
                position: relative;
                z-index: 1002;
                width: 40px; height: 40px;
                background: none !important;
                border: none;
                color: var(--action-blue);
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
                top: 0; left: 0;
            }
            .sidebar.mobile-open { transform: translateX(0); }
            .sidebar.collapsed { width: 280px; }
            .sidebar.collapsed .nav-link span { display: inline; }
            .sidebar.collapsed .nav-link i { width: 42px; min-width: 42px; }
            .sidebar-header .toggle-btn { display: none; }

            .content {
                margin-left: 0 !important;
                width: 100% !important;
                padding-top: 56px;
                height: 100vh;
            }
            .content.expanded { margin-left: 0 !important; width: 100% !important; }

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
                background: var(--page-bg);
                position: absolute;
                top: 0; left: 0; right: 0; bottom: 0;
                z-index: 1;
                transition: all 0.3s ease;
                overflow: hidden;
            }
            .left-panel.mobile-hidden { display: none !important; }
            .left-panel .pipeline-title { display: none; }
            .left-panel .search-box {
                font-size: 14px;
                padding: 10px 14px 10px 40px;
                background-size: 16px;
                border-radius: var(--radius);
                margin-top: 0;
                flex-shrink: 0;
                background-color: #ffffff;
                border: 1px solid var(--border);
            }
            .left-panel .tabs {
                margin: 10px 0 12px 0;
                gap: 6px;
                flex-shrink: 0;
                padding-bottom: 8px;
                border-bottom: 1px solid var(--divider);
                display: flex;
                flex-wrap: wrap;
                align-items: center;
            }
            .left-panel .tab-btn {
                font-size: 11px;
                padding: 5px 14px;
                border-radius: 20px;
            }
            .page-size-selector { margin-left: auto; flex-shrink: 0; }
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
                border-radius: var(--radius);
                border: 1px solid var(--border);
                background: #ffffff;
                box-shadow: 0 1px 3px rgba(15,23,42,0.04);
                min-height: 64px;
            }
            .candidate-card:active { transform: scale(0.98); background: #F8FAFC; }
            .candidate-card .avatar-img { width: 40px; height: 40px; font-size: 16px; }
            .candidate-card .avatar-placeholder { width: 40px; height: 40px; font-size: 16px; }
            .candidate-card .candidate-name { font-size: 15px; font-weight: 600; }
            .candidate-card .candidate-email { font-size: 12px; margin-top: 1px; }
            .candidate-card .score-badge { font-size: 12px; padding: 2px 12px; }
            .candidate-card .status-badge { font-size: 9px; padding: 2px 12px; }

            .right-panel {
                display: none !important;
                height: 100% !important;
                padding: 10px 12px 20px 12px;
                background: var(--page-bg);
                overflow-y: auto;
                -webkit-overflow-scrolling: touch;
                position: absolute;
                top: 0; left: 0; right: 0; bottom: 0;
                z-index: 2;
                width: 100% !important;
            }
            .right-panel.mobile-show { display: block !important; }

            .detail-card {
                padding: 16px 16px 60px 16px;
                border-radius: var(--radius-lg);
                margin-bottom: 10px;
            }
            .mobile-back-btn { display: flex !important; flex-shrink: 0; }

            .candidate-header { flex-direction: column; align-items: center; text-align: center; gap: 12px; width: 100%; }
            .candidate-header .profile-image-large { width: 60px !important; height: 60px !important; }
            .candidate-header .profile-placeholder-large { width: 60px !important; height: 60px !important; font-size: 24px !important; }
            .candidate-header .candidate-info { width: 100%; }
            .candidate-header .candidate-info .d-flex { flex-direction: column; align-items: center !important; width: 100%; }
            .candidate-header .name { font-size: 20px !important; text-align: center; width: 100%; }
            .candidate-header .position { font-size: 13px !important; text-align: center; width: 100%; }
            .candidate-header .text-end { text-align: center !important; width: 100%; margin-top: 4px; }
            .candidate-header .total-score { font-size: 24px !important; text-align: center; }
            .candidate-header .total-score-label { font-size: 11px !important; text-align: center; }
            .candidate-header .info-grid { display: block; margin-top: 8px; width: 100%; }
            .candidate-header .info-item {
                display: flex;
                flex-direction: column;
                align-items: center;
                margin-bottom: 10px;
                width: 100%;
                padding: 6px 0;
                border-bottom: 1px solid #F0F2F5;
            }
            .candidate-header .info-item:last-child { border-bottom: none; }
            .candidate-header .info-item .info-label { font-size: 9px; text-align: center; width: 100%; justify-content: center; }
            .candidate-header .info-item .info-value { font-size: 13px; text-align: center; width: 100%; justify-content: center; }
            .candidate-header .info-item .info-value.d-flex { justify-content: center; flex-wrap: wrap; }
            .candidate-header .total-score span { font-size: 14px !important; }
            .btn-download-cv { font-size: 11px; padding: 3px 12px; }
            .status-dropdown {
                font-size: 12px;
                padding: 5px 12px;
                min-width: 140px;
                width: 100%;
                max-width: 200px;
                margin: 0 auto;
                display: block;
            }
            .candidate-header .mt-3 { text-align: center; width: 100%; }
            .score-box { padding: 12px 8px; }
            .score-box .score-value { font-size: 1.6rem; }
            .score-box .score-label { font-size: 10px; }
            .score-box .score-max { font-size: 11px; }
            .section-header {
                font-size: 16px;
                margin-bottom: 8px;
                padding-bottom: 6px;
                white-space: normal !important;
                word-wrap: break-word !important;
                overflow-wrap: break-word !important;
                word-break: break-word;
            }
            .edu-item, .exp-item, .pub-item { padding: 10px 14px; margin-bottom: 6px; border-radius: var(--radius); }
            .edu-item .edu-degree, .exp-item .exp-title, .pub-item .pub-title { font-size: 14px; }
            .edu-item .edu-institute, .exp-item .exp-org, .pub-item .pub-journal { font-size: 13px; }
            .edu-item .edu-year, .exp-item .exp-date, .pub-item .pub-year { font-size: 12px; }
            .edu-item .edu-percentage { font-size: 11px; }
            .empty-message { font-size: 12px; }
            .select-placeholder { min-height: 300px; }
            .select-placeholder i { font-size: 40px; }
            .select-placeholder h5 { font-size: 16px; }
            .select-placeholder p { font-size: 13px; }
        }

        @media only screen and (max-width: 480px) {
            .mobile-header { height: 48px; padding: 0 12px; }
            .mobile-header .mobile-title { font-size: 15px; }
            .hamburger-btn { width: 32px; height: 32px; font-size: 22px; }
            .hamburger-btn i { font-size: 22px; }
            .content { padding-top: 48px; }
            .pipeline-container { height: calc(100vh - 48px); }
            .left-panel { padding: 8px 10px 16px 10px; }
            .left-panel .search-box { font-size: 12px; padding: 8px 12px 8px 34px; background-size: 14px; }
            .left-panel .tab-btn { font-size: 9px; padding: 4px 10px; }
            .page-size-dropdown { font-size: 9px; padding: 2px 8px; min-width: 70px; height: 24px; }
            .left-panel .candidate-list-container { padding-bottom: 100px; }
            .candidate-card { padding: 10px 12px; margin-bottom: 8px; min-height: 56px; }
            .candidate-card .avatar-img { width: 34px; height: 34px; font-size: 13px; }
            .candidate-card .avatar-placeholder { width: 34px; height: 34px; font-size: 13px; }
            .candidate-card .candidate-name { font-size: 13px; }
            .candidate-card .candidate-email { font-size: 11px; }
            .candidate-card .score-badge { font-size: 10px; padding: 1px 10px; }
            .candidate-card .status-badge { font-size: 8px; padding: 1px 10px; }
            .right-panel { padding: 6px 10px 16px 10px; }
            .detail-card { padding: 12px 12px 50px 12px; }
            .candidate-header .profile-image-large { width: 50px !important; height: 50px !important; }
            .candidate-header .profile-placeholder-large { width: 50px !important; height: 50px !important; font-size: 20px !important; }
            .candidate-header .name { font-size: 17px !important; }
            .candidate-header .position { font-size: 12px !important; }
            .candidate-header .total-score { font-size: 20px !important; }
            .candidate-header .info-item .info-label { font-size: 8px; }
            .candidate-header .info-item .info-value { font-size: 12px; }
            .btn-download-cv { font-size: 10px; padding: 2px 10px; }
            .status-dropdown { font-size: 11px; padding: 4px 10px; min-width: 120px; width: 100%; max-width: 200px; }
            .candidate-header .total-score-label { font-size: 10px !important; }
            .candidate-header .total-score span { font-size: 13px !important; }
            .score-box .score-value { font-size: 1.3rem; }
        }

        @media only screen and (min-width: 966px) and (max-width: 1024px) {
            .candidate-header .info-grid { grid-template-columns: 1fr 1fr; gap: 10px 25px; }
            .candidate-header .profile-image-large { width: 70px !important; height: 70px !important; }
        }

        @media (hover: none) and (pointer: coarse) {
            .candidate-card { min-height: 64px; }
            .candidate-card .candidate-name { font-size: 16px; }
            .tab-btn { padding: 6px 16px !important; font-size: 12px !important; }
        }

        @media only screen and (min-width: 965px) and (max-width: 1055px) {
            .candidate-header .info-item .info-value.d-flex { flex-wrap: wrap; gap: 6px; }
            .btn-download-cv { font-size: 11px; padding: 3px 12px; white-space: nowrap; flex-shrink: 0; }
            .candidate-header .info-item .info-value.d-flex .cv-status-available,
            .candidate-header .info-item .info-value.d-flex .cv-status-unavailable { font-size: 12px; white-space: nowrap; }
            .section-header { font-size: 16px; white-space: normal !important; word-wrap: break-word !important; overflow-wrap: break-word !important; word-break: break-word; }
            .section-header i { margin-right: 6px; font-size: 15px; flex-shrink: 0; }
            .candidate-header .info-grid { gap: 8px 15px; }
            .candidate-header .info-item .info-value { font-size: 13px; word-wrap: break-word; overflow-wrap: break-word; max-width: 100%; }
            .detail-card { padding: 20px 22px; overflow: hidden; max-width: 100%; }
            .candidate-header { gap: 16px; max-width: 100%; overflow: hidden; }
            .candidate-header .candidate-info { min-width: 0; max-width: 100%; overflow: hidden; }
            .candidate-header .name { font-size: 1.4rem; word-wrap: break-word; overflow-wrap: break-word; word-break: break-word; max-width: 100%; }
            .candidate-header .position { font-size: 13px; word-wrap: break-word; overflow-wrap: break-word; max-width: 100%; }
            .pub-item { padding: 10px 14px; overflow: hidden; max-width: 100%; }
            .pub-item .pub-title { font-size: 13px; word-wrap: break-word; overflow-wrap: break-word; word-break: break-word; max-width: 100%; }
            .pub-item .pub-journal { font-size: 12px; word-wrap: break-word; overflow-wrap: break-word; max-width: 100%; }
            .pub-item .pub-category { font-size: 9px; padding: 1px 8px; white-space: nowrap; flex-shrink: 0; }
            .pub-item .d-flex { flex-wrap: wrap; gap: 4px; }
            .edu-item, .exp-item { padding: 10px 14px; overflow: hidden; max-width: 100%; }
            .edu-item .edu-degree, .exp-item .exp-title { font-size: 13px; word-wrap: break-word; overflow-wrap: break-word; max-width: 100%; }
            .edu-item .edu-institute, .exp-item .exp-org { font-size: 12px; word-wrap: break-word; overflow-wrap: break-word; max-width: 100%; }
            .score-box { padding: 12px 10px; }
            .score-box .score-value { font-size: 1.6rem; }
            .score-box .score-label { font-size: 10px; }
            .row.g-3 { --bs-gutter-y: 0.75rem; --bs-gutter-x: 0.75rem; }
            .candidate-header .total-score { font-size: 24px; }
            .candidate-header .total-score span { font-size: 14px; }
            .status-dropdown { font-size: 12px; padding: 5px 12px; min-width: 140px; }
        }

        /* ============================================
           MOBILE HEADER
        ============================================ */
        .mobile-header {
            display: none;
            position: fixed;
            top: 0; left: 0; right: 0;
            height: 56px;
            background: #ffffff;
            z-index: 1000;
            border-bottom: 1px solid var(--border);
            align-items: center;
            justify-content: space-between;
            padding: 0 16px;
            box-shadow: 0 1px 3px rgba(15,23,42,0.06);
            width: 100%;
        }
        .mobile-header .mobile-title {
            font-family: var(--font-ui);
            font-size: 17px;
            font-weight: 700;
            color: var(--primary-navy);
            letter-spacing: 0.3px;
            text-align: right;
        }
        .hamburger-btn {
            display: none;
            background: none !important;
            border: none;
            color: var(--action-blue);
            font-size: 28px;
            padding: 0;
            cursor: pointer;
            z-index: 1002;
            transition: all 0.3s ease;
            box-shadow: none !important;
            width: 40px; height: 40px;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        .hamburger-btn:hover { transform: scale(1.05); }
        .hamburger-btn:active { transform: scale(0.95); }
        .hamburger-btn i { font-size: 28px; }

        .mobile-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(18, 48, 74, 0.5);
            z-index: 999;
            opacity: 0;
            transition: opacity 0.3s ease;
            pointer-events: none;
        }
        .mobile-overlay.active { opacity: 1; pointer-events: auto; }

        .mobile-back-btn {
            display: none;
            background: none;
            border: none;
            color: var(--action-blue);
            font-family: var(--font-ui);
            font-size: 14px;
            font-weight: 600;
            padding: 8px 0 12px 0;
            cursor: pointer;
            transition: all 0.2s;
            align-items: center;
            gap: 8px;
            width: 100%;
            text-align: left;
            margin-bottom: 8px;
            border-bottom: 1px solid var(--divider);
        }
        .mobile-back-btn i { font-size: 18px; }
        .mobile-back-btn:hover { color: var(--action-blue-hover); }
        .mobile-back-btn:active { transform: scale(0.97); }
    </style>
</head>

<body>
    <form id="form1" runat="server">

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

        <div id="mobileHeader" class="mobile-header">
            <button type="button" id="hamburgerBtn" class="hamburger-btn" aria-label="Toggle menu">
                <i class="bi bi-list"></i>
            </button>
            <span class="mobile-title">Candidate Pipeline</span>
        </div>

        <div id="mobileOverlay" class="mobile-overlay"></div>

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

        <div id="content" class="content">
            <div class="pipeline-container">

                <div id="leftPanel" class="left-panel">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="search-box"
                        placeholder="Search candidates..."
                        AutoPostBack="true"
                        OnTextChanged="txtSearch_TextChanged" />

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

                <div id="rightPanel" class="right-panel">
                    <asp:Panel ID="pnlDetails" runat="server" Visible="false">
                        <div class="detail-card">

                            <button type="button" id="mobileBackBtn" class="mobile-back-btn">
                                <i class="bi bi-arrow-left"></i> Back to Candidates
                            </button>

                            <div class="candidate-header">
                                <asp:Image ID="imgProfileLarge" runat="server"
                                    CssClass="profile-image-large photo-trigger"
                                    AlternateText="Profile" />

                                <div class="candidate-info">
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
            var imgSrc = element.src;
            if (imgSrc.includes('default-avatar.png')) { return; }
            modalPhotoImage.src = imgSrc;
            var nameLabel = document.getElementById('lblFullName');
            if (nameLabel && nameLabel.textContent) {
                modalPhotoName.textContent = nameLabel.textContent;
            } else {
                var card = element.closest('.candidate-card');
                if (card) {
                    var nameSpan = card.querySelector('.candidate-name');
                    if (nameSpan) { modalPhotoName.textContent = nameSpan.textContent; }
                }
            }
            photoModal.classList.add('active');
            document.body.style.overflow = 'hidden';
        }

        function closePhotoModal(event) {
            if (event) { event.stopPropagation(); }
            photoModal.classList.remove('active');
            document.body.style.overflow = '';
        }

        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape' && photoModal.classList.contains('active')) {
                closePhotoModal(e);
            }
        });

        document.addEventListener('DOMContentLoaded', function () {
            document.querySelectorAll('.photo-trigger').forEach(function (img) {
                img.addEventListener('click', function (e) {
                    e.stopPropagation();
                    e.preventDefault();
                    if (this.src && !this.src.includes('default-avatar.png')) {
                        openPhotoModal(this);
                    }
                });
            });
            photoModal.addEventListener('click', function (e) {
                if (e.target === this) { closePhotoModal(e); }
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
            var isMobile = window.innerWidth <= 965;

            function updateMobileState() {
                isMobile = window.innerWidth <= 965;
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
                    if (hamburgerBtn) { hamburgerBtn.querySelector('i').className = 'bi bi-list'; }
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
                    if (hamburgerBtn) { hamburgerBtn.querySelector('i').className = 'bi bi-list'; }
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
                if (listContainer) { listContainer.scrollTop = 0; }
            }

            if (hamburgerBtn) { hamburgerBtn.addEventListener('click', toggleMobileMenu); }
            if (overlay) { overlay.addEventListener('click', closeMobileMenu); }

            document.querySelectorAll('.sidebar .nav-link').forEach(function (link) {
                link.addEventListener('click', function () {
                    if (isMobile) { closeMobileMenu(); }
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
                    if (e.target.closest('.photo-trigger')) { return; }
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
                    if (window.innerWidth > 965) {
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
                resizeTimer = setTimeout(function () { updateMobileState(); }, 300);
            });

            updateMobileState();

            var selectedCard = document.querySelector('.candidate-card.active');
            if (selectedCard && window.innerWidth <= 965) {
                setTimeout(function () {
                    selectedCard.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }, 400);
            }

            setTimeout(function () {
                var pnlDetails = document.querySelector('#pnlDetails');
                if (pnlDetails && pnlDetails.style.display !== 'none' && window.innerWidth <= 965) {
                    showDetailsView();
                }
            }, 200);
        })();

        // ============================================
        // FALLBACK: close sidebar when clicking outside it on mobile
        // ============================================
        document.addEventListener('click', function (e) {
            if (window.innerWidth > 965) return;
            var sidebar = document.getElementById('sidebar');
            if (!sidebar || !sidebar.classList.contains('mobile-open')) return;

            // Ignore clicks inside the sidebar
            if (sidebar.contains(e.target)) return;

            // Ignore clicks on the hamburger button (toggle handles it)
            var hamburger = document.getElementById('hamburgerBtn');
            if (hamburger && hamburger.contains(e.target)) return;

            // Close the sidebar
            sidebar.classList.remove('mobile-open');
            var overlay = document.getElementById('mobileOverlay');
            if (overlay) overlay.classList.remove('active');
            var icon = hamburger ? hamburger.querySelector('i') : null;
            if (icon) icon.className = 'bi bi-list';
        });
    </script>
</body>
</html>