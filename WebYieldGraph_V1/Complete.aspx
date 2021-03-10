<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Complete.aspx.vb" Inherits="WebYieldGraph_V1.Complete" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            text-align: center;
        }
        .auto-style2 {
            color: #FFFFCC;
            background-color: #009900;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="auto-style1">
        
            <strong>
        
                <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
                <asp:Label ID="Label1" runat="server" Text="*** บันทึกข้อมูลสำเร็จ ***" CssClass="auto-style2"></asp:Label>
                <br />
                <br />
                <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="~/FLYLDControlGraph.aspx">*** คลิกที่นี้เพื่อกลับหน้าแรก ***</asp:LinkButton>

            </strong>

        </div>
    </form>
</body>
</html>
