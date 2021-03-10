<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AddMember.aspx.vb" Inherits="WebYieldGraph_V1.AddMember" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style5 {
            width: 206px;
        }
        .auto-style6 {
            width: 206px;
            text-align: center;
        }
        .auto-style7 {
            width: 114px;
        }
        .auto-style8 {
            width: 371px;
        }
        .auto-style9 {
            font-size: medium;
        }
        .auto-style10 {
            font-size: xx-small;
            color: #FF3300;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            <table align="center" class="auto-style8">
                <tr>
                    <td class="auto-style6" colspan="2">
                        <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Label ID="Label1" runat="server" Text="ADD MEMBER" CssClass="auto-style9"></asp:Label>
                        </strong>
                    </td>
                    
                </tr>
                
                <tr>
                    <td class="auto-style7">
                        OP (Emp. No): <br></td>
                    <td class="auto-style5">
                        
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:TextBox ID="txtOPNo" runat="server" Height="16px" Width="101px"></asp:TextBox>
                       
                        <asp:Label ID="Label2" runat="server" Text="Ex. 001234" CssClass="auto-style10"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style7">
                        <label for="lname">GL (Emp. No):</label>
                    </td>
                    <td>

                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                        <asp:DropDownList ID="Drop_GL" runat="server" DataSourceID="SqlDataSource1" DataTextField="ID" DataValueField="ID" Height="20px" Width="129px">
                            <asp:ListItem></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style7">
                        <label for="lname">Process :</label>
                    </td>
                    <td>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:DropDownList ID="DropProcess" runat="server" Height="20px" Width="129px">
                            <asp:ListItem>Select Process</asp:ListItem>
                            <asp:ListItem Value="FT">Process FT</asp:ListItem>
                            <asp:ListItem Value="FL">Process FL</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DBxConnectionString %>" SelectCommand="SELECT [ID] FROM [BMEmployee] WHERE ((([ProcessID] = @ProcessID) OR ([ProcessID] = @ProcessID2)) AND (([Permit] = @Permit) or ([Permit] = @Permit2 )) and (ID &lt;&gt; '974553' and ID &lt;&gt; '974556' and ID &lt;&gt; '974559' and ID&lt;&gt;'7777'))">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="FT" Name="ProcessID" Type="String" />
                                <asp:Parameter DefaultValue="FL" Name="ProcessID2" Type="String" />
                                <asp:Parameter DefaultValue="1" Name="Permit" Type="Int32" />
                                <asp:Parameter DefaultValue="2" Name="Permit2" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style5" colspan="2">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
                        <asp:Button ID="Button1" runat="server" Text="Submit" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
    <p>
&nbsp;</p>
</body>
</html>
