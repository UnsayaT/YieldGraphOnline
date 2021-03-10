﻿Imports System.Data.SqlClient
Imports System.IO
Imports System.Configuration
Imports System.Web.UI.DataVisualization.Charting
Imports System.Web.Services
Imports iTextSharp.text
Imports iTextSharp.text.pdf

Public Class CT_FTGraph
    Inherits System.Web.UI.Page
    Dim objConn1 As SqlConnection
    Dim objCmd As SqlCommand
    Dim strSQL, StrSQLDevice, strDevice, strSQLDate As String
    Dim dtAdapter, dtDevice, dtAdapterDate As SqlDataAdapter
    Dim dt1, dt2, dtDate As New DataTable
    Dim Data, DeviceName, SheetNo, Auto, FTBNo As String
    Dim i As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim strConnString As String
        strConnString = "Server=172.16.0.102; Uid=System; PASSWORD=p@$$w0rd; database=DBX;"
        objConn1 = New SqlConnection(strConnString)
        objConn1.Open()

        If Not Page.IsPostBack Then
            TableForm()
        End If
    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        'System.Threading.Thread.Sleep(100000)
        Session("DeviceName") = Request.Form("DeviceName")
        If DropDownList1.Text = "AUTO0" Then
            Session("Auto") = "AUTO0"
        ElseIf DropDownList1.Text = "AUTO1" Then
            Session("Auto") = "AUTO1"
        ElseIf DropDownList1.Text = "AUTO2" Then
            Session("Auto") = "AUTO2"
        ElseIf DropDownList1.Text = "AUTO3" Then
            Session("Auto") = "AUTO3"
        ElseIf DropDownList1.Text = "AUTO4" Then
            Session("Auto") = "AUTO4"
        ElseIf DropDownList1.Text = "AUTO5" Then
            Session("Auto") = "AUTO5"
        End If

        If DropDownList2.Text = "FTB-1" Then
            Session("FTBNo") = "FTB-1"
        ElseIf DropDownList2.Text = "FTB-2" Then
            Session("FTBNo") = "FTB-2"
        ElseIf DropDownList2.Text = "FTB-3" Then
            Session("FTBNo") = "FTB-3"
        ElseIf DropDownList2.Text = "FTB-4" Then
            Session("FTBNo") = "FTB-4"
        ElseIf DropDownList2.Text = "FTB-5" Then
            Session("FTBNo") = "FTB-5"
        ElseIf DropDownList2.Text = "FTB-6" Then
            Session("FTBNo") = "FTB-6"
        ElseIf DropDownList2.Text = "FTB-7" Then
            Session("FTBNo") = "FTB-7"
        ElseIf DropDownList2.Text = "FTB-8" Then
            Session("FTBNo") = "FTB-8"
        ElseIf DropDownList2.Text = "FTB-9" Then
            Session("FTBNo") = "FTB-9"
        ElseIf DropDownList2.Text = "FTB-10" Then
            Session("FTBNo") = "FTB-10"
        ElseIf DropDownList2.Text = "FTB-11" Then
            Session("FTBNo") = "FTB-11"
        ElseIf DropDownList2.Text = "FTB-12" Then
            Session("FTBNo") = "FTB-12"
        ElseIf DropDownList2.Text = "FTB-13" Then
            Session("FTBNo") = "FTB-13"
        ElseIf DropDownList2.Text = "FTB-14" Then
            Session("FTBNo") = "FTB-14"
        ElseIf DropDownList2.Text = "FTB-15" Then
            Session("FTBNo") = "FTB-15"
        ElseIf DropDownList2.Text = "FTB-16" Then
            Session("FTBNo") = "FTB-16"
        ElseIf DropDownList2.Text = "FTB-17" Then
            Session("FTBNo") = "FTB-17"
        ElseIf DropDownList2.Text = "FTB-18" Then
            Session("FTBNo") = "FTB-18"
        ElseIf DropDownList2.Text = "FTB-19" Then
            Session("FTBNo") = "FTB-19"
        ElseIf DropDownList2.Text = "FTB-20" Then
            Session("FTBNo") = "FTB-20"
        ElseIf DropDownList2.Text = "FTB-21" Then
            Session("FTBNo") = "FTB-21"
        ElseIf DropDownList2.Text = "FTB-22" Then
            Session("FTBNo") = "FTB-22"
        ElseIf DropDownList2.Text = "FTB-23" Then
            Session("FTBNo") = "FTB-23"
        ElseIf DropDownList2.Text = "FTB-24" Then
            Session("FTBNo") = "FTB-24"
        ElseIf DropDownList2.Text = "FTB-25" Then
            Session("FTBNo") = "FTB-25"
        ElseIf DropDownList2.Text = "FTB-26" Then
            Session("FTBNo") = "FTB-26"
        ElseIf DropDownList2.Text = "FTB-27" Then
            Session("FTBNo") = "FTB-27"
        ElseIf DropDownList2.Text = "FTB-28" Then
            Session("FTBNo") = "FTB-28"
        ElseIf DropDownList2.Text = "FTB-29" Then
            Session("FTBNo") = "FTB-29"
        ElseIf DropDownList2.Text = "FTB-30" Then
            Session("FTBNo") = "FTB-30"
        ElseIf DropDownList2.Text = "FTB-31" Then
            Session("FTBNo") = "FTB-31"
        ElseIf DropDownList2.Text = "FTB-32" Then
            Session("FTBNo") = "FTB-32"
        ElseIf DropDownList2.Text = "FTB-33" Then
            Session("FTBNo") = "FTB-33"
        ElseIf DropDownList2.Text = "FTB-34" Then
            Session("FTBNo") = "FTB-34"
        ElseIf DropDownList2.Text = "FTB-35" Then
            Session("FTBNo") = "FTB-35"
        ElseIf DropDownList2.Text = "FTB-36" Then
            Session("FTBNo") = "FTB-36"
        ElseIf DropDownList2.Text = "FTB-37" Then
            Session("FTBNo") = "FTB-37"
        ElseIf DropDownList2.Text = "FTB-38" Then
            Session("FTBNo") = "FTB-38"
        ElseIf DropDownList2.Text = "FTB-39" Then
            Session("FTBNo") = "FTB-39"
        ElseIf DropDownList2.Text = "FTB-43" Then
            Session("FTBNo") = "FTB-43"
        ElseIf DropDownList2.Text = "FTB-46" Then
            Session("FTBNo") = "FTB-46"
        ElseIf DropDownList2.Text = "OSB-1" Then
            Session("FTBNo") = "OSB-1"
        ElseIf DropDownList2.Text = "OSB-2" Then
            Session("FTBNo") = "OSB-2"
        End If
        TableForm()

    End Sub

    Sub TableForm()
        If Session("DeviceName") <> "" And Session("Auto") <> "" And Session("FTBNo") <> "" Then
            Dim time As DateTime = DateTime.Now
            Dim format As String = "yyyy-MM-dd"

            Dim time1 As DateTime = DateTime.Now
            Dim format1 As String = "yyyy-MM-dd"
            Dim Now1 As String = (time.ToString(format1) & " 07:00:00")

            'หาวันที่เริ่มต้นในการค้นหา
            strSQLDate = "SELECT UpdateTime,LastUpdateTime,DATEDIFF(m, LastUpdateTime, UpdateTime) AS CountMonthFT ,PackageName,DeviceName,UCL,AVE,LCL,FT_Flow_Name,BoxFTB,StatusLCL From [DBx].[dbo].[Cal_LCL] WHERE  DeviceName = '" & Session("DeviceName") & "' and FT_Flow_Name = '" & Session("Auto") & "' "
            dtAdapterDate = New SqlDataAdapter(strSQLDate, objConn1)
            dtAdapterDate.Fill(dtDate)
            If dtDate.Rows.Count > 0 Then
                If dtDate.Rows(i)("LastUpdateTime").ToString() = "" Then
                    Session("DateLast") = Now1
                Else
                    Session("DateLast") = dtDate.Rows(i)("LastUpdateTime").ToString()
                End If

                Session("Date") = dtDate.Rows(i)("UpdateTime").ToString()
                Session("Count") = dtDate.Rows(i)("CountMonthFT").ToString()
                Session("StatusLCL") = dtDate.Rows(i)("StatusLCL").ToString()
            End If

            If Session("StatusLCL") = "AUTO UPDATE" Then
                strSQL = "SELECT Top(30) Convert(Varchar,LotEndTime,121) AS LotEndTime,Test1.DeviceName,Test2.Device,Test1.LotNo,Test1.Package,Test1.MCNo,Test1.YLD,Test2.LCL,UCL=100,AVE,FT_Flow_Name,BoxFTB
                        FROM(Select  CASE WHEN InitialYield = 0 THEN 0 ELSE InitialYield END AS YLD,FTData.LotNo,MCNo,ETC1 As DeviceName,Package,LotEndTime
		                FROM [DBx].[dbo].[TransactionData] INNER JOIN [DBx].[dbo].[FTData] ON TransactionData.LotNo=[DBx].[dbo].[FTData].LotNo  WHERE  dbo.FTData.LotJudgement <> 'SampleJudge' And ETC1='" & Session("DeviceName") & "' And TestFlowName ='" & Session("Auto") & "' And LotEndTime Between  '" & Session("Date") & "' And '" & time & "' And (ChannelATestBoxNo = '" & Session("FTBNo") & "' Or ChannelBTestBoxNo= '" & Session("FTBNo") & "'))As Test1

                        INNER JOIN 

                        (Select DeviceName As Device,LCL,AVE,FT_Flow_Name,BoxFTB
                        From [DBx].[dbo].[Cal_LCL]) As Test2 on Test1.DeviceName = Test2.Device
                        where Test2.Device = '" & Session("DeviceName") & "' And FT_Flow_Name = '" & Session("Auto") & "'  order by LotEndTime ASC "
                dtAdapter = New SqlDataAdapter(strSQL, objConn1)
                dtAdapter.Fill(dt1)
            Else
                'FIX
                strSQL = "SELECT Top(30) Convert(Varchar,LotEndTime,121) AS LotEndTime,Test1.DeviceName,Test2.Device,Test1.LotNo,Test1.Package,Test1.MCNo,Test1.YLD,Test2.LCL,UCL=100,AVE,FT_Flow_Name,BoxFTB
                        FROM(Select  CASE WHEN InitialYield = 0 THEN 0 ELSE InitialYield END AS YLD,FTData.LotNo,MCNo,ETC1 As DeviceName,Package,LotEndTime
		                FROM [DBx].[dbo].[TransactionData] INNER JOIN [DBx].[dbo].[FTData] ON TransactionData.LotNo=[DBx].[dbo].[FTData].LotNo  WHERE  dbo.FTData.LotJudgement <> 'SampleJudge' And ETC1='" & Session("DeviceName") & "' And TestFlowName ='" & Session("Auto") & "' And LotEndTime <= '" & Now1 & "' And (ChannelATestBoxNo = '" & Session("FTBNo") & "' Or ChannelBTestBoxNo= '" & Session("FTBNo") & "'))As Test1

                        INNER JOIN 

                        (Select DeviceName As Device,LCL,AVE,FT_Flow_Name,BoxFTB
                        From [DBx].[dbo].[Cal_LCL]) As Test2 on Test1.DeviceName = Test2.Device
                        where Test2.Device = '" & Session("DeviceName") & "' And FT_Flow_Name = '" & Session("Auto") & "'  order by LotEndTime ASC "
                dtAdapter = New SqlDataAdapter(strSQL, objConn1)
                dtAdapter.Fill(dt1)
            End If

            DeviceName = Session("DeviceName")


            If dt1.Rows.Count > 0 Then
                Me.Chart1.DataSource = dt1
                Me.Chart1.Series("Series1").ChartType = SeriesChartType.Line
                Me.Chart1.Series("Series2").ChartType = SeriesChartType.Spline
                Me.Chart1.Series("Series3").ChartType = SeriesChartType.Spline
                Me.Chart1.Series("Series4").ChartType = SeriesChartType.Spline
                Me.Chart1.Series("Series1")("DrawingStyle") = "Emboss"
                Me.Chart1.Series("Series2")("DrawingStyle") = "Emboss"
                Me.Chart1.Series("Series3")("DrawingStyle") = "Emboss"
                Me.Chart1.Series("Series4")("DrawingStyle") = "Emboss"
                Me.Chart1.Series("Series1").XValueMember = "LotNo"
                Me.Chart1.Series("Series2").YValueMembers = "UCL"
                Me.Chart1.Series("Series3").YValueMembers = "LCL"
                Me.Chart1.Series("Series1").YValueMembers = "YLD"
                Me.Chart1.Series("Series1").IsValueShownAsLabel = True
                Me.Chart1.Series("Series2").IsValueShownAsLabel = False
                Me.Chart1.Series("Series3").IsValueShownAsLabel = False
                Me.Chart1.Series("Series4").IsValueShownAsLabel = False

                Me.Chart1.DataBind()

                Me.Label1.Text = dt1.Rows(i)("Package").ToString()
                Me.Label2.Text = dt1.Rows(i)("DeviceName").ToString()
                Me.Label3.Text = dt1.Rows(i)("UCL").ToString()
                Me.Label4.Text = dt1.Rows(i)("AVE").ToString()
                Me.Label5.Text = dt1.Rows(i)("LCL").ToString()
                Me.Label6.Text = dt1.Rows(i)("FT_Flow_Name").ToString()
                Me.Label7.Text = dt1.Rows(i)("BoxFTB").ToString()
            Else
                Me.Label1.Text = dtDate.Rows(i)("PackageName").ToString()
                Me.Label2.Text = dtDate.Rows(i)("DeviceName").ToString()
                Me.Label3.Text = dtDate.Rows(i)("UCL").ToString()
                Me.Label4.Text = dtDate.Rows(i)("AVE").ToString()
                Me.Label5.Text = dtDate.Rows(i)("LCL").ToString()
                Me.Label6.Text = dtDate.Rows(i)("FT_Flow_Name").ToString()
                Me.Label7.Text = dtDate.Rows(i)("BoxFTB").ToString()

                Page.RegisterClientScriptBlock("OnLoad", "<script>alert('ไม่พบข้อมูลการผลิตของ Device นี้')</script>")
            End If

            If Session("StatusLCL") = "AUTO UPDATE" Then
                Dim strSQL1 As String
                strSQL1 = "SELECT Top(30) Convert(Varchar,LotEndTime,121) AS LotEndTime ,Test1.LotNo,Test1.YLD,Test1.MCNo,ProgramName,OPNo,GLCheck,FT_Flow_Name
                        FROM( Select ETC1 As DeviceName,FTData.LotNo,MCNo, Package,ProgramName,LotEndTime,OPNo,GLCheck,CASE WHEN InitialYield = 0 THEN 0 WHEN InitialYield IS NULL THEN '' ELSE InitialYield END AS YLD
	                          FROM [DBx].[dbo].[TransactionData] INNER JOIN [DBx].[dbo].[FTData] ON TransactionData.LotNo=[DBx].[dbo].[FTData].LotNo WHERE ETC1='" & Session("DeviceName") & "' And TestFlowName ='" & Session("Auto") & "' And LotEndTime Between  '" & Session("Date") & "' And '" & time & "' And (ChannelATestBoxNo = '" & Session("FTBNo") & "' Or ChannelBTestBoxNo= '" & Session("FTBNo") & "'))As Test1
                        INNER JOIN 
                        (Select DeviceName As Device,LCL,FT_Flow_Name From [DBx].[dbo].[Cal_LCL]) As Test2 
                        on Test1.DeviceName = Test2.Device
                        where Test2.Device = '" & Session("DeviceName") & "' And FT_Flow_Name = '" & Session("Auto") & "'  order by LotEndTime ASC"

                Dim dtReader As SqlDataReader
                objCmd = New SqlCommand(strSQL1, objConn1)
                dtReader = objCmd.ExecuteReader()

                '*** BindData to GridView ***'
                GridView1.DataSource = dtReader
                GridView1.DataBind()

                dtReader.Close()
                dtReader = Nothing
            Else
                'FIX
                Dim strSQL1 As String
                strSQL1 = "SELECT Top(30) Convert(Varchar,LotEndTime,121) AS LotEndTime ,Test1.LotNo,Test1.YLD,Test1.MCNo,ProgramName,OPNo,GLCheck,FT_Flow_Name
                        FROM( Select ETC1 As DeviceName,FTData.LotNo,MCNo, Package,ProgramName,LotEndTime,OPNo,GLCheck,CASE WHEN InitialYield = 0 THEN 0 WHEN InitialYield IS NULL THEN '' ELSE InitialYield END AS YLD
	                          FROM [DBx].[dbo].[TransactionData] INNER JOIN [DBx].[dbo].[FTData] ON TransactionData.LotNo=[DBx].[dbo].[FTData].LotNo WHERE ETC1='" & Session("DeviceName") & "' And TestFlowName ='" & Session("Auto") & "' And LotEndTime <= '" & Now1 & "' And (ChannelATestBoxNo = '" & Session("FTBNo") & "' Or ChannelBTestBoxNo= '" & Session("FTBNo") & "'))As Test1
                        INNER JOIN 
                        (Select DeviceName As Device,LCL,FT_Flow_Name From [DBx].[dbo].[Cal_LCL]) As Test2 
                        on Test1.DeviceName = Test2.Device
                        where Test2.Device = '" & Session("DeviceName") & "' And FT_Flow_Name = '" & Session("Auto") & "'  order by LotEndTime ASC"

                Dim dtReader As SqlDataReader
                objCmd = New SqlCommand(strSQL1, objConn1)
                dtReader = objCmd.ExecuteReader()

                '*** BindData to GridView ***'
                GridView1.DataSource = dtReader
                GridView1.DataBind()

                dtReader.Close()
                dtReader = Nothing
            End If
        Else
            Page.RegisterClientScriptBlock("OnLoad", "<script>alert('Please Select DeviceName Or Auto')</script>")
        End If
    End Sub

    Protected Sub GridView1_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        '*** Date ***'
        Dim lblDate As Label = CType(e.Row.FindControl("lblDate"), Label)
        If Not IsNothing(lblDate) Then
            lblDate.Text = e.Row.DataItem("LotEndTime")
        End If

        '*** YLD ***'
        Dim lblYLD As Label = CType(e.Row.FindControl("lblInYield"), Label)
        If Not IsNothing(lblYLD) Then
            lblYLD.Text = e.Row.DataItem("YLD")
        End If

        '*** LotNo ***'
        Dim lblLotNo As Label = CType(e.Row.FindControl("lblLotNo"), Label)
        If Not IsNothing(lblLotNo) Then
            lblLotNo.Text = e.Row.DataItem("LotNo")
        End If

        '*** M/C ***'
        Dim lblMc As Label = CType(e.Row.FindControl("lblMc"), Label)
        If Not IsNothing(lblMc) Then
            lblMc.Text = e.Row.DataItem("MCNo")
        End If

        '*** Program Ver ***'
        Dim lblProgramVer As Label = CType(e.Row.FindControl("lblProgramVer"), Label)
        If Not IsNothing(lblProgramVer) Then
            lblProgramVer.Text = e.Row.DataItem("ProgramName")
        End If

        '*** OP ***'
        Dim lblOP As Label = CType(e.Row.FindControl("lblOP"), Label)
        If Not IsNothing(lblOP) Then
            lblOP.Text = e.Row.DataItem("OPNo")
        End If

        '*** GL ***'
        Dim lblGL As Label = CType(e.Row.FindControl("lblGL"), Label)
        If Not IsNothing(lblGL) Then
            lblGL.Text = e.Row.DataItem("GLCheck").ToString()
        End If
    End Sub

    Protected Sub ImgBtnCheckSheet_Click(sender As Object, e As ImageClickEventArgs) Handles ImgBtnCheckSheet.Click
        Dim oldFile As String = "//10.28.33.113/www/TestYieldGraphControl/File/FTYieldgraph.pdf"
        Dim newFile As String = "//10.28.33.113/www/TestYieldGraphControl/File/FTYieldgraphData.pdf"
        Dim imagePath As String = "//10.28.33.113/www/TestYieldGraphControl/Img"
        Dim gif As iTextSharp.text.Image
        Dim time As DateTime = DateTime.Now
        Dim strSQL2 As String
        Dim dtAdapterTran As SqlDataAdapter
        Dim dt, dtpro, dtNo, dtEmp, dtLot, dtTran, dtFT, dtFL, dtMAP, dtlots, dtGL As New DataTable
        Dim i, a, b, c, d As Integer
        Dim time1 As DateTime = DateTime.Now
        Dim format1 As String = "yyyy-MM-dd"
        Dim Now1 As String = (time.ToString(format1) & " 07:00:00")


        If Session("StatusLCL") = "AUTO UPDATE" Then
            strSQL2 = "SELECT Top(30) Convert(Varchar(5),LotEndTime,110) AS LotEndTime,
                        Test1.LotNo,
                        Test1.YLD,
                        Test1.MCNo,
                        ProgramName,
                        LCL,
                        UCL,
                        AVE,
                        LastUCL,
                        LastAVE,
                        LastLCL,
                        CASE WHEN GLCheck IS NULL THEN '' ELSE (Select GL_No From [DBx].[dbo].[QYIOP_GL] WHERE OP_No=OPNo) END AS GLCheck,
                        OPNo,
                        Package,
                        DeviceName,
                        LEN(ProgramName) As LENProgrm,
                        Convert(Varchar(10),UpdateTime,110) AS Thaitime,
                        Convert(Varchar(10),LastUpdateTime,110) AS LastTime,
                        FT_Flow_Name
                        FROM( 
                                Select  ETC1 As DeviceName,FTData.LotNo,MCNo, Package,ProgramName,LotEndTime,OPNo,
                                CASE WHEN GLCheck IS NULL THEN '' ELSE GLCheck END AS GLCheck,
                                CASE WHEN InitialYield = 0 THEN 0 WHEN InitialYield IS NULL THEN '' ELSE InitialYield END AS YLD
                                FROM [DBx].[dbo].[TransactionData] INNER JOIN [DBx].[dbo].[FTData] ON TransactionData.LotNo=[DBx].[dbo].[FTData].LotNo WHERE ETC1='" & Session("DeviceName") & "' And LotEndTime Between  '" & Session("Date") & "' And '" & time & "' 
                                And (ChannelATestBoxNo = '" & Session("FTBNo") & "' Or ChannelBTestBoxNo= '" & Session("FTBNo") & "')
                            )As Test1

                        INNER JOIN 

                        (Select DeviceName As Device,LCL,UpdateTime,UCL,AVE,LastUCL,LastAVE,LastLCL,LastUpdateTime,FT_Flow_Name,BoxFTB
                        From [DBx].[dbo].[Cal_LCL]) As Test2 on Test1.DeviceName = Test2.Device
                        where Test2.Device = '" & Me.Label2.Text & "' And FT_Flow_Name = '" & Me.Label6.Text & "' "
            dtAdapterTran = New SqlDataAdapter(strSQL2, objConn1)
            dtAdapterTran.Fill(dtTran)
        Else
            strSQL2 = "SELECT Top(30) Convert(Varchar(5),LotEndTime,110) AS LotEndTime,
                    Test1.LotNo,
                    Test1.YLD,
                    Test1.MCNo,
                    ProgramName,
                    LCL,
                    UCL,
                    AVE,
                    LastUCL,
                    LastAVE,
                    LastLCL,
                    CASE WHEN GLCheck IS NULL THEN '' ELSE (Select GL_No From [DBx].[dbo].[QYIOP_GL] WHERE OP_No=OPNo) END AS GLCheck,
                    OPNo,
                    Package,
                    DeviceName,
                    LEN(ProgramName) As LENProgrm,
                    Convert(Varchar(10),UpdateTime,110) AS Thaitime,
                    Convert(Varchar(10),LastUpdateTime,110) AS LastTime,
                    FT_Flow_Name
                    FROM( 
                            Select  ETC1 As DeviceName,FTData.LotNo,MCNo, Package,ProgramName,LotEndTime,OPNo,
                            CASE WHEN GLCheck IS NULL THEN '' ELSE GLCheck END AS GLCheck,
                            CASE WHEN InitialYield = 0 THEN 0 WHEN InitialYield IS NULL THEN '' ELSE InitialYield END AS YLD
                            FROM [DBx].[dbo].[TransactionData] INNER JOIN [DBx].[dbo].[FTData] ON TransactionData.LotNo=[DBx].[dbo].[FTData].LotNo WHERE ETC1='" & Session("DeviceName") & "' And LotEndTime <= '" & Now1 & "'
                            And (ChannelATestBoxNo = '" & Session("FTBNo") & "' Or ChannelBTestBoxNo= '" & Session("FTBNo") & "')
                        )As Test1

                    INNER JOIN 

                    (Select DeviceName As Device,LCL,UpdateTime,UCL,AVE,LastUCL,LastAVE,LastLCL,LastUpdateTime,FT_Flow_Name,BoxFTB
                    From [DBx].[dbo].[Cal_LCL]) As Test2 on Test1.DeviceName = Test2.Device
                    where Test2.Device = '" & Me.Label2.Text & "' And FT_Flow_Name = '" & Me.Label6.Text & "' "
            dtAdapterTran = New SqlDataAdapter(strSQL2, objConn1)
            dtAdapterTran.Fill(dtTran)
        End If

        ' Create reader
        Dim reader As New PdfReader(oldFile)
        Dim size As Rectangle = reader.GetPageSizeWithRotation(1)
        Dim document As New Document(size)

        ' Create the writer
        Dim fs As New FileStream(newFile, FileMode.Create, FileAccess.Write)
        Dim writer As PdfWriter = PdfWriter.GetInstance(document, fs)
        document.Open()
        Dim cb As PdfContentByte = writer.DirectContent
        Dim cb1 As PdfContentByte = writer.DirectContent


        ' Set the font, color and size properties for writing text to the PDF
        Dim bf As BaseFont = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED)
        cb.SetColorFill(BaseColor.DARK_GRAY)
        cb.SetFontAndSize(bf, 4)

        gif = iTextSharp.text.Image.GetInstance(imagePath + "/icon.png")

        For i = 0 To dtTran.Rows.Count - 1
            'AVE
            cb.BeginText()
            If IsDBNull(dtTran.Rows(i)("AVE")) Then

            Else
                cb.EndText()
                cb.SetLineWidth(1)
                If dtTran.Rows(i)("AVE") >= "100" Then
                    cb.MoveTo(139, 526)
                    cb.LineTo(820, 526)
                ElseIf dtTran.Rows(i)("AVE") >= "99.9" Then
                    cb.MoveTo(139, 518)
                    cb.LineTo(820, 518)
                ElseIf dtTran.Rows(i)("AVE") >= "99.8" Then
                    cb.MoveTo(139, 506)
                    cb.LineTo(820, 506)
                ElseIf dtTran.Rows(i)("AVE") >= "99.7" Then
                    cb.MoveTo(139, 494)
                    cb.LineTo(820, 494)
                ElseIf dtTran.Rows(i)("AVE") >= "99.6" Then
                    cb.MoveTo(139, 485)
                    cb.LineTo(820, 485)
                ElseIf dtTran.Rows(i)("AVE") >= "99.5" Then
                    cb.MoveTo(139, 475)
                    cb.LineTo(820, 475)
                ElseIf dtTran.Rows(i)("AVE") >= "99.4" Then
                    cb.MoveTo(139, 468)
                    cb.LineTo(820, 468)
                ElseIf dtTran.Rows(i)("AVE") >= "99.3" Then
                    cb.MoveTo(139, 456)
                    cb.LineTo(820, 456)
                ElseIf dtTran.Rows(i)("AVE") >= "99.2" Then
                    cb.MoveTo(139, 444)
                    cb.LineTo(820, 444)
                ElseIf dtTran.Rows(i)("AVE") >= "99.1" Then
                    cb.MoveTo(139, 432)
                    cb.LineTo(820, 432)
                ElseIf dtTran.Rows(i)("AVE") >= "99.0" Then
                    cb.MoveTo(139, 420)
                    cb.LineTo(820, 420)
                ElseIf dtTran.Rows(i)("AVE") >= "98.9" Then
                    cb.MoveTo(139, 408)
                    cb.LineTo(820, 408)
                ElseIf dtTran.Rows(i)("AVE") >= "98.8" Then
                    cb.MoveTo(139, 396)
                    cb.LineTo(820, 396)
                ElseIf dtTran.Rows(i)("AVE") >= "97.0" Then
                    cb.MoveTo(139, 384)
                    cb.LineTo(820, 384)
                End If

                cb.SetColorStroke(GrayColor.BLUE)
                cb.Stroke()
                cb.BeginText()
            End If

            'UCL
            cb.EndText()
            cb.SetLineWidth(1)
            cb.MoveTo(168, 530)
            cb.LineTo(820, 530)
            cb.SetColorStroke(GrayColor.RED)
            cb.Stroke()
            cb.BeginText()

            'LCL
            cb.EndText()
            cb.SetLineWidth(1)

            If dtTran.Rows(i)("LCL") >= "100" Then
                cb.MoveTo(168, 530)
                cb.LineTo(820, 530)
            ElseIf dtTran.Rows(i)("LCL") >= "99.9" Then
                cb.MoveTo(168, 518)
                cb.LineTo(820, 518)
            ElseIf dtTran.Rows(i)("LCL") >= "99.8" Then
                cb.MoveTo(168, 506)
                cb.LineTo(820, 506)
            ElseIf dtTran.Rows(i)("LCL") >= "99.7" Then
                cb.MoveTo(168, 494)
                cb.LineTo(820, 494)
            ElseIf dtTran.Rows(i)("LCL") >= "99.6" Then
                cb.MoveTo(168, 485)
                cb.LineTo(820, 485)
            ElseIf dtTran.Rows(i)("LCL") >= "99.5" Then
                cb.MoveTo(168, 475)
                cb.LineTo(820, 475)
            ElseIf dtTran.Rows(i)("LCL") >= "99.4" Then
                cb.MoveTo(168, 468)
                cb.LineTo(820, 468)
            ElseIf dtTran.Rows(i)("LCL") >= "99.3" Then
                cb.MoveTo(168, 456)
                cb.LineTo(820, 456)
            ElseIf dtTran.Rows(i)("LCL") >= "99.2" Then
                cb.MoveTo(168, 444)
                cb.LineTo(820, 444)
            ElseIf dtTran.Rows(i)("LCL") >= "99.1" Then
                cb.MoveTo(168, 432)
                cb.LineTo(820, 432)
            ElseIf dtTran.Rows(i)("LCL") >= "99.0" Then
                cb.MoveTo(168, 420)
                cb.LineTo(820, 420)
            ElseIf dtTran.Rows(i)("LCL") >= "98.9" Then
                cb.MoveTo(168, 408)
                cb.LineTo(820, 408)
            ElseIf dtTran.Rows(i)("LCL") >= "98.8" Then
                cb.MoveTo(168, 418)
                cb.LineTo(820, 418)
            ElseIf dtTran.Rows(i)("LCL") >= "97.0" Then
                cb.MoveTo(168, 400)
                cb.LineTo(820, 400)
            End If

            cb.SetColorStroke(GrayColor.RED)
            cb.Stroke()
            cb.BeginText()

            If i = 0 Then
                a = 176
                b = 176
                c = 137
                d = 155
            ElseIf i = 1 Then
                a = 195
                b = 195
                c = 155
                d = 173
            ElseIf i = 2 Then
                a = 215
                b = 215
                c = 173
                d = 190
            ElseIf i = 3 Then
                a = 234
                b = 234
                c = 190
                d = 208
            ElseIf i = 4 Then
                a = 253
                b = 253
                c = 208
                d = 225
            ElseIf i = 5 Then
                a = 272
                b = 272
                c = 225
                d = 243
            ElseIf i = 6 Then
                a = 290
                b = 290
                c = 243
                d = 261
            ElseIf i = 7 Then
                a = 310
                b = 310
                c = 261
                d = 278
            ElseIf i = 8 Then
                a = 330
                b = 330
                c = 278
                d = 296
            ElseIf i = 9 Then
                a = 348
                b = 348
                c = 296
                d = 313
            ElseIf i = 10 Then
                a = 367
                b = 367
                c = 313
                d = 331
            ElseIf i = 11 Then
                a = 388
                b = 388
                c = 331
                d = 349
            ElseIf i = 12 Then
                a = 407
                b = 407
                c = 349
                d = 366
            ElseIf i = 13 Then
                a = 425
                b = 425
                c = 366
                d = 384
            ElseIf i = 14 Then
                a = 445
                b = 445
                c = 384
                d = 402
            ElseIf i = 15 Then
                a = 463
                b = 463
                c = 402
                d = 419
            ElseIf i = 16 Then
                a = 483
                b = 483
                c = 419
                d = 437
            ElseIf i = 17 Then
                a = 502
                b = 502
                c = 437
                d = 454
            ElseIf i = 18 Then
                a = 520
                b = 520
                c = 454
                d = 472
            ElseIf i = 19 Then
                a = 539
                b = 539
                c = 472
                d = 490
            ElseIf i = 20 Then
                a = 559
                b = 559
                c = 490
                d = 508
            ElseIf i = 21 Then
                a = 567
                b = 567
                c = 508
                d = 526
            ElseIf i = 22 Then
                a = 579
                b = 579
                c = 526
                d = 544
            ElseIf i = 23 Then
                a = 599
                b = 599
                c = 544
                d = 561
            ElseIf i = 24 Then
                a = 619
                b = 619
                c = 561
                d = 579
            ElseIf i = 25 Then
                a = 638
                b = 638
                c = 579
                d = 596
            ElseIf i = 26 Then
                a = 657
                b = 657
                c = 596
                d = 613
            ElseIf i = 27 Then
                a = 676
                b = 676
                c = 613
                d = 630
            ElseIf i = 28 Then
                a = 695
                b = 695
                c = 630
                d = 647
            ElseIf i = 29 Then
                a = 715
                b = 715
                c = 647
                d = 664
            End If

            'YLDGraph
            cb.EndText()
            gif.ScaleToFit(5, 5) 'ขนาดรูป
            If dtTran.Rows(i)("YLD") >= "100" Then
                '100
                gif.SetAbsolutePosition(a, 516) 'ตำแหน่ง
                cb.AddImage(gif)
            ElseIf dtTran.Rows(i)("YLD") >= "99.9" And dtTran.Rows(i)("YLD") < "100" Then
                '99.9
                gif.SetAbsolutePosition(a, 512) 'ตำแหน่ง
                cb.AddImage(gif)
            ElseIf dtTran.Rows(i)("YLD") >= "99.8" And dtTran.Rows(i)("YLD") < "99.9" Then
                '99.8
                gif.SetAbsolutePosition(a, 508) 'ตำแหน่ง
                cb.AddImage(gif)
            ElseIf dtTran.Rows(i)("YLD") >= "99.7" And dtTran.Rows(i)("YLD") < "99.8" Then
                '99.7
                gif.SetAbsolutePosition(a, 495) 'ตำแหน่ง
                cb.AddImage(gif)
            ElseIf dtTran.Rows(i)("YLD") >= "99.6" And dtTran.Rows(i)("YLD") < "99.7" Then
                '99.6
                gif.SetAbsolutePosition(a, 485) 'ตำแหน่ง
                cb.AddImage(gif)
            ElseIf dtTran.Rows(i)("YLD") >= "99.5" And dtTran.Rows(i)("YLD") < "99.6" Then
                '99.5
                gif.SetAbsolutePosition(a, 475) 'ตำแหน่ง
                cb.AddImage(gif)
            ElseIf dtTran.Rows(i)("YLD") >= "99.4" And dtTran.Rows(i)("YLD") < "99.5" Then
                '99.4
                gif.SetAbsolutePosition(a, 465) 'ตำแหน่ง
                cb.AddImage(gif)
            ElseIf dtTran.Rows(i)("YLD") >= "99.3" And dtTran.Rows(i)("YLD") < "99.4" Then
                '99.3
                gif.SetAbsolutePosition(a, 455) 'ตำแหน่ง
                cb.AddImage(gif)
            ElseIf dtTran.Rows(i)("YLD") >= "99.2" And dtTran.Rows(i)("YLD") < "99.3" Then
                '99.2
                gif.SetAbsolutePosition(a, 445) 'ตำแหน่ง
                cb.AddImage(gif)
            ElseIf dtTran.Rows(i)("YLD") >= "99.1" And dtTran.Rows(i)("YLD") < "99.2" Then
                '99.1
                gif.SetAbsolutePosition(a, 435) 'ตำแหน่ง
                cb.AddImage(gif)
            ElseIf dtTran.Rows(i)("YLD") >= "99.0" And dtTran.Rows(i)("YLD") < "99.1" Then
                '99.0
                gif.SetAbsolutePosition(a, 425) 'ตำแหน่ง
                cb.AddImage(gif)
            ElseIf dtTran.Rows(i)("YLD") >= "98.0" And dtTran.Rows(i)("YLD") < "99.0" Then
                '98.0
                gif.SetAbsolutePosition(a, 415) 'ตำแหน่ง
                cb.AddImage(gif)
            ElseIf dtTran.Rows(i)("YLD") >= "97.0" And dtTran.Rows(i)("YLD") < "98.0" Then
                '97.0
                gif.SetAbsolutePosition(a, 405) 'ตำแหน่ง
                cb.AddImage(gif)
            End If
            cb.BeginText()
            'Date
            cb.ShowTextAligned(1, dtTran.Rows(i)("LotEndTime"), a, 295, 0)
            'YLD
            cb.ShowTextAligned(1, dtTran.Rows(i)("YLD"), a, 285, 0)
            'M/C
            cb.ShowTextAligned(1, dtTran.Rows(i)("MCNo"), a, 174, 0)
            'Program Ver
            Dim ProgramName1, ProgramName2 As String
            ProgramName1 = Mid(dtTran.Rows(i)("ProgramName"), 1, 4)
            ProgramName2 = Mid(dtTran.Rows(i)("ProgramName"), 5, dtTran.Rows(i)("LENProgrm"))
            cb.ShowTextAligned(1, ProgramName1, a, 167, 0)
            cb.ShowTextAligned(1, ProgramName2, b, 163, 0)

            'OPNo
            cb.ShowTextAligned(1, dtTran.Rows(i)("OPNo"), a, 141, 0)

            'GLCheck
            If IsDBNull(dtTran.Rows(i)("GLCheck")) Then
            Else
                cb.ShowTextAligned(1, dtTran.Rows(i)("GLCheck"), a, 95, 0)
            End If
            cb.EndText()
        Next


        'หัวตาราง
        Dim bf1 As BaseFont = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED)
        cb1.SetColorFill(BaseColor.DARK_GRAY)
        cb1.SetFontAndSize(bf1, 10)

        'This UCL/LCL
        cb1.BeginText()
        cb1.SetColorFill(GrayColor.RED)
        cb1.ShowTextAligned(1, Me.Label3.Text, 335, 80, 0)
        cb1.ShowTextAligned(1, Me.Label5.Text, 470, 80, 0)

        cb1.EndText()

        'This AVE
        cb1.BeginText()
        cb1.SetColorFill(GrayColor.BLUE)
        If IsDBNull(dtTran.Rows(0)("AVE")) Then
            cb1.ShowTextAligned(1, 0, 400, 545, 0)
        Else
            cb1.ShowTextAligned(1, dtTran.Rows(0)("AVE"), 400, 80, 0)
        End If
        cb1.EndText()

        cb1.BeginText()
        cb1.SetColorFill(GrayColor.BLACK)
        cb1.SetTextMatrix(37, 729)

        'Package Name 
        cb1.ShowTextAligned(1, dtTran.Rows(0)("Package"), 480, 550, 0)
        'Device Name
        cb1.ShowTextAligned(1, dtTran.Rows(0)("DeviceName"), 380, 550, 0)
        'AUTO
        cb1.ShowTextAligned(1, dtTran.Rows(0)("FT_Flow_Name"), 605, 558, 0)
        'BOX FTB NO.
        'If Session("FTBNo") <> "" Then
        'Else
        cb1.ShowTextAligned(1, Session("FTBNo"), 715, 558, 0)
        'End If

        cb1.EndText()



        ' Put the text on a new page in the PDF 
        Dim page As PdfImportedPage = writer.GetImportedPage(reader, 1)
        cb.AddTemplate(page, 0, 0)

        ''Close the objects
        document.Close()
        fs.Close()
        writer.Close()

        reader.Close()
        Response.ContentType = "application/pdf"
        Response.AppendHeader("Content-Disposition", "attachment; filename=FTYieldgraphData.pdf")
        Response.TransmitFile("//10.28.33.113/www/TestYieldGraphControl/File/FTYieldgraphData.pdf")
        Response.End()


    End Sub

    Public Overrides Sub VerifyRenderingInServerForm(control As Control)
        ' Verifies that the control is rendered 
    End Sub

End Class