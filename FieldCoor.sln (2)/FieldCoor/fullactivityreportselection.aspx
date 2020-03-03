<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<script runat="server">

    protected void cmdGo_Click(object sender, EventArgs e)
    {
        Response.Redirect("fullactivityreport.aspx?fc=" + DropFieldCoordinator.SelectedItem.Value + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
    }

    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1><asp:Label ID="lblTitle" runat="server"></asp:Label></h1>

<div id="divFieldCoor" runat="server">
<table cellpadding="10" cellspacing="0" border="0">
    <tr>
        <td>Law Enforcement Coordinator:
            <asp:SqlDataSource ID="SqlFieldCoordinator" runat="server" 
                ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                SelectCommand="spSelectFieldCoordinators" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:DropDownList ID="DropFieldCoordinator" runat="server" AppendDataBoundItems="true"
                DataSourceID="SqlFieldCoordinator" DataTextField="FullName" 
                DataValueField="FCS_u_emp_ID">
            </asp:DropDownList>
        </td>
    </tr>
</table>
</div>

<div id="divDates" runat="server">
<table cellpadding="10" cellspacing="0" border="0">
    <tr>
        <td>
            Begin Date: <asp:TextBox ID="txtDate" Columns="10" runat="server"></asp:TextBox>
            <asp:CalendarExtender ID="CalendarExtender1" TargetControlID="txtDate" PopupButtonID="cal"
                        runat="server">
                    </asp:CalendarExtender>
                    <asp:ImageButton ImageUrl="images/Calendar_scheduleHS.png" ID="cal" CausesValidation="false" runat="server" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtDate"
                        CssClass="validation" Text="*" runat="Server" /><asp:RegularExpressionValidator
                                                ID="RegularExpressionValidator6" runat="server" CssClass="validation" ErrorMessage="MM/DD/YYYY" ValidationExpression="\d{1,2}\/\d{1,2}/\d{4}"
                                                ControlToValidate="txtDate" />
        </td>
    </tr>
    <tr>
        <td>
            End Date: <asp:TextBox ID="txtEndDate" Columns="10" runat="server"></asp:TextBox>
            <asp:CalendarExtender ID="CalendarExtender2" TargetControlID="txtEndDate" PopupButtonID="cal1"
                        runat="server">
                    </asp:CalendarExtender>
                    <asp:ImageButton ImageUrl="images/Calendar_scheduleHS.png" ID="cal1" CausesValidation="false" runat="server" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtEndDate"
                        CssClass="validation" Text="*" runat="Server" /><asp:RegularExpressionValidator
                                                ID="RegularExpressionValidator1" runat="server" CssClass="validation" ErrorMessage="MM/DD/YYYY" ValidationExpression="\d{1,2}\/\d{1,2}/\d{4}"
                                                ControlToValidate="txtEndDate" />
        </td>
    </tr>
</table>
</div>

<table cellpadding="10" cellspacing="0" border="0">
    <tr>
        <td class="center"><asp:Button ID="cmdGo" Text="Go" runat="server" 
                onclick="cmdGo_Click" /></td>
    </tr>
</table>
</asp:Content>

