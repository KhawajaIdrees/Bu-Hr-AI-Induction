<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Reference.aspx.cs"
    Inherits="WebApplication4.Reference" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>Reference</title>

    <meta charset="utf-8" />

    <meta name="viewport"
          content="width=device-width, initial-scale=1" />

    <!-- Bootstrap 5 -->

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css"
          rel="stylesheet" />

    <!-- Bootstrap Icons -->

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />

<style>

body{

    background:#eef3f9;

    font-family:'Segoe UI',sans-serif;

}

.page-title{

    color:#143d86;

    font-size:2.4rem;

    font-weight:700;

}

.page-subtitle{

    color:#6c757d;

    font-size:1.05rem;

}

.form-card{

    border:none;

    border-radius:22px;

    box-shadow:0 6px 20px rgba(0,0,0,.08);

    overflow:hidden;

}

.form-header{

    background:linear-gradient(90deg,#254a91,#3557b7);

    color:#fff;

    padding:22px 30px;

}

.form-header h3{

    margin:0;

    font-weight:700;

    font-size:24px;

}

.form-body{

    background:#fff;

    padding:35px;

}

.form-label{

    color:#143d86;

    font-size:17px;

    font-weight:600;

}

.form-control{

    height:55px;

    border-radius:12px;

    border:1px solid #ced4da;

}

.form-control:focus{

    border-color:#3557b7;

    box-shadow:0 0 0 .2rem rgba(53,87,183,.15);

}

.required{

    color:#dc3545;

}

.btn-add{

    background:#3557b7;

    border:none;

    color:#fff;

    font-weight:600;

    padding:11px 40px;

    border-radius:10px;

}

.btn-add:hover{

    background:#23427f;

    color:#fff;

}

.saved-reference{

    border:none;

    border-radius:18px;

    box-shadow:0 5px 16px rgba(0,0,0,.08);

}

.reference-title{

    color:#143d86;

    font-weight:700;

}

.btn-edit{

    background:#3557b7;

    border-color:#3557b7;

    color:#fff;

    font-weight:600;

}

.btn-edit:hover{

    background:#28499b;

    border-color:#28499b;

    color:#fff;

}

.btn-edit:focus,
.btn-edit:active{

    background:#28499b !important;

    border-color:#28499b !important;

    color:#fff !important;

    box-shadow:none;

}

.upload-header{

    background:linear-gradient(135deg,#29488f,#3f5db5);

    color:#fff;

    border-radius:14px 14px 0 0 !important;

    padding:22px 30px;

    border:none;

}

.upload-header h3{

    color:#fff;

    font-size:20px;

    font-weight:700;

}

.upload-header i{

    font-size:24px;

}

.card{

    border-radius:14px;

    overflow:hidden;

}

.card-body{

    background:#fff;

}

.form-control{

    border-radius:12px;

}


.btn-save{

    background:#3557b7;

    color:#fff;

    border:none;

    padding:12px 45px;

    font-size:18px;

    font-weight:600;

    border-radius:10px;

}

.btn-save:hover{

    background:#157347;

}

@media(max-width:768px){

.page-title{

    font-size:1.8rem;

}

.form-header h3{

    font-size:18px;

}

.form-body{

    padding:20px;

}

.form-label{

    font-size:15px;

}

.form-control{

    height:50px;

}
.upload-header{

        padding:18px;

    }

    .upload-header h3{

        font-size:18px;

    }

.btn-add,

.btn-save{

    width:100%;

}

}

</style>

</head>

<body>

<form id="form1" runat="server">

<div class="container py-5">

<div class="mb-4">

<h1 class="page-title">

Reference

</h1>

<div class="page-subtitle">

Bahria University HR Portal

</div>

<hr />

</div>

<!-- ========================= -->
<!-- Reference Form -->
<!-- ========================= -->

<div class="card form-card">

<div class="form-header">

<h3>

<i class="bi bi-person-lines-fill me-2"></i>

Add References

</h3>

</div>

<div class="form-body">

<asp:Panel
    ID="pnlMessage"
    runat="server"
    Visible="false"
    CssClass="alert alert-warning">

    <asp:Label
        ID="lblMessage"
        runat="server">
    </asp:Label>

</asp:Panel>

<div class="row g-4">
    <!-- Reference Name -->

<div class="col-md-6">

    <label class="form-label">

        Reference Name

        <span class="required">*</span>

    </label>

    <asp:TextBox
        ID="txtReferenceName"
        runat="server"
        CssClass="form-control"
        placeholder="Enter Reference Name">
    </asp:TextBox>

</div>

<!-- Relationship -->

<div class="col-md-6">

    <label class="form-label">

        Relationship

        <span class="required">*</span>

    </label>

    <asp:TextBox
        ID="txtRelationship"
        runat="server"
        CssClass="form-control"
        placeholder="e.g. Supervisor">
    </asp:TextBox>

</div>

<!-- Organization -->

<div class="col-md-6">

    <label class="form-label">

        Organization / Company

        <span class="required">*</span>

    </label>

    <asp:TextBox
        ID="txtOrganization"
        runat="server"
        CssClass="form-control"
        placeholder="Organization Name">
    </asp:TextBox>

</div>

<!-- Job Title -->

<div class="col-md-6">

    <label class="form-label">

        Job Title

        <span class="required">*</span>

    </label>

    <asp:TextBox
        ID="txtJobTitle"
        runat="server"
        CssClass="form-control"
        placeholder="Job Title">
    </asp:TextBox>

</div>

<!-- Email -->

<div class="col-md-6">

    <label class="form-label">

        Email Address

        <span class="required">*</span>

    </label>

    <asp:TextBox
        ID="txtEmail"
        runat="server"
        TextMode="Email"
        CssClass="form-control"
        placeholder="example@email.com">
    </asp:TextBox>

</div>

<!-- Phone -->

<div class="col-md-6">

    <label class="form-label">

        Phone Number

        <span class="required">*</span>

    </label>

    <asp:TextBox
    ID="txtPhone"
    runat="server"
    TextMode="SingleLine"
    CssClass="form-control"
    placeholder="+92 300 1234567"
    MaxLength="20"
    oninput="validatePhone(this)">
</asp:TextBox>

</div>

<!-- Address -->

<div class="col-md-6">

    <label class="form-label">

        Work Address

    </label>

    <asp:TextBox
        ID="txtAddress"
        runat="server"
        CssClass="form-control"
        placeholder="Work Address">
    </asp:TextBox>

</div>

<!-- Years Known -->

<div class="col-md-6">

    <label class="form-label">

        Years Known

        <span class="required">*</span>

    </label>

    <asp:TextBox
    ID="txtYearsKnown"
    runat="server"
    TextMode="Number"
    CssClass="form-control"
    placeholder="e.g. 5">
</asp:TextBox>

</div>

<!-- Add Button -->

<div class="col-12 text-end mt-4">

    <asp:Button
        ID="btnAddReference"
        runat="server"
        Text="+ Add"
        CssClass="btn btn-add"
        OnClick="btnAddReference_Click" />

</div>

</div>

</div>

</div>

<!-- ========================= -->
<!-- Added References -->
<!-- ========================= -->

<div class="mt-5">

    <asp:Repeater
        ID="rptReferences"
        runat="server"
        OnItemCommand="rptReferences_ItemCommand">

        <ItemTemplate>
            <div class="card saved-reference mb-4">

    <div class="card-body">

        <div class="d-flex justify-content-between align-items-center mb-4">

            <h4 class="reference-title mb-0">

                <i class="bi bi-person-badge-fill text-primary me-2"></i>

                Reference <%# Container.ItemIndex + 1 %>

            </h4>

            <div>

                <asp:LinkButton
                    ID="btnEdit"
                    runat="server"
                    CssClass="btn btn-edit btn-sm me-2"
                    CommandName="EditReference"
                    CommandArgument='<%# Container.ItemIndex %>'>

                    <i class="bi bi-pencil-square me-1"></i>

                    Edit

                </asp:LinkButton>

                <asp:LinkButton
                    ID="btnDelete"
                    runat="server"
                    CssClass="btn btn-danger btn-sm"
                    CommandName="DeleteReference"
                    CommandArgument='<%# Container.ItemIndex %>'
                    OnClientClick="return confirm('Delete this reference?');">

                    <i class="bi bi-trash me-1"></i>

                    Delete

                </asp:LinkButton>

            </div>

        </div>

        <div class="row gy-3">

            <div class="col-md-6">

                <strong>Reference Name</strong>

                <div><%# Eval("ReferenceName") %></div>

            </div>

            <div class="col-md-6">

                <strong>Relationship</strong>

                <div><%# Eval("Relationship") %></div>

            </div>

            <div class="col-md-6">

                <strong>Organization / Company</strong>

                <div><%# Eval("Organization") %></div>

            </div>

            <div class="col-md-6">

                <strong>Job Title</strong>

                <div><%# Eval("JobTitle") %></div>

            </div>

            <div class="col-md-6">

                <strong>Email Address</strong>

                <div><%# Eval("Email") %></div>

            </div>

            <div class="col-md-6">

                <strong>Phone Number</strong>

                <div><%# Eval("Phone") %></div>

            </div>

            <div class="col-md-6">

                <strong>Work Address</strong>

                <div><%# Eval("Address") %></div>

            </div>

            <div class="col-md-6">

                <strong>Years Known</strong>

                <div><%# Eval("YearsKnown") %></div>

            </div>

        </div>

    </div>

</div>

</ItemTemplate>

</asp:Repeater>

  <div class="card shadow-sm border-0 mt-4">

    <!-- Header -->
    <div class="card-header upload-header">

        <h3 class="mb-0 d-flex align-items-center">

            <i class="bi bi-file-earmark-arrow-up-fill me-3"></i>

            Upload CV / Resume

        </h3>

    </div>

    <!-- Body -->
    <div class="card-body p-4">

        <div class="mb-3">

            <label class="form-label fw-semibold">

                Upload Resume <span class="text-danger">*</span>

            </label>

            <asp:FileUpload
                ID="fuResume"
                runat="server"
                CssClass="form-control form-control-lg" />

            <div class="form-text mt-2">

                <i class="bi bi-info-circle me-1"></i>

                Supported formats:
                <strong>PDF, DOC, DOCX</strong>

                &nbsp;|&nbsp;

                Maximum Size:
                <strong>5 MB</strong>

            </div>

        </div>

    </div>

</div>

<div class="text-center mt-4">

    <asp:Button
        ID="btnSaveContinue"
        runat="server"
        Text="Save & Continue"
        CssClass="btn btn-save"
        OnClick="btnSaveContinue_Click" />

</div>

</div>
    </div>

<!-- End Container -->

</form>

<!-- Bootstrap JS -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>

<script>

    // Prevent Enter key from accidentally submitting the form
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

    // Allow only digits and +
    input.value = input.value.replace(/[^\d+]/g, '');

    // Allow + only at the beginning
    if (input.value.indexOf('+') > 0) {
        input.value = input.value.replace(/\+/g, '');
        input.value = '+' + input.value;
    }

    // Prevent multiple +
    const plusCount = (input.value.match(/\+/g) || []).length;

    if (plusCount > 1) {
        input.value = '+' + input.value.replace(/\+/g, '');
    }
}
function checkYear(input) {

    if (input.value === "")
        return;

    let value = Number(input.value);

    if (value < 0) {
        input.value = 0;
        }
    }

</script>

</body>

</html>