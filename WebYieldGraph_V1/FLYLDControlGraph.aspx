<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FLYLDControlGraph.aspx.vb" Inherits="WebYieldGraph_V1.FLYLDControlGraph"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <style>
        * {
          box-sizing: border-box;
        }

        body {
          font: 16px Arial;  
        }

        /*the container must be positioned relative:*/
        .autocomplete {
          position: relative;
          display: inline-block;
        }

        input {
          border: 1px solid transparent; 
          background-color: #f1f1f1;
          padding: 10px;
          font-size: 16px;
        }

        input[type=text] {
          background-color: #f1f1f1;
          width: 100%;
        }

        input[type=submit] {
          background-color: DodgerBlue;
          color: #fff;
          cursor: pointer;
        }

        .autocomplete-items {
          position: absolute;
          border: 1px solid #d4d4d4;
          border-bottom: none;
          border-top: none;
          z-index: 99;
          /*position the autocomplete items to be the same width as the container:*/
          top: 100%;
          left: 0;
          right: 0;
        }

        .autocomplete-items div {
          padding: 10px;
          cursor: pointer;
          background-color: #fff; 
          border-bottom: 1px solid #d4d4d4; 
        }

        /*when hovering an item:*/
        .autocomplete-items div:hover {
          background-color: #e9e9e9; 
        }

        /*when navigating through the items using the arrow keys:*/
        .autocomplete-active {
          background-color: DodgerBlue !important; 
          color: #ffffff; 
        }
         .auto-style1 {
             text-align: center;
         }
         .auto-style2 {
             background-color: rgba(30, 144, 255, 1.00); 
             width: 1500px;
         }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="auto-style1">
            <div class="autocomplete" style="width:300px; ">
                <input id="myInput" type="text" name="DeviceName" placeholder="DeviceName">
            </div>
            <asp:Button ID="Button1" runat="server" Text="Search" class="btn btn-default"/>
        </div>
        <br />
        <div class="auto-style1">
            <table align="center" border="2" style="width: 445px; margin-bottom: 0px">
                <tr>
                    <td><strong>Package Name</strong></td>
                    <td><strong>Device Name</strong></td>
                    <td><strong>UCL</strong></td>
                    <td><strong>AVE</strong></td>
                    <td><strong>LCL</strong></td>
                    <td><strong>PDF File</strong></td>
                    <td><strong>OLD Data</strong></td>
                    <td><strong>ADD Member</strong></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="Label3" runat="server" style="color: #FF0000" Text=""></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="Label4" runat="server" style="color: #000000"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="Label5" runat="server" style="color: #0000FF"></asp:Label>
                    </td>
                    <td> 
                        <asp:ImageButton ID="ImgBtnCheckSheet" runat="server" Height="42px" Width="42px" ImageUrl="~/Img/ViewSheet.png" CommandName="ViewSheet"/>
                    </td>
                    <td> 
                        <asp:ImageButton ID="ImageBtnExcel" runat="server" Height="42px" Width="42px" ImageUrl="~/Img/History.png" CommandName="ViewSheet"/>
                        <asp:Label id="lblText" runat="server"></asp:Label>
                    </td>
                    <td> 
                        <asp:ImageButton ID="ImageButton1" runat="server" Height="42px" Width="42px" ImageUrl="~/Img/AddMember.jpg" CommandName="ViewSheet" PostBackUrl="~/AddMember.aspx"/>
                    </td>
                </tr>
            </table>
        </div> 
    <br />
    <div class="auto-style1">
        <strong>
        <asp:Label ID="Label9" runat="server" Text="Remark : " style="text-decoration: underline; color: #FF0000"></asp:Label></strong>&nbsp;&nbsp;
        <asp:Image ID="Image2" runat="server" Height="19px" ImageUrl="~/Img/R.jpg" Width="100px" />&nbsp;<strong><asp:Label ID="Label7" runat="server" Text=": UCL"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
        </strong>
        <asp:Image ID="Image1" runat="server" Height="19px" ImageUrl="~/Img/B.jpg" Width="100px" />&nbsp;<strong><asp:Label ID="Label6" runat="server" Text=": LCL"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
        </strong>
        <asp:Image ID="Image3" runat="server" Height="19px" ImageUrl="~/Img/G.jpg" Width="100px" />&nbsp;<strong><asp:Label ID="Label8" runat="server" Text=": Yield"></asp:Label>
        </strong>
    </div>
        <br />
    <div class="auto-style1">
        <!--Show Graph-->
        <asp:Chart ID="Chart1" runat="server" Width="1000px" RightToLeft="Yes" Height="600px">
            <Series>
                <asp:Series Name="Series1" BorderWidth="3" Color="Green" ChartType="Line" Font="Microsoft Sans Serif, 8pt, style=Bold">
                </asp:Series>
                <asp:Series Name="Series2" BorderWidth="2" Color="Red" ChartType="Spline">
                </asp:Series>
                <asp:Series Name="Series3" BorderWidth="2" Color="Blue" ChartType="Spline">
                </asp:Series>
                <asp:Series Name="Series4" BorderWidth="2" Color="Red" ChartType="Spline">
                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">
                    <AxisY Maximum="100" Minimum="96" Interval="0.2" LabelAutoFitStyle="LabelsAngleStep90" 
                        TitleFont="Verdana, 10pt, style=Bold" Title="YLD" TitleForeColor="Blue">
                        <ScaleBreakStyle MaxNumberOfBreaks="1" Spacing="1" />
                    </AxisY>
                    <AxisX IsLabelAutoFit="False" LabelAutoFitMinFontSize="5"
                        IntervalAutoMode="VariableCount" TitleFont="Verdana, 10pt, style=Bold" Title="Lot No" TitleForeColor="Blue">
                        <LabelStyle Angle="-90" Interval="Auto" Font="Arial Narrow, 10pt" />
                        <ScaleBreakStyle Enabled="True" />
                    </AxisX>
                </asp:ChartArea>
            </ChartAreas>
            <Titles>
                <asp:Title Name="Title" Text="FL Process FT YLD control graph" BackColor="255, 192, 128" Font="Microsoft Sans Serif, 20pt, style=Bold"></asp:Title>
            </Titles>
        </asp:Chart>
    </div>  

    <div style="text-align: center"> 
        <!--Dateilข้อมูล-->
        <table align="center">
            <tr>
                <td>
                   <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" 
                       GridLines="Vertical" Width="1500px" HorizontalAlign="Center" AutoGenerateColumns="False" OnRowDataBound="GridView1_RowDataBound">
                        <AlternatingRowStyle BackColor="#CCCCCC" />
                        <FooterStyle BackColor="#CCCCCC" />
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#808080" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#383838" />

                       <Columns>
                           <asp:TemplateField HeaderText="Date">
                               <ItemTemplate>
                                   <asp:Label id="lblDate" runat="server"></asp:Label>
                               </ItemTemplate>
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="YLD">
                               <ItemTemplate>
                                   <asp:Label id="lblYLD" runat="server"></asp:Label>
                               </ItemTemplate>
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="MC">
                               <ItemTemplate>
                                   <asp:Label id="lblMC" runat="server"></asp:Label>
                               </ItemTemplate>
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="LotNo">
                               <ItemTemplate>
                                   <asp:Label id="lblLotNo" runat="server"></asp:Label>
                               </ItemTemplate>
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="ProgramVer">
                               <ItemTemplate>
                                   <asp:Label id="lblProgramVer" runat="server"></asp:Label>
                               </ItemTemplate>
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="Ach">
                               <ItemTemplate>
                                   <asp:Label id="lblAch" runat="server"></asp:Label>
                               </ItemTemplate>
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="Bch">
                               <ItemTemplate>
                                   <asp:Label id="lblBch" runat="server"></asp:Label>
                               </ItemTemplate>
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="Cch">
                               <ItemTemplate>
                                   <asp:Label id="lblCch" runat="server"></asp:Label>
                               </ItemTemplate>
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="Dch">
                               <ItemTemplate>
                                   <asp:Label id="lblDch" runat="server"></asp:Label>
                               </ItemTemplate>
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="Ech">
                               <ItemTemplate>
                                   <asp:Label id="lblEch" runat="server"></asp:Label>
                               </ItemTemplate>
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="Fch">
                               <ItemTemplate>
                                   <asp:Label id="lblFch" runat="server"></asp:Label>
                               </ItemTemplate>
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="Gch">
                               <ItemTemplate>
                                   <asp:Label id="lblGch" runat="server"></asp:Label>
                               </ItemTemplate>
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="Hch">
                               <ItemTemplate>
                                   <asp:Label id="lblHch" runat="server"></asp:Label>
                               </ItemTemplate>
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="MAX-MIN(R)">
                               <ItemTemplate>
                                   <asp:Label id="lblMAXMIN" runat="server"></asp:Label>
                               </ItemTemplate>
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="OP">
                               <ItemTemplate>
                                   <asp:Label id="lblOP" runat="server"></asp:Label>
                               </ItemTemplate>
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="GL">
                               <ItemTemplate>
                                   <asp:Label id="lblGL" runat="server"></asp:Label>
                               </ItemTemplate>
                           </asp:TemplateField>
                       </Columns>
                    </asp:GridView>
                    <br />
                    <br />
                    <table class="auto-style2">
                        <tr>
                            <td>
                                <strong>
                                <asp:Label ID="lblHead" runat="server" Text=""></asp:Label>
                                </strong>
                            </td>
                        </tr>
                    </table>
                    <asp:GridView ID="GridView2" runat="server" EmptyDataText="No entries found." AutoGenerateColumns="False" Font-Size="Medium" Width="1500px" ShowHeaderWhenEmpty="True" OnPageIndexChanging="OnPageIndexChanging" PageSize="30" HorizontalAlign="Center" CssClass="auto-style24">
                        <columns>
                            <asp:BoundField HeaderText="Device" DataField="Device">
                                <HeaderStyle HorizontalAlign="Center" BackColor="#FFCC99" Font-Size="Smaller" />
                                <ItemStyle BackColor="#FFCC99" Font-Size="Smaller" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="LotNo" DataField="LotNo" >
                                <HeaderStyle HorizontalAlign="Center" Font-Size="Smaller" />
                                <ItemStyle Font-Size="Smaller" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="LotStartTime" DataField="LotStartTime">
                                <HeaderStyle Font-Size="Smaller" />
                                <ItemStyle Font-Size="Smaller" />
                            </asp:BoundField>
                            <asp:BoundField DataField="LotEndTime" HeaderText="LotEndTime">
                                <HeaderStyle Font-Size="Small" HorizontalAlign="Center" />
                                <ItemStyle Font-Size="Small" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="FTNGAdjust" DataField="FTNGAdjust" >
                                <HeaderStyle HorizontalAlign="Center" BackColor="#FFCCFF" Font-Size="Smaller" />
                                <ItemStyle BackColor="#FFCCFF" Font-Size="Smaller" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="GoodAdjust" DataField="GoodAdjust" >
                                <HeaderStyle HorizontalAlign="Center" BackColor="#FFCCFF" Font-Size="Smaller" />
                                <ItemStyle BackColor="#FFCCFF" Font-Size="Smaller" />
                            </asp:BoundField>
                        </columns>
                    </asp:GridView>

                    <br />

                </td>
            </tr>
        </table>
        
    </div>
    </form>

     <script>
        function autocomplete(inp, arr) {
            /*the autocomplete function takes two arguments,
            the text field element and an array of possible autocompleted values:*/
            var currentFocus;
            /*execute a function when someone writes in the text field:*/
            inp.addEventListener("input", function (e) {
                var a, b, i, val = this.value;
                /*close any already open lists of autocompleted values*/
                closeAllLists();
                if (!val) { return false; }
                currentFocus = -1;
                /*create a DIV element that will contain the items (values):*/
                a = document.createElement("DIV");
                a.setAttribute("id", this.id + "autocomplete-list");
                a.setAttribute("class", "autocomplete-items");
                /*append the DIV element as a child of the autocomplete container:*/
                this.parentNode.appendChild(a);
                /*for each item in the array...*/
                for (i = 0; i < arr.length; i++) {
                    /*check if the item starts with the same letters as the text field value:*/
                    if (arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
                        /*create a DIV element for each matching element:*/
                        b = document.createElement("DIV");
                        /*make the matching letters bold:*/
                        b.innerHTML = "<strong>" + arr[i].substr(0, val.length) + "</strong>";
                        b.innerHTML += arr[i].substr(val.length);
                        /*insert a input field that will hold the current array item's value:*/
                        b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
                        /*execute a function when someone clicks on the item value (DIV element):*/
                        b.addEventListener("click", function (e) {
                            /*insert the value for the autocomplete text field:*/
                            inp.value = this.getElementsByTagName("input")[0].value;
                            /*close the list of autocompleted values,
                            (or any other open lists of autocompleted values:*/
                            closeAllLists();
                        });
                        a.appendChild(b);
                    }
                }
            });
            /*execute a function presses a key on the keyboard:*/
            inp.addEventListener("keydown", function (e) {
                var x = document.getElementById(this.id + "autocomplete-list");
                if (x) x = x.getElementsByTagName("div");
                if (e.keyCode == 40) {
                    /*If the arrow DOWN key is pressed,
                    increase the currentFocus variable:*/
                    currentFocus++;
                    /*and and make the current item more visible:*/
                    addActive(x);
                } else if (e.keyCode == 38) { //up
                    /*If the arrow UP key is pressed,
                    decrease the currentFocus variable:*/
                    currentFocus--;
                    /*and and make the current item more visible:*/
                    addActive(x);
                } else if (e.keyCode == 13) {
                    /*If the ENTER key is pressed, prevent the form from being submitted,*/
                    e.preventDefault();
                    if (currentFocus > -1) {
                        /*and simulate a click on the "active" item:*/
                        if (x) x[currentFocus].click();
                    }
                }
            });
            function addActive(x) {
                /*a function to classify an item as "active":*/
                if (!x) return false;
                /*start by removing the "active" class on all items:*/
                removeActive(x);
                if (currentFocus >= x.length) currentFocus = 0;
                if (currentFocus < 0) currentFocus = (x.length - 1);
                /*add class "autocomplete-active":*/
                x[currentFocus].classList.add("autocomplete-active");
            }
            function removeActive(x) {
                /*a function to remove the "active" class from all autocomplete items:*/
                for (var i = 0; i < x.length; i++) {
                    x[i].classList.remove("autocomplete-active");
                }
            }
            function closeAllLists(elmnt) {
                /*close all autocomplete lists in the document,
                except the one passed as an argument:*/
                var x = document.getElementsByClassName("autocomplete-items");
                for (var i = 0; i < x.length; i++) {
                    if (elmnt != x[i] && elmnt != inp) {
                        x[i].parentNode.removeChild(x[i]);
                    }
                }
            }
            /*execute a function when someone clicks in the document:*/
            document.addEventListener("click", function (e) {
                closeAllLists(e.target);
            });
        }

        /*An array containing all the country names in the world:*/
         
         var countries = ["3AD3DT356C", "3D041201-E2", "3DA3DT328A", "3DA3DT328B", "3DA3DT328B-E2", "3DA3DT328C-E2", "3DA3DT336B", "3DA3DT336B-E2", "3DA3DT355A", "3DA3DT356B", "3DA3DT356C-E2", "3DA3DT362A-E2", "3DA3DT366A",
             "A01651315", "A01651315-E2", "ADB5446EFV", "ADBD5446EFV", "ADBD5446EFV1", "ADBD5446EFV2", "ADBD5446EFV3", "ADBD5446EFV4", "ADBD5446EFV5", "ADBD5446EFV6", "ADBD5446EFV8", "ADI-DOL-E2", "AL7761EFV-E2",
             "AL77895RFS-E2", "AO1651315-E2", "AP-N252-E2", "ATPSAMPLE-FX", "AU0-L302-15-GE2", "AU0L302-15-GE2", "AUO-L302-15-GE2", "AUO-L302-15-GFX", "AUO-L302-15GE2", "AUOL302-15-BZGE2", "AUOL302-15-GE2", "AX71111-E2",
             "AX71301-R", "AX71301-RE2",
             "BA00ASFP-BJE2", "BA00ASFP-BJSE2", "BA00ASFP-E2", "BA00ASFP-ME2", "BA00ASFP-SE2", "BA00ASZFP", "BA00ASZFP-BJS", "BA00ASZFP-BJSE2", "BA00ASZFP-E2", "BA00BC0WF", "BA00BC0WF-E2", "BA00BC0WFP", "BA00BC0WFP-BJ",
             "BA00BC0WFP-BJE2", "BA00BC0WFP-BZE2", "BA00BC0WFP-E2", "BA00BC0WFP-ME2", "BA00BC0WFP-SE2", "BA00CC0WFP", "BA00CC0WFP-BJE2", "BA00CC0WFP-BZE2", "BA00CC0WFP-BZME2", "BA00CC0WFP-BZSE2", "BA00CC0WFP-E2",
             "BA00CC0WFP-ME2", "BA00CC0WFP-SE2", "BA00DD0WHFP", "BA00DD0WHFP-E2", "BA00DD0WHFP-GTR", "BA00DD0WHFP-M3TR", "BA00DD0WHFP-ME2", "BA00DD0WHFP-MTR", "BA00DD0WHFP-RTR", "BA00DD0WHFP-TR", "BA00HC5FP",
             "BA00HC5FP-BJE2", "BA00HC5FP-E2", "BA00HC5FP-M", "BA00HC5FP-ME2", "BA00HC5WF-E2", "BA033CC0FP-BZE2", "BA033CC0FP-BZRE2", "BA033CC0FP-BZSE2", "BA033CC0FP-E2", "BA033CC0FP-FE2", "BA033CC0FP-GE2", "BA033CC0FP-QE2",
             "BA033CC0FP-RE2", "BA033CC0FP-SE2", "BA033CC0WFP", "BA033CC0WFP-BJE2", "BA033CC0WFP-BZE2", "BA033CC0WFP-E2", "BA033CC0WFP-FE2", "BA033CC0WFP-ME2", "BA033FP", "BA033FP-BJE2", "BA033FP-BZE2", "BA033FP-E1", "BA033FP-E2",
             "BA033FP-QE2", "BA033SFP-BJE2", "BA033SFP-E2", "BA033SFP-SE2", "BA033SZFP", "BA033SZFP-BJS", "BA033SZFP-BJSE2", "BA03CC0FP-BZE2", "BA03CC0FP-E2", "BA03FP-BJE2", "BA03FP-E2", "BA05CC0FP-BZE2", "BA05CC0FP-BZSE2",
             "BA05CC0FP-E2", "BA05CC0FP-ME2", "BA05CC0FP-SE2", "BA05CC0WFP", "BA05CC0WFP-BJE2", "BA05CC0WFP-BZE2", "BA05CC0WFP-E2", "BA05CC0WFP-ME2", "BA05CC0WFP-QE2", "BA05FP-BJE2", "BA05FP-BZE2", "BA05FP-E1", "BA05FP-E2",
             "BA05SFP-BJSE2", "BA05SFP-BZE2", "BA05SFP-E2", "BA05SFP-ME2", "BA05SFP-SE2", "BA05SZFP", "BA05SZFP-BJE2", "BA05SZFP-BJS", "BA05SZFP-BJSE2", "BA05SZFP-E2", "BA05SZFP-ME2", "BA06CC0FP-BZE2", "BA06CC0FP-E2", "BA06CC0WFP-E2",
             "BA06CC0WFP-ME2", "BA06FP-BZE2", "BA06FP-E2", "BA06SFP-E2", "BA07CC0FP-E2", "BA07SFP-BJSE2", "BA07SFP-E2", "BA07SFP-SE2", "BA07SZFP-BJSE2", "BA07SZFP-SE2", "BA08CC0FP-BJE2", "BA08CC0FP-BZE2", "BA08CC0FP-E2", "BA08CC0FP-GE2",
             "BA08CC0FP-ME2", "BA08CC0FP-SE2", "BA08CC0WFP-BJE2", "BA08CC0WFP-E2", "BA08CC0WFP-ME2", "BA08FP-E2", "BA08FP-ME2", "BA08SFP-E2", "BA08SFP-SE2", "BA08SZFP-BJSE2", "BA08SZFP-E2", "BA09CC0FP-BZE2", "BA09CC0FP-BZSE2", "BA09CC0FP-E2",
             "BA09CC0FP-ME2", "BA09CC0WFP", "BA09CC0WFP-BZE2", "BA09CC0WFP-E2", "BA09CC0WFP-ME2", "BA09FP-BZE2", "BA09FP-E2", "BA09SFP-BJSE2", "BA09SFP-E2", "BA09SFP-SE2", "BA09SZFP-E2", "BA10358F-E2", "BA10358FVM-TR",
             "BA10FP-BZE2", "BA10FP-E2", "BA1117FP-E2", "BA12068FS-BZE2", "BA12068FS-E2", "BA12068FS-ZAE2", "BA12FP-E2", "BA12SFP-E2", "BA12SZFP-E2", "BA1451F-E2", "BA15BC0FP-BJE2", "BA15BC0FP-BZE2", "BA15BC0FP-E2", "BA15BC0FP-QE2",
             "BA15BC0FP-SE2", "BA15BC0WFP-E2", "BA15DD0WHFP-TR", "BA15FP-BZE2", "BA16028FS-E2", "BA17805FP-BZE2", "BA17805FP-BZRE2", "BA17805FP-BZSE2", "BA17805FP-E2", "BA17805FP-FE2", "BA17805FP-ME2", "BA17805FP-QE2",
             "BA17805FP-SE2", "BA17806FP-E2", "BA17806FP-ME2", "BA17807FP", "BA17807FP-E2", "BA17807FP-STR", "BA17808FP-E2", "BA17809FP-BZE2", "BA17809FP-E2", "BA17809FP-SE2", "BA17810FP-E2", "BA17812FP-E2", "BA17812FP-SE2",
             "BA17815FP-BZE2", "BA17815FP-E2", "BA17818FP-E2", "BA17820FP-E2", "BA17824FP-BZE2", "BA17824FP-SE2", "BA178M05FP-BZE2", "BA178M05FP-BZSE2", "BA178M05FP-E2", "BA178M05FP-GE2", "BA178M05FP-ME2", "BA178M05FP-SE2",
             "BA178M06FP-BZE2", "BA178M06FP-E2", "BA178M07FP-E2", "BA178M07FP-SE2", "BA178M08FP", "BA178M08FP-BZE2", "BA178M08FP-E2", "BA178M08FP-ME2", "BA178M09FP-E2", "BA178M09FP-SE2", "BA178M10FP-BZE2", "BA178M10FP-E2",
             "BA178M10FP-ME2", "BA178M12FP-BZE2", "BA178M12FP-BZSE2", "BA178M12FP-E2", "BA178M12FP-ME2", "BA178M15FP", "BA178M15FP-BZE2", "BA178M15FP-E2", "BA178M15FP-SE2", "BA178M18FP-E2", "BA178M18FP-SE2", "BA178M20FP-E2",
             "BA178M24FP-E2", "BA18BC0FP", "BA18BC0FP-E2", "BA18BC0FP-ME2", "BA18BC0FP-SE2", "BA18BC0WFP-E2", "BA18BC0WFP-ME2", "BA18BC0WFP-MTR", "BA18BC0WFP-QE2", "BA18BC0WFP-RE2", "BA18DD0WHFP-MTR", "BA18DD0WHFP-TR",
             "BA2115FVM-MTR", "BA2115FVM-TR", "BA25BC0FP-BJE2", "BA25BC0FP-BZE2", "BA25BC0FP-RE2", "BA25BC0FP-SE2", "BA25DD0WHFP-TR", "BA2903FVM-DTR", "BA2903FVM-MTR", "BA2903FVM-TR", "BA2904FVM-BZSGTR", "BA2904FVM-GTR",
             "BA2904FVM-MTR", "BA2904FVM-STR", "BA2904FVM-TR", "BA2904HFVM-CTR", "BA2904SFVM-BZGTR", "BA2904SFVM-BZSGTR", "BA2904SFVM-STR", "BA2904SFVM-TR", "BA30BC0FP-BJE2", "BA30BC0FP-BZE2", "BA30BC0FP-E2", "BA30BC0FP-GE2",
             "BA30BC0WFP-E2", "BA30DD0WHFP-BZTR", "BA30DD0WHFP-TR", "BA30E00WHFP-TR", "BA3126N", "BA3126N-BZ", "BA3131FS-BZE2", "BA3131FS-E1", "BA3131FS-E2", "BA3131FS-LE1", "BA3131FS-LE2", "BA3131FS-ME2", "BA3131FS-ZAE2",
             "BA3165FV-E2", "BA3166FV-E2", "BA3169FV-E2", "BA3250FP-E2", "BA3254FP-E2", "BA3257FP-E2", "BA3257HFP-TR", "BA3258FP", "BA3258FP-ME2", "BA3258HFP-FTR", "BA3259HFP-DTR", "BA3259HFP-TR", "BA32903FVM-CTR",
             "BA32904FVM-CTR", "BA3308", "BA3308-KX", "BA333", "BA335", "BA336", "BA337", "BA338", "BA33B00FP-E2", "BA33BC0FP-BJE2", "BA33BC0FP-BZE2", "BA33BC0FP-E2", "BA33BC0FP-ME2", "BA33BC0FP-RE2", "BA33BC0FP-SE2",
             "BA33BC0WFP", "BA33BC0WFP-BJE2", "BA33BC0WFP-BZRE2", "BA33BC0WFP-E2", "BA33BC0WFP-ME2", "BA33BC0WFP-MSE2", "BA33BC0WFP-QE2", "BA33BC0WFP-RE2", "BA33BC0WFP-SE2", "BA33C18FP-E2", "BA33C18HFP-TR", "BA33C25FP-E2",
             "BA33C25HFP-TR", "BA33D15HFP", "BA33D15HFP-E2", "BA33D15HFP-MTR", "BA33D15HFP-TR", "BA33D18HFP-TR", "BA33DD0WHFP-BZTR", "BA33DD0WHFP-RTR", "BA33DD0WHFP-TR", "BA33E00WHFP-TR", "BA3430F-E2", "BA3430FS-E2",
             "BA3472FVM-BZGTR", "BA3472FVM-BZSG", "BA3472FVM-BZSGTR", "BA3472RFVM-BZG", "BA3472RFVM-TR", "BA3527FP-E2", "BA3571F-E2", "BA3574BFS-E2", "BA3682FP-E2", "BA3689FP-E2", "BA3706", "BA3834S", "BA3867AS", "BA3867S",
             "BA3868KV", "BA3868KV-E2", "BA3880AFS-E2", "BA3880AFS-FX", "BA3880AS", "BA3884F-E2", "BA3884F-ZAE2", "BA3946FP-E2", "BA3947FP-E2", "BA3948FP-E2", "BA3965FP-E2", "BA3993F-E2", "BA4424N", "BA4424N-BZ", "BA4558RFVM-TR",
             "BA4560RFVM-TR", "BA4580RFVM-STR", "BA4580RFVM-TR", "BA4910FP-BJE2", "BA4910FP-E2", "BA50BB2RF-E2", "BA50BC0FP-BJE2", "BA50BC0FP-BZSE2", "BA50BC0FP-E2", "BA50BC0FP-ME2", "BA50BC0FP-SE2", "BA50BC0WFP",
             "BA50BC0WFP-ME2", "BA50BC0WFP-SE2", "BA50DD0WHFP-TR", "BA527", "BA527-BZ", "BA546", "BA5925FV-E2", "BA5927FM-E2", "BA5956FM-E2", "BA5961FV-BZE2", "BA5961FV-E2", "BA5962FVM-BZGTR", "BA5962FVM-TR", "BA60BC0WFP-E2",
             "BA60BC0WFP-ME2", "BA60BC0WFP-SE2", "BA6110", "BA6124", "BA6124-BZ", "BA6125-BZ", "BA6138", "BA6144", "BA6208", "BA6208-BZ", "BA6218", "BA6283N", "BA6283N-BZ", "BA6287F-E2", "BA6287F-FE2", "BA6289F", "BA6289F-E2",
             "BA6354BFS-E2", "BA6364FS-E2", "BA6384AFV-E2", "BA6384FV-E2", "BA6417F-E2", "BA6418N", "BA6423AF", "BA6423AF-E2", "BA6423AF-GE2", "BA6425FV-BZE2", "BA6425FV-E2", "BA6427F-E2", "BA6428F-E2", "BA6492BFS-BZE2",
             "BA6492BFS-E2", "BA6525K", "BA6525K-FX", "BA6550AFS-FX", "BA6550FS (A)-BZE2", "BA6550FS-E2", "BA6596F-E2", "BA6680FS-E2", "BA6681FS-E2", "BA6700FV-E2", "BA6772FS-E2", "BA6775FS", "BA6775FS-E2", "BA6813F-E2",
             "BA6814F-E2", "BA6820F", "BA6822F", "BA6822F-E2", "BA6822F-FX", "BA6822S", "BA6840AFS", "BA6840AFS-E2", "BA6840AFS-GE2", "BA6840AFS-LE2", "BA6840AFS-WE2", "BA6840BFS-E2", "BA6840BFS-GE2", "BA6840BFS-LE2",
             "BA6840BFS-ZAE2", "BA6849FS-BZE2", "BA6849FS-E2", "BA6849FS-FZAE2", "BA6849FS-ZAE2", "BA6853FS-E2", "BA6862FS-E2", "BA6868KV-E2", "BA6888N", "BA6902F-E2", "BA6905FV-E2", "BA6905FV-FE2", "BA6906F-FE2", "BA6906F-GE2",
             "BA6907F-E2", "BA6907F-TE2", "BA6908F-E2", "BA6908F-GE2", "BA6956AN", "BA6956AN-BZ", "BA6970FS", "BA6970FS-E2", "BA7021", "BA7071F-E2", "BA70BC0FP-E2", "BA70BC0WFP-E2", "BA7622F-E2", "BA7623AF", "BA7623F", "BA7623F-E2",
             "BA7652AF-E2", "BA7655AF-E2", "BA7657F-KX", "BA7657F-SE2", "BA7725S", "BA7783FS-E2", "BA7785FS-E2", "BA7787FS-E2", "BA7805FP-E2", "BA7805FP-SE2", "BA7806FP-E2", "BA7807FP-E2", "BA7808FP", "BA7808FP-E2", "BA7809FP-E2",
             "BA7809FP-SE2", "BA7810FP-E2", "BA7810HFP-BJTR", "BA7810HFP-MTR", "BA7810HFP-TR", "BA7812FP-BZE2", "BA7812FP-E2", "BA7815FP-BZE2", "BA7818FP-E2", "BA7820FP-E2", "BA78M05FP-BZE2", "BA78M05FP-E2", "BA78M05FP-SE2",
             "BA78M06FP-E2", "BA78M08FP-E2", "BA78M10FP-E2", "BA78M15FP-E2", "BA78M18FP-E2", "BA78M20FP-E2", "BA78M24FP", "BA78M24FP-E2", "BA80BC0FP-E2", "BA80BC0FP-ME2", "BA80BC0WFP-E2", "BA8206F-AE1", "BA8206F-BE2", "BA8206F-E1",
             "BA8206F-E2", "BA82903YFVM-CTR", "BA82904YFVM-CTR", "BA8522RFVM-TR", "BA90BC0FP-BZE2", "BA90BC0FP-E2", "BA90BC0FP-SE2", "BA90BC0WFP-E2", "BA90DD0WHFP", "BA90DD0WHFP-BZTR", "BA9221F", "BA9225FV-E2", "BA9706K",
             "BA9706K-BZ", "BA9706K-BZE2", "BA9706K-E2", "BA9706K-L", "BA9706K-LE2", "BA9706K-ZA", "BA9706K-ZAE2", "BA9708K", "BA9714F-E2", "BA9734AKV", "BA9734AKV-ZA", "BA9734AKV-ZAE2", "BA9736KV", "BA9736KV-E2", "BA9737KV",
             "BA9737KV-E2", "BA9758AFS-E2", "BA9785AFV", "BA9785AFV-E2", "BA9785FS-E2", "BAJ0BC0FP-BZE2", "BAJ0BC0FP-E2", "BAJ0BC0WFP", "BAJ0CC0FP-E2", "BAJ2CC0FP-BZE2", "BAJ2CC0FP-E2", "BAJ2CC0FP-SE2", "BAJ2CC0FP-UBE2",
             "BAJ2CC0WFP-BZE2", "BAJ2CC0WFP-E2", "BAJ2DD0WHFP-BZTR", "BAJ2DD0WHFP-MTR", "BAJ2DD0WHFP-TR", "BAJ5CC0FP-BZE2", "BAJ5CC0FP-E2", "BAJ5CC0FP-FE2", "BAJ5CC0FP-SE2", "BAJ6DD0WHFP-TR", "BAOOHC5FP", "BB9141KV", "BB9151AKV",
             "BB9151KV", "BD00C0AWFP", "BD00C0AWFP-BJ", "BD00C0AWFP-BJE2", "BD00C0AWFP-BZE2", "BD00C0AWFP-E2", "BD00C0AWFP-ME2", "BD00C0AWFP2-CE2", "BD00C0AWFP2-CZ1E2", "BD00C0AWFP2-E2", "BD00C0AWFPS-E2", "BD00C0AWFPS-FX",
             "BD00C0AWFPS-ME2", "BD00C0AWHFP-CTR", "BD00D0AWHFP-BZTR", "BD00D0AWHFP-MTR", "BD00EA5WFP-E2", "BD00EA5WFP2-E2", "BD00EA5WHFP-TR", "BD00FC0WFP-E2", "BD00FD0WFP2-E2", "BD00IA5MHFV-MTR", "BD00IC0DSN-GTR",
             "BD00IC0WHFV-G", "BD00IC0WHFV-GTR", "BD00IC0WHFV-M5G", "BD00IC0WHFV-SGTR", "BD00KA5WF-E2", "BD00KA5WFP", "BD00KA5WFP-BJE2", "BD00KA5WFP-BZE2", "BD00KA5WFP-E2", "BD00KA5WFP-ME2", "BD00KA5WFP-RE2", "BD00KA5WFP-SE2",
             "BD00KA5WFP-TE2", "BD1020HFV-GTR", "BD1020HFV-TR", "BD10IC0WHFV-GTR", "BD10KA5FP-E2", "BD10KA5WF-E2", "BD10KA5WFP-E2", "BD12732FVJ-GE2", "BD12732FVM-GTR", "BD12IC0WHFV-GTR", "BD12KA5FP-BJE2", "BD12KA5FP-E2",
             "BD12KA5FP-ME2", "BD12KA5FP-SE2", "BD12KA5WF-E2", "BD12KA5WFP-BJE2", "BD12KA5WFP-BZE2", "BD12KA5WFP-ME2", "BD12KA5WFP-QE2", "BD12KA5WFP-RE2", "BD12KA5WFP-SE2", "BD15IC0WHFV-GTR", "BD15IC0WHFV-M5G", "BD15IC0WHFV-SGTR",
             "BD15KA5FP-BJE2", "BD15KA5FP-BZE2", "BD15KA5FP-E2", "BD15KA5WF-E2", "BD15KA5WFP-BJE2", "BD15KA5WFP-ME2", "BD15KA5WFP-SE2", "BD16805FV-E2", "BD16805FV-FX", "BD16805FV-ME2", "BD16805PFV-HE2", "BD16806EKV-CGE2", "BD16819FV-FX",
             "BD16819FV-ME2", "BD16820FV-ME2", "BD1689FV-ME2", "BD16910EFV-E2", "BD16910EFV-ME2", "BD16910EFV-MSE2", "BD16910EFV1-FX", "BD16912EFV-CE2", "BD16933EFV-CE2", "BD1754HFN-BZGTR", "BD1754HFN-GTR", "BD17901EKV-ME2",
             "BD1800TL-FX", "BD18345EFV-ME2", "BD18377EFV-E2", "BD18377EFV-ME2", "BD18377TL-FX", "BD18IC0WHFV-G", "BD18IC0WHFV-GTR", "BD18IC0WHFV-M5G", "BD18IC0WHFV-SGTR", "BD18KA5FP-BJE2", "BD18KA5FP-BZE2", "BD18KA5FP-E2",
             "BD18KA5WF-E2", "BD18KA5WFP-BJE2", "BD18KA5WFP-E2", "BD18KA5WFP-ME2", "BD18KA5WFP-SE2", "BD19906EFV-E2", "BD19912EFV-BZE2", "BD19912EFV-E2", "BD19925TST-FX", "BD19928TST-FX", "BD19956HFP-TR", "BD19960FPS",
             "BD19960FPS-BZE2", "BD19960FPS-DE2", "BD19960FPS-E2", "BD19961FPS-E2", "BD19971FPS", "BD19971FPS-E2", "BD19971FPS-G", "BD19971FPS-GE2", "BD19977HFP-TR", "BD19978HFP-TR", "BD1997FPS", "BD1997FPS-E2", "BD1CIC0WHFV-G",
             "BD1CIC0WHFV-GTR", "BD1CIC0WHFV-SGTR", "BD1HA500FVM-CGTR", "BD1HA500FVM-FX", "BD1HB500FVM-AUCGTR", "BD1HB500FVM-CGTR", "BD1HC500HFN-CTR", "BD1HD500FVM-CTR", "BD1HD500HFN-CTR", "BD1L500FVM-CGTR", "BD1LB500FVM-AUCGTR",
             "BD1LB500FVM-AUCSGTR", "BD1LB500FVM-CGTR", "BD1LB500FVM-FX", "BD1LB500FVM-GFX", "BD2270HFV", "BD2270HFV-E2", "BD2270HFV-GTR", "BD2270HFV-LBTR", "BD25IC0WHFV-GTR", "BD25IC0WHFV-SGTR", "BD25IC0WHFV2-GTR", "BD25KA5FP-BZE2",
             "BD25KA5FP-E2", "BD25KA5WF-E2", "BD25KA5WFP-BJE2", "BD25KA5WFP-BZE2", "BD25KA5WFP-E2", "BD26503KS2", "BD26503KS2-E2", "BD26503KS2-FX", "BD26IC0WHFV-GTR", "BD26IC0WHFV-M5G", "BD26IC0WHFV-SGTR", "BD3004HFP-CTR", "BD3004HFP-TR",
             "BD3005HFP-6TR", "BD3005HFP-CTR", "BD3005HFP-HTR", "BD3005HFP-M6TR", "BD3005HFP-MTR", "BD3005HFP-TR", "BD3007HFP-CTR", "BD3020HFP-MTR", "BD3021HFP-HTR", "BD3021HFP-M", "BD3021HFP-MTR", "BD3021HFP-TR", "BD3034FV-E2",
             "BD3034FV-ME2", "BD30DD0WHFP-BZTR", "BD30FC0WFP-E2", "BD30IC0WHFV-G", "BD30IC0WHFV-GTR", "BD30KA5FP-BZE2", "BD30KA5WF-E2", "BD30KA5WFP-BZE2", "BD30KA5WFP-E2", "BD30KA5WFP-ME2", "BD3181FVM-BZGTR", "BD3181FVM-TR", "BD3271FP-E2",
             "BD3272FP-E2", "BD3320ATL", "BD3320KV", "BD3320KV-M", "BD3360KV-HE2", "BD3360KV-M", "BD3360KV-ME2", "BD3361TL-FX", "BD3377EKV-CE2", "BD3381EKV-C", "BD3381EKV-CE2", "BD33C0AFP-BZCE2", "BD33C0AFP-CE2", "BD33C0AFP2-CE2",
             "BD33C0AFP2-CZ1E2", "BD33C0AHFP-CTR", "BD33C0AWFP", "BD33C0AWFP-CE2", "BD33C0AWFP-E2", "BD33C0AWFP2-CZ1E2", "BD33C0AWHFP-CTR", "BD33FC0FP-E2", "BD33FC0WFP-E2", "BD33FD0EHFP-MTR", "BD33IC0WHFV-GTR", "BD33IC0WHFV-M5G",
             "BD33IC0WHFV-SGTR", "BD33KA5FP-BZE2", "BD33KA5FP-E2", "BD33KA5FP-ME2", "BD33KA5FP-SE2", "BD33KA5WF-E2", "BD33KA5WF-GE2", "BD33KA5WFP-BJE2", "BD33KA5WFP-BZE2", "BD33KA5WFP-E2", "BD33KA5WFP-ME2", "BD33KA5WFP-SE2", "BD3403FV-E2",
             "BD3419FS", "BD3440FS", "BD3440FS-E2", "BD3442FS", "BD3442FS-BZE2", "BD3442FS-E2", "BD3443FS-BZE2", "BD3443FS-E2", "BD3443FS-ME2", "BD3444FS", "BD3444FS-E2", "BD3445FS-BZE2", "BD3445FS-E2", "BD3446FS", "BD3446FS-BZE2", "BD3446FS-E2",
             "BD3446FS-ME2", "BD3447AFV", "BD3447AFV-E2", "BD3447FV", "BD3447FV-E2", "BD3448FS", "BD3448FS-BZE2", "BD3448FS-E2", "BD3449FS", "BD3449FS-E2", "BD3449FS-ME2", "BD3449FS-ZAE2", "BD34601FS-ME2", "BD34602FS", "BD34602FS-E2",
             "BD34602FS-ME2", "BD3460FS", "BD3460FS-BJE2", "BD3460FS-BJZAE2", "BD3460FS-BZBJE2", "BD3460FS-E2", "BD3461FS", "BD3461FS-BJE2", "BD3461FS-BJZAE2", "BD3461FS-BZE2", "BD3461FS-E2", "BD3461FS-ME2", "BD3461FS-ZAE2", "BD3467FV-E2",
             "BD3468FV-E2", "BD34700FV", "BD34700FV-E2", "BD34701KS2", "BD34701KS2-E2", "BD34701KS2-Z", "BD34701KS2-ZE2", "BD34701NP2-E2", "BD3472FVM", "BD3472FVM-BZGTR", "BD3472FVM-TR", "BD3482FS", "BD3482FS-E2", "BD3484FS-E2",
             "BD3485FS", "BD3485FS-E2", "BD3486FS", "BD3486FS-E2", "BD3488FS", "BD3488FS-E2", "BD3490FV", "BD3490FV-BZE2", "BD3490FV-E2", "BD3491FS-BZE2", "BD3491FS-BZS", "BD3491FS-BZSE2", "BD3491FS-E2", "BD3491FS-SE2", "BD3497FS-E2", "BD3499FV-BZE2",
             "BD3499FV-E2", "BD3500FVM-TR", "BD3501FVM-TR", "BD3502FVM-TR", "BD3504FVM-FTR", "BD3504FVM-TR", "BD3506EFV-E2", "BD3506F-E2", "BD3507HFV-TR", "BD3520FVM-TR", "BD3521FVM-TR", "BD35221EFV-E2", "BD35222EFV-E2", "BD3522EFV-BZE2",
             "BD3522EFV-E2", "BD3522EFV-SE2", "BD35230HFN", "BD35230HFN-TR", "BD3523HFN-TR", "BD35250EFV-BZE2", "BD35250EFV-E2", "BD3525EFV-E2", "BD3525EFV-SE2", "BD35269HFN", "BD35269HFN-FX", "BD35269HFN-TR", "BD35270EFV-E2", "BD35270EFV-TR",
             "BD35274EFV-E2", "BD3527EFV-BZE2", "BD3527EFV-E2", "BD3527EFV-FX", "BD35280HFN-TR", "BD35281HFN-TR", "BD35282HFN-TR", "BD35287HFN-BZGTR", "BD35287HFN-CTR", "BD35287HFN-GTR", "BD35287HFN-TR", "BD35287TG1-FX", "BD35287TG1-TR", "BD35287TG2-TR",
             "BD3528HFN-G", "BD3528HFN-GTR", "BD35290HFN-TR", "BD3530F-F", "BD3531F-FE2", "BD3532EFV-E2", "BD3533FVM-RTR", "BD3533FVM-TR", "BD3533HFN-BZGTR", "BD3533HFN-TR", "BD3534FVM-TR", "BD3536F-E2", "BD3537F-E2", "BD3538FVM-TR",
             "BD3538HFN-TR", "BD3539FVM", "BD3539FVM-BZGTR", "BD3539FVM-BZHVGTR", "BD3539FVM-HVTR", "BD3539FVM-RTR", "BD3539FVM-TR", "BD3550HFN-GTR", "BD3550HFN-MTR", "BD3550HFN-TR", "BD3551HFN-BZG", "BD3551HFN-G", "BD3551HFN-SGTR",
             "BD3551HFN-TR", "BD3552HFN-GTR", "BD3552HFN-SG", "BD3552HFN-SGTR", "BD3552HFN-TR", "BD35605HFN", "BD35605HFN-BZGTR", "BD35605HFN-STR", "BD35605HFN-TR", "BD35605TG1", "BD35605TG1-TR", "BD35605TG2", "BD35605TG2-TR",
             "BD3560TG1", "BD35618HFV-STR", "BD35618HFV-TR", "BD3561AFP-CE2", "BD3561AFP-CTE2", "BD3561BFP-CE2", "BD3561BFP-E2", "BD3562FP-CE2", "BD35630HFV-BZ", "BD35630HFV-STR", "BD35630HFV-TR", "BD3565HFP", "BD3565HFP-MTR", "BD3565HFP-TR",
             "BD3566FP-E2", "BD3566FP-ME2", "BD3570F-E2", "BD3570FP-E2", "BD3570FP-ME2", "BD3570HFP-MTR", "BD3570HFP-TR", "BD3570YFP-ME2", "BD3570YHFP-MTR", "BD3571AHFP-TR", "BD3571FP-BZE2", "BD3571FP-CE2", "BD3571FP-E2", "BD3571FP-HE2",
             "BD3571FP-M6E2", "BD3571FP-ME2", "BD3571FP-YME2", "BD3571HFP-BZMTR", "BD3571HFP-MTR", "BD3571YFP-BZME2", "BD3571YHFP-M6TR", "BD3571YHFP-MTR", "BD3572FP-E2", "BD3572FP-ME2", "BD3572HFP-TR", "BD3572YFP-ME2",
             "BD3572YHFP-MTR", "BD3573FP-E2", "BD3573HFP-BZTR", "BD3573HFP-MTR", "BD3573HFP-TR", "BD3573YFP-ME2", "BD3573YHFP-MTR", "BD3574FP-BZE2", "BD3574FP-E2", "BD3574FP-M2E2", "BD3574FP-ME2", "BD3574HFP-BZTR", "BD3574HFP-MTR",
             "BD3574HFP-TR", "BD3574YFP-ME2", "BD3574YHFP-MTR", "BD3575FP-E2", "BD3575FP-ME2", "BD3575HFP-MTR", "BD3575HFP-TR", "BD3575YFP-ME2", "BD3575YHFP-MTR", "BD35905HFV-TR", "BD3650FP-BZME2", "BD3650FP-E2", "BD3650FP-HE2", "BD3650FP-ME2",
             "BD3681FP-E2", "BD3681HFP-TR", "BD3700FV", "BD3700FV-E2", "BD3701FV-A", "BD3701FV-A-FX", "BD3701FV - AE2", "BD3702FV", "BD3702FV- BZ", "BD3702FV- BZE2", "BD3702FV- E2", "BD3702FV- SE2", "BD37031FV- E2", "BD37031FV- FX", "BD37032FV- FX",
             "BD37033FV-E2", "BD37034FV-E2", "BD37034FV-ME2", "BD3704FV-E2", "BD3705FV-E2", "BD37067FV-ME2", "BD37068FV-ME2", "BD37069FV-ME2", "BD3711FS-BJE2", "BD3711FS-BJZAE2", "BD3711FS-E2", "BD3711FS-ZAE2",
             "BD37201NUX-TR", "BD3721FV", "BD3721FV-E2", "BD3731AFV-BJE2", "BD3731AFV-E2", "BD3731FV", "BD3731FV-E2", "BD3750FV-CE2", "BD3750FV-CFX", "BD3750FV-CZAE2", "BD3750FV-E2", "BD3750FV-FX", "BD37511FS-E2",
             "BD37512FS-E2", "BD37513FS-E2", "BD37513FS-FX", "BD37513FS-ME2", "BD37513FS-MZAE2", "BD37513FS-ZAE2", "BD37514FS", "BD37514FS-E2", "BD37515FS-E2", "BD37521FS-E2", "BD37521FS-FX", "BD37521FS-ZAE2",
             "BD37522FS-E2", "BD37523FS", "BD37523FS-E2", "BD37524FS-BZE2", "BD37524FS-E2", "BD37531FV", "BD37531FV-E2", "BD37532FV-E2", "BD37533FV-E2", "BD37534FV", "BD37534FV-BZE2", "BD37534FV-E2", "BD37541FS-E2",
             "BD37542FS-E2", "BD37543FS-E2", "BD37544FS-E2", "BD37544FS-ME2", "BD37545FS-E2", "BD3771FVM-TR", "BD37802TG-FX", "BD3780TGA-FX", "BD3794FVM-TR", "BD3795FVM-TR", "BD37A19FVM-TR", "BD37A41FVM-MLLTR",
             "BD37A41FVM-MTR", "BD37A41FVM-STR", "BD37A41FVM-TR", "BD3801FS-BZE2", "BD3801FS-E2", "BD3801FS-FE2", "BD3803AF-FE2", "BD3803F-E2", "BD3805F-E2", "BD3806FS-E2", "BD3808AFS-E2", "BD3808FS-E2",
             "BD3809FS-E2", "BD3814FV-BZE2", "BD3814FV-FE2", "BD3818KS", "BD3824FS-E2", "BD3826FS-E2", "BD3830FS-E2", "BD3834FS-E2", "BD3834FS-ME2", "BD3841FS-BZE2", "BD3841FS-E2", "BD3842FS-BZE2", "BD3842FS-E2",
             "BD3842FS-FE2", "BD3842FS-ZAE2", "BD3843FS-BZE2", "BD3843FS-E2", "BD3843FS-ZAE2", "BD3859AFV-E2", "BD3861FS", "BD3861FS-BZE2", "BD3861FS-E2", "BD3867AFV-E2", "BD3870FS-E2", "BD3870FS-FZAE2", "BD3870FS-ZAE2",
             "BD3871FS", "BD3871FS-BZE2", "BD3871FS-E2", "BD3871FS-ZAE2", "BD3872FS", "BD3872FS-BZE2", "BD3872FS-E2", "BD3873FS-E2", "BD3881FV-BZE2", "BD3881FV-E2", "BD3882FV-BZE2", "BD3882FV-E2", "BD3883FS-BZE2",
             "BD3883FS-E2", "BD3884FS-E2", "BD3886FS-E2", "BD3888FS-BZE2", "BD3888FS-E2", "BD3898HFN-BZGTR", "BD3898HFN-E2", "BD3898HFN-G", "BD3898HFN-GTR", "BD3910F-E2", "BD3916FVM-TR", "BD3917HFN-TR", "BD3925FP",
             "BD3925FP-6E2", "BD3925FP-C", "BD3925FP-C6", "BD3925FP-C6E2", "BD3925FP-CE2", "BD3925FP-E2", "BD3925HFP", "BD3925HFP-C", "BD3925HFP-CTR", "BD3925HFP-TR", "BD3930FP-BJE2", "BD3930FP-ME2", "BD3931FP-BJE2",
             "BD3931FP-E2", "BD3931FP-FE2", "BD3931FP-FME2", "BD3931FP-ME2", "BD3931HFP-TR", "BD3932FP-ME2", "BD3940FP-E2", "BD3940FP-ME1", "BD3940FP-ME2", "BD3941FP-E2", "BD3941FP-ME2", "BD3941HFP-TR", "BD3949FP-ME2",
             "BD3949HFP-BZMTR", "BD3949HFP-MTR", "BD3949HFP-TR", "BD3950F-E2", "BD3951F-E2", "BD3958FM-BZME2", "BD3958FM-E2", "BD3958FM-FX", "BD3958FM-ME2", "BD3959FV-BZCE2", "BD3959FV-CE2", "BD3959FV-HE2", "BD3961AFM-ME2",
             "BD3961AFM-MFX", "BD3961FM-BZME2", "BD3961FM-E2", "BD3961FM-ME2", "BD3965EKV-FX", "BD3965EKV-ME2", "BD3966EKV-CGE2", "BD3968FM-FX", "BD3968FM-ME2", "BD3968TL-FX", "BD3969FM-BZME2", "BD3969FM-E2", "BD3969FM-ME2",
             "BD39915HFN-BJTR", "BD39915HFN-TR", "BD3997EFV", "BD3997EFV-E2", "BD3997EFV-ME2", "BD3997EFV-SE2", "BD3999FVM-BZTR", "BD3999FVM-TR", "BD41005FV-CE2", "BD41030HFN-CGTR", "BD41030HFN-GTR", "BD4140HFV-GTR",
             "BD4140HFV-TR", "BD4141HFV-SGTR", "BD4141HFV-STR", "BD4141HFV-TR", "BD4142HFV-TR", "BD4153FV-E2", "BD4153FV-ZAE2", "BD4188FVM-TR", "BD4223FUJ-E2", "BD4223FUJ-TR", "BD4223FVM-BZE2", "BD4223FVM-BZTR",
             "BD4223FVM-FX", "BD4223FVM-TR", "BD4231TL-FX", "BD4250DSN-FX", "BD4250FS-BZE2", "BD4250FS-E2", "BD42530FP2-CE2", "BD42530FPJ-CE2", "BD4271FP2-CE2", "BD4271HFP-CTR", "BD4271HFP-FX", "BD4271HFP-H", "BD4271PHFP-HTR",
             "BD42754FP2-CE2", "BD42754FP2-HE2", "BD42754FPJ-CE2", "BD4275FP2-C6E2", "BD4275FP2-CE1", "BD4275FP2-CE2", "BD4275FP2-SCE2", "BD4275FPJ-C6E1", "BD4275FPJ-C6E2", "BD4275FPJ-CE1", "BD4275FPJ-CE2", "BD4275FPJ-CS6E2",
             "BD4275FPJ-CSE2", "BD4288FVM-TR", "BD4289FVM-TR", "BD433M2FP3-C6E2", "BD433M2FP3-CE2", "BD433M2FP3-CZ1E2", "BD433M2WFP3-CE2", "BD433M2WFP3-CZ1E2", "BD433M5FP-CE2", "BD433M5FP-CZE2", "BD433M5FP2-CE2",
             "BD433M5FP2-CZ1E2", "BD433M5FP2-CZE2", "BD433M5WFP-CE2", "BD433M5WFP-CZE2", "BD433M5WFP2-CZ1E2", "BD433M5WFPJ-CZ1E2", "BD433M5WFPJ-CZE2", "BD450M2FP3-CE2", "BD450M2FP3-CSE2", "BD450M2FP3-CZ1E2", "BD450M2FP3-NC6E2",
             "BD450M2FP3-NCE2", "BD450M2WFP3-C6", "BD450M2WFP3-C6E2", "BD450M2WFP3-NCE2", "BD450M5FP-CSE2", "BD450M5FP-CE2", "BD450M5FP2-C6Z1E2", "BD450M5FP2-CZ1E2", "BD450M5FP2-CZE2", "BD450M5FP2-CZRE2", "BD450M5WFP2-CSE2",
             "BD450M5WFP2-CZ1E2", "BD450M5WFP2-CZE2", "BD450M5WFP2-SCZE2", "BD450M5WFPJ-CZ1", "BD450M5WFPJ-CZ1E2", "BD450M5WFPJ-CZE2", "BD4565WHFP-CTR", "BD4823FVE-STR", "BD4823FVE-TR", "BD4824FVE-TR", "BD4825FVE",
             "BD4825FVE-E2", "BD4825FVE-STR", "BD4825FVE-TR", "BD4826FVE-STR", "BD4826FVE-TR", "BD4827FVE-TR", "BD4828FVE-TR", "BD4829FVE-TR", "BD4830FVE-TR", "BD4831FVE-TR", "BD4832FVE-TR", "BD4833FVE-TR", "BD4834FVE-TR",
             "BD4835FVE-TR", "BD4836FVE-TR", "BD4837FVE-TR", "BD4839FVE-TR", "BD4840FVE-TR", "BD4842FVE-TR", "BD4843FVE-TR", "BD4844FVE-TR", "BD4845FVE-RTR", "BD4845FVE-TR", "BD4846FVE-STR", "BD4846FVE-TR", "BD4847FVE-TR",
             "BD4848FVE-TR", "BD4850FVE-TR", "BD4851FVE-TR", "BD4852FVE-TR", "BD4853FVE-TR", "BD4854FVE-STR", "BD4854FVE-TR", "BD4855FVE-TR", "BD4856FVE-TR", "BD4857FVE-TR", "BD4858FVE-TR", "BD4859FVE-TR", "BD4860FVE-TR",
             "BD4900FM-E2", "BD4900FM-LE2", "BD4901FM-E2", "BD4901FM-LE2", "BD4902FM", "BD4902FM-E2", "BD4902FM-LE2", "BD4903FM-E2", "BD4903FM-LE2", "BD4904FM", "BD4904FM-BZE2", "BD4904FM-E2", "BD4904FM-LE2", "BD4905FM-BZE2",
             "BD4905FM-E2", "BD4906FM", "BD4908FM-E2", "BD4908FM-ME2", "BD49091FM-E2", "BD4909FM-AE2", "BD4909FM-E2", "BD4909FM-ME2", "BD49100DSN-FX", "BD49100RFS-E2", "BD49100RFS-FX", "BD49101AEFS-M", "BD49101AEFS-ME2",
             "BD49101ARFS-ME2", "BD49101EFS-E2", "BD49101EFS-ME2", "BD49105RFS-E2", "BD49105RFS-ME2", "BD49191FM", "BD49191FM-E2", "BD4923FVE-RTR", "BD4923FVE-TR", "BD4924FVE-TR", "BD4925FVE-TR", "BD4926FVE-TR", "BD4927FVE-TR", "BD4928FVE-TR",
             "BD4929FVE-TR", "BD4930FVE-TR", "BD4931FVE-STR", "BD4931FVE-TR", "BD4932FVE-STR", "BD4932FVE-TR", "BD4933FVE-STR", "BD4933FVE-TR", "BD4934FVE-TR", "BD4935FVE-TR", "BD4936FVE-TR", "BD4937FVE-TR", "BD4938FVE-TR",
             "BD4939FVE-TR", "BD4940FVE-TR", "BD4941FVE-TR", "BD4942FVE-TR", "BD4943FVE-TR", "BD4944FVE-TR", "BD4946FVE-TR", "BD4947FVE-TR", "BD4948FVE-TR", "BD4949FVE-TR", "BD4950FVE-TR", "BD4951FVE-TR", "BD4952FVE-TR",
             "BD4953FVE-TR", "BD4954FVE-TR", "BD4956FVE-TR", "BD4957FVE-TR", "BD4958FVE-TR", "BD4959FVE-TR", "BD4960FVE-TR", "BD50C0AFP-CE2", "BD50C0AFP-CTR", "BD50C0AFP2-CE2", "BD50C0AFP2-CZ1E2", "BD50C0AHFP-CTR",
             "BD50C0AWFP-BZ", "BD50C0AWFP-CE2", "BD50C0AWFP2-CZ1E2", "BD50FC0FP-E2", "BD50FD0WFP2-E2", "BD50FD0WHFP-TR", "BD5100FVM-FTR", "BD5180G", "BD5180G-TR", "BD5223FVE-TR", "BD5224FVE-TR", "BD5225FVE-TR",
             "BD5226FVE-TR", "BD5227FVE-TR", "BD5228FVE-STR", "BD5228FVE-TR", "BD5229FVE-GTR", "BD5229FVE-TR", "BD5229NVX-2CTL", "BD5230FVE-TR", "BD5232FVE-TR", "BD5233FVE-GTR", "BD5233FVE-TR", "BD5234FVE-TR",
             "BD5235FVE-TR", "BD5236FVE-TR", "BD5237FVE-TR", "BD5238FVE-TR", "BD5239FVE-TR", "BD5240FVE-TR", "BD5241FVE-TR", "BD5242FVE-TR", "BD5243FVE-TR", "BD5244FVE-TR", "BD5245FVE-TR", "BD5246FVE-TR", "BD5247FVE-TR",
             "BD5248FVE-TR", "BD5249FVE-TR", "BD5250FVE-TR", "BD5251FVE-TR", "BD5252FVE-TR", "BD5253FVE-TR", "BD5254FVE-TR", "BD5255FVE-STR", "BD5255FVE-TR", "BD5256FVE-TR", "BD5257FVE-TR", "BD5258FVE-TR", "BD5259FVE-TR",
             "BD5260FVE-TR", "BD5291FVE-GTR", "BD5323FVE-TR", "BD5324FVE-TR", "BD5325FVE-TR", "BD5326FVE-TR", "BD5327FVE-TR", "BD5328FVE-TR", "BD5329FVE-TR", "BD5330FVE-STR", "BD5330FVE-TR", "BD5331FVE-TR", "BD5332FVE-TR", "BD5333FVE-TR", "BD5334FVE-TR",
             "BD5335FVE- TR","BD5336FVE- TR","BD5337FVE- TR","BD5338FVE- TR","BD5339FVE- TR","BD5340FVE- TR","BD5341FVE- TR","BD5342FVE- TR","BD5343FVE- STR","BD5343FVE- TR","BD5344FVE- TR","BD5345FVE- TR","BD5346FVE- TR",
             "BD5347FVE-TR", "BD5348FVE-TR", "BD5349FVE-TR", "BD5350FVE-TR", "BD5351FVE-TR", "BD5352FVE-TR", "BD5353FVE-TR", "BD5354FVE-TR", "BD5355FVE-TR", "BD5356FVE-TR", "BD5357FVE-TR", "BD5358FVE-TR", "BD5359FVE-TR",
             "BD5360FVE-TR", "BD5421EFS-E2", "BD5422EFS-E2", "BD5423AEFS", "BD5423AEFS-BZE2", "BD5423AEFS-E2", "BD5423EFS-BZE2", "BD5423EFS-BZRE2", "BD5423EFS-E2", "BD5423EFS-ME2", "BD5423EFS-RE2", "BD5424EFS", "BD5424EFS-E2",
             "BD5426EFS", "BD5426EFS-BZE2", "BD5426EFS-BZSE2", "BD5426EFS-E2", "BD5426EFS-S", "BD5426EFS-SE2", "BD5427EFS", "BD5427EFS-E2", "BD5431EFS", "BD5431EFS-E2", "BD5446EFV-BZE2", "BD5446EFV-E2", "BD5446EFV-RE2",
             "BD5650AFVM-BZGTR", "BD5650AFVM-BZTR", "BD5650AFVM-GTR", "BD5650AFVM-TR", "BD5650FVM-TR", "BD5980EFS-BZE2", "BD5980EFS-E2", "BD60025TST-FX", "BD60026TST-FX", "BD6036EFS-E2", "BD6063HFN-TR", "BD6071HFN-TR",
             "BD6072HFN-BZGTR", "BD6072HFN-RTR", "BD6072HFN-TR", "BD60FC0WFP-E2", "BD6112FVM-BZGTR", "BD6112FVM-TR", "BD6155FVM-TR", "BD6171KV-E2", "BD6171KV-M", "BD6171KV-ME2", "BD62011AFS-E2", "BD62011FS-BZE2", "BD62011FS-E2",
             "BD62012AFS-E2", "BD62012FS-E2", "BD62012FS-SE2", "BD62013AFS-E2", "BD62013FS-E2", "BD62014AFS-E2", "BD62014FS-BZE2", "BD62014FS-E2", "BD62015AFS-E2", "BD62015AFVM-TR", "BD62015FS-E2", "BD62016FS-E2", "BD62017AFS-E2",
             "BD62017FS-E2", "BD62018AFS-E2", "BD62018FS-E2", "BD6201FS-E2", "BD6202FS-E2", "BD6203FS-BZE2", "BD6203FS-E2", "BD62049TGA-FX", "BD62049TGB-FX", "BD6204FS", "BD6204FS-BZE2", "BD6204FS-E2", "BD6204FS-ZAE2", "BD6205FS",
             "BD6205FS-E2", "BD6206FS", "BD6206FS-BZE2", "BD6206FS-E2", "BD6206FS-ZAE2", "BD6207FS-E2", "BD6208AFS-E2", "BD6208AFS-ZAE2", "BD6208FS-E2", "BD6208FS-ZAE2", "BD6209AFS", "BD6209AFS-BZE2", "BD6209AFS-E2",
             "BD6209FS", "BD6209FS-BZE2", "BD6209FS-E2", "BD62105AFVM-TR", "BD62105FVM-GTR", "BD6210F", "BD6210F-E2", "BD6210HFP-TR", "BD6211F-E2", "BD6211HFP-TR", "BD6212HFP-BZTR", "BD6212HFP-TR", "BD6220F",
             "BD6220F-E2", "BD6221F-E2", "BD6221HFP-BJTR", "BD6221HFP-TR", "BD62222HFP-BZTR", "BD62222HFP-E2", "BD6222HFP-BZTR", "BD6222HFP-TR", "BD6230F", "BD6230F-E2", "BD6230HFP-TR", "BD6231F",
             "BD6231F-E2", "BD6231HFP-BZTR", "BD6231HFP-MTR", "BD6231HFP-TR", "BD62321HFP", "BD62321HFP-BZTR", "BD62321HFP-E2", "BD62321HFP-TR", "BD6232HFP-BZTR", "BD6232HFP-MTR", "BD6232HFP-TR",
             "BD6262FVM-BZGTR", "BD6262FVM-TR", "BD6291AFV-CE2", "BD6291FV-CE2", "BD6298FS-E2", "BD6298FS-FX", "BD6300KU", "BD6300KU-E2", "BD63015EFV-E2", "BD63030EKV-CE2", "BD63035EFV", "BD63035EFV-E2",
             "BD63035EFV-ME2", "BD63065TL-FX", "BD6308KV", "BD63101TL-FX", "BD63130AFM-E2", "BD63150AFM-E2", "BD63150FM-E2", "BD63160EFV-BZE2", "BD63160EFV-E2", "BD63281AEFV-E2", "BD63281EFV-E2",
             "BD63282EFV-E2", "BD6333FV-FX", "BD63401EFV-E2", "BD63430EFV-E2", "BD63450EFV", "BD63450EFV-E2", "BD63565EFV-E2", "BD63565EFV-SE2", "BD63610AEFV-E2", "BD63610EFV-E2", "BD63672DSN-FX",
             "BD63672FUT-FX", "BD63674FUT-E2", "BD63674FUT-FX", "BD63730EFV", "BD63730EFV-E2", "BD63740FM-E2", "BD63830EFV-E2", "BD6383EFV-E2", "BD6384EFV-BZ", "BD6384EFV-BZE2", "BD6384EFV-E2",
             "BD6385EFV-BZE2", "BD6385EFV-E2", "BD6387EFV-E2", "BD6389FM-BZE2", "BD6389FM-E2", "BD64101EFV-E2", "BD64532EKV", "BD64532EKV-BZG", "BD64532EKV-BZGE2", "BD64532EKV-E2", "BD64550EFV",
             "BD64550EFV-BZE2", "BD64550EFV-E2", "BD6455EFV", "BD6455EFV-E2", "BD64560EUV", "BD64560EUV-BZE2", "BD64560EUV-E2", "BD6456EUV", "BD6456EUV-E2", "BD6510F-E2", "BD6512F-E2", "BD6513F-E2",
             "BD6516F-E2", "BD6516F-SE2", "BD6517F-E2", "BD6524HFV-BZ", "BD6524HFV-BZTR", "BD6524HFV-TR", "BD6528HFV-TR", "BD6573KV", "BD6573KV-E2", "BD6631KV", "BD6634AKV", "BD6636KV", "BD6637KV",
             "BD6645AKV", "BD6645AKV-E2", "BD6653FV-BZE2", "BD6653FV-E2", "BD6660FV-E2", "BD6661FV-E2", "BD6669FV-BZE2", "BD6669FV-E2", "BD6683FV-E2", "BD6701F-E2", "BD6701F-FE2", "BD6701F-TE2",
             "BD67051EFV", "BD67051EFV-E2", "BD67052EFV-BZE2", "BD67052EFV-E2", "BD67053EFV-BZE2", "BD67053EFV-E2", "BD67054EFV-BZE2", "BD67054EFV-E2", "BD67055EFV-BZE2", "BD67055EFV-E2", "BD67056EFV",
             "BD67056EFV-BZE2", "BD67056EFV-E2", "BD6713EFV-BZE2", "BD6713EFV-E2", "BD6713EFV-GE2", "BD6713EFV-ZAE2", "BD6718FS-E2", "BD6718FS-ZAE2", "BD6719AFV-E2", "BD6719AFV-GE2", "BD6719AFV-GZAE2",
             "BD6719FV", "BD6719FV-E2", "BD6719FV-GE2", "BD6750FS-BZE2", "BD6750FS-E2", "BD6752AKV", "BD6752AKV-E2", "BD6752KV", "BD6752KV-E2", "BD6753KV", "BD67611FS-BZE2", "BD67611FS-E2", "BD6761FS",
             "BD6761FS-E2", "BD6762FV-BZE2", "BD6762FV-E2", "BD6769EFV", "BD6769EFV-E2", "BD6794EFV-E2", "BD6795EFV-E2", "BD6796EFV-E2", "BD68609EFV-E2", "BD68610EFV-E2", "BD6861FS-DE2", "BD6861FS-E2",
             "BD68960EKV-CE2", "BD6902FS-E2", "BD6903EFV-BZE2", "BD6903EFV-E2", "BD6903EFV-ZAE2", "BD6909AEFV-BZ", "BD6909AEFV-BZE2", "BD6909AEFV-E2", "BD6909EFV-E2", "BD6921FV-E2", "BD6921FV-ZAE2",
             "BD6922FV", "BD6922FV-E2", "BD6922FV-ZAE2", "BD6923FV-E2", "BD6926FV-E2", "BD6926FV-ZAE2", "BD6941FM", "BD6941FM-E2", "BD6941FM-ME2", "BD6961F-E2", "BD6961F-G", "BD6961F-GE2", "BD6962FVM-BZGGTR",
             "BD6962FVM-BZGTR", "BD6962FVM-GTR", "BD6962FVM-TR", "BD6963AFUJ-BZE2", "BD6963AFUJ-E2", "BD6963AFUJ-SE2", "BD6963FUJ-E2", "BD6964F", "BD6964F-E2", "BD6964FVM-GTR", "BD6964FVM-TR", "BD6966FVM",
             "BD6967FVM-BZTR", "BD6967FVM-E2", "BD6967FVM-FX", "BD6967FVM-MTR", "BD6967FVM-STR", "BD6967FVM-TR", "BD6968FVM-FX", "BD6968FVM-TR", "BD6969FVM", "BD6969FVM-BZGGTR", "BD6969FVM-GFX",
             "BD6969FVM-GTR", "BD6969FVM-SGTR", "BD6981FVM-GFX", "BD6981FVM-GTR", "BD6982FVM-GTRBD6985FVM-MTR", "BD6988FVM-GTR", "BD6988FVM-TR", "BD6989FVM-GDTTR", "BD6989FVM-GTR", "BD6989FVM-TR",
             "BD7052EFV-BZ", "BD7052EFV - BZE2","BD7052EFV- E2","BD7071F- E2","BD70FC0WFP- E2","BD7160HFN- GTR","BD7161FUJ- E2","BD7161FUJ- SE2","BD7162FVM- GTR","BD7175FS- BZE2","BD7175FS- E2","BD7175FS- FX",
             "BD7175FS-ZAE2", "BD71L3SHFV-TR", "BD7274FUJ-BZHVGE2", "BD7274FUJ-E2", "BD7274FUJ-HVGE2", "BD733L2FP-CE2", "BD733L2FP2-CE2", "BD733L2FP3-CE2", "BD733L2FP3-CZ1E2", "BD733L5FP-CE2", "BD733L5FP2-CE2",
             "BD7351FUT-DGE2", "BD7351FUT-FX", "BD7358FUT-E2", "BD7358FUT1-FX", "BD7358FUT2-FX", "BD7358TL-FX", "BD7486FVM-TR", "BD750L2FP-BZCE2", "BD750L2FP-CE2", "BD750L2FP-NCE2", "BD750L2FP2-CE2", "BD750L2FP3-CE2",
             "BD750L2FP3-CZ1E2", "BD750L5AFP2-CE2", "BD750L5FP-BZCE2", "BD750L5FP-BZCTR", "BD750L5FP-BZTR", "BD750L5FP-CE2", "BD750L5FP2-CE2", "BD750L5FP2-CZ1E2", "BD7542FVM-BZGGTR", "BD7542FVM-BZGTR",
             "BD7542FVM-BZSGTR", "BD7542FVM-GTR", "BD7542FVM-STR", "BD7542FVM-TR", "BD7542SFVM-STR", "BD7562FVM-TR", "BD7562SFVM-TR", "BD7628FVM", "BD7671FVM-BZGGTR", "BD7671FVM-GTR", "BD7753RFV",
             "BD7753RFV-E2", "BD7755RFV-BZE2", "BD7755RFV-E2", "BD7756RFV-FX", "BD7756RFV1-FX", "BD7757MWX-E2", "BD77581DSN-FX", "BD77581EFV-E2", "BD77581EFV-FX", "BD7761DSN-FX", "BD7761EFV-E2",
             "BD7761EFV-FX", "BD7763DSN-FX", "BD7763EFV-E2", "BD7763EFV-FX", "BD7770MWX-E2", "BD7776ARFS-BZE2", "BD7776ARFS-E2", "BD7776RFS-E2", "BD77801DSN-FX", "BD77801DSN1-FX", "BD7780ARFS-E2",
             "BD7780RFS-E2", "BD7781EFS-E2", "BD77832EUV-E2", "BD77833EUV", "BD77833EUV-E2", "BD7785RFS-BZE2", "BD7785RFS-E2", "BD7787EFS-BZE2", "BD7787EFS-E2", "BD77891RFS-E2", "BD77891RFS-FX",
             "BD77891RFS1-FX", "BD77892DSN-FX", "BD77892RFS-E2", "BD77892RFS-FX", "BD77894RFS-E2", "BD77894RUV-E2", "BD77894RUV-NE2", "BD77895ARUV-E2", "BD77895RFS-E2", "BD77896RUV-E2", "BD77897RUV-E2",
             "BD7789DSN-FX", "BD7789RFS-BZE2", "BD7789RFS-E2", "BD7789RFS1-E2", "BD7789RFS3-E2", "BD7789RFS3-FX", "BD7791FUV-E2", "BD7791FUV-ZAE2", "BD7792FUV-E2", "BD7792FUV-SE2", "BD7792FUV-SZAE2",
             "BD7792FUV-ZAE2", "BD7800FP", "BD7800FP-BJE2", "BD7800FP-BZE2", "BD7800FP-E2", "BD7800FP-ME2", "BD7802FP-E2", "BD7802FP-ME2", "BD7820FP", "BD7820FP-BJE2", "BD7820FP-E2", "BD7820FP-ME2",
             "BD7836EFV-BZE2", "BD7836EFV-E2", "BD7836EFV-FX", "BD7841EFV-E2", "BD7843EFV-R", "BD7843EFV-RE2", "BD7909FS-E2", "BD7910FV-E2", "BD7911FV-E2", "BD7959EFV", "BD7959EFV-BZ", "BD7959EFV-BZE2",
             "BD7959EFV-E2", "BD7960FM-BZME2", "BD7960FM-E2", "BD7960FM-LE2", "BD7960FM-ME2", "BD7961FM", "BD7961FM-BZE2", "BD7961FM-E2", "BD7962FM", "BD7962FM-BJE2", "BD7962FM-BZBJE2", "BD7962FM-BZE2",
             "BD7962FM-E2", "BD7962FM-LE2", "BD7965FM-BZE2", "BD7965FM-E2", "BD7966EKV", "BD7966EKV-BZGE2", "BD7966EKV-C", "BD7966EKV-CE2", "BD7967EFS-E2", "BD7969EFV", "BD7969EFV-E2", "BD7971FM-E2",
             "BD7979EFV-E2", "BD7979EFV-FX", "BD7979EFV-SE2", "BD7986EFV-E2", "BD7995EFS-BZE2", "BD7995EFS-E2", "BD7996EFV-BZE2", "BD7996EFV-E2", "BD7998EFS-E2", "BD7F100HFN-LBGTR", "BD7F200HFN-LBG",
             "BD7F200HFN-LBGTR", "BD8000FV-CE2", "BD8000FV-E2", "BD8000FV - H","BD8000PFV- HE2","BD800M5WFP- CDE2","BD800M5WFP- CE2","BD800M5WFP2- CE2","BD800M5WHFP- CTR","BD800M7WFP2- CE2","BD8010FVJ",
             "BD8010FVJ-E2", "BD8011FVJ-E2", "BD8012FVJ-BZE2", "BD8012FVJ-E2", "BD8012FVJ-GE2", "BD8013FVJ-E2", "BD8014FVJ-BZGE2", "BD8014FVJ-E2", "BD8014FVJ-GE2", "BD8015FVJ-E2", "BD8018FVJ-E2",
             "BD8018FVJ-GE2", "BD8019FVJ-E2", "BD8019FVJ-GE2", "BD8020FVJ-TR", "BD80C0AFP-CE2", "BD80C0AFP2-CZ1E2", "BD80C0AFPS-CE2", "BD80C0AFPS-E2", "BD80C0AFPS-LBE2", "BD80C0AFPS-ME2", "BD80C0AHFP-CTR",
             "BD80C0AWFP-CE2", "BD80C0AWHFP-CTR", "BD80FC0WFP-E2", "BD8105FV-E2", "BD8105FV-ME2", "BD8132FV-BZE2", "BD8132FV-E2", "BD8133FV-E2", "BD8134EFV-E2", "BD8139AEFV-BZE2", "BD8139AEFV-E2",
             "BD8139EFV-E2", "BD8140FPS", "BD8140FPS-E2", "BD8151EFV-E2", "BD8152FVM-BZGTR", "BD8152FVM-RTR", "BD8152FVM-STR", "BD8152FVM-TR", "BD8154EFV-E2", "BD8156EFV-E2", "BD8157EFV-BZE2", "BD8157EFV-E2",
             "BD8157EFV-ME2", "BD8158FVM-BZGTR", "BD8158FVM-TR", "BD8166EFV-E2", "BD8171EFV", "BD8171EFV-E2", "BD81870EFV-ME2", "BD8192EFV-BZHVE2", "BD8192EFV-E2", "BD8192EFV-HVE2", "BD82000FVJ-E2",
             "BD82001FVJ-BZE2", "BD82001FVJ-E2", "BD82001FVJ-ME2", "BD82001FVJ-MLLE2", "BD82004FVJ-GE2", "BD82004FVJ-GTX", "BD82004FVJ-MGE2", "BD82005FVJ-MGE2", "BD82006FVJ-GE2", "BD82006FVJ-GFX",
             "BD82006FVJ-MGE2", "BD82007FVJ-MGE2", "BD82010FVFJ-E2", "BD82011FVJ-E2", "BD82012FVJ-GE2", "BD82012FVJ-GFX", "BD82020FVJ", "BD82020FVJ-E2", "BD82020FVJ-S", "BD82020FVJ-SE2", "BD82020FVJ-STR",
             "BD82021FVJ-E2", "BD82021FVJ-SE2", "BD82022FVJ", "BD82022FVJ-E2", "BD82022FVJ-SE2", "BD82023FVJ-E2", "BD82023FVJ-SE2", "BD82024DSN-FX", "BD82024FVJ", "BD82024FVJ-E2", "BD82024FVJ-FX",
             "BD82024FVJ-SE2", "BD82025FVJ", "BD82025FVJ-E2", "BD82025FVJ-SE2", "BD82028FVJ-GE2", "BD82029FVJ-GE2", "BD8202EFV", "BD8202EFV-BZ", "BD8202EFV-BZE2", "BD8202EFV-E2", "BD8202FVJ-E2",
             "BD8202FVJ-S2E", "BD82030FVJ-GE2", "BD82030FVJ-SGE2", "BD82031FVJ-GE2", "BD82031FVJ-SGE2", "BD82032FVJ-GE2", "BD82032FVJ-SGE2", "BD82033FVJ-GE2", "BD82034FVJ-GE2", "BD82034FVJ-GFX",
             "BD82034FVJ-SGE2", "BD82035FVJ-GE2", "BD82035FVJ-SGE2", "BD82038FVJ-GE2", "BD82039FVJ-GE2", "BD8203EFV-BZE2", "BD8203EFV-E2", "BD82040FVJ-GE2", "BD82041FVJ", "BD82041FVJ-GE2", "BD82042FVJ",
             "BD82042FVJ-GE2", "BD82043FVJ", "BD82043FVJ-GE2", "BD82044FVJ", "BD82044FVJ-GE2", "BD82044FVJ-SGE2", "BD82045FVJ", "BD82045FVJ-GE2", "BD82046FVJ-GE2", "BD82046FVJ-SGE2", "BD82047FVJ",
             "BD82047FVJ-GE2", "BD82047FVJ-SGE2", "BD82061FVJ-E2", "BD82061FVJ-LBE2", "BD82065FVJ-BZE2", "BD82065FVJ-E2", "BD82065FVJ-ME2", "BD82066EVJ-E2", "BD82066TL-FX", "BD8210EFV-BZE2", "BD8210EFV-E2",
             "BD8211EFV-BZE2", "BD8211EFV-E2", "BD8212EFV-E2", "BD8213EFV-E2", "BD8215EFV-BZE2", "BD8215EFV-E2", "BD8216EFV", "BD8216EFV-BJE2", "BD8216EFV-BZBJE2", "BD8216EFV-BZE2", "BD8216EFV-E2",
             "BD8216EFV-ME2", "BD8217EFV-BZE2", "BD8217EFV-E2", "BD8217EFV-ME2", "BD8217EFV-MSE2", "BD8219EFV-BZE2", "BD8219EFV-E2", "BD8219EFV-HVE2", "BD8231EFV-BZE2", "BD8231EFV-E2", "BD8253EFV-ME2",
             "BD8256EFV-E2", "BD8256EFV-ME2", "BD8312HFN-BZG", "BD8312HFN-BZGTR", "BD8312HFN-TR", "BD8313AHFN", "BD8313AHFN-BZDGTR", "BD8313AHFN-DGTR", "BD8313AHFN-GFX", "BD8313AHFN-TR", "BD8313HFN",
             "BD8313HFN-BZGTR", "BD8313HFN-DGTR", "BD8313HFN-E2", "BD8313HFN-GTR", "BD8313HFN-MTR", "BD8313HFN-TR", "BD8325FVT-ME2", "BD8365KV", "BD8365KV-E2", "BD8365KV-M", "BD8365KV-ME2", "BD8365KV-MFX",
             "BD8370FS", "BD8370FS-BZE2", "BD8370FS-E2", "BD8371HFP-FX", "BD8371HFP-MTR", "BD8371TST-FX", "BD8372HFP-FX", "BD8372HFP-MTR", "BD8372TST-FX", "BD83732HFP-MTR", "BD83733HFP-MTR", "BD83740HFP-MTR",
             "BD8374AHFP-MTR", "BD8374AHFP-TR", "BD8374AVHFP-M", "BD8374AVHFP-ME2", "BD8374AVHFP-MTR", "BD8374HFP-FX", "BD8374HFP-MTR", "BD8374TST-FX", "BD8374VHFP-MTR", "BD8375TST-FX", "BD8379EFV-ME2",
             "BD8379TST-FX", "BD8410FPS-E2", "BD8601FV", "BD8602FV", "BD8602FV-E2", "BD8604FV-E2", "BD8606FV", "BD8606FV-BZE2", "BD8606FV-E2", "BD86104TST-FX", "BD8611EFV-E2", "BD8617TST-FX", "BD86180TST-FX",
             "BD86180TST1-FX", "BD86181TST-FX", "BD86181TST1-FX", "BD8620EFV-E2", "BD8621EFV", "BD8621EFV-BZE2", "BD8621EFV-E2", "BD8622EFV-E2", "BD8625EFV-E2", "BD86260TST2-FX", "BD8627EFV-E2", "BD8632FV",
             "BD8632FV-BZE2", "BD8632FV-E2", "BD8633FV", "BD8633FV-E2", "BD8641EFV", "BD8643FV", "BD8643FV-BZE2", "BD8643FV-E2", "BD8643FV-ME2", "BD8645FS-E2", "BD8645FS-HV", "BD8646FV", "BD8646FV-E2", "BD8646FV-ME2",
             "BD8649EFV", "BD8649EFV-BZE2", "BD8649EFV-E2", "BD8649FV", "BD8649FV-E2", "BD8649FV-M", "BD8649FV-ME2", "BD8650FV-E2", "BD8650FV-ME2", "BD8651FV", "BD8651FV-E2", "BD8651FV-M", "BD8651FV-ME2", "BD8652FV",
             "BD8652FV-BZE2", "BD8652FV-E2", "BD8654FS-HVE2", "BD8655FV-HVE2", "BD8655FV-HVFX", "BD8655FV-HVGE2", "BD8655FV-HVGZAE2", "BD8656FS-BZHVGE2", "BD8656FS-HVE2", "BD8657FV-BZHVGE2", "BD8657FV-E2",
             "BD8657FV-GE2", "BD8657FV-HVGE2", "BD8657FV-HVGFX", "BD8657FV-HVGZAE2", "BD8658EFV-E2", "BD8658EFV-GE2", "BD8658EFV-HVGE2", "BD8658TST-FX", "BD8668TST-FX", "BD8691FVM-TR", "BD8692FVM-HVTR", "BD8693FVM-GTR",
             "BD8693FVM-HVTR", "BD8695TST-FX", "BD8779EFV", "BD8779EFV-BZ", "BD8779EFV-BZE2", "BD8779EFV-BZGE2", "BD8779EFV-BZHVE2", "BD8779EFV-E2", "BD8779EFV-GE2", "BD8779EFV-HVE2", "BD87A28FVM-MTR",
             "BD87A28FVM-RTR", "BD87A28FVM-TR", "BD87A29FVM-BKTR", "BD87A29FVM-MLLTR", "BD87A29FVM-MTR", "BD87A29FVM-RTR", "BD87A29FVM-TR", "BD87A34FVM-MTR", "BD87A34FVM-TR", "BD87A41FVM-MTR", "BD87A41FVM-TR",
             "BD8811FV-E2", "BD8872FV-E2", "BD8900FV-E2", "BD8900FV-S", "BD8900FV-SE2", "BD8904FV", "BD8904FV-BZE2", "BD8904FV-BZME2", "BD8904FV-E2", "BD8904FV-ME2", "BD8906FV", "BD8906FV-BZ", "BD8906FV-BZE2",
             "BD8906FV-E2", "BD8910FV", "BD8910FV-E2", "BD8964FVM-TR", "BD8966FVM-BZGTR", "BD8966FVM-TR", "BD8967FVM-TR", "BD8LB600DSN-E2", "BD8LB600DSN-FX", "BD8LB600FS-CE2", "BD8LB600FS-E2",
             "BD8LB600FS-FX", "BD8LB600FS-ME2", "BD9001F-E2", "BD9001F-ME2", "BD9001F-RE2", "BD9002HFP-TR", "BD9003F-E2", "BD9003F-ME2", "BD9006HFP", "BD9006HFP-BJTR", "BD9006HFP-E2", "BD9006HFP-MTR",
             "BD9006HFP-TR", "BD9007HFP", "BD9007HFP-E2", "BD9007HFP-TR", "BD9007HFP-TTR", "BD9009HFP-BJTR", "BD9009HFP-BZMTR", "BD9009HFP-BZTR", "BD9009HFP-MTR", "BD9009HFP-TR", "BD9011KV", "BD9011KV-E2",
             "BD9011KV-ZAE2", "BD9012KV", "BD9012KV-E2", "BD9013KV", "BD9013KV-E2", "BD9014EKV-BJE2", "BD9014EKV-E2", "BD9015DSN-ME2", "BD9015KV-BZME2", "BD9015KV-CE2", "BD9015KV-FX", "BD9015KV-ME2",
             "BD9015KVDSN-E2", "BD9015KVDSN-ME2", "BD9016KV-BZME2", "BD9016KV-E2", "BD9016KV-FX", "BD9016KV-ME2", "BD9016KV-MZAE2", "BD9016KV-ZAE2", "BD9017KV", "BD9017KV-E2", "BD9017KV-ZAE2", "BD9018DSN",
             "BD9018DSN-E2", "BD9018KV", "BD9018KV-E2", "BD9018KV-ME2", "BD9018KV-ZA1", "BD9018KV-ZA1E2", "BD9019FV-E2", "BD90201FV-BZME2", "BD90201FV-E2", "BD90201FV-FX", "BD90201FV-ME2", "BD9020FV-BZME2",
             "BD9020FV-E2", "BD9020FV-FX", "BD9020FV-ME2", "BD9045FV-BZE2", "BD9045FV-E2", "BD9045FV-ME2", "BD90520DSNB-E2", "BD90520EFV-CE2", "BD90521EFV-CE2", "BD90521EFV-E2", "BD90540EFV",
             "BD90540EFV-E2", "BD90540EFV-FX", "BD90590DSN-E2", "BD90590EFV-CE2", "BD90590EFV-FX", "BD9060HFP-CTR", "BD9060HFP-FX", "BD90620HFP-CTR", "BD90640HFP-CTR", "BD9071EFV-FX", "BD90C0AFP-CE2",
             "BD90C0AFPS-E2", "BD90C0AFPS-ME2", "BD90C0AHFP-CTR", "BD90C0AWFP-CE2", "BD90C0AWFP2-CE2", "BD90C0AWHFP-CTR", "BD90FC0WFP-E2", "BD9101FVM-GTR", "BD9101FVM-TR", "BD9102FVM-BZGTR", "BD9102FVM-TR",
             "BD9103FVM-GTR", "BD9103FVM-TR", "BD9104FVM-BZGTR", "BD9104FVM-TR", "BD9105FVM-TR", "BD9106FVM-BZGTR", "BD9106FVM-GTR", "BD9106FVM-MTR", "BD9106FVM-TR", "BD91071FVM-TR", "BD9107FVM-GTR",
             "BD9107FVM-MTR", "BD9107FVM-RTR", "BD9107FVM-TR", "BD9107FVM-TTR", "BD9109FVM-GTR", "BD9109FVM-TR", "BD91201HFN-BZG", "BD91201HFN-BZGTR", "BD91201HFN-TR", "BD9120HFN-BZG", "BD9120HFN-TR",
             "BD91364TST-FX", "BD91390TST-FX", "BD9140EFV", "BD9143TST-FX", "BD91510KV-E2", "BD91510KV-ME2", "BD91510TST-FX", "BD91512TST-FX", "BD91513TST-FX", "BD9160FVM-TR", "BD9161FVM-BZGTR",
             "BD9161FVM-G", "BD9161FVM-GTR", "BD9161FVM-LBTR", "BD9161FVM-TR", "BD9170TST2-FX", "BD9172TST-FX", "BD9202EFS", "BD9202EFS-E2", "BD9206EFV-BZE2", "BD9206EFV-BZSE2", "BD9206EFV-E2",
             "BD9206EFV-LBE2", "BD9206EFV-S", "BD9206EFV-SE2", "BD9207FPS", "BD9207FPS-BZE2", "BD9207FPS-E2", "BD9207FPS-SE2", "BD9214AFVM-TR", "BD9214FVM-TR", "BD9215AFV", "BD9215AFV-BZE2", "BD9215AFV-E2",
             "BD9215AFV-SE2", "BD9215FV", "BD9215FV-BZE2", "BD9215FV-BZSE2", "BD9215FV-E2", "BD9215FV-S", "BD9215FV-SE2", "BD9217F-E2", "BD9217FV-BZE2", "BD9217FV-E2", "BD9217FV-ZAE2", "BD9218FM-E2",
             "BD9222FV", "BD9222FV-E2", "BD9240FV-E2", "BD9244AFV-BZGE2", "BD9244AFV-E2", "BD9244AFV-GE2", "BD9244AFV-GZAE2", "BD9244AFV-ZAE2", "BD9244FV-BZE2", "BD9244FV-BZGE2", "BD9244FV-E2",
             "BD9244FV-GE2", "BD9263F-FX", "BD9263F-GE2", "BD9263F-GFX", "BD9263F-HVGE2", "BD9264EFV", "BD9264EFV-E2", "BD9264FP-G", "BD9264FP-GE2", "BD9266FV-GFX", "BD9267KU-FX", "BD9268FV-BZGE2",
             "BD9268FV-E2", "BD9268FV-GE2", "BD9268FV-GFX", "BD9269KS2-GFX", "BD9270F", "BD9270F-E2", "BD9270F-KX", "BD9276EFV-BZGE2", "BD9276EFV-E2", "BD9276EFV-GE2", "BD9276EFV-GFX", "BD9276EFV-RGE2",
             "BD9276EFV-SGE2", "BD9276EFVCS-BZE2", "BD9276EFVCSE2", "BD9279FV-E2", "BD9289DSN2-GFX", "BD9289DSN4-GFX", "BD9289FV-FX", "BD9289FV-GE2", "BD9289FV-GFX", "BD9305AFVM-BZGGTR", "BD9305AFVM-BZGTR",
             "BD9305AFVM-GTR", "BD9305AFVM-TR", "BD9305FVM-TR", "BD9306AFVM-BZGGTR", "BD9306AFVM-BZGTR", "BD9306AFVM-BZSGTR", "BD9306AFVM-GTR", "BD9306AFVM-MTR", "BD9306AFVM-RTR", "BD9306AFVM-STR",
             "BD9306AFVM-TR", "BD9306FVM-TR", "BD9307FVM-TR", "BD93941EFV-E2", "BD93941EFV-FX", "BD9397EFV-E2", "BD9397EFV-GE2", "BD9397EFV-GFX", "BD9397EFVA-GFX", "BD9415FS-GE2", "BD9416F-GE2",
             "BD9416FS-E2", "BD9421F-GE2", "BD9422EFV-E2", "BD9422EFV-RE2", "BD9423EFV-E2", "BD9477DSN-GFX", "BD9479FV-E2", "BD9479FV-GE2", "BD9479FV-SGE2", "BD9483F-GE2", "BD9483F-KX", "BD9483F-SGE2",
             "BD9483FV-GE2", "BD9490FUT", "BD9490FUT-E2", "BD9490FUT-HVE2", "BD9490FUT-HVFX", "BD95282TST-FX", "BD9536FV", "BD9536FV-E2", "BD95372DSN-FX", "BD95390FV", "BD95390FV-BZSE2", "BD95390FV-E2",
             "BD95390FV-SE2", "BD95390FV-SZAE2", "BD9539FV", "BD9539FV-E2", "BD9555FVM-CGTR", "BD9555FVM-CSGTR", "BD95802TST-FX", "BD95831TST-FX", "BD95833TST-FX", "BD95837TST-FX", "BD95841TST-FX",
             "BD9612AFV-BZME2", "BD9612AFV-ME2", "BD9612FV-E2", "BD9612FV-FX", "BD9612FV-ME2", "BD9683EFV-E2", "BD9684EFV-E2", "BD9685EFV-E2", "BD9685EFV-FX", "BD9685EFV1-E2", "BD9685EFV1-FX", "BD9685TST-FX",
             "BD9701FP-BZE2", "BD9701FP-ME2", "BD9703FP", "BD9703FP-BJE2", "BD9703FP-BZE2", "BD9703FP-E2", "BD9703FP-GE2", "BD9703FP-ME2", "BD9703FP-RE2", "BD9703FP-SE2", "BD9703FPS-BZE2", "BD9703FPS-E2",
             "BD9703HW-ME2", "BD9713KV", "BD9713KV-BZ", "BD9713KV-BZE2", "BD9713KV-E2", "BD9751FV-E2", "BD9763FVM-BZFGTR", "BD9763FVM-BZGTR", "BD9763FVM-FTR", "BD9763FVM-TR", "BD9766FV", "BD9766FV-AE2",
             "BD9766FV-BZE2", "BD9766FV-E2", "BD9766FV-F", "BD9766FV-FE2", "BD9766FV-P", "BD9766FV-PE2", "BD9766FV-R", "BD9766FV-RE2", "BD9774HFP-TR", "BD9775FV-BZE2", "BD9775FV-BZME2", "BD9775FV-E2",
             "BD9775FV-LE2", "BD9775FV-ME2", "BD9776HFP-E2", "BD9776HFP-M", "BD9776HFP-MTR", "BD9776HFP-TR", "BD9778F", "BD9778F-E2", "BD9778F-ME2", "BD9778HFP", "BD9778HFP-BVE2", "BD9778HFP-BVTR",
             "BD9778HFP-BZTR", "BD9778HFP-E2", "BD9778HFP-M6TR", "BD9778HFP-MTR", "BD9778HFP-RTR", "BD9778HFP-TR", "BD9781HFP", "BD9781HFP-BZTR", "BD9781HFP-M", "BD9781HFP-MTR", "BD9781HFP-RTR",
             "BD9781HFP-TR", "BD9781HFP-TTR", "BD9833KV", "BD9833KV-E2", "BD9850FVM-MTR", "BD9850FVM-TR", "BD9851EFV-E2", "BD9851EFV-ME2", "BD9851EFV-MZAE2", "BD9851EFV-ZAE2", "BD9870FPS-BZE2",
             "BD9870FPS-E2", "BD9870FPS-ME2", "BD9882F-E2", "BD9882F-PE2", "BD9883AF-E2", "BD9883F-E2", "BD9884FV-AE2", "BD9884FV-BE2", "BD9884FV-E2", "BD9884FV-PE2", "BD9884FV-RE2", "BD9885FV-BZE2",
             "BD9885FV-BZRE2", "BD9885FV-E2", "BD9885FV-RE2", "BD9886FV-BZE2", "BD9886FV-BZPE2", "BD9886FV-E2", "BD9886FV-GE2", "BD9886FV-PE2", "BD9886FV-RE2", "BD9887FS-E2", "BD9888FV-E2", "BD9889FV-E2",
             "BD9890FV-BZE2", "BD9890FV-E2", "BD9895FV-E2", "BD9896FV", "BD9896FV-BZE2", "BD9896FV-E2", "BD9896FV-GE2", "BD9896FV-LE2", "BD9897FS", "BD9897FS-BZE2", "BD9897FS-E2", "BD9897FS-GE2",
             "BD9897FS-KX", "BD9897FS-LE2", "BD9897FS-R", "BD9897FS-RE2", "BD9897FS-S", "BD9897FS-SE2", "BD9898FV", "BD9898FV-BZE2", "BD9898FV-BZS", "BD9898FV-BZSE2", "BD9898FV-E2", "BD9898FV-S",
             "BD9898FV-SE2", "BD9960EFV", "BD9960EFV-E2", "BD9960EFV-S", "BD9960EFV-SE2", "BD9962EFV", "BD9962EFV-E2", "BD9963EFV-E2", "BD9970EFV-E2", "BD9973EFV", "BD9973EFV-E2", "BD9975HFP-E2",
             "BD9976HFP-TR", "BD9977HFP", "BD9977HFP-DTR", "BD9977HFP-TR", "BD9978HFP-E2", "BD9979HFP-E2", "BD9980FVM-TR", "BD9981FVM-TR", "BD9982FVM-TR", "BD9984FVM-TR", "BD9985AFVM-TR", "BD9985FVM-TR",
             "BD9991FVM-GTR", "BD9991FVM-TR", "BD9994FVM-TR", "BD9A300TST-FX", "BD9A400TST-FX", "BD9B300TSTA-FX", "BD9B300TSTB-FX", "BD9B330TST-FX", "BD9B600TST-FX", "BD9D320TST-FX", "BD9E102TST-FX",
             "BD9E300TST-FX", "BD9F800TST2-FX", "BD9P105EFV-CE2", "BD9P135EFV-CE2", "BD9P155EFV-CE2", "BD9P235EFV-CE2", "BDH0801HFV-TR", "BDJ0550HFV-TR", "BDJ0600AHFV-TR", "BDJ0600HFV-TR", "BDJ0601HFV-TR",
             "BDJ0650HFV-TR", "BDJ0700AHFV-TR", "BDJ0700HFV-TR", "BDJ0701HFV-TR", "BDJ0751HFV-TR", "BDJ0800AHFV-TR", "BDJ0800HFV-TR", "BDJ0801HFV-TR", "BDJ0851HFV-TR", "BDJ0901HFV-TR", "BDJ0FC0WFP-E2",
             "BDJ2FC0WFP-E2", "BDJ2FD0WHFP-TR", "BDJ5FC0WFP-E2", "BDJ6FD0EHFP-MTR", "BH12PB1WHFV-STR", "BH12PB1WHFV-TR", "BH12PB3WHFV-TR", "BH1411FV-E2", "BH1412FV-E2", "BH1415F-E2", "BH1415FV-E2",
             "BH1416F-E2", "BH1417F-E2", "BH1417FV-E2", "BH1418FV", "BH1418FV-E2", "BH1418FV-S", "BH1418FV-SE2", "BH1418FV-ZAE2", "BH15FB1WHFV-TR", "BH15LB1WHFV-TR", "BH15M0AWHFV-TR", "BH15MA3WHFV-RTR",
             "BH15MA3WHFV-TR", "BH15PB1WHFV-BJTR", "BH15PB1WHFV-TR", "BH1600FVC-FX", "BH1600FVC-TR", "BH1603FVC-BJTR", "BH1603FVC-LNTR", "BH1603FVC-STR", "BH1603FVC-TR", "BH1620FVC-LRTR", "BH1620FVC-STR",
             "BH1620FVC-TR", "BH1621FVC-STR", "BH1621FVC-TR", "BH1622TL", "BH1622TL-TR", "BH1680FVC-LNTR", "BH1680FVC-TR", "BH1681FVC-TR", "BH1682FVC-TR", "BH1690FVC-S1TR", "BH1690FVC-SBTR", "BH1690FVC-SFX",
             "BH1690FVC-STR", "BH1690FVC-TR", "BH1690PK-TR", "BH1710FVC-GTR", "BH1710FVC-STR", "BH1710FVC-TR", "BH1711FVC-TR", "BH1715FVC-TR", "BH1721FVC-STR", "BH1730FVC-TR", "BH1733FVC-TR", "BH1750FVI-TR",
             "BH1751FVI-TR", "BH18FB1WHFV-TR", "BH18LB1WHFV-STR", "BH18LB1WHFV-TR", "BH18M0AWHFV-TR", "BH18MA3WHFV-RTR", "BH18MA3WHFV-STR", "BH18MA3WHFV-TR", "BH18PB1WHFV-TR", "BH1900NUX-RTR",
             "BH1900NUX-TR", "BH19PB1WHFV-TR", "BH1JLB1WHFV-TR", "BH20M0AWHFV", "BH20M0AWHFV-TR", "BH21M0AWHFV", "BH21M0AWHFV-TR", "BH2203KV", "BH2203KV-ZA", "BH2210FV-E2", "BH2219AFVM-MTR", "BH2219AFVM-TR",
             "BH2219FVM-BZGTR", "BH2219FVM-TR", "BH2220AFVM-TR", "BH2220FVM-BZFGTR", "BH2220FVM-BZGTR", "BH2220FVM-FTR", "BH2220FVM-TR", "BH2222FV-E2", "BH25FB1WHFV-TR", "BH25M0AWHFV-TR", "BH25MA3WHFV-G",
             "BH25MA3WHFV-STR", "BH25MA3WHFV-TR", "BH25NB1WHFV-TR", "BH25PB1WHFV-TR", "BH26M0AWHFV-TR", "BH27M0AWHFV-TR", "BH28FB1WHFV-GTR", "BH28FB1WHFV-STR", "BH28FB1WHFV-TR", "BH28M0AWHFV-TR",
             "BH28MA3WHFV-TR", "BH28NB1WHFV-TR", "BH28PB1WHFV-TR", "BH29FB1WHFV-STR", "BH29FB1WHFV-TR", "BH29M0AWHFV-TR", "BH29MA3WHFV-STR", "BH29MA3WHFV-TR", "BH29NB1WHFV-TR", "BH29PB1WHFV-STR",
             "BH29PB1WHFV-TR", "BH2JNB1WHFV-TR", "BH30FB1WHFV-STR", "BH30FB1WHFV-TR", "BH30M0AWHFV-TR", "BH30MA3WHFV-TR", "BH30NB1WHFV-TR", "BH30PB1WHFV-SGTR", "BH30PB1WHFV-STR", "BH30PB1WHFV-TR",
             "BH3156FV-E2", "BH31FB1WHFV-SGTR", "BH31FB1WHFV-STR", "BH31FB1WHFV-TR", "BH31M0AWHFV-TR", "BH31MA3WHFV-STR", "BH31MA3WHFV-TR", "BH31NB1WHFV-TR", "BH31PB1WHFV-TR", "BH32M0AWHFV-TR",
             "BH33FB1WHFV-GTR", "BH33FB1WHFV-STR", "BH33FB1WHFV-TR", "BH33M0AWHFV-TR", "BH33MA3WHFV-MTR", "BH33MA3WHFV-RTR", "BH33MA3WHFV-TR", "BH33PB1WHFV-STR", "BH33PB1WHFV-TR", "BH34M0AWHFV-TR",
             "BH3514AFV-E2", "BH3514BFV", "BH3514CFV-BZE2", "BH3514CFV-E2", "BH3515FV-BZE2", "BH3515FV-E2", "BH3515FV-LE2", "BH3516AFV-BZE2", "BH3516AFV-E2", "BH3516FV-E2", "BH3532AFS-FX", "BH3532AFS-ZAE2",
             "BH3532FS-BZE2", "BH3532FS-E2", "BH3532FS-ME2", "BH3546FVM-TR", "BH3682FV", "BH3682FV-E2", "BH3683FV-E2", "BH3802KV-E2", "BH3820FV", "BH3820FV-E2", "BH3852FS-E2", "BH3856FS-E2", "BH3856FSE2",
             "BH3857AFV-E2", "BH3857FV-E2", "BH3862FS-E2", "BH3863F-E2", "BH3868CFS-E2", "BH3950KU", "BH3950KU-E2", "BH3950KU-ZAE2", "BH5502KV", "BH5502KV-E2", "BH5510KV", "BH5510KV-BZ", "BH5510KV-BZE2",
             "BH5510KV-E2", "BH5510KV-ZAE2", "BH5511KV", "BH5511KV-E2", "BH5740CFS-E2", "BH6014BKV", "BH6014BKV-E2", "BH6020FV-BZE2", "BH6020FV-E2", "BH6020FV-ZAE2", "BH6021FV", "BH6021FV-E2", "BH6040FVM-TR",
             "BH6119FV-E2", "BH6393FUV", "BH6393FUV-E2", "BH6393FUV-ZAE2", "BH6406FV", "BH6406FV-E2", "BH6508FS-E2", "BH6511FS", "BH6511FS-E2", "BH6513FS-E2", "BH6519FS-BZE2", "BH6519FS-E2", "BH6522FV-E2",
             "BH6545AKV", "BH6545AKV-E2", "BH6546BKV", "BH6546BKV-E2", "BH6546KV-E2", "BH6547KV", "BH6547KV-E2", "BH6548KV", "BH6548KV-E2", "BH6549BKV", "BH6549BKV-E2", "BH6549KV", "BH6549KV-E2", "BH6551FV",
             "BH6551FV-E2", "BH6553FV", "BH6553FV-E2", "BH6554FV-E2", "BH6556FV", "BH6556FV-E2", "BH6561FV", "BH6561FV-E2", "BH6562FV-E2", "BH6564FV-E2", "BH6565FV-BZE2", "BH6565FV-E2", "BH6565FV-ZAE2",
             "BH6569FV-E2", "BH6573FV-E2", "BH6573FV-ZAE2", "BH6575FV", "BH6575FV-BZ E2", "BH6575FV-BZE2", "BH6575FV-E2", "BH6575HFV-BZE2", "BH6575HFV-E2", "BH6578FVM-BZGTR", "BH6578FVM-TR", "BH6581KV",
             "BH6581KV-E2", "BH6584KV", "BH6584KV-BZE2", "BH6584KV-E2", "BH6590AKU", "BH6590AKU-A", "BH6590AKU-AE2", "BH6590AKU-BE2", "BH6590AKU-E2", "BH6590KU-E2", "BH6595KU-E2", "BH6599KV", "BH6599KV-E2",
             "BH6733HFV-G", "BH6764FVM-GTR", "BH6765FVM-GTR", "BH6765FVM-TR", "BH6766FVM-GTR", "BH6766FVM-TR", "BH6776FVM-TR", "BH6779FVM-BZGTR", "BH6779FVM-GTR", "BH6779FVM-SGTR", "BH6779FVM-TR", "BH6789FVM-GTR",
             "BH6789FVM-TR", "BH6798FVM-GTR", "BH6798FVM-TR", "BH6799FVM-DTTR", "BH6799FVM-SGTR", "BH6799FVM-TR", "BH6799FVM-TTR", "BH6904HFV-TR", "BH6950AKU-A", "BH7086KV", "BH7086KV-BZ", "BH7086KV-E2",
             "BH7086KV-ZA", "BH7086KV-ZAE2", "BH72220FVM-TR", "BH7236AF-E2", "BH7236F", "BH7236F-E2", "BH7240AKV", "BH7240AKV-BZ", "BH7240AKV-BZE2", "BH72415F-E2", "BH7243KV", "BH7243KV-E2", "BH7343HFV-TR",
             "BH7344HFV-TR", "BH7600AFS-E2", "BH76010FS-E2", "BH76010FS-ZAE2", "BH76010FS-ZAFX", "BH76010FS-ZAFXE2", "BH7602FS", "BH7602FS-E2", "BH7602FS-ME2", "BH7602FS-SE2", "BH7602FS-SZAE2",
             "BH7602FS-ZAE2", "BH76106HFV-E2", "BH76106HFV-MTR", "BH76106HFV-TR", "BH76106SHFV-TR", "BH7610FVM-TR", "BH76112HFV-MTR", "BH76112HFV-TR", "BH7613HFV-TR", "BH7616HFV-TR", "BH76206HFV-MLLTR",
             "BH76206HFV-MTR", "BH76206HFV-TR", "BH7621KS2", "BH7623KS2", "BH7624KS2", "BH76250FS", "BH76250FS-E2", "BH7625KS2", "BH7626KS2", "BH76330FVM-MTR", "BH76330FVM-TR", "BH76331FVM-TR",
             "BH76332FVM-TR", "BH76333FVM-TR", "BH7641FV", "BH7641FV-E2", "BH7645KS2", "BH7645KS2-ZA", "BH7645KS2-ZAE2", "BH7649KS2", "BH7649KS2-E2", "BH7649KS2-ZA", "BH7649KS2-ZAE2", "BH7650FS-E2",
             "BH7659FS", "BH7659FS-E2", "BH76806FVM-GTR", "BH76806FVM-MTR", "BH76806FVM-STR", "BH76806FVM-TR", "BH76809FVM-STR", "BH76809FVM-TR", "BH76812FVM-STR", "BH76812FVM-TR", "BH76816FVM-TR",
             "BH7712HFV-TR", "BH7823AFVM-BZGTR", "BH7823AFVM-TR", "BH7824AFVM-TR", "BH7824FVM-BZFGTR", "BH7824FVM-BZGTR", "BH7824FVM-DFMTR", "BH7824FVM-FM", "BH7824FVM-FMTR", "BH7824FVM-FTR", 
             "BH7824FVM- TR","BH78250FS- E2","BH7826FVM- BZGTR","BH7826FVM- BZTR","BH7826FVM- FTR","BH7826FVM- GTR","BH7826FVM- TR","BH7856FS","BH7856FS- E2","BH7857FS","BH7857FS- E2","BH7857FS- HV",
             "BH7857FS-HVE2", "BH7862FS-E2", "BH7867FS-BZE2", "BH7867FS-E2", "BH7868FS-BZE2", "BH7868FS-E2", "BH7870AKV", "BH7870AKV-E2", "BH7870AKV-F", "BH7870AKV-FE2", "BH7870KV", "BH7870KV-E2",
             "BH8521HFV-TR", "BH9220FV", "BH9220FV-E2", "BH9221FV-E2", "BH9436JKV", "BH9450KV", "BH9450KV-E2", "BH9521BKS2", "BH9522AKS2", "BH9531KS2", "BH9531KS2-D", "BH9531KS2-E", "BH9547CKV",
             "BH9547CKV-E2", "BH9556BKV", "BH9556BKV-E2", "BH9558AKV-F", "BH9558AKV-FE2", "BH9571KV-B", "BH9571KV-BE2", "BH9794KV", "BH9794KV-E2", "BH9910KV", "BH9910KV-E2", "BH9911KV", "BH9911KV-E2",
             "BH9931AFVM-TR", "BH9931FVM-TR", "BH9932FVM-DTR", "BH9932FVM-TR", "BH9933FVM-TR", "BH9934AFVM-TR", "BH9934FVM-TR", "BH9941FV-E2", "BH9946FV-BZE2", "BH9946FV-E2", "BH9946FV-GE2", "BL940-BZE2",
             "BM1050AF-E2", "BM1050AF-GE2", "BM1050AFB-GE2", "BM1050F-MGFX", "BM1051F-GE2", "BM2P012T-Z", "BM2P014T-Z", "BM2P014T-ZV1", "BM2P0162T-Z", "BM2P0163T-Z", "BM2P016T-Z", "BM2SCQ121T-LBZ", 
             "BM2SCQ122T-LBZ", "BM2SCQ123T-LBZ", "BM2SCQ124T-LBZ", "BM5446EFV", "BM5446EFV-E2", "BM60011D10-FX", "BM60011D5-FX", "BM60011DSND2-FX", "BM60011DSND3-FX", "BM60011FV-CE2", "BM60011FV-CFX",
             "BM60011FV-FX", "BM60012TEG-FX", "BM60013FV-CE2", "BM60013FV-FX", "BM60013TEG-FX", "BM60014FV-CE2", "BM60015FV-LBE2", "BM60016FV-CE2", "BM60018FJ-CE2", "BM60018FJ-HE2", "BM60019FJ-CE2",
             "BM60019FJ-HE2", "BM6001TL-FX", "BM6002TL-FX", "BM60051FV-C6E2", "BM60051FV-CE2", "BM60052AFV", "BM60052AFV-CE2", "BM60053AFV-C6E2", "BM60053AFV-CE2", "BM60054AFV-CE2", "BM60054FV-CE2",
             "BM60055FV-CE2", "BM60056FV-CE2", "BM60059FV-CE2", "BM60060FV-CE2", "BM60210FV-CE2", "BM60211FV-CE2", "BM60212FV-CE2", "BM60212FV-HE2", "BM60213FV-CE2", "BM6101FV-CE2", "BM6101FV-E2",
             "BM6102FV-CE2", "BM6103-FX", "BM6103DSNB1-FX", "BM6103FV-CE2", "BM6103FV-CFX", "BM6103FV-FX", "BM6103TEG-FX", "BM6104FV-CE2", "BM6108FV-LBE2", "BM6109FV-CE2", "BM6112FV-CE2", "BM61M41RFV-CE2",
             "BM61S40RFV-CE2", "BM61S41RFV-C", "BM61S41RFV-CE2", "BM6201FS-E2", "BM6201FS-SE2", "BM6201FS1-E2", "BM6201FS2-E2", "BM6202FS-E2", "BM6202FS-SE2", "BM6203FS-E2", "BM6204FS-E2", "BM6205FS-E2",
             "BM6206FS-E2", "BM6207FS-E2", "BM6208FS-E2", "BM6209FS-E2", "BM6213FS-E2", "BM6214FS-E2", "BM6215FS-E2", "BM6221FS-E2", "BM6222FS-E2", "BM6223FS-E2", "BM6224FS-E2", "BM6226FS-E2",
             "BM6227FS-E2", "BM6228FS-E2", "BM6229FS-E2", "BM6230FS-E2", "BM6231FS-E2", "BM6232FP-E2", "BM6232FP1-E2", "BM6241FS-E2", "BM6242FS-E2", "BM6243FS-E2", "BM63164S-VA", "BM63164S-VC", "BM63363S",
             "BM63363S-VA", "BM63363S-VC", "BM63364S-VA", "BM63364S-VC", "BM63763S-VA", "BM63763S-VC", "BM63764S-VA", "BM63764S-VC", "BM63767S-VA", "BM63767S-VC", "BM64165S-VA", "BM64364S-VA", "BM64365S-VA",
             "BM64365S-VC", "BM6534S-VA", "BM65364DS-VA", "BM65364S-VA", "BM65364S-VC", "BM65464S-VA", "BM65464S-VC", "BM65465S-VA", "BM66002FV-CE2", "BM6600TLA-FX", "BM6600TLB-FX", "BM6600TLC-FX",
             "BM6600TLD-FX", "BM67220FV-CE2", "BM67220FV-CFX", "BM67221FV-CE2", "BM67221FV-CFX", "BM67221TEG-FX", "BM67225FV-E2", "BM67271FV-HE2", "BM67290FV-CE2", "BM67290FV-FX", "BM67290FV-HE2",
             "BM67420FV-CE2", "BM67421FV-CE2", "BM67421FV-FX", "BM67424FV-CE2", "BM67424FV-HE2", "BM69010ND-C", "BM69012ND-C", "BM69014ND-C", "BM9014ND-C", "BR24A02FVM-WMTR", "BR24C01-DS6TP",
             "BR24C01-RDS6TP", "BR24C01-WDS6TP", "BR24C02-DS6TP", "BR24C02-RDS6TP", "BR24C02-WDS6TP", "BR24C04-DS6TP", "BR24C04-RDS6TP", "BR24C04-WDS6TP", "BR24C08-DS6TP", "BR24C08-RDS6TP",
             "BR24C08-WDS6TP", "BR24C16-DS6TP", "BR24C16-RDS6TP", "BR24C16-WDS6TP", "BR24G01FVJ-3AGTE2", "BR24G01FVJ-3GTE2", "BR24G01FVM-3AGTTR", "BR24G01FVM-3GTTR", "BR24G01NUX-3ATTR", "BR24G01NUX-3TTR",
             "BR24G02FVJ-3AGTE2", "BR24G02FVJ-3GTE2", "BR24G02FVM-3AGTTR", "BR24G02FVM-3GTTR", "BR24G02NUX-3ATTR", "BR24G02NUX-3BTR", "BR24G02NUX-3BXT", "BR24G02NUX-3BXTTR", "BR24G02NUX-3STTR",
             "BR24G02NUX-3TS1", "BR24G02NUX-3TS1TR", "BR24G02NUX-3TTR", "BR24G04FVJ-3AGTE2", "BR24G04FVJ-3GTE2", "BR24G04FVM-3AGTTR", "BR24G04FVM-3GTE2", "BR24G04FVM-3GTTR", "BR24G04NUX-3ATTR",
             "BR24G04NUX-3STTR", "BR24G04NUX-3TTR", "BR24G08FVJ-3AGTE2", "BR24G08FVJ-3GTE2", "BR24G08FVM-3AGTTR", "BR24G08FVM-3GT", "BR24G08FVM-3GTR", "BR24G08FVM-3GTTR", "BR24G08NUX-3ATTR",
             "BR24G08NUX-3TS", "BR24G08NUX-3TS1", "BR24G08NUX-3TS1TR", "BR24G08NUX-3TSTR", "BR24G08NUX-3TTR", "BR24G08NUX-TR", "BR24G08NUX-WTR", "BR24G128FVJ-3AGTE2", "BR24G128FVJ-3GTE2",
             "BR24G128FVM-3AGT-FX", "BR24G128FVM-3AGTTR", "BR24G128FVM-5TR", "BR24G128NUX-3ATSTR", "BR24G128NUX-3ATTR", "BR24G128NUX-3TSTR", "BR24G128NUX-5TR", "BR24G16FVJ-3AGTE2", "BR24G16FVJ-3GTE2",
             "BR24G16FVM-3AGTTR", "BR24G16FVM-3GTSTR", "BR24G16FVM-3GTTR", "BR24G16FVM-TR", "BR24G16NUX-3ATTR", "BR24G16NUX-3BXT", "BR24G16NUX-3BXTTR", "BR24G16NUX-3STTR", "BR24G16NUX-3TTR",
             "BR24G256FVM-5TR", "BR24G256NUX-5TR", "BR24G32FVJ-3AGTE2", "BR24G32FVJ-3GTE2", "BR24G32FVM-3AGTTR", "BR24G32FVM-3GTTR", "BR24G32FVM-5", "BR24G32FVM-5TR", "BR24G32NUX-306CTR",
             "BR24G32NUX-3ATTR", "BR24G32NUX-3BTR", "BR24G32NUX-3BXTTR", "BR24G32NUX-3TSTR", "BR24G32NUX-3TTR", "BR24G32NUX-5TR", "BR24G64FVJ-3AGTE2", "BR24G64FVM-3AGTTR", "BR24G64FVM-3GTTR",
             "BR24G64FVM-5TR", "BR24G64NUX-3ATTR", "BR24G64NUX-3TSTR", "BR24G64NUX-3TTR", "BR24G64NUX-5TR", "BR24H256NUX", "BR24H256NUX-5ACTR", "BR24L01AFVJ-WE2", "BR24L01AFVM-WGTR", "BR24L01AFVM-WMTR",
             "BR24L01AFVM-WS", "BR24L01AFVM-WSTR", "BR24L01AFVM-WTR", "BR24L01ANUX-WTR", "BR24L02FVJ-WE2", "BR24L02FVM-WGTR", "BR24L02FVM-WMTR", "BR24L02FVM-WSGTR", "BR24L02FVM-WSTR", "BR24L02FVM-WTR",
             "BR24L02NUX-WSGR", "BR24L02NUX-WSGTR", "BR24L02NUX-WSTR", "BR24L02NUX-WTR", "BR24L04FVJ-WE2", "BR24L04FVM-WSTR", "BR24L04FVM-WTR", "BR24L04NUX-W", "BR24L04NUX-WTR", "BR24L08FVJ-WE2",
             "BR24L08FVM-WMTR", "BR24L08FVM-WSTR", "BR24L08FVM-WTR", "BR24L08NUX-WTR", "BR24L16FVJ-WE2", "BR24L16FVM-WMBITR", "BR24L16FVM-WMTR", "BR24L16FVM-WTR", "BR24S08FVM-WTR", "BR24S08NUX-WSGTR",
             "BR24S08NUX-WSTR", "BR24S08NUX-WTR", "BR24S16FVJ-WE2", "BR24S16FVM-WMTR", "BR24S16FVM-WTR", "BR24S16NUX-W", "BR24S16NUX-WTR", "BR24S32FVM-WBJTR", "BR24S32FVM-WTR", "BR24S32NUX-WSTR",
             "BR24S32NUX-WTR", "BR24S64FVJ-WE2", "BR24S64FVM-0055TR", "BR24S64FVM-WTR", "BR24T01FVJ-W", "BR24T01FVJ-WE2", "BR24T01FVJ-WGE2", "BR24T01FVJ-WTR", "BR24T01FVM-W", "BR24T01FVM-WBZG",
             "BR24T01FVM-WBZGTR", "BR24T01FVM-WE2", "BR24T01FVM-WGTR", "BR24T01FVM-WTR", "BR24T01NUX-WGTR", "BR24T01NUX-WTR", "BR24T02FVJ-W", "BR24T02FVJ-WBZE2", "BR24T02FVJ-WE2", "BR24T02FVJ-WG",
             "BR24T02FVJ-WGE2", "BR24T02FVM-WBZGTR", "BR24T02FVM-WGTR", "BR24T02FVM-WMGTR", "BR24T02FVM-WMTR", "BR24T02FVM-WTR", "BR24T02FVM-WVP", "BR24T02NUX-3BBZTR", "BR24T02NUX-3BTR", "BR24T02NUX-WBZGTR",
             "BR24T02NUX-WBZTR", "BR24T02NUX-WGTR", "BR24T02NUX-WSGTR", "BR24T02NUX-WTR", "BR24T04FVJ-WE2", "BR24T04FVJ-WGE2", "BR24T04FVJ2-W", "BR24T04FVJ2-WE2", "BR24T04FVJ2-WG", "BR24T04FVJ2-WGE2",
             "BR24T04FVM-WGTR", "BR24T04FVM-WTR", "BR24T04FVM-WVP", "BR24T04NUX-WTR", "BR24T08FVJ-E2", "BR24T08FVJ-TR", "BR24T08FVJ-WE2", "BR24T08FVJ-WFX", "BR24T08FVJ-WGE2", "BR24T08FVM-WGTR",
             "BR24T08FVM-WMTR", "BR24T08FVM-WTR", "BR24T08NUX-WBZGTR", "BR24T08NUX-WBZTR", "BR24T08NUX-WGTR", "BR24T08NUX-WM", "BR24T08NUX-WMTR", "BR24T08NUX-WTR", "BR24T128FVJ-W", "BR24T128FVJ-WBZE2",
             "BR24T128FVJ-WE2", "BR24T128FVJ-WG", "BR24T128FVJ-WGE2", "BR24T128FVM-WGTR", "BR24T128FVM-WTR", "BR24T128FVM-WVP", "BR24T128NUX-WGTR", "BR24T128NUX-WSTR", "BR24T128NUX-WTR", "BR24T16FVJ-WBE2",
             "BR24T16FVJ-WBZE2", "BR24T16FVJ-WBZSE2", "BR24T16FVJ-WE2", "BR24T16FVJ-WGE2", "BR24T16FVM-WGTR", "BR24T16FVM-WMGTR", "BR24T16FVM-WMTR", "BR24T16FVM-WTR", "BR24T16NUX-WBZGTR", "BR24T16NUX-WBZSGTR",
             "BR24T16NUX-WBZTR", "BR24T16NUX-WGTR", "BR24T16NUX-WMGTR", "BR24T16NUX-WSGTR", "BR24T16NUX-WTR", "BR24T32FVJ-W", "BR24T32FVJ-WBZE2", "BR24T32FVJ-WE2", "BR24T32FVJ-WG", "BR24T32FVJ-WGE2",
             "BR24T32FVM-W06BTR", "BR24T32FVM-WGTR", "BR24T32FVM-WTR", "BR24T32FVM-WVP", "BR24T32NUX-WB04TR", "BR24T32NUX-WBZGTR", "BR24T32NUX-WBZSGTR", "BR24T32NUX-WGTR", "BR24T32NUX-WH03TR",
             "BR24T32NUX-WSGTR", "BR24T32NUX-WTR", "BR24T64FVJ-W", "BR24T64FVJ-WE2", "BR24T64FVJ-WFX", "BR24T64FVJ-WG", "BR24T64FVJ-WGE2", "BR24T64FVM-05EGTR", "BR24T64FVM-WFX", "BR24T64FVM-WGTR",
             "BR24T64FVM-WM", "BR24T64FVM-WMTR", "BR24T64FVM-WSTR", "BR24T64FVM-WTR", "BR24T64FVM-WVP", "BR24T64NUX-WBZTR", "BR24T64NUX-WGTR", "BR24T64NUX-WMGTR", "BR24T64NUX-WTR", "BR25G128FVM-3GTR",
             "BR25G128NUX-3TR", "BR25G320FVM-3G", "BR25G320FVM-3GTR", "BR25G320NUX-3TR", "BR25G640FVM-3GTR", "BR25G640NUX-3TR", "BR25H010FVM-2CGTR", "BR25H010FVM-2CTR", "BR25H020FVM-2CTR",
             "BR25H040FVM-2CTR", "BR25H080FVM-2CTR", "BR25H160FVM-2CTR", "BR25H320FVM-2CTR", "BR25H320FVM-TR", "BR25H640FVM-2ACTR", "BR25H640FVM-3ACTR", "BR25L010FVJ-WE2", "BR25L010FVJ-WG", "BR25L010FVJ-WGE2",
             "BR25L010FVM-W", "BR25L010FVM-WE2", "BR25L010FVM-WTR", "BR25L020FVJ-W", "BR25L020FVJ-WE2", "BR25L020FVM-W", "BR25L020FVM-WE2", "BR25L020FVM-WSE2", "BR25L020FVM-WSTR", "BR25L020FVM-WTR", "BR25L040FVJ-W",
             "BR25L040FVJ-WE2", "BR25L040FVJ-WG", "BR25L040FVJ-WGE2", "BR25L040FVM-W", "BR25L040FVM-WE2", "BR25L040FVM-WTR", "BR25S320FVJ-W", "BR25S320FVJ-WE2", "BR25S320FVJ-WG", "BR25S320FVJ-WGE2", "BR25S320FVM-TR",
             "BR25S320FVM-WTR", "BR25S320NUX-WTR", "BR25S640FVJ-W", "BR25S640FVJ-WE2", "BR25S640FVJ-WG", "BR25S640FVJ-WGE2", "BR25S640FVM-W", "BR25S640FVM-WM", "BR25S640FVM-WMTR", "BR25S640FVM-WTR",
             "BR25S840FVJ-WE2", "BR25S840FVM-WTR", "BR34E02NUX-3BZTR", "BR34E02NUX-3MTR", "BR34E02NUX-3TR", "BR34E02NUX-3VP", "BR34E02NUX-WSTR", "BR34E02NUX-WTR", "BR34E02NUX-WTTR", "BR35H160FVM-WC",
             "BR35H160FVM-WCTR", "BR35H160FVM-WCTTR", "BR35H160FVM-WHTR", "BR35H320FVM-WCTR", "BR35H320FVM-WHTR", "BR9010RFVM-WTR", "BR9016ARFVM-WFTR", "BR9016ARFVM-WTR", "BR9020RFVM-WTR", "BR9040RFVM-WTR",
             "BR9080ARFVM-WTR", "BR93A46RFVM-WMTR", "BR93A56RFVM-M", "BR93A56RFVM-MTR", "BR93A56RFVM-TR", "BR93A56RFVM-W", "BR93A56RFVM-WM", "BR93A56RFVM-WMTR", "BR93A56RFVM-WTR", "BR93A57RFVM-TR",
             "BR93A66RFVM-WMTR", "BR93A76RFVM-WMTR", "BR93C46-DS6TP", "BR93C46-WDS6TP", "BR93C56-DS6TP", "BR93C56-WDS6TP", "BR93C66-DS6TP", "BR93C66-WDS6TP", "BR93C86-DS6TP", "BR93G46FVJ-3AGTE2",
             "BR93G46FVJ-3BGTE2", "BR93G46FVJ-3GTE2", "BR93G46FVM-3AGTTR", "BR93G46FVM-3BGTTR", "BR93G46FVM-3GT", "BR93G46FVM-3GTTR", "BR93G46NUX-3ATTL", "BR93G46NUX-3ATTR", "BR93G46NUX-3BTTR",
             "BR93G46NUX-3TTR", "BR93G56FVJ-3AGTE2", "BR93G56FVJ-3BGTE2", "BR93G56FVJ-3GTE2", "BR93G56FVM-3AGTTR", "BR93G56FVM-3BGTTR", "BR93G56FVM-3GTTR", "BR93G56NUX-3ATTR", "BR93G56NUX-3BTTR", "BR93G56NUX-3TTR",
             "BR93G66FVJ-3AGTE2", "BR93G66FVJ-3BGTE2", "BR93G66FVJ-3GTE2", "BR93G66FVM-3AGTTR", "BR93G66FVM-3BGTTR", "BR93G66FVM-3GTTR", "BR93G66NUX-3ATTR", "BR93G66NUX-3BTTR", "BR93G66NUX-3TTR", "BR93G66RFVM-3AGT",
             "BR93G66RFVM-3AGTTR", "BR93G76FVJ-3AGTE2", "BR93G76FVJ-3BGTE2", "BR93G76FVJ-3GTE2", "BR93G76FVM-3AGTTR", "BR93G76FVM-3BGTTR", "BR93G76FVM-3GTTR", "BR93G76NUX-3ATTR", "BR93G76NUX-3BTTR",
             "BR93G76NUX-3TTR", "BR93G86FVJ-3AGTE2", "BR93G86FVJ-3BGTE2", "BR93G86FVJ-3GTE2", "BR93G86FVM-3AGTTR", "BR93G86FVM-3BGTTR", "BR93G86FVM-3GTTR", "BR93G86NUX-3ATTR", "BR93G86NUX-3BTTR",
             "BR93G86NUX-3TTR", "BR93H46RFVM-2CTR", "BR93H56RFVM-2CGTR", "BR93H56RFVM-2CTR", "BR93H66RFVM-2C-FX", "BR93H66RFVM-2C6TR", "BR93H66RFVM-2CTR", "BR93H66RFVM-WCFX", "BR93H66RFVM-WCTR",
             "BR93H76RFVM-2C6TR", "BR93H76RFVM-2CTR", "BR93H86RFVM-2CSTR", "BR93H86RFVM-2CTR", "BR93L46RFVJ-WE2", "BR93L46RFVM-WFTR", "BR93L46RFVM-WMTR", "BR93L46RFVM-WSTR", "BR93L46RFVM-WTR",
             "BR93L56RFVJ-WE2", "BR93L56RFVM-WSTR", "BR93L56RFVM-WTR", "BR93L66RFVJ-WE2", "BR93L66RFVM-W0003TR", "BR93L66RFVM-WMTR", "BR93L66RFVM-WSTR", "BR93L66RFVM-WTR", "BR93L76RFVJ-WE2",
             "BR93L76RFVM-WSTR", "BR93L76RFVM-WTR", "BR93L86RFVJ-E2", "BR93L86RFVM-W0029", "BR93L86RFVM-W0029TR", "BR93L86RFVM-W002A", "BR93L86RFVM-W002ATR", "BR93L86RFVM-W002B", "BR93L86RFVM-W002BTR",
             "BR93L86RFVM-W004C", "BR93L86RFVM-W004CTR", "BR93L86RFVM-W004D", "BR93L86RFVM-W004DTR", "BR93L86RFVM-W004E", "BR93L86RFVM-W004ETR", "BR93L86RFVM-W0050TR", "BR93L86RFVM-WMTR", "BR93L86RFVM-WTR",
             "BS007TG-FX", "BS6202TL-FX", "BS6202TL3-FX", "BS6202TL3A-FX", "BS6202TST-FX", "BS6202TST1-FX", "BS6202TST2-FX", "BS63000TST-FX", "BS6302TL-FX", "BS63065TL-FX", "BS63164TL-FX", "BS63165TST-FX",
             "BS63166TST-FX", "BU10101-OKE2", "BU10CJA2MNVX-C", "BU10JA2MNVX-CTL", "BU11JA2MNVX-CTL", "BU1206-01", "BU12101-08", "BU12101-0K-F", "BU12101-OK", "BU12102-0S-E2", "BU12102-0S-ZAE2",
             "BU12102-16-E2", "BU12102-16-ZAE2", "BU12104-0Z", "BU12104-OP", "BU12104-OZ", "BU12306-04", "BU12306-04-BZ", "BU12CJA2MNVX-C", "BU12JA2MNVX-CTL", "BU12UA3ASNVX-S1TL", "BU12UA3ASNVX-TL",
             "BU12UA3SNVX-S1TL", "BU12UA3SNVX-TL", "BU1424K", "BU1425AK", "BU1425AKV", "BU1425AKV-E2", "BU1425K", "BU1427K", "BU1550KV-E2", "BU1573KV", "BU1573KV-E2", "BU1573KV-ZA", "BU1573KV-ZAE2",
             "BU1574KU-E2", "BU1574KU-ZAE2", "BU1575KV-FX", "BU15CJA2MNVX-C", "BU15JA2MNVX-CTL", "BU15TA2WHFV-TR", "BU16006KV", "BU16006KV-E2", "BU16014KV", "BU16014KV-E2", "BU16024KV", "BU16024KV-E2",
             "BU16027KV", "BU16027KV-E2", "BU16027KV-S", "BU16027KV-SE2", "BU16027KV-SZA", "BU16028KV", "BU16028KV-E2", "BU16028KV-ZAE2", "BU16029KV", "BU16029KV-ZAE2", "BU16501KS2", "BU16501KS2-AU", "BU16501KS2-AUE2",
             "BU16501KS2-AURE2", "BU16501KS2-AUZE2", "BU16501KS2-E2", "BU16501KS2-FX", "BU16501ZKS2", "BU16501ZKS2-E2", "BU16505-0D", "BU17070AKV-E2", "BU17070AKV-ZAE2", "BU17070KV", "BU17070KV-E2", "BU17070KV-ZAE2",
             "BU17072AKV-E2", "BU17072AKV-ME2", "BU17072KV", "BU17072KV-E2", "BU17072KV1-FX", "BU17074KV-E2", "BU17074KV-RE2", "BU17101AKV-ME2", "BU17101KV-E2", "BU17101KV-M", "BU17101KV-ME2", "BU17101KV-MFX",
             "BU17102AKV-ME2", "BU17102KV-E2", "BU17102KV-ME2", "BU17102KV-MFX", "BU17R272-RGE2", "BU17RL82-RGE2", "BU17T272-RGE2", "BU17TL82-RGE2", "BU18JA2MNVX-CTL", "BU18TA2WHFV-TR", "BU18TD1SNVX-S1TL",
             "BU18TD2WNVX-F2TL", "BU18TD2WNVX-S", "BU18TD2WNVX-TL", "BU1920F-E2", "BU19501KV-E2", "BU19502KV-E2", "BU19502KV-SE2", "BU19502KV-SZAE2", "BU19502KV-ZAE2", "BU19503KV", "BU19503KV-E2",
             "BU19503KV-S", "BU19503KV-SE1", "BU19503KV-SE2", "BU19503KV-SZAE2", "BU19510KV", "BU19510KV-E2", "BU19510KV-FX", "BU19510KV-M", "BU19510KV-ME2", "BU19510KV-MFX", "BU19510KV-MPI",
             "BU19510KV-MPIE2", "BU1CJA2MNVX-CTL", "BU1S12S1FVM-MTR", "BU1S12S1FVM-TR", "BU21024FV-E2", "BU21024FV-ME2", "BU21050FS", "BU21050FS-E2", "BU21078FV", "BU21078FV-E", "BU21078FV-E2",
             "BU21180FS-E2", "BU21181FS-E2", "BU21182FS-E2", "BU2152FS", "BU2152FS-E2", "BU2152FS-RE2", "BU2280FV-E2", "BU2302F", "BU2302F-E2", "BU2305F-E2", "BU2358FV-E2", "BU2365FV-E2", "BU2365FV-ZAE2",
             "BU23TA2WHFV-TR", "BU2430-00-FX", "BU24393-3M", "BU24393-8Z", "BU24393-AM", "BU24590-8J", "BU24590-8P", "BU24590-8Y", "BU24590-9H", "BU24591-7B", "BU24591-7S", "BU24591-81", "BU24591-8L",
             "BU24593-8G", "BU2502FS-E2", "BU2502FS-ZAE2", "BU25507-03", "BU25507-03E2", "BU25CJA2MNVX-C", "BU25JA2MNVX-CTL", "BU25TA2WHFV-TR", "BU25TD2WNVX-F2TL", "BU2611AF-E2", "BU26156RFS-E2",
             "BU2624AF-E2", "BU26TA2WHFV-TR", "BU27TA2WHFV-TR", "BU28131KV-E2", "BU28131KV-ME2", "BU28131KV-MSJE2", "BU28132KV-ME2", "BU28132KV-MSJE2", "BU2874AFV-E2", "BU2878FS-E2", "BU28JA2MNVX-CTL",
             "BU28TA2WHFV-TR", "BU28TD1SNVX-S1TL", "BU28TD1SNVX-TL", "BU28TD2WNVX-F2", "BU28TD2WNVX-F2TL", "BU28TD2WNVX-S", "BU28TD2WNVX-TL", "BU29408KV-ME2", "BU29504KV", "BU29504KV-E2", "BU29505KV-M",
             "BU29507KV", "BU29507KV-E2", "BU29507KV-ZA", "BU29507KV-ZAE2", "BU29508KV", "BU29508KV-M", "BU29508KV-ME2", "BU29510KV", "BU29510KV-E2", "BU29512KV-E2", "BU29515KV-E2", "BU29JA2MNVX-CTL",
             "BU29JA2WNVX-CTL", "BU29TA2WHFV-TR", "BU2JJA2MNVX-C", "BU2JJA2MNVX-CTL", "BU2JTA2WHFV-TR", "BU2JTH5WNVX-TL", "BU3006FV", "BU3006FV-E2", "BU3047FV-E2", "BU3049FV-E2", "BU3052FV-E2", "BU3065FV",
             "BU3065FV-E2", "BU3065FV-ZAE2", "BU3069FV", "BU3069FV-E2", "BU3069FV-HVGTE2", "BU3069FV-TE2", "BU3071HFV-TR", "BU3072HFV-TR", "BU3073HFV-STR", "BU3076HFV-TR", "BU3081FV-E2", "BU3081FV-GE2",
             "BU3085FV-E2", "BU3086FV-E2", "BU3086FV-TE2", "BU3086FV-TZAE2", "BU30JA2MNVX", "BU30JA2MNVX-C", "BU30JA2MNVX-CTL", "BU30TA2WHFV-TR", "BU31TA2WHFV-TR", "BU32105EFV-ME2", "BU32107EFV-ME2",
             "BU32TA2WHFV-TR", "BU3372FVM", "BU3372FVM-TR", "BU33JA2MNVX-CTL", "BU33JA2MNVX-CTX", "BU33TA2WHFV-MTR", "BU33TA2WHFV-TR", "BU33TD1SNVX", "BU33TD1SNVX-S1", "BU33TD1SNVX-S1TL", "BU33TD1SNVX-TL",
             "BU33TD2WNVX-F2TL", "BU33TD2WNVX-S", "BU33TD2WNVX-TL", "BU33UA3SNVX-S1T", "BU33UA3SNVX-S1TL", "BU33UA3SNVX-TL", "BU34581-5G", "BU34581-6H", "BU3461-2D-E2", "BU3461-2D-FX", "BU3461-2G-E2",
             "BU3461-2G-FX", "BU3461-2H-E2", "BU3461-2H-FX", "BU34JA2MNVX-CTL", "BU34TA2WHFV-TR", "BU3668K", "BU3668K-E2", "BU37201NUX-TR", "BU38101-03-FX", "BU4209F-STR", "BU4209F-TR", "BU4209FVE-TR",
             "BU4210F-TR", "BU4210FVE-MTR", "BU4210FVE-STR", "BU4210FVE-TR", "BU4211F-TR", "BU4211FVE-TR", "BU4212F-TR", "BU4212FVE-TR", "BU4213F-TR", "BU4213FVE-TR", "BU4214F-TR", "BU4214FVE-TR",
             "BU4215F-GTR", "BU4215F-SGTR", "BU4215F-TR", "BU4215FVE-TR", "BU4216F-TR", "BU4216FVE-TR", "BU4217F-TR", "BU4217FVE-TR", "BU4218F-TR", "BU4218FVE-TR", "BU4219F-GTR", "BU4219F-STR", "BU4219F-TR",
             "BU4219FVE-TR", "BU4220F-TR", "BU4220FVE-GTR", "BU4220FVE-STR", "BU4220FVE-TR", "BU4221F-STR", "BU4221F-TR", "BU4221FVE-TR", "BU4222F-TR", "BU4222FVE-STR", "BU4222FVE-TR", "BU4223F-TR",
             "BU4223FVE-TR", "BU4224F-TR", "BU4224FVE-TR", "BU4225F-G", "BU4225F-GTR", "BU4225F-SGTR", "BU4225F-TR", "BU4225FVE-MTR", "BU4225FVE-TR", "BU4226F-STR", "BU4226F-TR", "BU4226FVE-TR", "BU4227F-GTR",
             "BU4227F-SGTR", "BU4227F-STR", "BU4227F-TR", "BU4227FVE-STR", "BU4227FVE-TR", "BU4228F-STR", "BU4228F-TR", "BU4228FVE-STR", "BU4228FVE-TR", "BU4229F-STR", "BU4229F-TR", "BU4229FVE-TR",
             "BU4229FVE-TTR", "BU4230F-SG", "BU4230F-SGTR", "BU4230F-STR", "BU4230F-TR", "BU4230FVE-TR", "BU4231F-TR", "BU4231FVE-TR", "BU4232F-TR", "BU4232FVE-TR", "BU4233F-TR", "BU4233FVE-TR", "BU4234F-STR",
             "BU4234FVE-TR", "BU4235F-STR", "BU4235F-TR", "BU4235FVE-TR", "BU4236F-TR", "BU4236FVE-TR", "BU4237F-TR", "BU4237FVE-TR", "BU4238F-TR", "BU4238FVE-TR", "BU4239F-TR", "BU4239FVE-TR", "BU4240F-TR",
             "BU4240FVE-TR", "BU4241F-TR", "BU4241FVE-TR", "BU4242F-STR", "BU4242F-TR", "BU4242FVE-TR", "BU4242FVE-TTR", "BU4243F-STR", "BU4243FVE-TR", "BU4244F-STR", "BU4244F-TR", "BU4244FVE-TR",
             "BU4245F-STR", "BU4245F-TR", "BU4245FVE-TR", "BU4246F-TR", "BU4246FVE-TR", "BU4247F-TR", "BU4247FVE-TR", "BU4248F-TR", "BU4248FVE-TR", "BU42N20F-MGTR", "BU4309F-TR", "BU4309FVE-TR", "BU4310F-TR",
             "BU4310FVE-TR", "BU4311F-TR", "BU4311FVE-TR", "BU4312F-TR", "BU4312FVE-TR", "BU4313F-TR", "BU4313FVE-TR", "BU4314F-STR", "BU4314F-TR", "BU4314FVE-TR", "BU4315F-TR", "BU4315FVE-TR", "BU4316F-TR",
             "BU4316FVE-TR", "BU4317F-TR", "BU4317FVE-TR", "BU4318F-TR", "BU4318FVE-TR", "BU4319F-TR", "BU4319FVE-TR", "BU4320F-TR", "BU4320FVE-TR", "BU4321F-TR", "BU4321FVE-TR", "BU4322F-TR", "BU4322FVE-TR",
             "BU4323F-TR", "BU4323FVE-TR", "BU4324F-TR", "BU4324FVE-TR", "BU4325F-GTR", "BU4325F-SGTR", "BU4325FVE-STR", "BU4326F-TR", "BU4326FVE", "BU4326FVE-E2", "BU4326FVE-TR", "BU4327F-STR", "BU4327F-TR",
             "BU4327FVE-TR", "BU4328F-TR", "BU4328FVE-TR", "BU4329F-TR", "BU4329FVE-TR", "BU4330-TR", "BU4330F-TR", "BU4330FVE-TR", "BU4331F-TR", "BU4331FVE-GTR", "BU4331FVE-TR", "BU4332F-TR", "BU4332FVE-TR",
             "BU4333F-TR", "BU4333FVE-TR", "BU4334FVE-TR", "BU4335F-TR", "BU4335FVE-TR", "BU4336FVE-TR", "BU4337F-TR", "BU4338F-TR", "BU4338FVE-TR", "BU4339F-TR", "BU4339FVE-TR", "BU4340F-TR", "BU4340FVE-TR",
             "BU4341F-TR", "BU4341FVE", "BU4341FVE-TR", "BU4342F-TR", "BU4342FVE-TR", "BU4343FVE-TR", "BU4344F-TR", "BU4344FVE-TR", "BU4345F-TR", "BU4345FVE-TR", "BU4346F-TR", "BU4346FVE-TR", "BU4347F-TR", "BU4347FVE-TR",
             "BU4348FVE-TR", "BU4809F-TR", "BU4809FVE-RTR", "BU4809FVE-TR", "BU4810F-STR", "BU4810F-TR", "BU4810FVE-TR", "BU4811F-TR", "BU4811FVE-TR", "BU4812F-STR", "BU4812F-TR", "BU4812FVE-TR", "BU4813F-TR",
             "BU4813FVE-TR", "BU4814F-TR", "BU4814FVE-TR", "BU4815F-STR", "BU4815F-TR", "BU4815FVE-TR", "BU4816F-TR", "BU4816FVE-TR", "BU4817F-TR", "BU4817FVE-TR", "BU4818F-STR", "BU4818F-TR", "BU4818FVE-TR",
             "BU4819F-TR", "BU4819FVE-TR", "BU4820F-STR", "BU4820F-TR", "BU4820FVE-TR", "BU4821F-TR", "BU4821FVE-TR", "BU4822F-STR", "BU4822F-TR", "BU4822FVE-TR", "BU4823F-GTR", "BU4823F-STR", "BU4823F-TR",
             "BU4823FVE-TR", "BU4824F-STR", "BU4824F-TR", "BU4824FVE-TR", "BU4825F-STR", "BU4825F-TR", "BU4825FVE-TR", "BU4826F-STR", "BU4826F-TR", "BU4826FVE", "BU4826FVE-E2", "BU4826FVE-TR", "BU4826TG1-TR",
             "BU4826TG3-E2", "BU4826TG5-E2", "BU4826TG5-TR", "BU4827F-STR", "BU4827F-TR", "BU4827FVE-TR", "BU4828F-STR", "BU4828F-TR", "BU4828FVE-TR", "BU4829F-STR", "BU4829F-TR", "BU4829FVE-STR",
             "BU4829FVE-TR", "BU4830F-STR", "BU4830F-TR", "BU4830FVE-STR", "BU4830FVE-TR", "BU4831F-TR", "BU4831FVE-TR", "BU4832F-STR", "BU4832F-TR", "BU4832FVE-TR", "BU4833F-STR", "BU4833F-TR",
             "BU4833FVE-STR", "BU4833FVE-TR", "BU4834F-TR", "BU4834FVE-TR", "BU4835F-STR", "BU4835F-TR", "BU4835FVE-TR", "BU4836F-STR", "BU4836F-TR", "BU4836FVE-TR", "BU4837F-STR", "BU4837FVE-TR",
             "BU4838F-TR", "BU4838FVE-TR", "BU4839F-TR", "BU4839FVE-TR", "BU4840F-S", "BU4840F-STR", "BU4840F-TR", "BU4840FVE-TR", "BU4841F-TR", "BU4841FVE-TR", "BU4842F-STR", "BU4842F-TR", "BU4842FVE-TR",
             "BU4843F-STR", "BU4843F-TR", "BU4843FVE-TR", "BU4844F-TR", "BU4844FVE-TR", "BU4845F-TR", "BU4845FVE-TR", "BU4846F-TR", "BU4846FVE-TR", "BU4847F-TR", "BU4848F-TR", "BU4848FVE-TR", "BU4909F-TR",
             "BU4909FVE-TR", "BU4910F-STR", "BU4910F-TR", "BU4910FVE-TR", "BU4911F-TR", "BU4911FVE-TR", "BU4912F-TR", "BU4912FVE-TR", "BU4913F-TR", "BU4913FVE-TR", "BU4914F-TR", "BU4914FVE-TR", "BU4915F-TR",
             "BU4915FVE-TR", "BU4916F-TR", "BU4916FVE-TR", "BU4917F-TR", "BU4917FVE-TR", "BU4918F-STR", "BU4918F-TR", "BU4918FVE-TR", "BU4919F-TR", "BU4919FVE-TR", "BU4920F-TR", "BU4920FVE-GTR",
             "BU4920FVE-SGTR", "BU4920FVE-TR", "BU4921F-TR", "BU4921FVE-TR", "BU4922F-TR", "BU4922FVE-TR", "BU4923F-TR", "BU4923FVE-TR", "BU4924F-STR", "BU4924F-TR", "BU4924FVE-TR", "BU4925F-TR",
             "BU4925FVE-TR", "BU4926F-TR", "BU4926FVE-TR", "BU4927F-TR", "BU4927FVE-TR", "BU4928F-TR", "BU4928FVE-TR", "BU4929F-TR", "BU4929FVE-TR", "BU4930F-TR", "BU4930FVE-TR", "BU4931F-TR", "BU4931FVE-TR",
             "BU4932F-TR", "BU4932FVE-TR", "BU4933F-TR", "BU4933FVE-TR", "BU4934F-TR", "BU4934FVE-TR", "BU4935F - TR","BU4935FVE- TR","BU4936F- TR","BU4936FVE- TR","BU4937F- TR","BU4937FVE- TR","BU4938F- TR",
             "BU4938FVE-TR", "BU4939F-TR", "BU4939FVE-TR", "BU4940F-TR", "BU4940FVE-TR", "BU4941FVE-TR", "BU4942F-TR", "BU4942FVE-TR", "BU4943F-TR", "BU4943FVE-TR", "BU4944F-STR", "BU4944F-TR", "BU4944FVE-TR",
             "BU4945F-TR", "BU4945FVE-TR", "BU4946F-TR", "BU4946FVE-TR", "BU4947F-TR", "BU4947FVE-TR", "BU4948F-TR", "BU52011HFV-STR", "BU52011HFV-TR", "BU52012HFV-TR", "BU52012NVX-STR", "BU52012NVX-TR",
             "BU52013HFV-TR", "BU52014HFV-GTR", "BU52014HFV-TR", "BU52016HFV-TR", "BU52017HFV-GTR", "BU52017HFV-TR", "BU52018HFV-GTR", "BU52018HFV-S", "BU52018HFV-SGTR", "BU52018HFV-STR", "BU52018HFV-TR",
             "BU52019HFV-GTR", "BU52019HFV-SGTR", "BU52019HFV-TR", "BU52021HFV-TR", "BU52031NVX-S1TR", "BU52031NVX-STR", "BU52031NVX-TR", "BU52033NVX-TR", "BU52040HFV-STR", "BU52040HFV-TR", "BU52051NVX-TR",
             "BU52053NVX-STR", "BU52053NVX-TR", "BU52056NVX-TR", "BU52061NVX-STR", "BU52061NVX-TR", "BU52271NUZ-ZE2", "BU52272NUZ-ZA", "BU52272NUZ-ZAE2", "BU52272NUZ-ZATR", "BU52272NUZ-ZE2",
             "BU52273NUZ-ZE2", "BU52274NUZ-ZE2", "BU52422NUZ-ZE2", "BU52472NUZ-ZE2", "BU52492NUZ-ZE2", "BU52493NUZ-ZE2", "BU52494NUZ-ZE2", "BU5255HFV-STR", "BU5255HFV-TR", "BU5255SHFV-TR", "BU5265HFV-TR",
             "BU5265SHFV-TR", "BU52740HFV-TR", "BU55041HFN-S", "BU55041HFN-STR", "BU55041HFN-TR", "BU5999FS", "BU6065FV", "BU6124AFS", "BU6124AFS-E2", "BU6124AFS-ZAE2", "BU6132F-E1", "BU6132F-E2",
             "BU6341FV-E2", "BU6370AK-E2", "BU6370K-E2", "BU6375FV-E2", "BU64293TG-FX", "BU6456FUV", "BU6456FUV-E2", "BU6460FS-E2", "BU6460FS-ZAE2BU6484K", "BU6500AK", "BU6520KV-E2", "BU6521KV", "BU6521KV-E2",
             "BU6521KV-ME2", "BU6575FV-E2", "BU6577FV", "BU6577FV-E2", "BU6590AKU-A", "BU66B02WNWX-S1TL", "BU66B02WNWX-TL", "BU66B04WNWX-S1", "BU66B04WNWX-S1TL", "BU66B06WNWX-S1E2", "BU66B06WNWX-S1TL",
             "BU66B07WNWX-S1TL", "BU66B08WNWX-S1TL", "BU66B09WNWX-S1TL", "BU66B12WNWX-S1TL", "BU66B13WNWX-S1TL", "BU66B14WNWX-S1TL", "BU66B14WNWX-TL", "BU66B15WNWX-S1TL", "BU67B02WNWX-S1E2",
             "BU67B07WNWX-S1E2", "BU67B08WNWX-E2", "BU67B08WNWX-S1E2", "BU67B10WNWX-S1E2", "BU67B11WNWX-E2", "BU67B11WNWX-S1E2", "BU67B12WNWX-S1E2", "BU67B13WNWX-S1E2", "BU67B14WNWX-S1E2",
             "BU67B17WNWX-S1E2", "BU6903TL-FX", "BU6922KV", "BU6922KV-E2", "BU6922KV-ZAE2", "BU6929AFV-E2", "BU6929FV-E2", "BU6930FV", "BU6930FV-E2", "BU6934-01-E2", "BU6934-03", "BU6934-03-E2", "BU6934-03E2",
             "BU6939FV-E2", "BU6940FV-E2", "BU6945K", "BU6945K-E2", "BU6945K-ZAE2", "BU6949FV-E2", "BU6952-02-E2", "BU6952-02E2", "BU6952-03-E2", "BU6952-04-E2", "BU6952-04-ZAE2", "BU6952-16-E2",
             "BU6952-16-ZAE2", "BU6954-00", "BU6954-00-E2", "BU6954-02-E2", "BU6954-02-ZAE2", "BU6954-15-E2", "BU6954-15-ZAE2", "BU70110TL-FX", "BU7122KV", "BU7122KV-E2", "BU7122KV-ZAE2", "BU7205HFV",
             "BU7205HFV-TR", "BU7205SHFV-TR", "BU7232FVM-TR", "BU7232SFVM-TR", "BU7232YFVM-CTR", "BU7242FVM-GTR", "BU7242FVM-TR", "BU7242SFVM-TR", "BU7242YFVM-CGTR", "BU72432KV-E2", "BU72432KV-ZAE2",
             "BU72435AKV", "BU72435AKV-E2", "BU72435AKV-FX", "BU72435AKV-ZAE2", "BU72435KV", "BU72435KV-E2", "BU72435KV-ZAE2", "BU72436AKV-E2", "BU72436AKV-FX", "BU72436AKV-ZAE2", "BU72436KV", "BU72436KV-E2",
             "BU72436KV-ZAE2", "BU72437KV", "BU72437KV-E2", "BU72437KV-ZAE2", "BU72441KV", "BU72441KV-E2", "BU7245HFV-TR", "BU7245SHFV-TR", "BU7252FVM-STR", "BU7252SFVM-TR", "BU7255HFV-TR", "BU7255SHFV-TR",
             "BU7262FVM-GTR", "BU7262FVM-STR", "BU7262FVM-TR", "BU7262SFVM-MTR", "BU7262SFVM-TR", "BU7266FVM-TR", "BU7266SFVM-TR", "BU7275HFV-TR", "BU7275SHFV-TR", "BU7295HFV-STR", "BU7295HFV-TR",
             "BU7295SHFV-TR", "BU7321HFV-TR", "BU7322HFV-TR", "BU7325HFV-TR", "BU7328HFV-TR", "BU7345HFV-TR", "BU7442FVM-STR", "BU7442FVM-TR", "BU7442SFVM-TR", "BU7445HFV-STR", "BU7445HFV-TR",
             "BU7445SHFV-TR", "BU7462FVM-STR", "BU7462FVM-TR", "BU7462SFVM-TR", "BU7465HFV-STR", "BU7465HFV-TR", "BU7465SHFV-TR", "BU7475HFV-TR", "BU7475SHFV-TR", "BU7486FVM-FX", "BU7486FVM-TR",
             "BU7486FVMTR", "BU7486SFVM-TR", "BU7495HFV-GTR", "BU7495HFV-STR", "BU7495HFV-TR", "BU7495SHFV-TR", "BU7680G-STR", "BU7680G-TR", "BU7681G-TR", "BU7826FV", "BU7826FV-E2", "BU78435KV",
             "BU78435KV-E2", "BU78436KV", "BU78436KV-E2", "BU78437KV-E2", "BU78441KV", "BU78441KV-E2", "BU7848FV", "BU7848FV-E2", "BU8140EFV-E2", "BU81438JKV", "BU81438JKV-E2", "BU8143JKV",
             "BU8143JKV-E2", "BU81459KV", "BU81459KV-E2", "BU81459KV-ZAE2", "BU8166EKV-ME2", "BU8241F", "BU8241F-E2", "BU8241FS-E2", "BU8241FS-FX", "BU8241FS-ZAE2", "BU8242F", "BU8242F-E2",
             "BU8242F-FX", "BU8298KV", "BU8298KV-E2", "BU8298KV-ZAE2", "BU8307CF-E2", "BU8307CF-FX", "BU8307CS", "BU8307CS-FX", "BU8310AK", "BU8310AK-FX", "BU8315F-E2", "BU8332KV-ME2", "BU8364KV-HV",
             "BU8364KV-HVE2", "BU8622KV", "BU8622KV-E2", "BU8622KV-ME2", "BU8622KV-MLLE2", "BU8622KV-ZAE2", "BU8626TG-FX", "BU8626TGB-FX", "BU8630HFN-TR", "BU8720KS", "BU8732AKV", "BU87500KV-E2",
             "BU87500KV-ZAE2", "BU8848FV", "BU8848FV-E2", "BU8849FV", "BU8849FV-E2", "BU8849FV-ZAE2", "BU90RT102", "BU90RT102-E2", "BU90RT102-RZE2", "BU90RT102-ZE2", "BU91501KV-E2", "BU91501KV-ME2",
             "BU9150KV-ME2", "BU91510KV-M", "BU91510KV-ME2", "BU91600FUV-ME2", "BU91600FV-ME2", "BU91796FS-ME2", "BU91797FUV-ME2", "BU91799KV-ME2", "BU9214AFVM-TR", "BU9241FS-E2", "BU9253AS", "BU9262AFS",
             "BU9262AFS-E2", "BU92747KV-E2", "BU92R101-ME2", "BU92RT82-ME2", "BU92RT82A-ME2", "BU92RTF82-ME2", "BU92T101-ME2", "BU9369FVM-TR", "BU9408KS2", "BU9408KS2-E2", "BU9408KS2-ZA", "BU9408KS2-ZAE2",
             "BU9409FV", "BU9409FV-E2", "BU9411FV-E2", "BU9412FV-E2", "BU9414FV-E2", "BU9415KV", "BU9415KV-E2", "BU9415KV-ME2", "BU9415KV-MLLE2", "BU9415KV-ZAE2", "BU9416DSN-FX", "BU9418TST-FX",
             "BU9428JKV-E2", "BU9428JKV-ZAE2", "BU9428KV", "BU9428KV-E2", "BU9435KV", "BU9435KV-E2", "BU9435KV-ZAE2", "BU9436JKV", "BU9436JKV-E2", "BU9436KV-E2", "BU9437AJKV", "BU9437AJKV-E2",
             "BU9437AKV-E2", "BU9437JKV", "BU9437JKV-E2", "BU9438KV", "BU9438KV-E2", "BU9439AKV", "BU9439AKV-E2", "BU9439AKV-ZAE2", "BU9439KV", "BU9439KV-E2", "BU9445EKV-E2", "BU94501AKS-E2", "BU94501AKS2",
             "BU94501AKS2-E2", "BU94501AKS2-SE2", "BU94501ZKS-E2", "BU94501ZKS2", "BU94501ZKS2-E2", "BU94501ZKS2-SE2", "BU94502AKS2", "BU94502AKS2-E2", "BU94502AKS2-SE2", "BU94502AKS3", "BU94502AKS3-E2",
             "BU94502CKS2-E2", "BU94502ZKS2-E2", "BU94502ZKS2-SE2", "BU9450KV", "BU9450KV-D", "BU9450KV-DE2", "BU9450KV-E2", "BU9451KV", "BU9451KV-E2", "BU9451KV-ZAE2", "BU9457KV-E2", "BU9457KV-ZA",
             "BU9457KV-ZAE2", "BU9458AKV-E2", "BU9458AKV-ZAE2", "BU9458KV", "BU9458KV-E2", "BU9458KV-ZAE2", "BU9459KV", "BU9459KV-E2", "BU9459KV-ZAE2", "BU94601KV", "BU94601KV-E2", "BU94601KV-FX",
             "BU94601KV-ZAE2", "BU94601RKV-ZAE2", "BU94603KV-E2", "BU94603KV-FX", "BU94603KV-SE2", "BU94603KV-SZAE2", "BU94603KV-ZAE2", "BU94603RKV-E2", "BU94603RKV-ZE2", "BU94604AKV-E2", "BU94604BKV-E2",
             "BU94604BKV-FX", "BU94604BKV-ZAE2", "BU94604BRKV-E2", "BU94604BRKV-ZAE2", "BU94604KV-E2", "BU9480F", "BU9486KV-E2", "BU9489AK", "BU9489AKV", "BU9489AKV-E2", "BU9489BKV", "BU9489BKV-E2","BA25BC0WFP-E2",
             "BU9489CKV", "BU9489CKV-E2", "BU9489KV", "BU9489KV-E2", "BU9489KV-ME2", "BU9528KS", "BU9532KS2", "BU9532KS2-ZA", "BU9536KS2-F", "BU9536KS2-FE2", "BU9536KS2-FZA", "BU9536KS2-FZAE2",
             "BU9536KS2-ZAE2", "BU9543KV", "BU9543KV-E2", "BU9543KV-S", "BU9543KV-SDGE2", "BU9543KV-SE2", "BU9543KV-SZAE2", "BU9543KV-ZA", "BU9543KV-ZAE2", "BU9545KS2", "BU9545KS2-E2", "BU9545KS2-ZE2",
             "BU9546KV", "BU9546KV-D", "BU9546KV-DGE2", "BU9546KV-E2", "BU9547KV", "BU9547KV-E2", "BU9547KV-ZA", "BU9547KV-ZAE2", "BU9587KV", "BU9587KV-E2", "BU9587KV-ZAE2", "BU9716BKV", "BU9716BKV-BZ",
             "BU9716BKV-BZE2", "BU9716BKV-E2", "BU9718KV", "BU97199KV", "BU97199KV-E2", "BU9728AKV", "BU9728AKV-E2", "BU9729K", "BU9729K-BZ", "BU9729K-E2", "BU9735K", "BU9735K-BZE2", "BU9735K-E2",
             "BU9735K-FE2", "BU9735K-ME2", "BU9735K-ZAE2", "BU97500KV-BJE2", "BU97500KV-BJZAE2", "BU97500KV-BZAE2", "BU97500KV-BZE2", "BU97500KV-E2", "BU97500KV-NE2", "BU97500KV-ZAE2", "BU97501KV-E2",
             "BU97501KV-ME2", "BU97510AKV-E2", "BU97510AKV-ME2", "BU97510BKV-E2", "BU97510CDSN-E2", "BU97510CDSN-ME2", "BU97510CKV-E2", "BU97510CKV-ME2", "BU97510KV-E2", "BU97510KV-ME2", "BU97600FUV-ME2",
             "BU97600FV-ME2", "BU97601FV-ME2", "BU9768AK-E2", "BU9768AKV", "BU9768AKV-ZA", "BU9768AKV-ZA1", "BU9768AKV-ZAE2", "BU9791AKV", "BU9792ADSN-E2", "BU9792AFUV-BZE2", "BU9792AFUV-BZZAE2",
             "BU9792AFUV-DZZAE2", "BU9792AFUV-E2", "BU9792AFUV-FX", "BU9792AFUV-SE2", "BU9792BFUV-E2", "BU9792BFUV-ZE2", "BU9792FUV", "BU9792FUV-E2", "BU9792FUV-SE2", "BU97931FV-BZE2", "BU97931FV-E2",
             "BU97931FV-LBE2", "BU9793AFS-E2", "BU9793FS-E2", "BU97941FV-E2", "BU97941FV-FX", "BU97941FV-LBE2", "BU97941FV-SE2", "BU9794AKV", "BU9794AKV-BZE2", "BU9794AKV-E2", "BU9794AKV-NE2",
             "BU9794AKV-ZAE2", "BU9794KV", "BU9794KV-E2", "BU9794KV-SE2", "BU9794KV-ZAE2", "BU97950AFUV-E2", "BU97950FUV-BZ", "BU97950FUV-BZA", "BU97950FUV-BZE2", "BU97950FUV-BZZE2", "BU97950FUV-E2",
             "BU97950FUV-FX", "BU97950FUV-ZAE2", "BU97950KS2", "BU9795AFV", "BU9795AFV-E2", "BU9795AFV-LBE2", "BU9795AFV-ME2", "BU9795AKS2", "BU9795AKS2-E2", "BU9795AKV", "BU9795AKV-BZE2", "BU9795AKV-BZZE2",
             "BU9795AKV-E2", "BU9795AKV-ME2", "BU9795AKV-Z", "BU9795AKV-ZAE2", "BU9795AKV-ZE2", "BU9795BKV-E2", "BU9795KV-E2", "BU9795ZKS2", "BU9795ZKS2-E2", "BU9796AFS-E2", "BU9796AFS-ME2", "BU9796FS",
             "BU9796FS-E2", "BU9797AFUV-E2", "BU9797FUV-E2", "BU9797FUV-ME2", "BU97981KV-BZE2", "BU97981KV-E2", "BU97981KV-NE2", "BU97981KV-ZAE2", "BU9798KV", "BU9798KV-BZE2", "BU9798KV-BZZE2",
             "BU9798KV-ZAE2", "BU9798KV-ZE2", "BU9799KV-BZE2", "BU9799KV-E2", "BU9799KV-NE2", "BU9799KV-ZAE2", "BU9828KS", "BU9828KS-E2", "BU9831F-E2", "BU9838HFN-WTR", "BU9852FVM-WTR", "BU9869W-02-TR",
             "BU9870FV-W", "BU9870FV-WE2", "BU9870FV-WZAE2", "BU9871FV-WC", "BU9871FV-WCE2", "BU9871FV-WCZA", "BU9871FV-WCZAE2", "BU9873FVM-GTTR", "BU9873FVM-TR", "BU9873NUX-TTR", "BU9929FV-E2",
             "BU99415FVM-WFX", "BU99415FVM-WTR", "BU9949FS-E2", "BU9955EKV-E2", "BU9955EKV-SE2", "BUL08-1FVJ-WE2", "BUL08-1FVJ-WGE2", "BUL081-FVJ-WE2", "BUL081-FVJ-WGE2", "BUL081-FVJ-WGTR", "BUL081-FVJ-WTR",
             "BV1LB010FPJ-CE1", "BV1LB010FPJ-E1", "BV1LB028FPJ-CE1", "BV1LB045FPJ-CE1", "BV1LB090HFS-CTR", "BV1LB090HFS-FX", "BV1LB090HFS-LBTR", "BV1LB150HFS-CTR", "BV1LB300HFS-CTR", "BV2HC045EFU-CE2", "BV2HD045EFU-CE2",
             "BV2HD045EFV- CE2","CXA8087Q", "CXD3742R-DE2", "CXD3742R-E2", "CXD8087Q", "CXD8087Q-E2", "CXD8525N-E2", "CXD8525N-FX", "CXD8525N-ZAE2", "CXD9572N-E2", "CXD9848AN-E2",
             "DDA016-GE2", "DDA016-GFX", "DDA016DSN-GFX", "DIA001-LBE2", "DIA002-LBE2", "FF1130", "FF1130-E2", "FF1132-E2", "FF1152", "FF1152-E2",
             "HL940", "HL940-BZE2", "HL940-E2", "HL940-ZAE2", "HL941", "HL941-E2", "HL941-FE2", "HL941-FZAE2", "HM938-E2", "HM938A-E2", "HTSSOP-A44", "ICALS5070-FX", "JCM5056-E2", "JCY0177-FX", "JCY0207", "K7F62",
             "LGBD9219FV", "LGBD9219FV-BZE2", "LGBD9219FV-E2", "LM2903DGKR", "LM2903DGKR-BZ", "LM2903DGKR-E2", "LM2903DGKR-TR", "LM2903FVJ-E2", "LM2903FVM-TR", "LM2904DGKR", "LM2904DGKR-BZ", "LM2904FVJ",
             "LM2904FVM-E2", "LM2904FVM-GTR", "LM2904KR", "LM2904KR-TR", "LM2904ST", "LM2904ST-S", "LM358DGKR", "LM358FVJ-E2", "LM358FVJ-GE2", "LM358FVJ-GTR", "LM358FVM-E2", "LM358FVM-GTR", "LM358ST",
             "LM358ST-BZ", "LM393DGKR", "LM393FVJ-E2", "LM393FVM-TR", "LM393ST-S", "LM4559FVJ-GE2", "LM4559FVM-GTR", "LM4565FVJ-GE2", "LM4565FVM-GTR", "LM932FVM-TR", "LMR1801HFV-LBTR", "LMR342FVJ-GE2",
             "LMR342FVM-GTR", "LMR358FVJ-E2", "LMR358FVJ-GE2", "LMR822FVJ-GE2", "LMR822FVJ-GTR", "LMR822FVM-GTR", "LMR932FVJ-E2", "LMR932FVJ-GE2", "LMR932FVM-GTR", "LMR982FVM-TR", "LMV358FVJ-E2", "LS3004AL-TR",
             "LS3004AU-TR", "LS4230F01-TR", "LS4230F03-TR", "LSI3528HFZ-GTR", "LSI62011A-FX", "LSI62011B-E2", "LSI62011C-E2", "LSI62011D-E2", "LSI62012E-E2", "LSI62012F-E2", "LSI62012G-FX", "LSI62012H-E2",
             "LSI62014I-FX", "LSI62014J-FX", "LSI6209AFZ-E2", "LSI6384EFZ-E2", "LSI6967FVZ-TR", "LSI6981FVZ-G", "LSI6981FVZ-GTR", "LSI7763EFV-E2", "LSI82024FVJ-E2", "LSI82024FVJ-FX", "LSI82034FVZ-GE2",
             "LSI82042FVZ-GE2", "LSI82044FVZ-GE2", "LSI8219EFZ-E2", "LSI9397EFV-GE2", "LSI9415FS-GE2", "LSI9685EFV-E2",
             "MRT015A-ME2", "NBC3901MA-E2", "NBC9902-A", "NBC9902-AE2", "NBC9902-E2", "NBC9902-F", "NBC9902-F  E2", "NBC9902-FE2", "NBC9902-FZAE2", "NBC9903A-E2", "NBC9905-E2", "NCL039B", "NCL039B-E2", "NCL053J", "NCL053J-E2",
             "NCL062-E2", "NCL070M", "NCL071-E2", "NCL093B", "NCL093B-E2", "NTP3001-E2", "NTP3103-E2", "NTP3103B-E2", "NTP3104-E2", "NTP3105-E2", "NTP3105A-E2", "NTP3105B-E2", "NTP3106-E2", "NTP3301A-E2", 
             "TD40A - FX", "TD40A- ME2", "TF261RM- E2", "TF459RM- E2", "TF459RM- ZAE2", "TF565RF", "TF565RF- E2", "TF565RF- ZAE2", "TF586RF", "TF586RF- E2", "TLR342FVJ- GE2", "TM1030- C", "TR81E1- E2", "TR81E1- GE2", "TR81E1- GFX", "TR81R1- GE2", "TW6407F- E2", "VQFP64",
             "PA9007A", "PDA4050", "PDA4050-ZA", "PK18IC0DSN-GTR", "PK3320M22", "PK3320M23", "PK3320M24", "PK3320M25", "PK6966FVM-GFX", "PK7824FVM-FTR", "PK8012H1-FX", "PK8012P7-FX", "PK8012P8-FX", "PK8012S2-FX", "PK8012S3-FX",
             "PK8012S4-FX", "PK82066E1-FX", "PK82066E2-FX", "PK82066H2-FX", "PK82066H3-FX", "PK82066H4-FX", "PK82066J1-FX", "PK82066J2-FX", "PK82066J3-FX", "PK82066R1-FX", "PK82066R2-FX", "PK82066R3-FX", "PK82066S1-FX",
             "PK82066S2-FX", "PK82066S3-FX", "PK9397EFV-GE2", "PK93A86AFVM-FX", "PK93A86EFVM-FX", "PK9422EFV-E2", "PK9555FVMA-TR", "PK9555FVMB-TR", "PK9555FVMC-TR", "PKBBD3932FP-E2", "PKBD013-FX", "PKBD7979EFV-FX",
             "PKBDXA1T050-FX", "PKBDXA3T050-FX", "PKBDXA3T100-FX", "PKBDXA4T050-FX", "PKBDXA4T100-FX", "PKBDXA5T050-FX", "PKBDXA5T100-FX", "PKBU46090-FX", "PKCBD3932FP-E2", "PKG3320KV1-E2", "PKG3320KV2-E2", "PKG3320KV3-E2",
             "PKG3320KV4-E2", "PKG3320KV5-E2", "PKG3320KV6-E2", "PKHTB20PD-FX", "PKHTB40PD-FX", "PKHTB54PD-FX", "PKHTSSOPA44-E2", "PKHTSSOPA44-FX", "PKHVSOF5PD-TR", "PKHVSOF6PD-TR", "PKSOP4PD-TR", "PKVSOF5PD-TR",
             "PL36FPS-FX", "PL7789RFS1-E2", "PL7789RFS3-E2", "PL9276EFV-GE2", "PLBD9018KV1-FX", "PM9012A-E2", "PM9013A", "PM9013A-E2", "PM9013A-FX", "PM9014A-E2", "PM9014A-FX", "PM9014A-ME2", "PM9015A-ME2", "PRS492NX-ME2", 
             "QC00CC0WFP", "QC00CC0WFP-E2", "QC00DD0WHFP-TR", "QC05CC0DSN-E2", "QC05CC0FP-E2", "QC1603FVC-TR", "QC1620FVC-TR", "QC1690FVC", "QC1690FVC-S1TR", "QC1730FVC-TR", "QC3005HFP-TR", "QC3565HFP-TR", "QC3565HFPC-TR",
             "QC3565HFPC2-TR", "QC3575HFP-TR", "QC3930FP-E2", "QC3931HFP-TR", "QC6761FS-E2", "QC7810HFP-TR", "QC9781HFPC-TR", 
             "RS10002", "RS10002-E2", "RS10003", "RS10003-E2", "RS2006EFV", "RS2006EFV-BZE2", "RS2006EFV-E2", "S003694-E2", "S0036941-E2", "SD709A-E2", "SD709C-E2", "SH5023-E2", "SH5023-ZAE2", "SK3002-BZE2", "SK3002-E2", "SLC5014R-E2", "SPS10RA-E2", 
             "W001 - C", "W001- CE2", "W001- CX", "W001- CXE2", "W001D- E2", "W001X", "W001YTG- E2", "W001ZTG- E2", "W003- CE2", "W004- CE2", "W2RF002- RE2", "W2RF002F- R", "W2RF002RF- RE2", "W2RF002RFA- RE2", "W2RF002RFB - RE2",
             "W2RF002RFC-RE2", "W2RF004RM-BZRE2", "W2RF004RM-RE2", "WAL88-E2", "WAL888-E2", "WD60901-E2", "WD60901-FX", "WD60901-ZAE2", "WL6601-E2", "YLD335-RFX", "YLD335DSN-FX"];
        /*initiate the autocomplete function on the "myInput" element, and pass along the countries array as possible autocomplete values:*/
        autocomplete(document.getElementById("myInput"), countries);
        </script>

</body>
</html>
