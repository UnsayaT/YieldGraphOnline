Imports System.Data.SqlClient
Imports System.IO
Imports System.Web.UI.DataVisualization.Charting
Imports iTextSharp.text
Imports iTextSharp.text.pdf
Imports Microsoft.Office.Interop

Public Class CT_FLGraph
    Inherits System.Web.UI.Page
    Dim objConn1 As SqlConnection
    Dim objCmd As SqlCommand
    Dim strSQL, StrSQLDevice, strDevice, strSQLDate As String
    Dim dtAdapter, dtDevice, dtAdapterDate As SqlDataAdapter
    Dim dt1, dt2, dtDate As New DataTable
    Dim Data, DeviceName, SheetNo As String
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
        DeviceName = Request.Form("DeviceName")
        TableForm()
    End Sub

    Sub TableForm()
        If DeviceName <> "" Then
            Dim time As DateTime = DateTime.Now
            Dim format As String = "yyyy-MM-dd"

            Dim time1 As DateTime = DateTime.Now
            Dim format1 As String = "yyyy-MM-dd"
            Dim Now1 As String = (time.ToString(format1) & " 07:00:00")
            Session("ChiefDate") = time.ToString(format)

            'หาวันที่เริ่มต้นในการค้นหา
            strSQLDate = "SELECT UpdateTime,LastUpdateTime, DATEDIFF(m, LastUpdateTime, UpdateTime) AS CountMonthFL,PackageName,DeviceName,UCL,AVE,LCL,StatusLCL From [DBx].[dbo].[Cal_LCL] WHERE  DeviceName = '" & DeviceName & "' "
            dtAdapterDate = New SqlDataAdapter(strSQLDate, objConn1)
            dtAdapterDate.Fill(dtDate)
            If dtDate.Rows.Count > 0 Then
                If dtDate.Rows(i)("LastUpdateTime").ToString() = "" Then
                    Session("DateLast") = Now1
                Else
                    Session("DateLast") = dtDate.Rows(i)("LastUpdateTime").ToString()
                End If

                Session("Date") = dtDate.Rows(i)("UpdateTime").ToString()
                Session("Count") = dtDate.Rows(i)("CountMonthFL").ToString()
                Session("StatusLCL") = dtDate.Rows(i)("StatusLCL").ToString()
            End If

            If Session("StatusLCL") = "AUTO UPDATE" Then
                strSQL = "SELECT Top(30) Test1.DeviceName,Test2.Device,Test1.LotNo,Test1.Package,Test1.MCNo,Test1.YLD,Test2.LCL,UCL=100,AVE,Test2.Chief,Test2.SheetFL
                        FROM(
		                Select  CASE WHEN TotalGood = 0 THEN 0 
					                ELSE CAST((CAST( TotalGood AS decimal)/(CAST(TotalGood AS decimal)+ CAST( FTTesterNG AS decimal)))*100 As decimal(10,2)) END AS YLD,FLData.LotNo,
		                MCNo,ETC1 As DeviceName,Package
		                FROM [DBx].[dbo].[TransactionData] INNER JOIN [DBx].[dbo].[FLData] ON TransactionData.LotNo=[DBx].[dbo].[FLData].LotNo And LotEndTime Between  '" & Session("Date") & "' And '" & time & "' )As Test1

                        INNER JOIN 

                        (Select DeviceName As Device,LCL,AVE,SheetFL,Chief
                        From [DBx].[dbo].[Cal_LCL]) As Test2 on Test1.DeviceName = Test2.Device  and YLD >= LCL
                        where Test2.Device = '" & DeviceName & "'"
                dtAdapter = New SqlDataAdapter(strSQL, objConn1)
                dtAdapter.Fill(dt1)
            Else
                strSQL = "SELECT Top(30) Test1.DeviceName,Test2.Device,Test1.LotNo,Test1.Package,Test1.MCNo,Test1.YLD,Test2.LCL,UCL=100,AVE,Test2.Chief,Test2.SheetFL
                        FROM(
		                Select  CASE WHEN TotalGood = 0 THEN 0 
					                ELSE CAST((CAST( TotalGood AS decimal)/(CAST(TotalGood AS decimal)+ CAST( FTTesterNG AS decimal)))*100 As decimal(10,2)) END AS YLD,FLData.LotNo,
		                MCNo,ETC1 As DeviceName,Package
		                FROM [DBx].[dbo].[TransactionData] INNER JOIN [DBx].[dbo].[FLData] ON TransactionData.LotNo=[DBx].[dbo].[FLData].LotNo And LotEndTime <= '" & Now1 & "')As Test1

                        INNER JOIN 

                        (Select DeviceName As Device,LCL,AVE,SheetFL,Chief
                        From [DBx].[dbo].[Cal_LCL]) As Test2 on Test1.DeviceName = Test2.Device  and YLD >= LCL
                        where Test2.Device = '" & DeviceName & "'"
                dtAdapter = New SqlDataAdapter(strSQL, objConn1)
                dtAdapter.Fill(dt1)
            End If

            DeviceName = DeviceName


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
                Session("Chief") = dt1.Rows(i)("Chief").ToString()
                Session("SheetFL") = dt1.Rows(i)("SheetFL").ToString()
            Else
                Me.Label1.Text = dtDate.Rows(i)("PackageName").ToString()
                Me.Label2.Text = dtDate.Rows(i)("DeviceName").ToString()
                Me.Label3.Text = dtDate.Rows(i)("UCL").ToString()
                Me.Label4.Text = dtDate.Rows(i)("AVE").ToString()
                Me.Label5.Text = dtDate.Rows(i)("LCL").ToString()
                Session("Chief") = dt1.Rows(i)("Chief").ToString()
                Session("SheetFL") = dt1.Rows(i)("SheetFL").ToString()
                Page.RegisterClientScriptBlock("OnLoad", "<script>alert('ไม่พบข้อมูลการผลิตของ Device นี้')</script>")
            End If

            If Session("StatusLCL") = "AUTO UPDATE" Then
                Dim strSQL1 As String
                strSQL1 = "SELECT Top(30) Convert(Varchar,LotEndTime,121) AS LotEndTime ,Test1.LotNo,Test1.YLD,Test1.MCNo,FTProgram,
                CASE WHEN Test1.Ach = 0 THEN 0 ELSE Test1.Ach END AS Ach,
                CASE WHEN Test1.Bch = 0 THEN 0 ELSE Test1.Bch END AS Bch,
                CASE WHEN Test1.Cch = 0 THEN 0 ELSE Test1.Cch END AS Cch,
                CASE WHEN Test1.Dch = 0 THEN 0 ELSE Test1.Dch END AS Dch,
                CASE WHEN Test1.Ech = 0 THEN 0 ELSE Test1.Ech END AS Ech,
                CASE WHEN Test1.Fch = 0 THEN 0 ELSE Test1.Fch END AS Fch,
                CASE WHEN Test1.Gch = 0 THEN 0 ELSE Test1.Gch END AS Gch,
                CASE WHEN Test1.Hch = 0 THEN 0 ELSE Test1.Hch END AS Hch,
                OPNo,GLCheck
                FROM(
		                Select  CASE WHEN TotalGood =0 THEN 0 ELSE CAST((CAST( TotalGood AS decimal)/(CAST( TotalGood AS decimal)+ CAST( FTTesterNG AS decimal)))*100 As decimal(10,2))END AS YLD,
		                CASE WHEN FTChPass1 = 0 THEN 0
			                 ELSE CAST((CAST( FTChPass1  AS decimal)/(CAST( FTChPass1 AS decimal)+ CAST( FTChFail1  AS decimal)))*100 As decimal(10,2)) END AS Ach,
	                    CASE WHEN FTChPass2 = 0 THEN 0 
			                ELSE CAST((CAST( FTChPass2  AS decimal)/(CAST( FTChPass2 AS decimal)+ CAST( FTChFail2  AS decimal)))*100 As decimal(10,2)) END AS Bch,
		                CASE WHEN FTChPass3 = 0 THEN 0 
			                ELSE CAST((CAST( FTChPass3  AS decimal)/(CAST( FTChPass3 AS decimal)+ CAST( FTChFail3  AS decimal)))*100 As decimal(10,2)) END AS Cch,
		                CASE WHEN FTChPass4 = 0 THEN 0 
			                ELSE CAST((CAST( FTChPass4  AS decimal)/(CAST( FTChPass4 AS decimal)+ CAST( FTChFail4  AS decimal)))*100 As decimal(10,2)) END AS Dch,
		                CASE WHEN FTChPass5 = 0 THEN 0
			                ELSE CAST((CAST( FTChPass5  AS decimal)/(CAST( FTChPass5 AS decimal)+ CAST( FTChFail5  AS decimal)))*100 As decimal(10,2)) END AS Ech,
		                CASE WHEN FTChPass6 = 0 THEN 0 
			                ELSE CAST((CAST( FTChPass6  AS decimal)/(CAST( FTChPass6 AS decimal)+ CAST( FTChFail6  AS decimal)))*100 As decimal(10,2)) END AS Fch,
		                CASE WHEN FTChPass7 = 0 THEN 0
			                ELSE CAST((CAST( FTChPass7  AS decimal)/(CAST( FTChPass7 AS decimal)+ CAST( FTChFail7  AS decimal)))*100 As decimal(10,2)) END AS Gch,
		                CASE WHEN FTChPass8 = 0 THEN 0
			                ELSE CAST((CAST( FTChPass8  AS decimal)/(CAST( FTChPass8 AS decimal)+ CAST( FTChFail8  AS decimal)))*100 As decimal(10,2)) END AS Hch,
		                ETC1 As DeviceName,
		                FLData.LotNo,MCNo, Package,FTProgram,LotEndTime,OPNo,GLCheck
		                FROM [DBx].[dbo].[TransactionData] INNER JOIN [DBx].[dbo].[FLData] ON TransactionData.LotNo=[DBx].[dbo].[FLData].LotNo And LotEndTime Between '" & Session("Date") & "' And '" & time & "' )As Test1

                INNER JOIN 

                (Select DeviceName As Device,LCL
                From [DBx].[dbo].[Cal_LCL]) As Test2 on Test1.DeviceName = Test2.Device
                        where Test2.Device = '" & DeviceName & "'  and YLD >= LCL order by LotEndTime ASC"

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
                strSQL1 = "SELECT Top(30) Convert(Varchar,LotEndTime,121) AS LotEndTime ,Test1.LotNo,Test1.YLD,Test1.MCNo,FTProgram,
                CASE WHEN Test1.Ach = 0 THEN 0 ELSE Test1.Ach END AS Ach,
                CASE WHEN Test1.Bch = 0 THEN 0 ELSE Test1.Bch END AS Bch,
                CASE WHEN Test1.Cch = 0 THEN 0 ELSE Test1.Cch END AS Cch,
                CASE WHEN Test1.Dch = 0 THEN 0 ELSE Test1.Dch END AS Dch,
                CASE WHEN Test1.Ech = 0 THEN 0 ELSE Test1.Ech END AS Ech,
                CASE WHEN Test1.Fch = 0 THEN 0 ELSE Test1.Fch END AS Fch,
                CASE WHEN Test1.Gch = 0 THEN 0 ELSE Test1.Gch END AS Gch,
                CASE WHEN Test1.Hch = 0 THEN 0 ELSE Test1.Hch END AS Hch,
                OPNo,GLCheck
                FROM(
		                Select  CASE WHEN TotalGood =0 THEN 0 ELSE CAST((CAST( TotalGood AS decimal)/(CAST( TotalGood AS decimal)+ CAST( FTTesterNG AS decimal)))*100 As decimal(10,2))END AS YLD,
		                CASE WHEN FTChPass1 = 0 THEN 0
			                 ELSE CAST((CAST( FTChPass1  AS decimal)/(CAST( FTChPass1 AS decimal)+ CAST( FTChFail1  AS decimal)))*100 As decimal(10,2)) END AS Ach,
	                    CASE WHEN FTChPass2 = 0 THEN 0 
			                ELSE CAST((CAST( FTChPass2  AS decimal)/(CAST( FTChPass2 AS decimal)+ CAST( FTChFail2  AS decimal)))*100 As decimal(10,2)) END AS Bch,
		                CASE WHEN FTChPass3 = 0 THEN 0 
			                ELSE CAST((CAST( FTChPass3  AS decimal)/(CAST( FTChPass3 AS decimal)+ CAST( FTChFail3  AS decimal)))*100 As decimal(10,2)) END AS Cch,
		                CASE WHEN FTChPass4 = 0 THEN 0 
			                ELSE CAST((CAST( FTChPass4  AS decimal)/(CAST( FTChPass4 AS decimal)+ CAST( FTChFail4  AS decimal)))*100 As decimal(10,2)) END AS Dch,
		                CASE WHEN FTChPass5 = 0 THEN 0
			                ELSE CAST((CAST( FTChPass5  AS decimal)/(CAST( FTChPass5 AS decimal)+ CAST( FTChFail5  AS decimal)))*100 As decimal(10,2)) END AS Ech,
		                CASE WHEN FTChPass6 = 0 THEN 0 
			                ELSE CAST((CAST( FTChPass6  AS decimal)/(CAST( FTChPass6 AS decimal)+ CAST( FTChFail6  AS decimal)))*100 As decimal(10,2)) END AS Fch,
		                CASE WHEN FTChPass7 = 0 THEN 0
			                ELSE CAST((CAST( FTChPass7  AS decimal)/(CAST( FTChPass7 AS decimal)+ CAST( FTChFail7  AS decimal)))*100 As decimal(10,2)) END AS Gch,
		                CASE WHEN FTChPass8 = 0 THEN 0
			                ELSE CAST((CAST( FTChPass8  AS decimal)/(CAST( FTChPass8 AS decimal)+ CAST( FTChFail8  AS decimal)))*100 As decimal(10,2)) END AS Hch,
		                ETC1 As DeviceName,
		                FLData.LotNo,MCNo, Package,FTProgram,LotEndTime,OPNo,GLCheck
		                FROM [DBx].[dbo].[TransactionData] INNER JOIN [DBx].[dbo].[FLData] ON TransactionData.LotNo=[DBx].[dbo].[FLData].LotNo And LotEndTime <= '" & Now1 & "')As Test1

                INNER JOIN 

                (Select DeviceName As Device,LCL
                From [DBx].[dbo].[Cal_LCL]) As Test2 on Test1.DeviceName = Test2.Device
                        where Test2.Device = '" & DeviceName & "'  and YLD >= LCL order by LotEndTime ASC"

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
            Page.RegisterClientScriptBlock("OnLoad", "<script>alert('Please Select DeviceName')</script>")
        End If
    End Sub

    Protected Sub ImgBtnCheckSheet_Click(sender As Object, e As ImageClickEventArgs) Handles ImgBtnCheckSheet.Click
        Dim oldFile As String = "//10.28.33.113/www/TestYieldGraphControl/File/FLYieldgraph.pdf"
        Dim newFile As String = "//10.28.33.113/www/TestYieldGraphControl/File/FLYieldgraphData.pdf"
        Dim imagePath As String = "//10.28.33.113/www/TestYieldGraphControl/Img"
        Dim gif As iTextSharp.text.Image
        Dim time As DateTime = DateTime.Now
        Dim strSQL2, strSQL3 As String
        Dim dtAdapterTran, dtCount As SqlDataAdapter
        Dim dt, dtpro, dtNo, dtEmp, dtLot, dtTran, dtFT, dtFL, dtMAP, dtlots, dtGL, dtcheckcount As New DataTable
        Dim Max1, Max2, Max3, Max4, Max5, Max6, Max7 As Decimal
        Dim Min1, Min2, Min3, Min4, Min5, Min6, Min7 As Decimal
        Dim i, a, b, c, d As Integer
        Dim time1 As DateTime = DateTime.Now
        Dim format1 As String = "yyyy-MM-dd"
        Dim Now1 As String = (time.ToString(format1) & " 07:00:00")

        'If dtcheckcount.Rows.Count > 0 Then
        'แสดงว่าหลังจากคำนวณ LCL แล้วมีข้อมูลการผลิตใหม่เข้ามา

        If Session("StatusLCL") = "AUTO UPDATE" Then
            strSQL2 = "SELECT Top(30) Convert(Varchar(5),LotEndTime,110) AS LotEndTime ,Test1.LotNo,Test1.YLD,Test1.MCNo,FTProgram,LCL,UCL,AVE,LastUCL,LastAVE,LastLCL,
            CASE WHEN Test1.Ach = 0 THEN 0 ELSE Test1.Ach END AS Ach,
            CASE WHEN Test1.Bch = 0 THEN 0 ELSE Test1.Bch END AS Bch,
            CASE WHEN Test1.Cch = 0 THEN 0 ELSE Test1.Cch END AS Cch,
            CASE WHEN Test1.Dch = 0 THEN 0 ELSE Test1.Dch END AS Dch,
            CASE WHEN Test1.Ech = 0 THEN 0 ELSE Test1.Ech END AS Ech,
            CASE WHEN Test1.Fch = 0 THEN 0 ELSE Test1.Fch END AS Fch,
            CASE WHEN Test1.Gch = 0 THEN 0 ELSE Test1.Gch END AS Gch,
            CASE WHEN Test1.Hch = 0 THEN 0 ELSE Test1.Hch END AS Hch,
            CASE WHEN GLCheck IS NULL THEN ''
                         ELSE (Select GL_No From [DBx].[dbo].[QYIOP_GL] WHERE OP_No=OPNo) END AS GLCheck,
            OPNo,Package,DeviceName,LEN(FTProgram) As LENProgrm,Convert(Varchar(10),UpdateTime,110) AS Thaitime,Convert(Varchar(10),LastUpdateTime,110) AS LastTime
            FROM(
		            Select  CASE WHEN TotalGood =0 THEN 0 ELSE CAST((CAST( TotalGood AS decimal)/(CAST( TotalGood AS decimal)+ CAST( FTTesterNG AS decimal)))*100 As decimal(10,2))END AS YLD,
		            CASE WHEN FTChPass1 = 0 THEN 0
			             ELSE CAST((CAST( FTChPass1  AS decimal)/(CAST( FTChPass1 AS decimal)+ CAST( FTChFail1  AS decimal)))*100 As decimal(10,2)) END AS Ach,
	                CASE WHEN FTChPass2 = 0 THEN 0 
			            ELSE CAST((CAST( FTChPass2  AS decimal)/(CAST( FTChPass2 AS decimal)+ CAST( FTChFail2  AS decimal)))*100 As decimal(10,2)) END AS Bch,
		            CASE WHEN FTChPass3 = 0 THEN 0 
			            ELSE CAST((CAST( FTChPass3  AS decimal)/(CAST( FTChPass3 AS decimal)+ CAST( FTChFail3  AS decimal)))*100 As decimal(10,2)) END AS Cch,
		            CASE WHEN FTChPass4 = 0 THEN 0 
			            ELSE CAST((CAST( FTChPass4  AS decimal)/(CAST( FTChPass4 AS decimal)+ CAST( FTChFail4  AS decimal)))*100 As decimal(10,2)) END AS Dch,
		            CASE WHEN FTChPass5 = 0 THEN 0
			            ELSE CAST((CAST( FTChPass5  AS decimal)/(CAST( FTChPass5 AS decimal)+ CAST( FTChFail5  AS decimal)))*100 As decimal(10,2)) END AS Ech,
		            CASE WHEN FTChPass6 = 0 THEN 0 
			            ELSE CAST((CAST( FTChPass6  AS decimal)/(CAST( FTChPass6 AS decimal)+ CAST( FTChFail6  AS decimal)))*100 As decimal(10,2)) END AS Fch,
		            CASE WHEN FTChPass7 = 0 THEN 0
			            ELSE CAST((CAST( FTChPass7  AS decimal)/(CAST( FTChPass7 AS decimal)+ CAST( FTChFail7  AS decimal)))*100 As decimal(10,2)) END AS Gch,
		            CASE WHEN FTChPass8 = 0 THEN 0
			            ELSE CAST((CAST( FTChPass8  AS decimal)/(CAST( FTChPass8 AS decimal)+ CAST( FTChFail8  AS decimal)))*100 As decimal(10,2)) END AS Hch,
		            ETC1 As DeviceName,
		            FLData.LotNo,MCNo, Package,FTProgram,LotEndTime,OPNo,
                    CASE WHEN GLCheck IS NULL THEN ''
                         ELSE GLCheck END AS GLCheck
            FROM [DBx].[dbo].[TransactionData] INNER JOIN [DBx].[dbo].[FLData] ON TransactionData.LotNo=[DBx].[dbo].[FLData].LotNo 
            WHERE LotEndTime Between  '" & Session("Date") & "' And '" & time & "' )As Test1
           


            INNER JOIN 

            (Select DeviceName As Device,LCL,UpdateTime,UCL,AVE,LastUCL,LastAVE,LastLCL,LastUpdateTime
            From [DBx].[dbo].[Cal_LCL]) As Test2 on Test1.DeviceName = Test2.Device
                    where Test2.Device = '" & Me.Label2.Text & "'  and YLD >= LCL "
            dtAdapterTran = New SqlDataAdapter(strSQL2, objConn1)
            dtAdapterTran.Fill(dtTran)
        Else
            'FIX
            strSQL2 = "SELECT Top(30) Convert(Varchar(5),LotEndTime,110) AS LotEndTime ,Test1.LotNo,Test1.YLD,Test1.MCNo,FTProgram,LCL,UCL,AVE,LastUCL,LastAVE,LastLCL,
            CASE WHEN Test1.Ach = 0 THEN 0 ELSE Test1.Ach END AS Ach,
            CASE WHEN Test1.Bch = 0 THEN 0 ELSE Test1.Bch END AS Bch,
            CASE WHEN Test1.Cch = 0 THEN 0 ELSE Test1.Cch END AS Cch,
            CASE WHEN Test1.Dch = 0 THEN 0 ELSE Test1.Dch END AS Dch,
            CASE WHEN Test1.Ech = 0 THEN 0 ELSE Test1.Ech END AS Ech,
            CASE WHEN Test1.Fch = 0 THEN 0 ELSE Test1.Fch END AS Fch,
            CASE WHEN Test1.Gch = 0 THEN 0 ELSE Test1.Gch END AS Gch,
            CASE WHEN Test1.Hch = 0 THEN 0 ELSE Test1.Hch END AS Hch,
            CASE WHEN GLCheck IS NULL THEN ''
                         ELSE (Select GL_No From [DBx].[dbo].[QYIOP_GL] WHERE OP_No=OPNo) END AS GLCheck,
            OPNo,Package,DeviceName,LEN(FTProgram) As LENProgrm,Convert(Varchar(10),UpdateTime,110) AS Thaitime,Convert(Varchar(10),LastUpdateTime,110) AS LastTime
            FROM(
		            Select  CASE WHEN TotalGood =0 THEN 0 ELSE CAST((CAST( TotalGood AS decimal)/(CAST( TotalGood AS decimal)+ CAST( FTTesterNG AS decimal)))*100 As decimal(10,2))END AS YLD,
		            CASE WHEN FTChPass1 = 0 THEN 0
			             ELSE CAST((CAST( FTChPass1  AS decimal)/(CAST( FTChPass1 AS decimal)+ CAST( FTChFail1  AS decimal)))*100 As decimal(10,2)) END AS Ach,
	                CASE WHEN FTChPass2 = 0 THEN 0 
			            ELSE CAST((CAST( FTChPass2  AS decimal)/(CAST( FTChPass2 AS decimal)+ CAST( FTChFail2  AS decimal)))*100 As decimal(10,2)) END AS Bch,
		            CASE WHEN FTChPass3 = 0 THEN 0 
			            ELSE CAST((CAST( FTChPass3  AS decimal)/(CAST( FTChPass3 AS decimal)+ CAST( FTChFail3  AS decimal)))*100 As decimal(10,2)) END AS Cch,
		            CASE WHEN FTChPass4 = 0 THEN 0 
			            ELSE CAST((CAST( FTChPass4  AS decimal)/(CAST( FTChPass4 AS decimal)+ CAST( FTChFail4  AS decimal)))*100 As decimal(10,2)) END AS Dch,
		            CASE WHEN FTChPass5 = 0 THEN 0
			            ELSE CAST((CAST( FTChPass5  AS decimal)/(CAST( FTChPass5 AS decimal)+ CAST( FTChFail5  AS decimal)))*100 As decimal(10,2)) END AS Ech,
		            CASE WHEN FTChPass6 = 0 THEN 0 
			            ELSE CAST((CAST( FTChPass6  AS decimal)/(CAST( FTChPass6 AS decimal)+ CAST( FTChFail6  AS decimal)))*100 As decimal(10,2)) END AS Fch,
		            CASE WHEN FTChPass7 = 0 THEN 0
			            ELSE CAST((CAST( FTChPass7  AS decimal)/(CAST( FTChPass7 AS decimal)+ CAST( FTChFail7  AS decimal)))*100 As decimal(10,2)) END AS Gch,
		            CASE WHEN FTChPass8 = 0 THEN 0
			            ELSE CAST((CAST( FTChPass8  AS decimal)/(CAST( FTChPass8 AS decimal)+ CAST( FTChFail8  AS decimal)))*100 As decimal(10,2)) END AS Hch,
		            ETC1 As DeviceName,
		            FLData.LotNo,MCNo, Package,FTProgram,LotEndTime,OPNo,
                    CASE WHEN GLCheck IS NULL THEN ''
                         ELSE GLCheck END AS GLCheck
            FROM [DBx].[dbo].[TransactionData] INNER JOIN [DBx].[dbo].[FLData] ON TransactionData.LotNo=[DBx].[dbo].[FLData].LotNo 
            WHERE LotEndTime <= '" & Now1 & "' )As Test1
           


            INNER JOIN 

            (Select DeviceName As Device,LCL,UpdateTime,UCL,AVE,LastUCL,LastAVE,LastLCL,LastUpdateTime
            From [DBx].[dbo].[Cal_LCL]) As Test2 on Test1.DeviceName = Test2.Device
                    where Test2.Device = '" & Me.Label2.Text & "'  and YLD >= LCL "
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
                ElseIf dtTran.Rows(i)("AVE") >= "98.0" Then
                    cb.MoveTo(139, 408)
                    cb.LineTo(820, 408)
                ElseIf dtTran.Rows(i)("AVE") >= "97.0" Then
                    cb.MoveTo(139, 396)
                    cb.LineTo(820, 396)
                ElseIf dtTran.Rows(i)("AVE") >= "96.0" Then
                    cb.MoveTo(139, 384)
                    cb.LineTo(820, 384)
                ElseIf dtTran.Rows(i)("AVE") >= "95.0" Then
                    cb.MoveTo(139, 372)
                    cb.LineTo(820, 372)
                ElseIf dtTran.Rows(i)("AVE") >= "94.0" Then
                    cb.MoveTo(139, 360)
                    cb.LineTo(820, 360)
                ElseIf dtTran.Rows(i)("AVE") >= "93.0" Then
                    cb.MoveTo(139, 360)
                    cb.LineTo(820, 360)
                End If

                cb.SetColorStroke(GrayColor.BLUE)
                cb.Stroke()
                cb.BeginText()
            End If


            'UCL
            cb.EndText()
            cb.SetLineWidth(1)
            cb.MoveTo(139, 526)
            cb.LineTo(820, 526)
            cb.SetColorStroke(GrayColor.RED)
            cb.Stroke()
            cb.BeginText()

            'LCL
            cb.EndText()
            cb.SetLineWidth(1)
            If dtTran.Rows(i)("LCL") >= "100" Then
                cb.MoveTo(139, 526)
                cb.LineTo(820, 526)
            ElseIf dtTran.Rows(i)("LCL") >= "99.9" Then
                cb.MoveTo(139, 518)
                cb.LineTo(820, 518)
            ElseIf dtTran.Rows(i)("LCL") >= "99.8" Then
                cb.MoveTo(139, 510)
                cb.LineTo(820, 510)
            ElseIf dtTran.Rows(i)("LCL") >= "99.7" Then
                cb.MoveTo(139, 495)
                cb.LineTo(820, 495)
            ElseIf dtTran.Rows(i)("LCL") >= "99.6" Then
                cb.MoveTo(139, 487)
                cb.LineTo(820, 487)
            ElseIf dtTran.Rows(i)("LCL") >= "99.5" Then
                cb.MoveTo(139, 478)
                cb.LineTo(820, 478)
            ElseIf dtTran.Rows(i)("LCL") >= "99.4" Then
                cb.MoveTo(139, 468)
                cb.LineTo(820, 468)
            ElseIf dtTran.Rows(i)("LCL") >= "99.3" Then
                cb.MoveTo(139, 458)
                cb.LineTo(820, 458)
            ElseIf dtTran.Rows(i)("LCL") >= "99.2" Then
                cb.MoveTo(139, 445)
                cb.LineTo(820, 445)
            ElseIf dtTran.Rows(i)("LCL") >= "99.1" Then
                cb.MoveTo(139, 435)
                cb.LineTo(820, 435)
            ElseIf dtTran.Rows(i)("LCL") >= "99.0" Then
                cb.MoveTo(139, 425)
                cb.LineTo(820, 425)
            ElseIf dtTran.Rows(i)("LCL") >= "98.0" Then
                cb.MoveTo(139, 415)
                cb.LineTo(820, 415)
            ElseIf dtTran.Rows(i)("LCL") >= "97.0" Then
                cb.MoveTo(139, 405)
                cb.LineTo(820, 405)
            ElseIf dtTran.Rows(i)("LCL") >= "96.0" Then
                cb.MoveTo(139, 395)
                cb.LineTo(820, 395)
            End If

            cb.SetColorStroke(GrayColor.RED)
            cb.Stroke()
            cb.BeginText()

            If i = 0 Then
                a = 145
                b = 147
                c = 137
                d = 155
            ElseIf i = 1 Then
                a = 164
                b = 167
                c = 155
                d = 173
            ElseIf i = 2 Then
                a = 182
                b = 184
                c = 173
                d = 190
            ElseIf i = 3 Then
                a = 199
                b = 202
                c = 190
                d = 208
            ElseIf i = 4 Then
                a = 216
                b = 220
                c = 208
                d = 225
            ElseIf i = 5 Then
                a = 235
                b = 236
                c = 225
                d = 243
            ElseIf i = 6 Then
                a = 252
                b = 254
                c = 243
                d = 261
            ElseIf i = 7 Then
                a = 270
                b = 272
                c = 261
                d = 278
            ElseIf i = 8 Then
                a = 288
                b = 290
                c = 278
                d = 296
            ElseIf i = 9 Then
                a = 306
                b = 306
                c = 296
                d = 313
            ElseIf i = 10 Then
                a = 323
                b = 324
                c = 313
                d = 331
            ElseIf i = 11 Then
                a = 340
                b = 342
                c = 331
                d = 349
            ElseIf i = 12 Then
                a = 357
                b = 360
                c = 349
                d = 366
            ElseIf i = 13 Then
                a = 375
                b = 378
                c = 366
                d = 384
            ElseIf i = 14 Then
                a = 393
                b = 396
                c = 384
                d = 402
            ElseIf i = 15 Then
                a = 410
                b = 414
                c = 402
                d = 419
            ElseIf i = 16 Then
                a = 428
                b = 432
                c = 419
                d = 437
            ElseIf i = 17 Then
                a = 445
                b = 448
                c = 437
                d = 454
            ElseIf i = 18 Then
                a = 463
                b = 466
                c = 454
                d = 472
            ElseIf i = 19 Then
                a = 481
                b = 484
                c = 472
                d = 490
            ElseIf i = 20 Then
                a = 499
                b = 502
                c = 490
                d = 508
            ElseIf i = 21 Then
                a = 517
                b = 518
                c = 508
                d = 526
            ElseIf i = 22 Then
                a = 534
                b = 536
                c = 526
                d = 544
            ElseIf i = 23 Then
                a = 552
                b = 554
                c = 544
                d = 561
            ElseIf i = 24 Then
                a = 570
                b = 572
                c = 561
                d = 579
            ElseIf i = 25 Then
                a = 588
                b = 590
                c = 579
                d = 596
            ElseIf i = 26 Then
                a = 605
                b = 608
                c = 596
                d = 613
            ElseIf i = 27 Then
                a = 623
                b = 624
                c = 613
                d = 630
            ElseIf i = 28 Then
                a = 641
                b = 642
                c = 630
                d = 647
            ElseIf i = 29 Then
                a = 659
                b = 660
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
            cb.ShowTextAligned(1, dtTran.Rows(i)("YLD"), a, 280, 0)
            'M/C
            cb.ShowTextAligned(1, dtTran.Rows(i)("MCNo"), a, 270, 0)
            'Test No Ng
            'ขีดเส้นทับ
            cb.EndText()
            cb.SetLineWidth(0.5)
            cb.MoveTo(c, 249)
            cb.LineTo(d, 263)
            cb.SetColorStroke(GrayColor.BLACK)
            cb.Stroke()
            cb.BeginText()

            cb.EndText()
            cb.SetLineWidth(0.5)
            cb.MoveTo(c, 236)
            cb.LineTo(d, 249)
            cb.SetColorStroke(GrayColor.BLACK)
            cb.Stroke()
            cb.BeginText()

            cb.EndText()
            cb.SetLineWidth(0.5)
            cb.MoveTo(c, 221)
            cb.LineTo(d, 235)
            cb.SetColorStroke(GrayColor.BLACK)
            cb.Stroke()
            cb.BeginText()
            'Program Ver
            Dim ProgramName1, ProgramName2 As String
            ProgramName1 = Mid(dtTran.Rows(i)("FTProgram"), 1, 4)
            ProgramName2 = Mid(dtTran.Rows(i)("FTProgram"), 5, dtTran.Rows(i)("LENProgrm"))
            cb.ShowTextAligned(1, ProgramName1, a, 215, 0)
            cb.ShowTextAligned(1, ProgramName2, b, 208, 0)
            'Ach
            If dtTran.Rows(i)("Ach") = "0.00" Then
                cb.EndText()
                cb.SetLineWidth(0.5)
                cb.MoveTo(c, 197)
                cb.LineTo(d, 206)
                cb.SetColorStroke(GrayColor.BLACK)
                cb.Stroke()
                cb.BeginText()
            Else
                cb.ShowTextAligned(1, dtTran.Rows(i)("Ach"), a, 200, 0)
            End If

            'Bch
            If dtTran.Rows(i)("Bch") = "0.00" Then
                cb.EndText()
                cb.SetLineWidth(0.5)
                cb.MoveTo(c, 188)
                cb.LineTo(d, 197)
                cb.SetColorStroke(GrayColor.BLACK)
                cb.Stroke()
                cb.BeginText()
            Else
                cb.ShowTextAligned(1, dtTran.Rows(i)("Bch"), a, 190, 0)
            End If

            'Cch
            If dtTran.Rows(i)("Cch") = "0.00" Then
                cb.EndText()
                cb.SetLineWidth(0.5)
                cb.MoveTo(c, 179)
                cb.LineTo(d, 188)
                cb.SetColorStroke(GrayColor.BLACK)
                cb.Stroke()
                cb.BeginText()
            Else
                cb.ShowTextAligned(1, dtTran.Rows(i)("Cch"), a, 180, 0)
            End If

            'Dch
            If dtTran.Rows(i)("Dch") = "0.00" Then
                cb.EndText()
                cb.SetLineWidth(0.5)
                cb.MoveTo(c, 170)
                cb.LineTo(d, 179)
                cb.SetColorStroke(GrayColor.BLACK)
                cb.Stroke()
                cb.BeginText()
            Else
                cb.ShowTextAligned(1, dtTran.Rows(i)("Dch"), a, 171, 0)
            End If

            'Ech
            If dtTran.Rows(i)("Ech") = "0.00" Then
                cb.EndText()
                cb.SetLineWidth(0.5)
                cb.MoveTo(c, 160)
                cb.LineTo(d, 169)
                cb.SetColorStroke(GrayColor.BLACK)
                cb.Stroke()
                cb.BeginText()
            Else
                cb.ShowTextAligned(1, dtTran.Rows(i)("Ech"), a, 161, 0)
            End If

            'Fch
            If dtTran.Rows(i)("Fch") = "0.00" Then
                cb.EndText()
                cb.SetLineWidth(0.5)
                cb.MoveTo(c, 151)
                cb.LineTo(d, 160)
                cb.SetColorStroke(GrayColor.BLACK)
                cb.Stroke()
                cb.BeginText()
            Else
                cb.ShowTextAligned(1, dtTran.Rows(i)("Fch"), a, 151, 0)
            End If

            'Gch
            If dtTran.Rows(i)("Gch") = "0.00" Then
                cb.EndText()
                cb.SetLineWidth(0.5)
                cb.MoveTo(c, 142)
                cb.LineTo(d, 151)
                cb.SetColorStroke(GrayColor.BLACK)
                cb.Stroke()
                cb.BeginText()
            Else
                cb.ShowTextAligned(1, dtTran.Rows(i)("Gch"), a, 143, 0)
            End If

            'Hch
            If dtTran.Rows(i)("Hch") = "0.00" Then
                cb.EndText()
                cb.SetLineWidth(0.5)
                cb.MoveTo(c, 133)
                cb.LineTo(d, 141)
                cb.SetColorStroke(GrayColor.BLACK)
                cb.Stroke()
                cb.BeginText()
            Else
                cb.ShowTextAligned(1, dtTran.Rows(i)("Hch"), a, 134, 0)
            End If

            'Max-Min(R)
            If dtTran.Rows(i)("Ach") <> 0 Then
                If dtTran.Rows(i)("Ach") <> 0 And dtTran.Rows(i)("Bch") <> 0 Then
                    Max1 = Math.Max(dtTran.Rows(i)("Ach"), dtTran.Rows(i)("Bch"))
                    Min1 = Math.Min(dtTran.Rows(i)("Ach"), dtTran.Rows(i)("Bch"))
                End If
                If dtTran.Rows(i)("Cch") <> 0 Then
                    Max2 = Math.Max(Max1, dtTran.Rows(i)("Cch"))
                    Min2 = Math.Min(Min1, dtTran.Rows(i)("Cch"))
                End If
                If dtTran.Rows(i)("Dch") <> 0 Then
                    Max3 = Math.Max(Max2, dtTran.Rows(i)("Dch"))
                    Min3 = Math.Min(Min2, dtTran.Rows(i)("Dch"))
                End If
                If dtTran.Rows(i)("Ech") <> 0 Then
                    Max4 = Math.Max(Max3, dtTran.Rows(i)("Ech"))
                    Min4 = Math.Min(Min3, dtTran.Rows(i)("Ech"))
                End If
                If dtTran.Rows(i)("Fch") <> 0 Then
                    Max5 = Math.Max(Max4, dtTran.Rows(i)("Fch"))
                    Min5 = Math.Min(Min4, dtTran.Rows(i)("Fch"))
                End If
                If dtTran.Rows(i)("Gch") <> 0 Then
                    Max6 = Math.Max(Max5, dtTran.Rows(i)("Gch"))
                    Min6 = Math.Min(Min5, dtTran.Rows(i)("Gch"))
                End If
                If dtTran.Rows(i)("Hch") <> 0 Then
                    Max7 = Math.Max(Max6, dtTran.Rows(i)("Hch"))
                    Min7 = Math.Min(Min6, dtTran.Rows(i)("Hch"))
                End If

                If Max7 <> 0 And Min7 <> 0 Then
                    cb.ShowTextAligned(1, Max7 - Min7, a, 124, 0)
                    'ความต่างระหว่าง CH
                    cb.EndText()
                    gif.ScaleToFit(3, 3) 'ขนาดรูป
                    If Max7 - Min7 >= "0.05" And Max7 - Min7 <= "0.1" Then
                        gif.SetAbsolutePosition(a, 308) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max7 - Min7 > "0.1" And Max7 - Min7 <= "0.15" Then
                        gif.SetAbsolutePosition(a, 310) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max7 - Min7 > "0.15" And Max7 - Min7 <= "0.2" Then
                        gif.SetAbsolutePosition(a, 312) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max7 - Min7 > "0.2" And Max7 - Min7 <= "0.25" Then
                        gif.SetAbsolutePosition(a, 315) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max7 - Min7 > "0.25" And Max7 - Min7 <= "0.3" Then
                        gif.SetAbsolutePosition(a, 319) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max7 - Min7 > "0.3" And Max7 - Min7 <= "0.35" Then
                        gif.SetAbsolutePosition(a, 322) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max7 - Min7 > "0.35" And Max7 - Min7 <= "0.4" Then
                        gif.SetAbsolutePosition(a, 325) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max7 - Min7 > "0.4" And Max7 - Min7 <= "0.45" Then
                        gif.SetAbsolutePosition(a, 330) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max7 - Min7 > "0.45" And Max7 - Min7 <= "0.5" Then
                        gif.SetAbsolutePosition(a, 333) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max7 - Min7 > "0.5" And Max7 - Min7 <= "0.55" Then
                        gif.SetAbsolutePosition(a, 336) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max7 - Min7 > "0.55" And Max7 - Min7 <= "0.6" Then
                        gif.SetAbsolutePosition(a, 338) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max7 - Min7 > "0.6" And Max7 - Min7 <= "0.65" Then
                        gif.SetAbsolutePosition(a, 341) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max7 - Min7 > "0.65" And Max7 - Min7 <= "0.7" Then
                        gif.SetAbsolutePosition(a, 343) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max7 - Min7 > "0.7" Then
                        gif.SetAbsolutePosition(a, 352) 'ตำแหน่ง
                        cb.AddImage(gif)
                    End If
                    cb.BeginText()
                ElseIf Max6 <> 0 And Min6 <> 0 Then
                    cb.ShowTextAligned(1, Max6 - Min6, a, 124, 0)
                    'ความต่างระหว่าง CH
                    cb.EndText()
                    gif.ScaleToFit(3, 3) 'ขนาดรูป
                    If Max6 - Min6 >= "0.05" And Max6 - Min6 <= "0.1" Then
                        gif.SetAbsolutePosition(a, 308) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max6 - Min6 > "0.1" And Max6 - Min6 <= "0.15" Then
                        gif.SetAbsolutePosition(a, 310) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max6 - Min6 > "0.15" And Max6 - Min6 <= "0.2" Then
                        gif.SetAbsolutePosition(a, 312) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max6 - Min6 > "0.2" And Max6 - Min6 <= "0.25" Then
                        gif.SetAbsolutePosition(a, 315) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max6 - Min6 > "0.25" And Max6 - Min6 <= "0.3" Then
                        gif.SetAbsolutePosition(a, 319) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max6 - Min6 > "0.3" And Max6 - Min6 <= "0.35" Then
                        gif.SetAbsolutePosition(a, 322) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max6 - Min6 > "0.35" And Max6 - Min6 <= "0.4" Then
                        gif.SetAbsolutePosition(a, 325) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max6 - Min6 > "0.4" And Max6 - Min6 <= "0.45" Then
                        gif.SetAbsolutePosition(a, 330) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max6 - Min6 > "0.45" And Max6 - Min6 <= "0.5" Then
                        gif.SetAbsolutePosition(a, 333) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max6 - Min6 > "0.5" And Max6 - Min6 <= "0.55" Then
                        gif.SetAbsolutePosition(a, 336) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max6 - Min6 > "0.55" And Max6 - Min6 <= "0.6" Then
                        gif.SetAbsolutePosition(a, 338) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max6 - Min6 > "0.6" And Max6 - Min6 <= "0.65" Then
                        gif.SetAbsolutePosition(a, 341) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max6 - Min6 > "0.65" And Max6 - Min6 <= "0.7" Then
                        gif.SetAbsolutePosition(a, 343) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max6 - Min6 > "0.7" Then
                        gif.SetAbsolutePosition(a, 352) 'ตำแหน่ง
                        cb.AddImage(gif)
                    End If
                    cb.BeginText()
                ElseIf Max5 <> 0 And Min5 <> 0 Then
                    cb.ShowTextAligned(1, Max5 - Min5, a, 124, 0)
                    'ความต่างระหว่าง CH
                    cb.EndText()
                    gif.ScaleToFit(3, 3) 'ขนาดรูป
                    If Max5 - Min5 >= "0.05" And Max5 - Min5 <= "0.1" Then
                        gif.SetAbsolutePosition(a, 308) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max5 - Min5 > "0.1" And Max5 - Min5 <= "0.15" Then
                        gif.SetAbsolutePosition(a, 310) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max5 - Min5 > "0.15" And Max5 - Min5 <= "0.2" Then
                        gif.SetAbsolutePosition(a, 312) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max5 - Min5 > "0.2" And Max5 - Min5 <= "0.25" Then
                        gif.SetAbsolutePosition(a, 315) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max5 - Min5 > "0.25" And Max5 - Min5 <= "0.3" Then
                        gif.SetAbsolutePosition(a, 319) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max5 - Min5 > "0.3" And Max5 - Min5 <= "0.35" Then
                        gif.SetAbsolutePosition(a, 322) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max5 - Min5 > "0.35" And Max5 - Min5 <= "0.4" Then
                        gif.SetAbsolutePosition(a, 325) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max5 - Min5 > "0.4" And Max5 - Min5 <= "0.45" Then
                        gif.SetAbsolutePosition(a, 330) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max5 - Min5 > "0.45" And Max5 - Min5 <= "0.5" Then
                        gif.SetAbsolutePosition(a, 333) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max5 - Min5 > "0.5" And Max5 - Min5 <= "0.55" Then
                        gif.SetAbsolutePosition(a, 336) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max5 - Min5 > "0.55" And Max5 - Min5 <= "0.6" Then
                        gif.SetAbsolutePosition(a, 338) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max5 - Min5 > "0.6" And Max5 - Min5 <= "0.65" Then
                        gif.SetAbsolutePosition(a, 341) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max5 - Min5 > "0.65" And Max5 - Min5 <= "0.7" Then
                        gif.SetAbsolutePosition(a, 343) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max5 - Min5 > "0.7" Then
                        gif.SetAbsolutePosition(a, 352) 'ตำแหน่ง
                        cb.AddImage(gif)
                    End If
                    cb.BeginText()
                ElseIf Max4 <> 0 And Min4 <> 0 Then
                    cb.ShowTextAligned(1, Max4 - Min4, a, 124, 0)
                    'ความต่างระหว่าง CH
                    cb.EndText()
                    gif.ScaleToFit(3, 3) 'ขนาดรูป
                    If Max4 - Min4 >= "0.05" And Max4 - Min4 <= "0.1" Then
                        gif.SetAbsolutePosition(a, 308) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max4 - Min4 > "0.1" And Max4 - Min4 <= "0.15" Then
                        gif.SetAbsolutePosition(a, 310) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max4 - Min4 > "0.15" And Max4 - Min4 <= "0.2" Then
                        gif.SetAbsolutePosition(a, 312) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max4 - Min4 > "0.2" And Max4 - Min4 <= "0.25" Then
                        gif.SetAbsolutePosition(a, 315) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max4 - Min4 > "0.25" And Max4 - Min4 <= "0.3" Then
                        gif.SetAbsolutePosition(a, 319) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max4 - Min4 > "0.3" And Max4 - Min4 <= "0.35" Then
                        gif.SetAbsolutePosition(a, 322) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max4 - Min4 > "0.35" And Max4 - Min4 <= "0.4" Then
                        gif.SetAbsolutePosition(a, 325) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max4 - Min4 > "0.4" And Max4 - Min4 <= "0.45" Then
                        gif.SetAbsolutePosition(a, 330) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max4 - Min4 > "0.45" And Max4 - Min4 <= "0.5" Then
                        gif.SetAbsolutePosition(a, 333) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max4 - Min4 > "0.5" And Max4 - Min4 <= "0.55" Then
                        gif.SetAbsolutePosition(a, 336) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max4 - Min4 > "0.55" And Max4 - Min4 <= "0.6" Then
                        gif.SetAbsolutePosition(a, 338) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max4 - Min4 > "0.6" And Max4 - Min4 <= "0.65" Then
                        gif.SetAbsolutePosition(a, 341) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max4 - Min4 > "0.65" And Max4 - Min4 <= "0.7" Then
                        gif.SetAbsolutePosition(a, 343) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max4 - Min4 > "0.7" Then
                        gif.SetAbsolutePosition(a, 352) 'ตำแหน่ง
                        cb.AddImage(gif)
                    End If
                    cb.BeginText()
                ElseIf Max3 <> 0 And Min3 <> 0 Then
                    cb.ShowTextAligned(1, Max3 - Min3, a, 124, 0)
                    'ความต่างระหว่าง CH
                    cb.EndText()
                    gif.ScaleToFit(3, 3) 'ขนาดรูป
                    If Max3 - Min3 >= "0.05" And Max3 - Min3 <= "0.1" Then
                        gif.SetAbsolutePosition(a, 308) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max3 - Min3 > "0.1" And Max3 - Min3 <= "0.15" Then
                        gif.SetAbsolutePosition(a, 310) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max3 - Min3 > "0.15" And Max3 - Min3 <= "0.2" Then
                        gif.SetAbsolutePosition(a, 312) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max3 - Min3 > "0.2" And Max3 - Min3 <= "0.25" Then
                        gif.SetAbsolutePosition(a, 315) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max3 - Min3 > "0.25" And Max3 - Min3 <= "0.3" Then
                        gif.SetAbsolutePosition(a, 319) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max3 - Min3 > "0.3" And Max3 - Min3 <= "0.35" Then
                        gif.SetAbsolutePosition(a, 322) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max3 - Min3 > "0.35" And Max3 - Min3 <= "0.4" Then
                        gif.SetAbsolutePosition(a, 325) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max3 - Min3 > "0.4" And Max3 - Min3 <= "0.45" Then
                        gif.SetAbsolutePosition(a, 330) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max3 - Min3 > "0.45" And Max3 - Min3 <= "0.5" Then
                        gif.SetAbsolutePosition(a, 333) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max3 - Min3 > "0.5" And Max3 - Min3 <= "0.55" Then
                        gif.SetAbsolutePosition(a, 336) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max3 - Min3 > "0.55" And Max3 - Min3 <= "0.6" Then
                        gif.SetAbsolutePosition(a, 338) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max3 - Min3 > "0.6" And Max3 - Min3 <= "0.65" Then
                        gif.SetAbsolutePosition(a, 341) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max3 - Min3 > "0.65" And Max3 - Min3 <= "0.7" Then
                        gif.SetAbsolutePosition(a, 343) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max3 - Min3 > "0.7" Then
                        gif.SetAbsolutePosition(a, 352) 'ตำแหน่ง
                        cb.AddImage(gif)
                    End If
                    cb.BeginText()
                ElseIf Max2 <> 0 And Min2 <> 0 Then
                    cb.ShowTextAligned(1, Max2 - Min2, a, 124, 0)
                    'ความต่างระหว่าง CH
                    cb.EndText()
                    gif.ScaleToFit(3, 3) 'ขนาดรูป
                    If Max2 - Min2 >= "0.05" And Max2 - Min2 <= "0.1" Then
                        gif.SetAbsolutePosition(a, 308) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max2 - Min2 > "0.1" And Max2 - Min2 <= "0.15" Then
                        gif.SetAbsolutePosition(a, 310) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max2 - Min2 > "0.15" And Max2 - Min2 <= "0.2" Then
                        gif.SetAbsolutePosition(a, 312) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max2 - Min2 > "0.2" And Max2 - Min2 <= "0.25" Then
                        gif.SetAbsolutePosition(a, 315) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max2 - Min2 > "0.25" And Max2 - Min2 <= "0.3" Then
                        gif.SetAbsolutePosition(a, 319) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max2 - Min2 > "0.3" And Max2 - Min2 <= "0.35" Then
                        gif.SetAbsolutePosition(a, 322) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max2 - Min2 > "0.35" And Max2 - Min2 <= "0.4" Then
                        gif.SetAbsolutePosition(a, 325) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max2 - Min2 > "0.4" And Max2 - Min2 <= "0.45" Then
                        gif.SetAbsolutePosition(a, 330) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max2 - Min2 > "0.45" And Max2 - Min2 <= "0.5" Then
                        gif.SetAbsolutePosition(a, 333) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max2 - Min2 > "0.5" And Max2 - Min2 <= "0.55" Then
                        gif.SetAbsolutePosition(a, 336) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max2 - Min2 > "0.55" And Max2 - Min2 <= "0.6" Then
                        gif.SetAbsolutePosition(a, 338) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max2 - Min2 > "0.6" And Max2 - Min2 <= "0.65" Then
                        gif.SetAbsolutePosition(a, 341) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max2 - Min2 > "0.65" And Max2 - Min2 <= "0.7" Then
                        gif.SetAbsolutePosition(a, 343) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max2 - Min2 > "0.7" Then
                        gif.SetAbsolutePosition(a, 352) 'ตำแหน่ง
                        cb.AddImage(gif)
                    End If
                    cb.BeginText()
                ElseIf Max1 <> 0 And Min1 <> 0 Then
                    cb.ShowTextAligned(1, Max1 - Min1, a, 124, 0)
                    'ความต่างระหว่าง CH
                    cb.EndText()
                    gif.ScaleToFit(3, 3) 'ขนาดรูป
                    If Max1 - Min1 >= "0.05" And Max1 - Min1 <= "0.1" Then
                        gif.SetAbsolutePosition(a, 308) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max1 - Min1 > "0.1" And Max1 - Min1 <= "0.15" Then
                        gif.SetAbsolutePosition(a, 310) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max1 - Min1 > "0.15" And Max1 - Min1 <= "0.2" Then
                        gif.SetAbsolutePosition(a, 312) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max1 - Min1 > "0.2" And Max1 - Min1 <= "0.25" Then
                        gif.SetAbsolutePosition(a, 315) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max1 - Min1 > "0.25" And Max1 - Min1 <= "0.3" Then
                        gif.SetAbsolutePosition(a, 319) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max1 - Min1 > "0.3" And Max1 - Min1 <= "0.35" Then
                        gif.SetAbsolutePosition(a, 322) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max1 - Min1 > "0.35" And Max1 - Min1 <= "0.4" Then
                        gif.SetAbsolutePosition(a, 325) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max1 - Min1 > "0.4" And Max1 - Min1 <= "0.45" Then
                        gif.SetAbsolutePosition(a, 330) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max1 - Min1 > "0.45" And Max1 - Min1 <= "0.5" Then
                        gif.SetAbsolutePosition(a, 333) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max1 - Min1 > "0.5" And Max1 - Min1 <= "0.55" Then
                        gif.SetAbsolutePosition(a, 336) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max1 - Min1 > "0.55" And Max1 - Min1 <= "0.6" Then
                        gif.SetAbsolutePosition(a, 338) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max1 - Min1 > "0.6" And Max1 - Min1 <= "0.65" Then
                        gif.SetAbsolutePosition(a, 341) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max1 - Min1 > "0.65" And Max1 - Min1 <= "0.7" Then
                        gif.SetAbsolutePosition(a, 343) 'ตำแหน่ง
                        cb.AddImage(gif)
                    ElseIf Max1 - Min1 > "0.7" Then
                        gif.SetAbsolutePosition(a, 352) 'ตำแหน่ง
                        cb.AddImage(gif)
                    End If
                    cb.BeginText()
                End If

            End If

            'OPNo
            cb.ShowTextAligned(1, dtTran.Rows(i)("OPNo"), a, 110, 0)

            'GLCheck
            If IsDBNull(dtTran.Rows(i)("GLCheck")) Then
            Else
                cb.ShowTextAligned(1, dtTran.Rows(i)("GLCheck"), a, 95, 0)
            End If
            cb.EndText()



        Next

        'For i = 0 To dtTran.Rows.Count - 1
        'หัวตาราง

        Dim bf1 As BaseFont = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED)
        cb1.SetColorFill(BaseColor.DARK_GRAY)
        cb1.SetFontAndSize(bf1, 7.5)

        'This UCL/LCL
        cb1.BeginText()
        cb1.SetColorFill(GrayColor.RED)
        cb1.ShowTextAligned(1, dtTran.Rows(0)("UCL"), 428, 545, 0)
        cb1.ShowTextAligned(1, dtTran.Rows(0)("LCL"), 534, 545, 0)

        If IsDBNull(dtTran.Rows(0)("LastUCL")) Then
            cb1.ShowTextAligned(1, 0, 590, 545, 0)
        Else
            cb1.ShowTextAligned(1, dtTran.Rows(0)("LastUCL"), 590, 545, 0)
        End If

        If IsDBNull(dtTran.Rows(0)("LastLCL")) Then
            cb1.ShowTextAligned(1, 0, 690, 545, 0)
        Else
            cb1.ShowTextAligned(1, dtTran.Rows(0)("LastLCL"), 690, 545, 0)
        End If


        cb1.EndText()

        'This AVE
        cb1.BeginText()
        cb1.SetColorFill(GrayColor.BLUE)
        If IsDBNull(dtTran.Rows(0)("AVE")) Then
            cb1.ShowTextAligned(1, 0, 480, 545, 0)
        Else
            cb1.ShowTextAligned(1, dtTran.Rows(0)("AVE"), 480, 545, 0)
        End If

        If IsDBNull(dtTran.Rows(0)("LastAVE")) Then
            cb1.ShowTextAligned(1, 0, 640, 545, 0)
        Else
            cb1.ShowTextAligned(1, dtTran.Rows(0)("LastAVE"), 640, 545, 0)
        End If

        cb1.EndText()

        cb1.BeginText()
        cb1.SetColorFill(GrayColor.BLACK)
        cb1.SetTextMatrix(37, 729)

        'Package Name 
        cb1.ShowTextAligned(1, dtTran.Rows(0)("Package"), 260, 550, 0)
        'Device Name
        cb1.ShowTextAligned(1, dtTran.Rows(0)("DeviceName"), 350, 550, 0)
        'Thaitime
        cb1.ShowTextAligned(1, dtTran.Rows(0)("Thaitime"), 534, 570, 0)

        'Lasttime 
        If IsDBNull(dtTran.Rows(0)("LastLCL")) Then
            cb1.ShowTextAligned(1, 0, 680, 570, 0)
        Else
            cb1.ShowTextAligned(1, dtTran.Rows(0)("LastTime"), 680, 570, 0)
        End If

        'Session("SheetFL")
        If IsDBNull(Session("SheetFL")) Then
            cb1.ShowTextAligned(1, 0, 750, 555, 0)
        Else
            cb1.ShowTextAligned(1, Session("SheetFL"), 749, 550, 0)
        End If

        'Session("Chief")
        If IsDBNull(Session("Chief")) Then
            cb1.ShowTextAligned(1, 0, 750, 555, 0)
        Else
            cb1.ShowTextAligned(1, Session("Chief"), 800, 555, 0)
            cb1.ShowTextAligned(1, Session("ChiefDate"), 800, 545, 0)
        End If



        cb1.EndText()
        'Next


        ' Put the text on a new page in the PDF 
        Dim page As PdfImportedPage = writer.GetImportedPage(reader, 1)
        cb.AddTemplate(page, 0, 0)
        cb1.AddTemplate(page, 0, 0)

        ''Close the objects
        document.Close()
        fs.Close()
        writer.Close()

        reader.Close()
        Response.ContentType = "application/pdf"
        Response.AppendHeader("Content-Disposition", "attachment; filename=FLYieldgraphData.pdf")
        Response.TransmitFile("//10.28.33.113/www/TestYieldGraphControl/File/FLYieldgraphData.pdf")
        Response.End()


    End Sub


    Protected Sub GridView1_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        '*** Date ***'
        Dim lblDate As Label = CType(e.Row.FindControl("lblDate"), Label)
        If Not IsNothing(lblDate) Then
            lblDate.Text = e.Row.DataItem("LotEndTime")
        End If

        '*** YLD ***'
        Dim lblYLD As Label = CType(e.Row.FindControl("lblYLD"), Label)
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
            lblProgramVer.Text = e.Row.DataItem("FTProgram")
        End If

        '*** Ach ***'
        Dim lblAch As Label = CType(e.Row.FindControl("lblAch"), Label)
        If Not IsNothing(lblAch) Then
            lblAch.Text = e.Row.DataItem("Ach")
        End If

        '*** Bch ***'
        Dim lblBch As Label = CType(e.Row.FindControl("lblBch"), Label)
        If Not IsNothing(lblBch) Then
            lblBch.Text = e.Row.DataItem("Bch")
        End If

        '*** Cch ***'
        Dim lblCch As Label = CType(e.Row.FindControl("lblCch"), Label)
        If Not IsNothing(lblCch) Then
            lblCch.Text = e.Row.DataItem("Cch")
        End If

        '*** Dch ***'
        Dim lblDch As Label = CType(e.Row.FindControl("lblDch"), Label)
        If Not IsNothing(lblDch) Then
            lblDch.Text = e.Row.DataItem("Dch")
        End If

        '*** Ech ***'
        Dim lblEch As Label = CType(e.Row.FindControl("lblEch"), Label)
        If Not IsNothing(lblEch) Then
            lblEch.Text = e.Row.DataItem("Ech")
        End If

        '*** Fch ***'
        Dim lblFch As Label = CType(e.Row.FindControl("lblFch"), Label)
        If Not IsNothing(lblFch) Then
            lblFch.Text = e.Row.DataItem("Fch")
        End If

        '*** Gch ***'
        Dim lblGch As Label = CType(e.Row.FindControl("lblGch"), Label)
        If Not IsNothing(lblGch) Then
            lblGch.Text = e.Row.DataItem("Gch")
        End If

        '*** Hch ***'
        Dim lblHch As Label = CType(e.Row.FindControl("lblHch"), Label)
        If Not IsNothing(lblHch) Then
            lblHch.Text = e.Row.DataItem("Hch")
        End If

        '*** MAX-MIN(R) ***'
        Dim lblMAXMIN As Label = CType(e.Row.FindControl("lblMAXMIN"), Label)
        If Not IsNothing(lblMAXMIN) Then
            Dim Max1, Max2, Max3, Max4, Max5, Max6, Max7 As Decimal
            Dim Min1, Min2, Min3, Min4, Min5, Min6, Min7 As Decimal

            If e.Row.DataItem("Ach") <> 0 And e.Row.DataItem("Bch") <> 0 Then
                Max1 = Math.Max(e.Row.DataItem("Ach"), e.Row.DataItem("Bch"))
                Min1 = Math.Min(e.Row.DataItem("Ach"), e.Row.DataItem("Bch"))
            End If
            If e.Row.DataItem("Cch") <> 0 Then
                Max2 = Math.Max(Max1, e.Row.DataItem("cch"))
                Min2 = Math.Min(Min1, e.Row.DataItem("cch"))
            End If
            If e.Row.DataItem("Dch") <> 0 Then
                Max3 = Math.Max(Max2, e.Row.DataItem("Dch"))
                Min3 = Math.Min(Min2, e.Row.DataItem("Dch"))
            End If
            If e.Row.DataItem("Ech") <> 0 Then
                Max4 = Math.Max(Max3, e.Row.DataItem("Ech"))
                Min4 = Math.Min(Min3, e.Row.DataItem("Ech"))
            End If
            If e.Row.DataItem("Fch") <> 0 Then
                Max5 = Math.Max(Max4, e.Row.DataItem("Fch"))
                Min5 = Math.Min(Min4, e.Row.DataItem("Fch"))
            End If
            If e.Row.DataItem("Gch") <> 0 Then
                Max6 = Math.Max(Max5, e.Row.DataItem("Gch"))
                Min6 = Math.Min(Min5, e.Row.DataItem("Gch"))
            End If
            If e.Row.DataItem("Hch") <> 0 Then
                Max7 = Math.Max(Max6, e.Row.DataItem("Hch"))
                Min7 = Math.Min(Min6, e.Row.DataItem("Hch"))
            End If

            If Max7 <> 0 And Min7 <> 0 Then
                lblMAXMIN.Text = Max7 - Min7
            ElseIf Max6 <> 0 And Min6 <> 0 Then
                lblMAXMIN.Text = Max6 - Min6
            ElseIf Max5 <> 0 And Min5 <> 0 Then
                lblMAXMIN.Text = Max5 - Min5
            ElseIf Max4 <> 0 And Min4 <> 0 Then
                lblMAXMIN.Text = Max4 - Min4
            ElseIf Max3 <> 0 And Min3 <> 0 Then
                lblMAXMIN.Text = Max3 - Min3
            ElseIf Max2 <> 0 And Min2 <> 0 Then
                lblMAXMIN.Text = Max2 - Min2
            ElseIf Max1 <> 0 And Min1 <> 0 Then
                lblMAXMIN.Text = Max1 - Min1
            End If

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

    Public Overrides Sub VerifyRenderingInServerForm(control As Control)
        ' Verifies that the control is rendered 
    End Sub
End Class