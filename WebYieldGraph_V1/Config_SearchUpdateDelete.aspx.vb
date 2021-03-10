Imports System.Data.SqlClient

Public Class Config_SearchUpdateDelete
    Inherits System.Web.UI.Page
    Dim objConn, objConnPro, objConnIS As SqlConnection
    Dim objCmd, objCmdPro, objCmdIS As SqlCommand
    Dim strSQLSearch, strSQLUpdate, strSQLDelete As String
    Dim dtAdapterSearch As SqlDataAdapter
    Dim dtSearch As New DataTable

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim strConnString As String
        strConnString = "Server=172.16.0.102;Uid=System;PASSWORD=p@$$w0rd;database=DBx;Max Pool Size=400;Connect Timeout=600;"
        objConn = New SqlConnection(strConnString)
        objConn.Open()
    End Sub

    'SEARCH
    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        strSQLSearch = "Select * From [DBx].[dbo].[Cal_LCL] Where DeviceName ='" & txtDEVICENAME.Text & "' AND PackageName ='" & DropDownList1.Text & "'"
        dtAdapterSearch = New SqlDataAdapter(strSQLSearch, objConn)
        dtAdapterSearch.Fill(dtSearch)

        If dtSearch.Rows.Count > 0 Then
            LCL.Text = dtSearch.Rows(0)("LCL")

            If dtSearch.Rows(0)("FT_Flow_Name") = "AUTO1" Then
                DropDownList2.SelectedValue = "AUTO1"
            ElseIf dtSearch.Rows(0)("FT_Flow_Name") = "AUTO2" Then
                DropDownList2.SelectedValue = "AUTO2"
            ElseIf dtSearch.Rows(0)("FT_Flow_Name") = "AUTO3" Then
                DropDownList2.SelectedValue = "AUTO3"
            ElseIf dtSearch.Rows(0)("FT_Flow_Name") = "AUTO4" Then
                DropDownList2.SelectedValue = "AUTO4"
            ElseIf dtSearch.Rows(0)("FT_Flow_Name") = "AUTO5" Then
                DropDownList2.SelectedValue = "AUTO5"
            End If

            If dtSearch.Rows(0)("Process") = "FT" Then
                DropDownList3.SelectedValue = "FT"
            ElseIf dtSearch.Rows(0)("Process") = "FL" Then
                DropDownList3.SelectedValue = "FL"
            End If

            If dtSearch.Rows(0)("StatusLCL") = "FIX" Then
                RadioButton2.Checked = True
            ElseIf dtSearch.Rows(0)("StatusLCL") = "AUTO UPDATE" Then
                RadioButton3.Checked = True
            End If

            If IsDBNull(dtSearch.Rows(0)("StatusRank")) Then
            Else
                If dtSearch.Rows(0)("StatusRank") = "FIX" Then
                    RadioButton1.Checked = True
                ElseIf dtSearch.Rows(0)("StatusRank") = "NOT FIX" Then
                    RadioButton4.Checked = True
                End If
            End If

            If IsDBNull(dtSearch.Rows(0)("Chief")) Then
            Else
                txtChief.Text = dtSearch.Rows(0)("Chief")
            End If

            If IsDBNull(dtSearch.Rows(0)("SheetFL")) Then
            Else
                txtsheet.Text = dtSearch.Rows(0)("SheetFL")
            End If
        Else
                Page.RegisterClientScriptBlock("OnLoad", "<script>alert('NO DATA')</script>")
        End If
    End Sub

    'UPDATE
    Protected Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        'Update LCL
        If RadioButton2.Checked = True Then
            Session("StatusLCL") = "FIX"
        ElseIf RadioButton3.Checked = True Then
            Session("StatusLCL") = "AUTO UPDATE"
        End If

        'Status Rank
        If RadioButton1.Checked = True Then
            Session("StatusRank") = "FIX"
        ElseIf RadioButton4.Checked = True Then
            Session("StatusRank") = "NOT FIX"
        End If


        strSQLUpdate = "Update [DBx].[dbo].[Cal_LCL] Set LCL = '" & LCL.Text & "',StatusLCL ='" & Session("StatusLCL") & "',StatusRank ='" & Session("StatusRank") & "',Chief = '" & txtChief.Text & "',SheetFL = '" & txtsheet.Text & "' Where DeviceName ='" & txtDEVICENAME.Text & "' AND PackageName ='" & DropDownList1.Text & "'"
        objCmd = New SqlCommand(strSQLUpdate, objConn)
        objCmd.ExecuteNonQuery()
        Page.RegisterClientScriptBlock("OnLoad", "<script>alert('UPDATE DATA COMPLETE')</script>")
    End Sub

    'DELETE
    Protected Sub Button3_Click(sender As Object, e As EventArgs) Handles Button3.Click
        strSQLDelete = "DELETE FROM [DBx].[dbo].[Cal_LCL] Where DeviceName ='" & txtDEVICENAME.Text & "' AND PackageName ='" & DropDownList1.Text & "' "
        objCmd = New SqlCommand
        With objCmd
            .Connection = objConn
            .CommandText = strSQLDelete
            .CommandType = CommandType.Text
        End With
        objCmd.ExecuteNonQuery()

        objCmd = Nothing
        objCmd = Nothing
        objConn.Close()
        objConn = Nothing
        Page.RegisterClientScriptBlock("OnLoad", "<script>alert('DELETE DATA COMPLETE')</script>")
    End Sub

End Class