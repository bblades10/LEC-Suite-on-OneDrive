﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<script runat="server">
    protected void dropCategories_SelectedIndexChanged(object sender, EventArgs e)
    {
        dropSubCategories.DataBind();
    }


    protected void SubmitBtn_Click(object sender, EventArgs e)
    {
        DataClasses2DataContext myDB = new DataClasses2DataContext();
        myDB.sp_INT_AddCalRecord(Convert.ToInt32(Session["EmpID"]), Convert.ToDateTime(txtStartDate.Text), Convert.ToDateTime(txtEndDate.Text), txtStartTime.Text, txtReturnTime.Text, Convert.ToInt32(dropCategories.SelectedItem.Value), Convert.ToInt32(dropSubCategories.SelectedItem.Value), txtComment.Text, Convert.ToInt32(Session["EmpID"]));
        Response.Redirect("listcalendar.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<h1>Add Personal Calendar</h1>
    <table width="400" border="0" cellspacing="0" cellpadding="5">
        <tr>
            <td colspan="3">
                <i>
                    <asp:ValidationSummary ID="valSum" runat="server" HeaderText="* Required Fields"
                        DisplayMode="SingleParagraph" Font-Size="12px" />
                </i>
            </td>
        </tr>
        <tr>
            <td>
                <font class="normal">Start Date:</font>
            </td>
            <td>
                <asp:TextBox ID="txtStartDate" size="10" MaxLength="10" runat="server" />
                <asp:CalendarExtender ID="CalendarExtenderStart" TargetControlID="txtStartDate" PopupButtonID="cal" runat="server"></asp:CalendarExtender>
                <asp:imagebutton ImageUrl="images/Calendar_scheduleHS.png" CausesValidation="false" id="cal" runat="server" />
            </td>
            <td>
                <img src="images/spacer.gif" width="1" height="1" border="0" alt=""><asp:RequiredFieldValidator
                    ID="RequiredFieldValidator1" ControlToValidate="txtStartDate" Text="*" runat="Server" />
            </td>
        </tr>
        <tr>
            <td>
                <font class="normal">End Date:</font>
            </td>
            <td>
                <asp:TextBox ID="txtEndDate" size="10" MaxLength="10" runat="server" />
                <asp:CalendarExtender ID="CalendarExtenderEnd" TargetControlID="txtEndDate" PopupButtonID="cal2" runat="server"></asp:CalendarExtender>
                <asp:imagebutton ImageUrl="images/Calendar_scheduleHS.png" CausesValidation="false" id="cal2" runat="server" />
            </td>
            <td>
                <img src="images/spacer.gif" width="1" height="1" border="0" alt=""><asp:RequiredFieldValidator
                    ID="RequiredFieldValidator2" ControlToValidate="txtEndDate" Text="*" runat="Server" />
            </td>
        </tr>
        <tr>
            <td>
                <font class="normal">Departing Time:</font>
            </td>
            <td>
                <asp:TextBox ID="txtStartTime" size="10" MaxLength="50" runat="server" />
            </td>
            <td>
                <img src="images/spacer.gif" width="1" height="1" border="0" alt="">
            </td>
        </tr>
        <tr>
            <td>
                <font class="normal">Anticipated Return Time:</font>
            </td>
            <td>
                <asp:TextBox ID="txtReturnTime" size="10" MaxLength="50" runat="server" />
            </td>
            <td>
                <img src="images/spacer.gif" width="1" height="1" border="0" alt="">
            </td>
        </tr>
        <tr>
            <td>
                <font class="normal">Event Category:</font>
            </td>
            <td>
                <asp:SqlDataSource ID="sqlCategories" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:EmployeeConnectionString %>" 
                    SelectCommand="sp_INT_SelectCalendarCategories" 
                    SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                <asp:DropDownList ID="dropCategories" AutoPostBack="True" OnSelectedIndexChanged="dropCategories_SelectedIndexChanged"
                    runat="server" DataTextField="cc_Category" DataValueField="cc_ID" 
                    DataSourceID="sqlCategories" />
                <td>
                    <img src="images/spacer.gif" width="1" height="1" border="0" alt=""><asp:RequiredFieldValidator
                        ID="RequiredFieldValidator5" ControlToValidate="dropCategories" Text="*" runat="Server" />
                </td>
        </tr>
        <tr>
            <td>
                <font class="normal">Event Sub-Category:</font>
            </td>
            <td>
                <asp:SqlDataSource ID="sqlSubCategories" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:EmployeeConnectionString %>" 
                    SelectCommand="sp_INT_SelectCalendarSubCategories" 
                    SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="dropCategories" Name="cc_ID" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:DropDownList ID="dropSubCategories" runat="server" 
                    DataSourceID="sqlSubCategories" DataTextField="cs_SubCategory" 
                    DataValueField="cs_ID" />
            </td>
            <td>
                <img src="images/spacer.gif" width="1" height="1" border="0" alt=""><asp:RequiredFieldValidator
                    ID="RequiredFieldValidator6" ControlToValidate="dropSubCategories" Text="*" runat="Server" />
            </td>
        </tr>
        <tr>
            <td>
                <font class="normal">Comment:</font>
            </td>
            <td>
                <asp:TextBox ID="txtComment" MaxLength="50" runat="server" />
            </td>
            <td>
                <img src="images/spacer.gif" width="1" height="1" border="0" alt=""><asp:RequiredFieldValidator
                    ID="RequiredFieldValidator7" ControlToValidate="txtComment" Text="*" runat="Server" />
            </td>
        </tr>
        <tr>
            <td>
                <img src="images/spacer.gif" width="1" height="1" border="0" alt="">
            </td>
            <%--<td colspan="2">
                <asp:Button ID="Button1" Text="Add Record" OnClick="SubmitBtn_Click" runat="server" />
            </td>--%>
        </tr>
    </table>

</asp:Content>

