<%@ Page Title="" Debug="true" Language="C#" MasterPageFile="~/Main.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<script runat="server">
    protected void gridActivity_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (gridActivity.DataKeys[gridActivity.SelectedIndex].Values["TypeID"].ToString() == "0")
        {
            Response.Redirect("editcalendar.aspx?l=y&id=" + gridActivity.SelectedDataKey.Value.ToString());
        }
        else
        {
            Response.Redirect("editactivity.aspx?l=y&id=" + gridActivity.SelectedDataKey.Value.ToString());
        }
    }

    protected void gridActivity_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "MyDelete")
        {
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            string val = this.gridActivity.DataKeys[rowIndex].Values["ActivityID"].ToString();

            DataClassesDataContext myDB = new DataClassesDataContext();
            myDB.spDeleteActivity(Convert.ToInt32(Session["EmpID"]), Convert.ToInt32(val));

            gridActivity.DataBind();
        }
    }

    protected void gridAdmin_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (gridAdmin.DataKeys[gridAdmin.SelectedIndex].Values["TypeID"].ToString() == "0")
        {
            Response.Redirect("editcalendar.aspx?l=y&id=" + gridAdmin.SelectedDataKey.Value.ToString());
        }
        else
        {
            Response.Redirect("editActivity.aspx?l=y&id=" + gridAdmin.SelectedDataKey.Value.ToString());
        }
    }

    protected void gridAdmin_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "MyDelete")
        {
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            string val = this.gridAdmin.DataKeys[rowIndex].Values["ActivityID"].ToString();

            DataClassesDataContext myDB = new DataClassesDataContext();
            myDB.spDeleteActivity(Convert.ToInt32(Session["EmpID"]), Convert.ToInt32(val));

            gridAdmin.DataBind();
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToInt32(Session["AccessLevel"]) == 1)
        {
            divCoor.Visible = true;
            divAdmin.Visible = false;
        }
        else
        {
            if (Convert.ToInt32(Session["AccessLevel"]) == 3)
            {
                gridAdmin.Columns[15].Visible = false;
            }
            divCoor.Visible = false;
            divAdmin.Visible = true;
        }
    }

protected void  DropFieldCoordinator_SelectedIndexChanged(object sender, EventArgs e)
{
    gridAdmin.DataBind();
}


protected void cmdGo_Click(object sender, EventArgs e)
{
    if (Convert.ToInt32(Session["AccessLevel"]) == 1)
    {
        gridAdmin.DataBind();
    }
    else
    {
        gridActivity.DataBind();
    }
}
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1>Activities</h1>
    <asp:Label ID="lblMessage" runat="server" /></br>
<div id="divDates" runat="server">
<table cellpadding="2" cellspacing="0" border="0">
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
        <td>
            <asp:Button ID="cmdGo" Text="Go" runat="server" onclick="cmdGo_Click" />
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>"
                SelectCommand="spSelectAgencies" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter DefaultValue="00" Name="District" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            Agency:
            <asp:DropDownList ID="dropAgency" runat="server" DataSourceID="SqlDataSource3" AppendDataBoundItems="true" DataTextField="AgencyName"
                DataValueField="ag_Key">
                <asp:ListItem Text="All" Value="00" Selected="True"></asp:ListItem>
            </asp:DropDownList>
            
        </td>
    </tr>
