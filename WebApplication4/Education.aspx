<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Education.aspx.cs" Inherits="WebApplication4.candDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

<title>Educational Information</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />


<style>

body {
    background:#f5f7fb;
    font-family:'Segoe UI',Arial,sans-serif;
}


/* Top Navigation */

.top-bar {

    background:#0d6efd;
    padding:12px 25px;
    border-radius:10px;
    margin-top:20px;
    box-shadow:0 3px 10px rgba(0,0,0,.15);

}


.portal-title {

    color:white;
    font-size:18px;
    font-weight:600;

}


.top-bar .btn {

    margin-left:10px;

}



/* Main Card */

.container-box {

    margin-top:30px;

}


.card {

    border-radius:12px;

}



.card-header-title {

    font-weight:700;
    color:#0d6efd;

}



/* Table */

.education-table input {

    min-width:120px;

}


.education-table th {

    text-align:center;
    vertical-align:middle;

}


.education-table td {

    vertical-align:middle;

}



/* Validation */

.validation-error {

    color:red;
    display:block;

}
 h5 {

    font-size:26px;

}


</style>


</head>


<body>


<form id="form1" runat="server">



<!-- TOP BAR -->

<div class="container py-4">
<div class="text-left mb-4">
    <h5 class="fw-bold text-primary">Educational Information</h5>
    <h6 class="text-secondary">Bahria University HR Portal</h6>
   
</div>


<!-- PAGE CONTENT -->


<div class="container container-box">

<div class="card shadow">
<div class="card-body">

<div class="table-responsive">

<table class="table table-bordered table-striped align-middle education-table">

<thead class="table-dark">

<tr>

<th>Certificate/Degree</th>

<th>Duration in Years</th>

<th>Specialization</th>

<th>Passing Year</th>

<th>Percentage</th>

<th>University</th>
<th>Country</th>
</tr>


</thead>
<tbody>
<tr>
<td>SSC/O&#39;levels*</td>

<td>
<input type="text" id="ssc_duration" runat="server" class="form-control" required />
</td>

<td>
<input type="text" id="ssc_specialization" runat="server" class="form-control" required />
</td>


<td>
<input type="number" id="ssc_year" runat="server" class="form-control" required />
</td>


<td>
<input type="number" id="sscper" runat="server" class="form-control" required />
</td>


<td>
<input type="text" id="ssc_uni" runat="server" class="form-control" required />
</td>

<td>
<input type="text" id="ssc_country" runat="server" class="form-control" required />
</td>
</tr>

<tr>

<td>HSSC/A&#39;levels *</td>
<td>
<input type="text" id="hssc_duration" runat="server" class="form-control" required />
</td>

<td>
<input type="text" id="hssc_specialization" runat="server" class="form-control" required />
</td>


<td>
<input type="number" id="hssc_year" runat="server" class="form-control" required />
</td>


<td>
<input type="number" id="hsscper" runat="server" class="form-control" required />
</td>


<td>
<input type="text" id="hssc_uni" runat="server" class="form-control" required />
</td>

<td>
<input type="text" id="hssc_country" runat="server" class="form-control" required />
</td>
</tr>

<tr>
<td>Bachelor *</td>
<td>
<input type="text" id="bs_duration" runat="server" class="form-control" required />
</td>

<td>
<input type="text" id="bs_specialization" runat="server" class="form-control" required />
</td>


<td>
<input type="number" id="bs_year" runat="server" class="form-control" required />
</td>


<td>
<input type="number" id="bs_cgpa" runat="server" class="form-control" required />
</td>


<td>
<input type="text" id="bs_uni" runat="server" class="form-control" required />
</td>

<td>
<input type="text" id="bs_country" runat="server" class="form-control" required />
</td>
</tr>

<tr>
<td>Masters/MPhil</td>
<td>
<input type="text" id="ms_duration" runat="server" class="form-control"  />
</td>

<td>
<input type="text" id="ms_specialization" runat="server" class="form-control"  />
</td>


<td>
<input type="number" id="ms_year" runat="server" class="form-control"  />
</td>


<td>
<input type="number" id="ms_cgpa" runat="server" class="form-control" />
</td>


<td>
<input type="text" id="ms_uni" runat="server" class="form-control"  />
</td>

<td>
<input type="text" id="ms_country" runat="server" class="form-control"  />
</td>
</tr>

<tr>
<td>PhD</td>
<td>
<input type="text" id="phd_duration" runat="server" class="form-control" />
</td>

<td>
<input type="text" id="phd_specialization" runat="server" class="form-control"  />
</td>


<td>
<input type="number" id="phd_year" runat="server" class="form-control"  />
</td>


<td>
<input type="number" id="phd_cgpa" runat="server" class="form-control"  />
</td>


<td>
<input type="text" id="phd_uni" runat="server" class="form-control"  />
</td>

<td>
<input type="text" id="phd_country" runat="server" class="form-control"  />
</td>
</tr>

<tr>
<td>Post Doc</td>
<td>
<input type="text" id="postdoc_duration" runat="server" class="form-control"  />
</td>

<td>
<input type="text" id="postdoc_specialization" runat="server" class="form-control"  />
</td>


<td>
<input type="number" id="postdoc_year" runat="server" class="form-control" />
</td>


<td>
<input type="number" id="postdoc_cgpa" runat="server" class="form-control"  />
</td>


<td>
<input type="text" id="postdoc_uni" runat="server" class="form-control" />
</td>

<td>
<input type="text" id="postdoc_country" runat="server" class="form-control"  />
</td>
</tr>

</tbody>


</table>


</div>







<div class="d-grid mt-4">


<asp:Button

ID="btnSubmit"

runat="server"

Text="Save and Continue"

CssClass="btn btn-primary btn-lg"

OnClick="BtnSubmit_Click" />


</div>
    </div>




<div class="mt-3 text-center">


<asp:Label

ID="lblMessage"

runat="server"

CssClass="text-success">

</asp:Label>


</div>





</div>


</div>


</div>





</form>


</body>


</html>