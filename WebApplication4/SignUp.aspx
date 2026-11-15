<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="WebApplication4.SignIn" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Sign Up - Bahria University HR Portal</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Georgia&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" />

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
        html, body { margin: 0; padding: 0; }

        body {
            background: var(--page-bg);
            font-family: var(--font-ui);
            font-size: 14px;
            color: var(--body-text);
            min-height: 100vh;
            -webkit-font-smoothing: antialiased;
        }

        .page-wrap {
            max-width: 560px;
            margin: 0 auto;
            padding: 48px 24px 60px;
        }

        /* HEADER */
        .page-header {
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 32px;
        }

        .page-header .logo { height: 48px; width: auto; }

        .page-header .uni-name {
            font-family: var(--font-ui);
            font-weight: 600;
            font-size: 22px;
            color: var(--primary-navy);
            line-height: 1.2;
        }

        .page-header .hr-portal {
            font-family: var(--font-ui);
            font-weight: 400;
            font-size: 13px;
            color: var(--muted-text);
            line-height: 1.2;
            margin-top: 2px;
        }

        .main-heading {
            font-family: var(--font-heading);
            font-weight: 600;
            font-size: 34px;
            color: var(--primary-navy);
            line-height: 1.15;
            margin: 0 0 6px 0;
            letter-spacing: -0.3px;
        }

        .main-subtitle {
            font-family: var(--font-ui);
            font-weight: 400;
            font-size: 15px;
            color: var(--muted-text);
            margin: 0 0 28px 0;
        }

        /* SIGNUP CARD */
        .signup-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            box-shadow: 0 1px 3px rgba(15, 23, 42, 0.03);
            padding: 32px 30px;
        }

        /* FORM LABEL */
        .form-label {
            display: block;
            font-family: var(--font-ui);
            font-weight: 500;
            font-size: 13px;
            color: var(--body-text);
            margin-bottom: 7px;
        }

        /* INPUTS */
        .form-control {
            width: 100%;
            background: var(--input-bg);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            height: 46px;
            font-family: var(--font-ui);
            font-size: 14px;
            color: var(--body-text);
            padding: 0 14px;
            transition: border-color 0.15s ease, box-shadow 0.15s ease;
        }

        .form-control::placeholder {
            color: var(--placeholder);
            font-weight: 400;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--action-blue);
            box-shadow: 0 0 0 2px rgba(23, 105, 168, 0.08);
        }

        .form-group {
            margin-bottom: 20px;
        }

        /* HELP TEXT */
        .form-text {
            font-family: var(--font-ui);
            font-size: 12px;
            color: var(--muted-text);
            margin-top: 6px;
            line-height: 1.4;
        }

        /* VALIDATION */
        .text-danger {
            display: block;
            color: var(--error-red) !important;
            font-size: 12px;
            font-weight: 500;
            margin-top: 5px;
            font-family: var(--font-ui);
        }

        /* VALIDATION SUMMARY */
        .alert-danger {
            background: #FEF2F2;
            border: 1px solid #FECACA;
            color: #991B1B;
            border-radius: var(--radius);
            padding: 12px 16px;
            font-size: 13px;
            font-family: var(--font-ui);
            margin-bottom: 20px;
        }

        .alert-danger ul {
            margin: 0;
            padding-left: 20px;
        }

        /* BUTTON */
        .btn-signup {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            width: 100%;
            background: var(--action-blue);
            color: #FFFFFF;
            border: none;
            border-radius: var(--radius);
            height: 48px;
            padding: 0 20px;
            font-family: var(--font-ui);
            font-weight: 600;
            font-size: 15px;
            letter-spacing: 0.3px;
            cursor: pointer;
            transition: background 0.15s ease;
            text-decoration: none;
        }

        .btn-signup:hover {
            background: var(--action-blue-hover);
            color: #FFFFFF;
        }

        /* MESSAGE */
        .message-label {
            display: block;
            text-align: center;
            font-family: var(--font-ui);
            font-weight: 600;
            font-size: 13px;
            margin-top: 14px;
        }

        /* BOTTOM LINKS */
        .bottom-links {
            text-align: center;
            margin-top: 26px;
            padding-top: 20px;
            border-top: 1px solid var(--divider);
            font-family: var(--font-ui);
            font-size: 13px;
            color: var(--muted-text);
        }

        .bottom-links .login-link {
            color: var(--action-blue);
            font-weight: 600;
            text-decoration: none;
            margin-left: 4px;
        }

        .bottom-links .login-link:hover {
            text-decoration: underline;
        }

        /* RESPONSIVE */
        @media (max-width: 640px) {
            .page-wrap { padding: 32px 16px 40px; }
            .main-heading { font-size: 28px; }
            .signup-card { padding: 24px 20px; }
            .form-control { height: 44px; }
            .btn-signup { height: 46px; }
        }
    </style>
