Imports System.Data.SqlClient

Public Class Config_Add
    Inherits System.Web.UI.Page

    Dim objConn, objConnPro, objConnIS As SqlConnection
    Dim objCmd, objCmdPro, objCmdIS As SqlCommand

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim strConnString As String
        strConnString = "Server=172.16.0.102;Uid=System;PASSWORD=p@$$w0rd;database=DBx;Max Pool Size=400;Connect Timeout=600;"
        objConn = New SqlConnection(strConnString)
        objConn.Open()
    End Sub

    'ปุ่มADD 2020-09-03
    Protected Sub Button1_Click1(sender As Object, e As EventArgs) Handles Button1.Click

        Dim strSQLInsert As String
        Dim myDate As String
        myDate = Format(DateTime.Now, "dd/MM/yyyy")

        'Update LCL
        If RadioButton2.Checked = True Then
            Session("StatusLCL") = "FIX"
        ElseIf RadioButton3.Checked = True Then
            Session("StatusLCL") = "AUTO UPDATE"
        End If

        'FLOW NAME
        If DropDownList2.Text = "AUTO1" Then
            Session("FlowName") = "AUTO1"
        ElseIf DropDownList2.Text = "AUTO2" Then
            Session("FlowName") = "AUTO2"
        ElseIf DropDownList2.Text = "AUTO3" Then
            Session("FlowName") = "AUTO3"
        ElseIf DropDownList2.Text = "AUTO4" Then
            Session("FlowName") = "AUTO4"
        ElseIf DropDownList2.Text = "AUTO5" Then
            Session("FlowName") = "AUTO5"
        End If

        'PROCESS
        If DropDownList3.Text = "FT" Then
            Session("Process") = "FT"
        ElseIf DropDownList3.Text = "FL" Then
            Session("Process") = "FL"
        End If

        'Status Rank
        If RadioButton1.Checked = True Then
            Session("StatusRank") = "FIX"
        ElseIf RadioButton4.Checked = True Then
            Session("StatusRank") = "NOT FIX"
        End If


        strSQLInsert = "INSERT INTO [DBx].[dbo].[Cal_LCL] (PackageName,Process,FT_Flow_Name,UCL,UpdateTime,DeviceName,LCL,StatusLCL,StatusRank,Chief,SheetFL)  
VALUES ('" & DropDownList1.Text & "','" & Session("Process") & "','" & Session("FlowName") & "','100','" & myDate & " 07:00:00.000" & "','" & txtDEVICENAME.Text & "','" & txtLCL.Text & "','" & Session("StatusLCL") & "','" & Session("StatusRank") & "','" & txtChief.Text & "','" & txtsheet.Text & "')"
        objCmd = New SqlCommand(strSQLInsert, objConn)
        objCmd.ExecuteNonQuery()
        Page.RegisterClientScriptBlock("OnLoad", "<script>alert('ADD DATA COMPLETE')</script>")
    End Sub
End Class