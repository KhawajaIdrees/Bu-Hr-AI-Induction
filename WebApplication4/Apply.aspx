<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Apply.aspx.cs" Inherits="WebApplication4.candApply" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Candidate Application</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />  
    <style type="text/css">


        .message {
            color: green;
            font-weight: bold;
        }
        
        .station-list input {
    margin-right: 5px;
}

.station-list label {
    margin-right: 30px;
    cursor: pointer;
}
    </style>
</head>
<body>


<form id="form1" runat="server">

<div class="container py-4">

    <div class="text-left mb-4">
        <h4 class="fw-bold text-primary">Application</h4>
        <h5 class="text-secondary">Bahria University HR Portal</h5>
        <hr />
    </div>


    <!-- Station Selection -->
    <div class="row mb-3">

        <!-- Location -->
        <div class="col-md-6">

            <label class="form-label fw-bold">
                Location
            </label>

            <br />

            <asp:RadioButtonList
                ID="rblStation"
                runat="server"
                CssClass="station-list"
                RepeatDirection="Horizontal"
                RepeatLayout="Flow">

                <asp:ListItem Text="Islamabad" Value="Islamabad"></asp:ListItem>
                <asp:ListItem Text="Lahore" Value="Lahore"></asp:ListItem>
                <asp:ListItem Text="Karachi" Value="Karachi"></asp:ListItem>

            </asp:RadioButtonList>


            <asp:RequiredFieldValidator
                ID="rfvStation"
                runat="server"
                ControlToValidate="rblStation"
                InitialValue=""
                ValidationGroup="Register"
                ErrorMessage="Please select a location."
                CssClass="text-danger"
                Display="Dynamic">
            </asp:RequiredFieldValidator>

        </div>



        <!-- Advertisement Date -->
        <div class="col-md-6">

            <asp:Label 
                ID="lblAdvertisementDate" 
                runat="server"
                Text="Advertisement Date"
                CssClass="form-label fw-bold">
            </asp:Label>


            <asp:TextBox
                ID="txtAdvertisementDate"
                runat="server"
                CssClass="form-control"
                TextMode="Date">
            </asp:TextBox>


            <asp:RequiredFieldValidator
                ID="rfvAdvertisementDate"
                runat="server"
                ControlToValidate="txtAdvertisementDate"
                ValidationGroup="Register"
                ErrorMessage="Please select advertisement date."
                CssClass="text-danger"
                Display="Dynamic">
            </asp:RequiredFieldValidator>

        </div>

    </div>




    <!-- Job Selection -->

    <div class="row mb-3">


        <!-- Job Applied -->
        <div class="col-md-6">


            <label class="form-label fw-bold">
                Job Applied For
            </label>


            <asp:DropDownList
                ID="ddlJobApplied"
                runat="server"
                CssClass="form-select"
                onchange="loadJobOptions();">


                <asp:ListItem 
                    Text="-- Select Post --" 
                    Value="">
                </asp:ListItem>


                <asp:ListItem 
                    Text="Teaching" 
                    Value="Faculty">
                </asp:ListItem>


                <asp:ListItem 
                    Text="Non Teaching" 
                    Value="NonTeaching">
                </asp:ListItem>


            </asp:DropDownList>


            <asp:RequiredFieldValidator
                ID="rfvJobApplied"
                runat="server"
                ControlToValidate="ddlJobApplied"
                InitialValue=""
                ValidationGroup="Register"
                ErrorMessage="Please select job type."
                CssClass="text-danger"
                Display="Dynamic">
            </asp:RequiredFieldValidator>


        </div>




        <!-- CV Upload -->

        <div class="col-md-6">


            <label class="form-label fw-bold">

                Upload CV

                <small class="text-muted">
                    (PDF only, Maximum 5 MB)
                </small>

            </label>


            <asp:FileUpload
                ID="fuCV"
                runat="server"
                CssClass="form-control" />


        </div>


    </div>






    <!-- Position -->

    <div class="mb-3">


        <label class="form-label fw-bold">
            Select Position
        </label>


        <asp:DropDownList
            ID="ddlJobCategory"
            runat="server"
            CssClass="form-select">


            <asp:ListItem
                Text="-- Select Position --"
                Value="">
            </asp:ListItem>


        </asp:DropDownList>


    </div>







    <!-- Teaching Details -->

    <div id="teachingDetails" style="display:none;">


        <div class="row mb-3">


            <!-- Department -->

            <div class="col-md-6">


                <label class="form-label fw-bold">
                    Department
                </label>


                <asp:TextBox
                    ID="txtDepartment"
                    runat="server"
                    CssClass="form-control"
                    placeholder="Enter Department">
                </asp:TextBox>


            </div>





            <!-- Specialization -->

            <div class="col-md-6">


                <label class="form-label fw-bold">
                    Specialization
                </label>


                <asp:TextBox
                    ID="txtSpecialization"
                    runat="server"
                    CssClass="form-control"
                    placeholder="Enter Specialization">
                </asp:TextBox>


            </div>


        </div>


    </div>





    <!-- Submit -->

    <div class="text-center mt-4">


        <asp:Button
            ID="btnSubmit"
            runat="server"
            Text="Save and Continue"
            CssClass="btn btn-primary"
            ValidationGroup="Register"
            OnClick="BtnSubmit_Click" />


        <asp:Label
            ID="lblMessage"
            runat="server"
            CssClass="d-block mt-3">
        </asp:Label>


    </div>



</div>





<script type="text/javascript">


    function loadJobOptions() {

        var jobType =
            document.getElementById('<%= ddlJobApplied.ClientID %>').value;


    var ddlCategory =
        document.getElementById('<%= ddlJobCategory.ClientID %>');


        var teachingDetails =
            document.getElementById("teachingDetails");



        ddlCategory.innerHTML = "";



        var defaultOption =
            document.createElement("option");


        defaultOption.text =
            "-- Select Position --";


        defaultOption.value = "";


        ddlCategory.add(defaultOption);




        if (jobType === "Faculty") {


            teachingDetails.style.display = "block";



            var teachingOptions =
                [
                    "Permanent Faculty",
                    "Visiting Faculty",
                    "Professor of Practice"
                ];



            for (var i = 0; i < teachingOptions.length; i++) {

                var option =
                    document.createElement("option");


                option.text =
                    teachingOptions[i];


                option.value =
                    teachingOptions[i];


                ddlCategory.add(option);

            }


        }


        else if (jobType === "NonTeaching") {


            teachingDetails.style.display = "none";



            var nonTeachingOptions =
                [
                    "Officers",
                    "Staff"
                ];



            for (var i = 0; i < nonTeachingOptions.length; i++) {

                var option =
                    document.createElement("option");


                option.text =
                    nonTeachingOptions[i];


                option.value =
                    nonTeachingOptions[i];


                ddlCategory.add(option);

            }


        }


        else {

            teachingDetails.style.display = "none";

        }


    }


</script>



</form>
    <!--EndFragment-->
</body>
</html>

 