</table>
</div>
<div id="divCoor" runat="server">
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
        SelectCommand="spSelectSearchActivityDetails" 
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="EmpID" SessionField="EmpID" Type="Int32" />
            <asp:ControlParameter ControlID="txtDate" Name="StartDate" PropertyName="Text" 
                Type="DateTime" />
            <asp:ControlParameter ControlID="txtEndDate" Name="EndDate" PropertyName="Text" 
                Type="DateTime" />
            <asp:ControlParameter ControlID="dropAgency" DefaultValue="00" Name="AgencyKey" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="gridActivity" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" EmptyDataText="No data available."
        ForeColor="#333333" GridLines="None" DataKeyNames="ActivityID,TypeID" 
        AllowPaging="True" PageSize="15"
        onselectedindexchanged="gridActivity_SelectedIndexChanged" 
        OnRowCommand="gridActivity_RowCommand" HorizontalAlign="Center" >
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="ActivityID" HeaderText="ActivityID" ReadOnly="True" 
                SortExpression="ActivityID" Visible="False" />
            <asp:BoundField DataField="TypeID" HeaderText="TypeID" ReadOnly="True" 
                SortExpression="TypeID" Visible="False" />
            <asp:BoundField DataField="ActivityType" HeaderText="Activity Type" 
                ReadOnly="True" SortExpression="ActivityType" />
            <asp:BoundField DataField="VisitDate" HeaderText="Date" ReadOnly="True" 
                SortExpression="VisitDate" DataFormatString="{0:d}" />
            <asp:BoundField DataField="VisitHours" HeaderText="Hours" ItemStyle-CssClass="center" ReadOnly="true"
                SortExpression="VisitHours" />
            <asp:BoundField DataField="AgencyName" HeaderText="Agency Name" ReadOnly="True" 
                SortExpression="AgencyName" />
            <asp:TemplateField HeaderText="Phone" ItemStyle-CssClass="center" SortExpression="Phone">
                <ItemTemplate>
                    <asp:Checkbox ID="chkPhone" Enabled="false" runat="server" Checked='<%# Bind("Phone") %>'></asp:Checkbox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="OnSite" ItemStyle-CssClass="center" SortExpression="OnSite">
                <ItemTemplate>
                    <asp:Checkbox ID="chkOnSite" Enabled="false" runat="server" Checked='<%# Bind("OnSite") %>'></asp:Checkbox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Attemp" ItemStyle-CssClass="center" SortExpression="Attempted">
                <ItemTemplate>
                    <asp:Checkbox ID="chkAttempted" Enabled="false" runat="server" Checked='<%# Bind("Attempted") %>'></asp:Checkbox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Atix" ItemStyle-CssClass="center" SortExpression="Atix">
                <ItemTemplate>
                    <asp:Checkbox ID="chkAtix" Enabled="false" runat="server" Checked='<%# Bind("Atix") %>'></asp:Checkbox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="CISOP" ItemStyle-CssClass="center" SortExpression="CISOP">
                <ItemTemplate>
                    <asp:Checkbox ID="chkCISOP" Enabled="false" runat="server" Checked='<%# Bind("CISOP") %>'></asp:Checkbox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="SSL" HeaderText="SSL" ItemStyle-CssClass="center" ReadOnly="True" 
                SortExpression="SSL" >
            </asp:BoundField>
            <asp:TemplateField HeaderText="Demoed" ItemStyle-CssClass="center" SortExpression="Demoed">
                <ItemTemplate>
                    <asp:Checkbox ID="chkDemoed" Enabled="false" runat="server" Checked='<%# Bind("Demoed") %>'></asp:Checkbox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="FCR" ItemStyle-CssClass="center" SortExpression="Background">
                <ItemTemplate>
                    <asp:Checkbox ID="chkBackground" Enabled="false" runat="server" Checked='<%# Bind("Background") %>'></asp:Checkbox>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:CommandField ShowSelectButton="True" />
            <asp:TemplateField><ItemTemplate>
                <asp:imageButton ID="cmdDeleteActivity" runat="server" ImageUrl="~/images/redxgrey.gif" OnClientClick="return confirm('Are you sure you want to delete this record?');" CommandName="MyDelete" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"></asp:imageButton>
            </ItemTemplate></asp:TemplateField>
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#234e6c" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#234e6c" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#234e6c" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
</div>
<div id="divAdmin" runat="server">
<table cellpadding="10" cellspacing="0" border="0">
    <tr>
        <td>Law Enforcement Coordinator:
            <asp:SqlDataSource ID="SqlFieldCoordinator" runat="server" 
                ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                SelectCommand="spSelectFieldCoordinators" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:DropDownList ID="DropFieldCoordinator" runat="server" AppendDataBoundItems="true"
                DataSourceID="SqlFieldCoordinator" DataTextField="FullName" 
                DataValueField="FCS_u_emp_ID" AutoPostBack="true"
                onselectedindexchanged="DropFieldCoordinator_SelectedIndexChanged">
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                SelectCommand="spSelectSearchActivityDetails" 
                SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropFieldCoordinator" Name="EmpID" 
                                    PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="txtDate" Name="StartDate" PropertyName="Text" 
                        Type="DateTime" />
                    <asp:ControlParameter ControlID="txtEndDate" Name="EndDate" PropertyName="Text" 
                        Type="DateTime" />
                    <asp:ControlParameter ControlID="dropAgency" DefaultValue="00" Name="AgencyKey" 
                        PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="gridAdmin" runat="server" AllowSorting="True" 
                AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" EmptyDataText="No data available."
                ForeColor="#333333" GridLines="None" DataKeyNames="ActivityID,TypeID" 
                AllowPaging="True" PageSize="15"
                onselectedindexchanged="gridAdmin_SelectedIndexChanged" 
                OnRowCommand="gridAdmin_RowCommand" HorizontalAlign="Center" >
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="ActivityID" HeaderText="ActivityID" ReadOnly="True" 
                        SortExpression="ActivityID" Visible="False" />
                    <asp:BoundField DataField="TypeID" HeaderText="TypeID" ReadOnly="True" 
                        SortExpression="TypeID" Visible="False" />
                    <asp:BoundField DataField="ActivityType" HeaderText="Activity Type" 
                        ReadOnly="True" SortExpression="ActivityType" />
                    <asp:BoundField DataField="VisitDate" HeaderText="Date" ReadOnly="True" 
                        SortExpression="VisitDate" DataFormatString="{0:d}" />
                    <asp:BoundField DataField="VisitHours" HeaderText="Hours" ItemStyle-CssClass="center" ReadOnly="true"
                        SortExpression="VisitHours" />
                    <asp:BoundField DataField="AgencyName" HeaderText="Agency Name" ReadOnly="True" 
                        SortExpression="AgencyName" />
                    <asp:TemplateField HeaderText="Phone" ItemStyle-CssClass="center" SortExpression="Phone">
                        <ItemTemplate>
                            <asp:Checkbox ID="chkPhone" Enabled="false" runat="server" Checked='<%# Bind("Phone") %>'></asp:Checkbox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="OnSite" ItemStyle-CssClass="center" SortExpression="OnSite">
                        <ItemTemplate>
                            <asp:Checkbox ID="chkOnSite" Enabled="false" runat="server" Checked='<%# Bind("OnSite") %>'></asp:Checkbox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Attemp" ItemStyle-CssClass="center" SortExpression="Attempted">
                        <ItemTemplate>
                            <asp:Checkbox ID="chkAttempted" Enabled="false" runat="server" Checked='<%# Bind("Attempted") %>'></asp:Checkbox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Atix" ItemStyle-CssClass="center" SortExpression="Atix">
                        <ItemTemplate>
                            <asp:Checkbox ID="chkAtix" Enabled="false" runat="server" Checked='<%# Bind("Atix") %>'></asp:Checkbox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="CISOP" ItemStyle-CssClass="center" SortExpression="CISOP">
                        <ItemTemplate>
                            <asp:Checkbox ID="chkCISOP" Enabled="false" runat="server" Checked='<%# Bind("CISOP") %>'></asp:Checkbox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="SSL" HeaderText="SSL" ItemStyle-CssClass="center" ReadOnly="True" 
                        SortExpression="SSL" >
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Demoed" ItemStyle-CssClass="center" SortExpression="Demoed">
                        <ItemTemplate>
                            <asp:Checkbox ID="chkDemoed" Enabled="false" runat="server" Checked='<%# Bind("Demoed") %>'></asp:Checkbox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="FCR" ItemStyle-CssClass="center" SortExpression="Background">
                        <ItemTemplate>
                            <asp:Checkbox ID="chkBackground" Enabled="false" runat="server" Checked='<%# Bind("Background") %>'></asp:Checkbox>
                        </ItemTemplate>
                    </asp:TemplateField>
            
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:TemplateField><ItemTemplate>
                        <asp:imageButton ID="cmdDeleteActivity" runat="server" ImageUrl="~/images/redxgrey.gif" OnClientClick="return confirm('Are you sure you want to delete this record?');" CommandName="MyDelete" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"></asp:imageButton>
                    </ItemTemplate></asp:TemplateField>
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#234e6c" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#234e6c" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#234e6c" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
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

