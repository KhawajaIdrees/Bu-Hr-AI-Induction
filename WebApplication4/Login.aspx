<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication4.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <title>HR Portal Login</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" 
          rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" 
          rel="stylesheet" />

    <style>

        body {
            background: linear-gradient(135deg, #f4f7fc 0%, #e8edf7 100%);
            font-family: 'Segoe UI', Arial, sans-serif;
            min-height: 100vh;

        }

        .login-card {
            width: 420px;
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(45, 57, 141, 0.15) !important;
            padding: 2.25rem 2rem !important;
        }

        .text-bu-blue {
            color: #2D398D !important;
        }

        .bg-bu-blue {
            background-color: #2D398D !important;
            color: #ffffff;
        }

        h5.welcome-text {
            color: #2D398D;
            font-weight: 700;
            margin-bottom: 0.15rem;
        }

        h5.portal-text {
            color: #6c757d;
            font-weight: 500;
            font-size: 1rem;
        }

        .form-label {
            font-weight: 600;
            color: #2D398D;
            font-size: 0.92rem;
        }

        .form-control {
            border-radius: 8px;
            border: 1px solid #dde3f0;
            padding: 0.65rem 0.9rem;
            transition: all 0.2s ease-in-out;
        }

        .form-control:focus {
            border-color: #2D398D;
            box-shadow: 0 0 0 0.2rem rgba(45, 57, 141, 0.15);
        }

        .validation-error {
            color: #dc3545;
            font-size: 13px;
        }

        .btn-bu-blue {
            background-color: #2D398D;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            padding: 0.65rem;
            font-weight: 600;
            letter-spacing: 0.3px;
            transition: all 0.2s ease-in-out;
        }

        .btn-bu-blue:hover {
            background-color: #232c70;
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(45, 57, 141, 0.3);
            color: #ffffff;
        }

        a.text-bu-blue:hover {
            text-decoration: underline !important;
        }

        .forgot-link {
            color: #6c757d;
            font-size: 0.85rem;
        }

        .forgot-link:hover {
            color: #2D398D;
        }

    @media(max-width:768px) {
        .login-card {
            width: 100%;
            max-width: 420px;
            margin: 20px;
            padding: 1rem !important;
        }
        .container.vh-100 {
            padding-top: 20px;
            padding-bottom: 20px;
            align-items: flex-start;
        }
    }

    </style>

</head>


<body>


<form id="form1" runat="server">


<div class="container vh-100 d-flex justify-content-center align-items-center">


    <div class="card shadow login-card">



        <!-- Logo -->

        <div class="text-center mb-3">

            <asp:Image 
                ID="imgLogo"
                runat="server"
                ImageUrl="~/Images/bu_logo.png"
                AlternateText="Bahria University Logo"
                CssClass="img-fluid"
                Style="max-width:90px;height:auto;" />

        </div>



        <!-- Heading -->

        <div class="text-center mb-4">
            <h5 class="welcome-text">Welcome to Bahria University</h5>
            <h5 class="portal-text">HR Portal</h5>
        </div>




        <!-- Email -->

        <div class="mb-3">

            <label class="form-label">
                <i class="bi bi-envelope-fill me-1"></i>Email Address
            </label>

            <asp:TextBox 
                ID="txtEmail"
                runat="server"
                CssClass="form-control"
                placeholder="Enter Email Address">
            </asp:TextBox>

            <asp:RequiredFieldValidator
                ID="rfvEmail"
                runat="server"
                ControlToValidate="txtEmail"
                ErrorMessage="Email Address is required."
                CssClass="validation-error"
                Display="Dynamic">
            </asp:RequiredFieldValidator>

            <asp:RegularExpressionValidator
                ID="revEmail"
                runat="server"
                ControlToValidate="txtEmail"
                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                ErrorMessage="Enter a valid email address."
                CssClass="validation-error"
                Display="Dynamic">
            </asp:RegularExpressionValidator>

        </div>


        <!-- Password -->

        <div class="mb-3">

            <label class="form-label">
                <i class="bi bi-lock-fill me-1"></i>Password
            </label>

            <asp:TextBox
                ID="txtPassword"
                runat="server"
                CssClass="form-control"
                TextMode="Password"
                placeholder="Enter Password">
            </asp:TextBox>

            <div class="text-end mt-2">

                <asp:HyperLink
                    ID="lnkForgotPassword"
                    runat="server"
                    NavigateUrl="~/ForgotPassword.aspx"
                    CssClass="text-decoration-none forgot-link">

                    Forgot Password?

                </asp:HyperLink>

            </div>

        </div>


        <!-- Login Button -->

        <div class="d-grid mt-2">

            <asp:Button
                ID="btnLogin"
                runat="server"
                Text="Login"
                CssClass="btn btn-lg btn-bu-blue"
                OnClick="Login_Click" />

        </div>


        <!-- Sign Up -->

        <div class="mt-3 text-center">

            <span class="text-muted">
                Don't have an account?
            </span>

            <asp:HyperLink
                ID="lnkSignUp"
                runat="server"
                NavigateUrl="~/SignUp.aspx"
                CssClass="text-decoration-none fw-bold text-bu-blue">

                Sign Up

            </asp:HyperLink>

        </div>


        <!-- Message -->

        <div class="mt-3 text-center">

            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="text-danger">
            </asp:Label>

        </div>



    </div>


</div>


</form>


</body>
</html>