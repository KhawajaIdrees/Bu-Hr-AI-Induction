<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication4.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>HR Portal Login</title>

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

        /* PAGE HEADER */
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

        /* CARD */
        .login-card {
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

        /* VALIDATION */
        .validation-error {
            display: block;
            color: var(--error-red);
            font-size: 12px;
            font-weight: 500;
            margin-top: 5px;
            font-family: var(--font-ui);
        }

        /* FORGOT LINK */
        .forgot-link {
            color: var(--action-blue);
            font-size: 13px;
            font-weight: 500;
            font-family: var(--font-ui);
            text-decoration: none;
            transition: color 0.15s ease;
        }

        .forgot-link:hover {
            color: var(--action-blue-hover);
            text-decoration: underline;
        }

        /* BUTTON */
        .btn-login {
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

        .btn-login:hover {
            background: var(--action-blue-hover);
            color: #FFFFFF;
        }

        /* MESSAGE */
        .text-danger {
            display: block;
            text-align: center;
            color: var(--error-red) !important;
            font-size: 13px;
            font-weight: 500;
            margin-top: 16px;
            font-family: var(--font-ui);
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

        .bottom-links .signup-link {
            color: var(--action-blue);
            font-weight: 600;
            text-decoration: none;
            margin-left: 4px;
        }

        .bottom-links .signup-link:hover {
            text-decoration: underline;
        }

        /* RESPONSIVE */
        @media (max-width: 640px) {
            .page-wrap { padding: 32px 16px 40px; }
            .main-heading { font-size: 28px; }
            .login-card { padding: 24px 20px; }
            .form-control { height: 44px; }
            .btn-login { height: 46px; }
        }
    </style>
</head>

<body>

    <form id="form1" runat="server">

        <div class="page-wrap">

            <!-- HEADER -->
            <div class="page-header">
                <asp:Image ID="imgLogo"
                    runat="server"
                    ImageUrl="~/Images/bu_logo.png"
                    AlternateText="Bahria University Logo"
                    CssClass="logo" />
                <div>
                    <div class="uni-name">Bahria University</div>
                    <div class="hr-portal">HR Portal</div>
                </div>
            </div>

            <!-- MAIN HEADING -->
            <h1 class="main-heading">Welcome Back</h1>
            <p class="main-subtitle">Sign in to your HR Portal account.</p>

            <!-- CARD -->
            <div class="login-card">

                <!-- EMAIL -->
                <div class="form-group">
                    <label class="form-label">Email Address</label>

                    <asp:TextBox ID="txtEmail"
                        runat="server"
                        CssClass="form-control"
                        placeholder="Enter Email Address">
                    </asp:TextBox>

                    <asp:RequiredFieldValidator ID="rfvEmail"
                        runat="server"
                        ControlToValidate="txtEmail"
                        ErrorMessage="Email Address is required."
                        CssClass="validation-error"
                        Display="Dynamic">
                    </asp:RequiredFieldValidator>

                    <asp:RegularExpressionValidator ID="revEmail"
                        runat="server"
                        ControlToValidate="txtEmail"
                        ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                        ErrorMessage="Enter a valid email address."
                        CssClass="validation-error"
                        Display="Dynamic">
                    </asp:RegularExpressionValidator>
                </div>

                <!-- PASSWORD -->
                <div class="form-group">
                    <label class="form-label">Password</label>

                    <asp:TextBox ID="txtPassword"
                        runat="server"
                        CssClass="form-control"
                        TextMode="Password"
                        placeholder="Enter Password">
                    </asp:TextBox>

                    <div class="text-end mt-2">
                        <asp:HyperLink ID="lnkForgotPassword"
                            runat="server"
                            NavigateUrl="~/ForgotPassword.aspx"
                            CssClass="forgot-link">
                            Forgot Password?
                        </asp:HyperLink>
                    </div>
                </div>

                <!-- LOGIN BUTTON -->
                <asp:Button ID="btnLogin"
                    runat="server"
                    Text="Login"
                    CssClass="btn-login"
                    OnClick="Login_Click" />

                <!-- MESSAGE -->
                <asp:Label ID="lblMessage"
                    runat="server"
                    CssClass="text-danger">
                </asp:Label>

                <!-- SIGN UP LINK -->
                <div class="bottom-links">
                    Don't have an account?
                    <asp:HyperLink ID="lnkSignUp"
                        runat="server"
                        NavigateUrl="~/SignUp.aspx"
                        CssClass="signup-link">
                        Sign Up
                    </asp:HyperLink>
                </div>

            </div>

        </div>

    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>