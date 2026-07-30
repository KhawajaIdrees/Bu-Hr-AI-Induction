<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CalculateScore.aspx.cs" Inherits="WebApplication4.CalculateScore" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="CalcEduScore" runat="server" Text="Calculate Education Score" OnClick="CalcEduScore_Click" />
            <asp:Button ID="CalcJobScore" runat="server" Text="Calculate Job Score" OnClick="CalcJobScore_Click" />
            <asp:Button ID="CalcResearchScore" runat="server" Text="Calculate Research Score" OnClick="CalcResearchScore_Click" />
            <br />
            <br />
               <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="True"></asp:GridView>
             <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="True"></asp:GridView>
        </div>
    </form>
    </body>
</html>