</head>

<body>

<form id="form1" runat="server">

    <div class="page-wrap">

        <!-- HEADER -->
        <div class="page-header">
            <img src="Images/bu_logo.png" alt="Bahria University" class="logo" />
            <div>
                <div class="uni-name">Bahria University</div>
                <div class="hr-portal">HR Portal</div>
            </div>
        </div>

        <!-- MAIN HEADING -->
        <h1 class="main-heading">Create Your Account</h1>
        <p class="main-subtitle">Fill in your details to register for the HR Portal.</p>

        <!-- SIGNUP CARD -->
        <div class="signup-card">

            <asp:ValidationSummary
                ID="ValidationSummary1"
                runat="server"
                ValidationGroup="Register"
                CssClass="alert-danger" />

            <!-- EMAIL -->
            <div class="form-group">
                <label class="form-label">Email Address</label>

                <asp:TextBox ID="txtEmail"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Email"
                    placeholder="Enter your email">
                </asp:TextBox>

                <asp:RequiredFieldValidator ID="rfvEmail"
                    runat="server"
                    ControlToValidate="txtEmail"
                    ValidationGroup="Register"
                    ErrorMessage="Email is required."
                    CssClass="text-danger"
                    Display="Dynamic" />

                <asp:RegularExpressionValidator ID="revEmail"
                    runat="server"
                    ControlToValidate="txtEmail"
                    ValidationGroup="Register"
                    Display="Dynamic"
                    CssClass="text-danger"
                    ValidationExpression="^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,})+$"
                    ErrorMessage="Please enter a valid email address." />
            </div>

            <!-- PASSWORD -->
            <div class="form-group">
                <label class="form-label">Password</label>

                <asp:TextBox ID="txtPassword"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Password"
                    placeholder="Enter password">
                </asp:TextBox>

                <div class="form-text">
                    Must contain at least 8 characters, one uppercase, one lowercase, and one number.
                </div>

                <asp:RequiredFieldValidator ID="rfvPassword"
                    runat="server"
                    ControlToValidate="txtPassword"
                    ValidationGroup="Register"
                    ErrorMessage="Password is required."
                    CssClass="text-danger"
                    Display="Dynamic" />

                <asp:RegularExpressionValidator ID="revPassword"
                    runat="server"
                    ControlToValidate="txtPassword"
                    ValidationGroup="Register"
                    Display="Dynamic"
                    CssClass="text-danger"
                    ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$"
                    ErrorMessage="Password must be at least 8 characters and include uppercase, lowercase and a number." />
            </div>

            <!-- CONFIRM PASSWORD -->
            <div class="form-group">
                <label class="form-label">Confirm Password</label>

                <asp:TextBox ID="txtConfirmPassword"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Password"
                    placeholder="Confirm password">
                </asp:TextBox>

                <asp:RequiredFieldValidator ID="rfvConfirmPassword"
                    runat="server"
                    ControlToValidate="txtConfirmPassword"
                    ValidationGroup="Register"
                    ErrorMessage="Confirm Password is required."
                    CssClass="text-danger"
                    Display="Dynamic" />

                <asp:CompareValidator ID="cvPassword"
                    runat="server"
                    ControlToValidate="txtConfirmPassword"
                    ControlToCompare="txtPassword"
                    ValidationGroup="Register"
                    Display="Dynamic"
                    CssClass="text-danger"
                    ErrorMessage="Passwords do not match." />
            </div>

            <!-- SUBMIT BUTTON -->
            <asp:Button ID="btnRegister"
                runat="server"
                Text="Create Account"
                CssClass="btn-signup"
                ValidationGroup="Register"
                OnClick="BtnRegister_Click" />

            <!-- MESSAGE -->
            <asp:Label ID="lblMessage"
                runat="server"
                CssClass="message-label">
            </asp:Label>

            <!-- LOGIN LINK -->
            <div class="bottom-links">
                Already have an account?
                <a href="Login.aspx" class="login-link">Login Here</a>
            </div>

        </div>

    </div>

</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>