<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="CreateJob.aspx.cs"
    Inherits="WebApplication4.CreateJob" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>Create Job</title>

    <meta charset="utf-8" />

    <meta name="viewport"
          content="width=device-width, initial-scale=1" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
          rel="stylesheet" />

    <style>

        body {
            background: #f5f6fa;
            font-family: "Segoe UI",sans-serif;
            margin: 0;
            padding: 40px 0;
        }

        .back-icon {
            display: inline-block;
            text-decoration: none;
            color: #243B86;
            font-size: 42px;
            font-weight: bold;
            transition: .25s;
        }

        .back-icon:hover {
            color: #182d70;
            transform: translateX(-4px);
        }

        .page-card {
            background: #fff;
            border-radius: 12px;
            border: 1px solid #ddd;
            box-shadow: 0 4px 14px rgba(0,0,0,.08);
            padding: 45px;
            margin: auto;
            max-width: 1350px;
        }

        .page-title {
            color: #243B86;
            font-size: 42px;
            font-weight: 700;
            margin-bottom: 40px;
        }

        .form-label {
            color: #243B86;
            font-weight: 600;
            font-size: 17px;
            margin-bottom: 10px;
        }

        .required {
            color: red;
        }

        .form-control,
        .form-select {
            height: 58px;
            border-radius: 8px;
            font-size: 17px;
        }

        .form-control:focus,
        .form-select:focus {
            border-color: #243B86;
            box-shadow: none;
        }

        .submit-btn {
            width: 320px;
            height: 60px;
            border: none;
            border-radius: 8px;
            background: #343B97;
            color: #fff;
            font-size: 22px;
            font-weight: 600;
            transition: .25s;
        }

        .submit-btn:hover {
            background: #243B86;
        }

        @media(max-width:768px) {

            body {
                padding: 20px 0;
            }

            .page-card {
                padding: 25px;
            }

            .page-title {
                font-size: 30px;
            }

            .submit-btn {
                width: 100%;
            }
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="container-fluid px-lg-5 px-3">

<div class="page-card">

<div class="mb-3">

<a href="AdminDashboard.aspx" class="back-icon">

&#8249;

</a>

</div>

<h2 class="page-title">

<i class="fa-solid fa-briefcase"></i>

CREATE JOB

</h2>

<asp:Panel
    ID="pnlMessage"
    runat="server"
    Visible="false"
    CssClass="alert message-panel"
    Style="padding:15px;border-radius:6px;margin-bottom:25px;">

    <asp:Label
        ID="lblMessage"
        runat="server">
    </asp:Label>

</asp:Panel>
    <div class="row g-4">

    <div class="col-xl-4 col-lg-4 col-md-6 col-12">

        <label class="form-label">
            Job Title <span class="required">*</span>
        </label>

        <asp:TextBox
            ID="txtJobTitle"
            runat="server"
            CssClass="form-control"
            placeholder="Enter Job Title">
        </asp:TextBox>

    </div>

    <div class="col-xl-4 col-lg-4 col-md-6 col-12">

        <label class="form-label">
            Job ID <span class="required">*</span>
        </label>

        <asp:TextBox
            ID="txtJobID"
            runat="server"
            CssClass="form-control"
            placeholder="Enter Job ID">
        </asp:TextBox>

    </div>

    <div class="col-xl-4 col-lg-4 col-md-6 col-12">

        <label class="form-label">
            Reference No <span class="required">*</span>
        </label>

        <asp:TextBox
            ID="txtReferenceNo"
            runat="server"
            CssClass="form-control"
            placeholder="Enter Reference No">
        </asp:TextBox>

    </div>

</div>

<div class="row g-4 mt-1">

    <div class="col-xl-4 col-lg-4 col-md-6 col-12">

        <label class="form-label">
            Campus <span class="required">*</span>
        </label>

        <asp:TextBox
            ID="txtCampus"
            runat="server"
            CssClass="form-control"
            placeholder="Enter Campus">
        </asp:TextBox>

    </div>

    <div class="col-xl-4 col-lg-4 col-md-6 col-12">

        <label class="form-label">
            Job Type <span class="required">*</span>
        </label>

        <asp:DropDownList
            ID="ddlJobType"
            runat="server"
            CssClass="form-select">

            <asp:ListItem Value="">
                -- Select Job Type --
            </asp:ListItem>

            <asp:ListItem>
                Teaching
            </asp:ListItem>

            <asp:ListItem>
                Non Teaching
            </asp:ListItem>

        </asp:DropDownList>

    </div>

    <div class="col-xl-4 col-lg-4 col-md-6 col-12">

        <label class="form-label">
            Published Date <span class="required">*</span>
        </label>

        <asp:TextBox
            ID="txtPublishedDate"
            runat="server"
            CssClass="form-control"
            TextMode="Date">
        </asp:TextBox>

    </div>

</div>

<div class="row g-4 mt-1">

    <div class="col-xl-4 col-lg-4 col-md-6 col-12">

        <label class="form-label">
            Deadline Date <span class="required">*</span>
        </label>

        <asp:TextBox
            ID="txtDeadlineDate"
            runat="server"
            CssClass="form-control"
            TextMode="Date">
        </asp:TextBox>

    </div>

</div>

<asp:ValidationSummary
    ID="ValidationSummary1"
    runat="server"
    ForeColor="Red"
    DisplayMode="BulletList"
    ShowSummary="true" />

<div class="text-center mt-5">

    <asp:Button
        ID="btnSubmit"
        runat="server"
        Text="Submit"
        CssClass="submit-btn"
        OnClick="btnSubmit_Click" />

</div>
    </div>

</div>

<script>

    document.addEventListener("DOMContentLoaded", function () {

        const panel = document.querySelector(".message-panel");

        if (!panel)
            return;

        const controls = document.querySelectorAll("input, select, textarea");

        controls.forEach(function (control) {

            control.addEventListener("input", function () {
                panel.style.display = "none";
            });

            control.addEventListener("change", function () {
                panel.style.display = "none";
            });

        });

    });

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</form>

</body>

</html>