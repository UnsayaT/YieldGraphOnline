Imports System.Data.SqlClient
Imports System.IO
Imports System.Web.UI.DataVisualization.Charting
Public Class AddMember
    Inherits System.Web.UI.Page

    Dim strConnString, strSQLInsert, strSQLOP, strSQLUpdate As String
    Dim objConn1 As SqlConnection
    Dim objCmd As SqlCommand
    Dim dtOP As SqlDataAdapter
    Dim dtDataOP As New DataTable

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        strConnString = "Server=172.16.0.102; Uid=System; PASSWORD=p@$$w0rd; database=DBX;"
        objConn1 = New SqlConnection(strConnString)
        objConn1.Open()


    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        'เช็คก่อนว่ามี รหัสพนักงานคนนี้หรือไม่
        strSQLOP = "SELECT * From [DBx].[dbo].[QYIOP_GL] WHERE  OP_No = '" & txtOPNo.Text & "' "
        dtOP = New SqlDataAdapter(strSQLOP, objConn1)
        dtOP.Fill(dtDataOP)

        If dtDataOP.Rows.Count > 0 Then
            strSQLUpdate = "Update [DBx].[dbo].[QYIOP_GL] Set GL_No = '" & Drop_GL.Text & "',Process ='" & DropProcess.Text & "' Where ID='" & dtDataOP.Rows(0)("ID") & "'"
            objCmd = New SqlCommand(strSQLUpdate, objConn1)
            objCmd.ExecuteNonQuery()

            ScriptManager.RegisterStartupScript(Me, Page.GetType, "alertMessage", "alert('Update Member Complete');location.href='FLYLDControlGraph.aspx';", True)

        Else
            strSQLInsert = "INSERT INTO [DBx].[dbo].[QYIOP_GL] (OP_No,GL_No,Process)  VALUES ('" & txtOPNo.Text & "','" & Drop_GL.Text & "','" & DropProcess.Text & "')"
            objCmd = New SqlCommand(strSQLInsert, objConn1)
            objCmd.ExecuteNonQuery()

            ScriptManager.RegisterStartupScript(Me, Page.GetType, "alertMessage", "alert('Update Member Complete');location.href='FLYLDControlGraph.aspx';", True)
        End If

    End Sub
End Class