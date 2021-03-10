<%@ Page Title="Home Page" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="WebYieldGraph_V1._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>YIELD GRAPH CONTROL</h1>
    </div>

    <div class="row">
        <div class="col-md-4">
            <h2 class="text-center">FL Yield Graph Control</h2>
            <p class="text-center">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Img/Graph.PNG" />
            </p>
            <p class="text-center">
                <a class="btn btn-default" href="FLYLDControlGraph.aspx">Detail &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2 class="text-center">FT Yield Graph Control</h2>
            <p class="text-center">
                <asp:Image ID="Image2" runat="server" ImageUrl="~/Img/Graph.PNG" />
            </p>
            <p class="text-center">
                <a class="btn btn-default" href="FTYLD_ControlGraph.aspx">Detail &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2 class="text-center">Config Yield Graph</h2>
            <p class="text-center">
                <asp:Image ID="Image3" runat="server" Height="80px" ImageUrl="~/Img/Config.png" Width="80px" />
            </p>
            <p class="text-center">
                <a class="btn btn-default" href="Config_Add.aspx">ADD &raquo;</a>&nbsp;&nbsp;&nbsp;
                <a class="btn btn-default" href="Config_SearchUpdateDelete.aspx">Search / Update / Delete  &raquo;</a>
            </p>
        </div>
    </div>

</asp:Content>
