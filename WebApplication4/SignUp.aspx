<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="WebApplication4.SignIn" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Bahria University HR Portal - Sign Up</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        body {
            background: linear-gradient(135deg, #f4f7fc 0%, #e8edf7 100%);
            font-family: 'Segoe UI', Arial, sans-serif;
            min-height: 100vh;
        }

        .signup-card {
            max-width: 550px;
            margin: 60px auto;
            border: none;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(45, 57, 141, 0.15) !important;
        }

        .card-header {
            background: linear-gradient(135deg, #2D398D 0%, #3a4bb0 100%) !important;
            padding: 1.75rem 1.5rem;
            border: none;
        }

        .card-header h3 {
            margin: 0;
            font-weight: 700;
            letter-spacing: 0.3px;
        }

        .card-header p {
            margin: 0.25rem 0 0;
            opacity: 0.85;
            font-size: 0.9rem;
        }

        .card-body {
            padding: 2.25rem 2rem;
        }

        .text-bu-blue {
            color: #2D398D !important;
        }

        .bg-bu-blue {
            background-color: #2D398D !important;
            color: #ffffff;
            border-color: #2D398D;
        }

        .form-label {
            color: #2D398D;
            font-size: 0.92rem;
            margin-bottom: 0.4rem;
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

        .form-text {
            font-size: 0.8rem;
            color: #6c757d;
        }

        .text-danger {
            font-size: 0.85rem;
        }

        .btn-bu-blue {
            background-color: #2D398D;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            padding: 0.7rem;
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

        .page-title h4 {
            color: #2D398D;
            font-weight: 700;
        }

        .page-title hr {
            border-top: 2px solid #2D398D;
            opacity: 0.15;
           
            margin: 0.75rem 0 0;
        }

        .login-link {
            color: #2D398D;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.2s;
        }

        .login-link:hover {
            color: #232c70;
            text-decoration: underline;
        }
    </style>
</head>

<body>

<form id="form1" runat="server">

<div class="container py-4">

    <div class="text-left mb-4 page-title">
        <h4 class="fw-bold">User Registration</h4>
        <h5 class="text-secondary fw-normal">Bahria University HR Portal</h5>
        <hr />
    </div>

    <div class="card shadow signup-card">

        <div class="card-header text-white text-center">
            <h3><i class="bi bi-person-plus-fill me-2"></i>Create Your Account</h3>
            <p>Fill in your details to register</p>
        </div>

        <div class="card-body">

            <asp:ValidationSummary
                ID="ValidationSummary1"
                runat="server"
                ValidationGroup="Register"
                CssClass="alert alert-danger" />

            <!-- Email -->
            <div class="mb-3">
                <label class="form-label fw-bold">
                    <i class="bi bi-envelope-fill me-1"></i>Email Address
                </label>

                <asp:TextBox
                    ID="txtEmail"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Email"
                    placeholder="Enter your email">
                </asp:TextBox>

                <asp:RequiredFieldValidator
                    ID="rfvEmail"
                    runat="server"
                    ControlToValidate="txtEmail"
                    ValidationGroup="Register"
                    ErrorMessage="Email is required."
                    CssClass="text-danger"
                    Display="Dynamic" />

                <asp:RegularExpressionValidator
                    ID="revEmail"
                    runat="server"
                    ControlToValidate="txtEmail"
                    ValidationGroup="Register"
                    Display="Dynamic"
                    CssClass="text-danger"
                    ValidationExpression="^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,})+$"
                    ErrorMessage="Please enter a valid email address." />
            </div>

            <!-- Password -->
            <div class="mb-3">
                <label class="form-label fw-bold">
                    <i class="bi bi-lock-fill me-1"></i>Password
                </label>

                <asp:TextBox
                    ID="txtPassword"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Password"
                    placeholder="Enter password">
                </asp:TextBox>

                <div class="form-text">
                    Must contain at least 8 characters, one uppercase, one lowercase, and one number.
                </div>

                <asp:RequiredFieldValidator
                    ID="rfvPassword"
                    runat="server"
                    ControlToValidate="txtPassword"
                    ValidationGroup="Register"
                    ErrorMessage="Password is required."
                    CssClass="text-danger"
                    Display="Dynamic" />

                <asp:RegularExpressionValidator
                    ID="revPassword"
                    runat="server"
                    ControlToValidate="txtPassword"
                    ValidationGroup="Register"
                    Display="Dynamic"
                    CssClass="text-danger"
                    ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$"
                    ErrorMessage="Password must be at least 8 characters and include uppercase, lowercase and a number." />
            </div>

            <!-- Confirm Password -->
            <div class="mb-4">
                <label class="form-label fw-bold">
                    <i class="bi bi-shield-lock-fill me-1"></i>Confirm Password
                </label>

                <asp:TextBox
                    ID="txtConfirmPassword"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Password"
                    placeholder="Confirm password">
                </asp:TextBox>

                <asp:RequiredFieldValidator
                    ID="rfvConfirmPassword"
                    runat="server"
                    ControlToValidate="txtConfirmPassword"
                    ValidationGroup="Register"
                    ErrorMessage="Confirm Password is required."
                    CssClass="text-danger"
                    Display="Dynamic" />

                <asp:CompareValidator
                    ID="cvPassword"
                    runat="server"
                    ControlToValidate="txtConfirmPassword"
                    ControlToCompare="txtPassword"
                    ValidationGroup="Register"
                    Display="Dynamic"
                    CssClass="text-danger"
                    ErrorMessage="Passwords do not match." />
            </div>

            <!-- Button -->
            <div class="d-grid">
                <asp:Button
                    ID="btnRegister"
                    runat="server"
                    Text="Create Account"
                    CssClass="btn btn-lg btn-bu-blue"
                    ValidationGroup="Register"
                    OnClick="BtnRegister_Click" />
            </div>

            <div class="text-center mt-3">
                <asp:Label
                    ID="lblMessage"
                    runat="server"
                    CssClass="fw-bold">
                </asp:Label>
            </div>

            <!-- Login Link -->
            <div class="text-center mt-4 pt-2 border-top">
                <span class="text-muted">Already have an account?</span>
                <a href="Login.aspx" class="login-link ms-1">
                    <i class="bi bi-box-arrow-in-right me-1"></i>Login Here
                </a>
            </div>

        </div>

    </div>

</div>

</form>

</body>
</html>