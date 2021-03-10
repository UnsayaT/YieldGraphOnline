<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Config_SearchUpdateDelete.aspx.vb" Inherits="WebYieldGraph_V1.Config_SearchUpdateDelete" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="auto-style4">
            <h2 class="text-center">SEARCH / UPDATE / DELETE</h2>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-body">
             <div class="form-group">
                 <span style="color: #FF0000">
                 <label for="DEVICE NAME">DEVICE NAME</label></span>
                 <asp:TextBox ID="txtDEVICENAME" runat="server" class="form-control" ></asp:TextBox>    
             </div>
            <div class="form-group">
                 <span style="color: #FF0000">
                 <label for="PACKAGENAME">PACKAGENAME</label></span>
                 <asp:DropDownList ID="DropDownList1" runat="server" class="form-control" Height="30px" Width="100%" DataSourceID="SqlDataSource1" DataTextField="PackageName" DataValueField="PackageName"></asp:DropDownList>
                 <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DBxConnectionString %>" SelectCommand="SELECT DISTINCT [PackageName] FROM [Cal_LCL]  ORDER BY PackageName ASC"></asp:SqlDataSource>
             </div>

            <div class="form-group">
                 <label for="FLOWNAME">FLOW NAME</label>
                 <asp:DropDownList ID="DropDownList2" runat="server" class="form-control" Height="30px" Width="100%">
                    <asp:ListItem>Select Flow Name</asp:ListItem>
                    <asp:ListItem>AUTO1</asp:ListItem>
                    <asp:ListItem>AUTO2</asp:ListItem>
                    <asp:ListItem>AUTO3</asp:ListItem>
                    <asp:ListItem>AUTO4</asp:ListItem>
                    <asp:ListItem>AUTO5</asp:ListItem>
                </asp:DropDownList>
             </div>

             <div class="form-group">
                 <label for="PROCESS">PROCESS</label>
                 <asp:DropDownList ID="DropDownList3" runat="server" class="form-control" Height="30px" Width="100%">
                    <asp:ListItem>Select Process</asp:ListItem>
                    <asp:ListItem>FT</asp:ListItem>
                    <asp:ListItem>FL</asp:ListItem>
                </asp:DropDownList>
            </div>

             <div class="form-group">
                 <label for="LCL">LCL</label>
                 <asp:TextBox ID="LCL" runat="server" class="form-control" ></asp:TextBox>    
             </div>

             <div class="form-group">
                 <label for="UPDATE LCL">UPDATE LCL</label>
                 <div class="form-control">
                     <label class="radio-inline">
                        <asp:RadioButton ID="RadioButton2" runat="server" GroupName="Menu" Text="FIX" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     </label>
                     <label class="radio-inline"> 
                         <asp:RadioButton ID="RadioButton3" runat="server" GroupName="Menu" Text="AUTO UPDATE" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     </label>
                </div>
             </div>

            <div class="form-group">
                 <label for="Status Rank">Status Rank</label>
                 <div class="form-control">
                     <label class="radio-inline">
                        <asp:RadioButton ID="RadioButton1" runat="server" GroupName="Rank" Text="FIX" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     </label>
                     <label class="radio-inline"> 
                         <asp:RadioButton ID="RadioButton4" runat="server" GroupName="Rank" Text="NOT FIX" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     </label>
                </div>
             </div>

            <div class="form-group">
                 <label for="Chief">Chief</label>
                 <asp:TextBox ID="txtChief" runat="server" class="form-control"></asp:TextBox>
             </div>

            <div class="form-group">
                 <label for="Sheet">Sheet</label>
                 <asp:TextBox ID="txtsheet" runat="server" class="form-control"></asp:TextBox>
                 <span style="color: #FF3300">****EX. 1/1
             </span>
             </div>

            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </div>
        <div class="panel-footer">
            <asp:Button ID="Button1" runat="server"  class="btn btn-primary" Text="SEARCH" Height="35px"/>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button2" runat="server"  class="btn btn-primary" Text="UPDATE" Height="35px"/>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button3" runat="server"  class="btn btn-primary" Text="DELETE" Height="35px" BackColor="#FF5050"/>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button4" runat="server"  class="btn btn-primary" Text="CLOSE" Height="35px" PostBackUrl="~/Default.aspx"/>
        </div>
    </div>
</asp:Content>
