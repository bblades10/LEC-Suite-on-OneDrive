<%@ Page Title="" Language="C#" Debug="true" MasterPageFile="~/Main.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<script runat="server">

protected void gridAdmin_SelectedIndexChanged(object sender, EventArgs e)
{
    if (gridAdmin.DataKeys[gridAdmin.SelectedIndex].Values["TypeID"].ToString() == "0")
    {
        Response.Redirect("editcalendar.aspx?l=y&id=" + gridAdmin.SelectedDataKey.Value.ToString());
    }
    else
    {
        Response.Redirect("editschedule.aspx?l=y&id=" + gridAdmin.SelectedDataKey.Value.ToString());
    }
}

protected void gridAdmin_RowCommand(object sender, GridViewCommandEventArgs e)
{   
    if (e.CommandName == "MyDelete")
    {
        int rowIndex = int.Parse(e.CommandArgument.ToString());
        string val = this.gridAdmin.DataKeys[rowIndex].Values["RecordID"].ToString();

        DataClassesDataContext myDB = new DataClassesDataContext();
        myDB.spDeleteScheduledActivity(Convert.ToInt32(Session["EmpID"]), Convert.ToInt32(val));

        gridAdmin.DataBind();
    }

}

protected void Page_Load(object sender, EventArgs e)
{
    
}

protected void DropFieldCoordinator_SelectedIndexChanged(object sender, EventArgs e)
{
    //gridAdmin.DataBind();
}

protected void cmdGo_Click(object sender, EventArgs e)
{
    gridAdmin.DataBind();
}    
    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Schedule</h1>
    <asp:Label ID="lblMessage" runat="server" />

<div id="divAdmin" runat="server">
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
    <tr>
        <td>Law Enforcement Coordinator:
            <asp:SqlDataSource ID="SqlFieldCoordinator" runat="server" 
                ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                SelectCommand="spSelectFieldCoordinators" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:DropDownList ID="DropFieldCoordinator" runat="server" AppendDataBoundItems="true"
                DataSourceID="SqlFieldCoordinator" DataTextField="FullName" 
                DataValueField="FCS_u_emp_ID"><%-- AutoPostBack="true"
                onselectedindexchanged="DropFieldCoordinator_SelectedIndexChanged">--%>
            </asp:DropDownList>
            <asp:Button ID="Button1" Text="Go" runat="server" 
                onclick="cmdGo_Click" />
        </td>
    </tr>
</table>
<table cellpadding="10" cellspacing="0" border="0">
    <tr>
        <td>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                SelectCommand="spSelectAllFCScheduledActivitySelection" 
                SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropFieldCoordinator" Name="EmpID" 
                                    PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="txtDate" DbType="Date" Name="StartDate" 
                        PropertyName="Text" />
                    <asp:ControlParameter ControlID="txtEndDate" DbType="Date" Name="EndDate" 
                        PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="gridAdmin" runat="server" AllowSorting="True" 
                AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" 
                ForeColor="#333333" GridLines="None" DataKeyNames="RecordID,TypeID"
                onselectedindexchanged="gridAdmin_SelectedIndexChanged" OnRowCommand="gridAdmin_RowCommand" >
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="RecordID" HeaderText="RecordID" ReadOnly="True" 
                        SortExpression="RecordID" Visible="False" />
                    <asp:BoundField DataField="TypeID" HeaderText="TypeID" ReadOnly="True" 
                        SortExpression="TypeID" Visible="False" />
                    <asp:BoundField DataField="ActivityType" HeaderText="Activity Type" 
                        ReadOnly="True" SortExpression="ActivityType" />
                    <asp:BoundField DataField="VisitDate" HeaderText="Date" ReadOnly="True" 
                        SortExpression="VisitDate" DataFormatString="{0:d}" />
                    <asp:BoundField DataField="AgencyName" HeaderText="Agency Name" ReadOnly="True" 
                        SortExpression="AgencyName" />
                    <asp:BoundField DataField="AgencyCity" HeaderText="City" ReadOnly="True" 
                        SortExpression="AgencyCity" />
                    <asp:BoundField DataField="AgencyState" HeaderText="State" 
                        ReadOnly="True" SortExpression="AgencyState" />
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:TemplateField><ItemTemplate>
                        <asp:imageButton ID="cmdDeleteScheduleActivity" runat="server" ImageUrl="~/images/redxgrey.gif" OnClientClick="return confirm('Are you sure you want to delete this record?');" CommandName="MyDelete" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"></asp:imageButton>
                    </ItemTemplate></asp:TemplateField>
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#234e6c" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#234e6c" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
        </td>
    </tr>
</table>
</div>
</asp:Content>

