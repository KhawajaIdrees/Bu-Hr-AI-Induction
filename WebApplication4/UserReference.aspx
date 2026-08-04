<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserReference.aspx.cs" Inherits="WebApplication4.UserReference" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>References</title>

    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        body {
            background: #f0f4f8;
            font-family: 'Segoe UI', Arial, sans-serif;
            font-size: 16px;
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
            margin-bottom: 30px;
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

        .form-label {
            font-size: 15px;
            font-weight: 600;
            color: #44496b;
            margin-bottom: 6px;
        }

        .form-control {
            font-size: 15px;
            height: 48px;
            border-radius: 8px;
            border: 1px solid #ced4da;
            padding: 10px 14px;
            transition: all .2s ease-in-out;
            background: #f8faff;
            color: #1a2332;
        }

        .form-control:focus {
            border-color: #1a3a7a;
            box-shadow: 0 0 0 .2rem rgba(26, 58, 122, 0.15);
        }

        .form-group {
            margin-bottom: 24px;
        }

        .required-star {
            color: #dc3545;
            font-weight: 700;
        }

        .btn-add {
            background: #1a3a7a;
            color: white;
            border-radius: 8px;
            padding: 12px 34px;
            font-size: 16px;
            font-weight: 600;
            border: none;
            transition: all .2s ease-in-out;
        }

        .btn-add:hover {
            background: #2a5aaa;
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(26, 58, 122, 0.3);
        }

        .btn-save {
            background: #1a3a7a;
            color: white;
            border-radius: 8px;
            padding: 14px 55px;
            font-size: 17px;
            font-weight: 600;
            border: none;
            transition: all .2s ease-in-out;
        }

        .btn-save:hover {
            background: #2a5aaa;
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(26, 58, 122, 0.35);
        }

        .btn-edit {
            background: #1a3a7a;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 6px 14px;
            font-size: 13px;
            font-weight: 600;
            transition: all .2s ease-in-out;
        }

        .btn-edit:hover {
            background: #2a5aaa;
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(26, 58, 122, 0.3);
        }

        .btn-delete {
            background: #dc3545;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 6px 14px;
            font-size: 13px;
            font-weight: 600;
            transition: all .2s ease-in-out;
        }

        .btn-delete:hover {
            background: #a71d2a;
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.3);
        }

        .btn-delete:focus {
            box-shadow: none;
        }

        .btn-edit:focus {
            box-shadow: none;
        }

        .reference-card {
            border: 1px solid #eef1f8;
            border-radius: 12px;
            padding: 20px 24px;
            margin-bottom: 20px;
            background: #fafbff;
            transition: all .2s ease-in-out;
        }

        .reference-card:hover {
            border-color: #1a3a7a;
            box-shadow: 0 4px 16px rgba(26, 58, 122, 0.08);
        }

        .reference-card .ref-title {
            color: #1a3a7a;
            font-weight: 700;
            font-size: 17px;
            margin-bottom: 12px;
        }

        .reference-card .ref-detail {
            font-size: 14px;
            color: #44496b;
            margin-bottom: 4px;
        }

        .reference-card .ref-detail strong {
            color: #1a3a7a;
            font-weight: 600;
        }

        .text-danger {
            font-size: 13px;
        }

        .text-success {
            font-size: 13px;
            font-weight: 500;
        }

        .text-primary-custom {
            color: #1a3a7a;
        }

        .text-muted {
            color: #6c757d !important;
        }

        .mt-4 {
            margin-top: 1.5rem;
        }
        .mt-5 {
            margin-top: 2rem;
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
        .me-3 {
            margin-right: 1rem;
        }
        .ms-3 {
            margin-left: 1rem;
        }
        .py-4 {
            padding-top: 1.5rem;
            padding-bottom: 1.5rem;
        }
        .fw-semibold {
            font-weight: 600;
        }

        .btn-save-wrapper {
            text-align: center;
            margin-top: 30px;
        }

        .section-divider {
            border-top: 2px dashed #eef1f8;
            margin: 25px 0;
        }

        @media (max-width: 768px) {
            body {
                font-size: 15px;
            }

            .card-body {
                padding: 15px;
            }

            .form-label {
                font-size: 14px;
            }

            .form-control {
                font-size: 14px;
                height: 44px;
            }

            .btn-add,
            .btn-save {
                width: 100%;
            }

            .btn-edit,
            .btn-delete {
                padding: 4px 10px;
                font-size: 12px;
            }

            .page-title h4 {
                font-size: 20px;
            }

            .page-title h5 {
                font-size: 14px;
            }

            .container {
                padding-left: 10px;
                padding-right: 10px;
            }

            .reference-card {
                padding: 15px 16px;
            }

            .reference-card .ref-title {
                font-size: 15px;
            }

            .reference-card .ref-detail {
                font-size: 13px;
            }
        }

        @media (max-width: 480px) {
            .form-control {
                height: 40px;
                font-size: 13px;
            }

            .card-header-blue {
                padding: 14px 18px;
            }

            .card-header-blue h5 {
                font-size: 16px;
            }

            .btn-add {
                font-size: 14px;
                padding: 10px 20px;
            }

            .btn-save {
                font-size: 15px;
                padding: 12px 20px;
            }

            .reference-card {
                padding: 12px 14px;
            }

            .reference-card .ref-title {
                font-size: 14px;
            }

            .reference-card .ref-detail {
                font-size: 12px;
            }

            .page-title h4 {
                font-size: 17px;
            }

            .page-title h5 {
                font-size: 12px;
            }

            .container {
                padding-left: 6px;
                padding-right: 6px;
            }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="container py-4">

            <!-- Page Title -->
            <div class="text-left mb-4 page-title">
                <h4><i class="bi bi-person-lines-fill text-primary-custom me-2"></i>References</h4>
                <h5>Bahria University HR Portal</h5>
                <hr />
            </div>

            <!-- ============================================================ -->
            <!-- SECTION 1: REFERENCES (Add Form + List Together) -->
            <!-- ============================================================ -->
            <div class="card card-main">
                <div class="card-header-blue">
                    <h5><i class="bi bi-person-plus-fill"></i> Add Reference</h5>
                </div>
                <div class="card-body">

                    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert alert-warning">
                        <asp:Label ID="lblMessage" runat="server"></asp:Label>
                    </asp:Panel>

                    <div class="row">
                        <!-- Reference Name -->
                        <div class="col-md-6 form-group">
                            <label class="form-label">
                                Reference Name <span class="required-star">*</span>
                            </label>
                            <asp:TextBox ID="txtReferenceName" runat="server" CssClass="form-control" />
                        </div>

                        <!-- Relationship -->
                        <div class="col-md-6 form-group">
                            <label class="form-label">
                                Relationship <span class="required-star">*</span>
                            </label>
                            <asp:TextBox ID="txtRelationship" runat="server" CssClass="form-control" />
                        </div>

                        <!-- Organization -->
                        <div class="col-md-6 form-group">
                            <label class="form-label">
                                Organization / Company <span class="required-star">*</span>
                            </label>
                            <asp:TextBox ID="txtOrganization" runat="server" CssClass="form-control" />
                        </div>

                        <!-- Job Title -->
                        <div class="col-md-6 form-group">
                            <label class="form-label">
                                Job Title <span class="required-star">*</span>
                            </label>
                            <asp:TextBox ID="txtJobTitle" runat="server" CssClass="form-control" />
                        </div>

                        <!-- Email -->
                        <div class="col-md-6 form-group">
                            <label class="form-label">
                                Email Address <span class="required-star">*</span>
                            </label>
                            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" />
                        </div>

                        <!-- Phone -->
                        <div class="col-md-6 form-group">
                            <label class="form-label">
                                Phone Number <span class="required-star">*</span>
                            </label>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" MaxLength="20" oninput="validatePhone(this)" />
                        </div>

                        <!-- Address -->
                        <div class="col-md-6 form-group">
                            <label class="form-label">
                                Work Address
                            </label>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" />
                        </div>

                        <!-- Years Known -->
                        <div class="col-md-6 form-group">
                            <label class="form-label">
                                Years Known <span class="required-star">*</span>
                            </label>
                            <asp:TextBox ID="txtYearsKnown" runat="server" TextMode="Number" CssClass="form-control" />
                        </div>

                        <!-- Add Button -->
                        <div class="col-12 text-end mt-2">
                            <asp:Button ID="btnAddReference" runat="server" Text="Add Reference" CssClass="btn btn-add" OnClick="btnAddReference_Click" />
                        </div>
                    </div>

                    <!-- ========================================================== -->
                    <!-- REFERENCES LIST (Inside the same container) -->
                    <!-- ========================================================== -->
                    <div class="section-divider"></div>

                    <div class="mt-3">
                        <h6 class="text-primary-custom fw-bold mb-3">
                            <i class="bi bi-list-columns-reverse me-2"></i>References List
                        </h6>
                        <asp:Repeater ID="rptReferences" runat="server" OnItemCommand="rptReferences_ItemCommand">
                            <ItemTemplate>
                                <div class="reference-card">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div class="ref-title">
                                            <i class="bi bi-person-badge-fill text-primary-custom me-2"></i>
                                            Reference <%# Container.ItemIndex + 1 %>
                                        </div>
                                        <div>
                                            <asp:LinkButton ID="btnEdit" runat="server"
                                                CssClass="btn btn-edit me-1"
                                                CommandName="EditReference"
                                                CommandArgument='<%# Container.ItemIndex %>'>
                                                <i class="bi bi-pencil-square me-1"></i>Edit
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnDelete" runat="server"
                                                CssClass="btn btn-delete"
                                                CommandName="DeleteReference"
                                                CommandArgument='<%# Container.ItemIndex %>'
                                                OnClientClick="return confirm('Delete this reference?');">
                                                <i class="bi bi-trash me-1"></i>Delete
                                            </asp:LinkButton>
                                        </div>
                                    </div>

                                    <div class="row mt-2">
                                        <div class="col-md-6 ref-detail">
                                            <strong>Name:</strong> <%# Eval("ReferenceName") %>
                                        </div>
                                        <div class="col-md-6 ref-detail">
                                            <strong>Relationship:</strong> <%# Eval("Relationship") %>
                                        </div>
                                        <div class="col-md-6 ref-detail">
                                            <strong>Organization:</strong> <%# Eval("Organization") %>
                                        </div>
                                        <div class="col-md-6 ref-detail">
                                            <strong>Job Title:</strong> <%# Eval("JobTitle") %>
                                        </div>
                                        <div class="col-md-6 ref-detail">
                                            <strong>Email:</strong> <%# Eval("Email") %>
                                        </div>
                                        <div class="col-md-6 ref-detail">
                                            <strong>Phone:</strong> <%# Eval("Phone") %>
                                        </div>
                                        <div class="col-md-6 ref-detail">
                                            <strong>Address:</strong> <%# Eval("Address") %>
                                        </div>
                                        <div class="col-md-6 ref-detail">
                                            <strong>Years Known:</strong> <%# Eval("YearsKnown") %>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>

            <!-- ============================================================ -->
            <!-- SECTION 2: CV UPLOAD (Separate Container) -->
            <!-- ============================================================ -->
            <div class="card card-main">
                <div class="card-header-blue">
                    <h5><i class="bi bi-file-earmark-arrow-up-fill"></i> Upload CV / Resume</h5>
                </div>
                <div class="card-body">
                    <div class="form-group">
                        <label class="form-label">
                            Upload Resume <span class="required-star">*</span>
                        </label>
                        <asp:FileUpload ID="fuResume" runat="server" CssClass="form-control" />
                        <div class="text-muted mt-2" style="font-size: 14px;">
                            <i class="bi bi-info-circle me-1"></i>
                            Supported formats: <strong>PDF, DOC, DOCX</strong>
                            &nbsp;|&nbsp; Maximum Size: <strong>5 MB</strong>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ============================================================ -->
            <!-- SAVE & CONTINUE BUTTON (Outside Both Containers) -->
            <!-- ============================================================ -->
            <div class="btn-save-wrapper">
                <asp:Button ID="btnSaveContinue" runat="server" Text="Save and Continue" CssClass="btn btn-save" OnClick="btnSaveContinue_Click" />
            </div>

        </div>
    </form>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const inputs = document.querySelectorAll("input");
            inputs.forEach(function (input) {
                input.addEventListener("keypress", function (e) {
                    if (e.key === "Enter") {
                        e.preventDefault();
                    }
                });
            });
        });

        function validatePhone(input) {
            input.value = input.value.replace(/[^\d+]/g, '');
            if (input.value.indexOf('+') > 0) {
                input.value = input.value.replace(/\+/g, '');
                input.value = '+' + input.value;
            }
            const plusCount = (input.value.match(/\+/g) || []).length;
            if (plusCount > 1) {
                input.value = '+' + input.value.replace(/\+/g, '');
            }
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>