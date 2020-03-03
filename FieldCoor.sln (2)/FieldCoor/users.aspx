<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>

<script runat="server">

protected void  GridUsers_SelectedIndexChanged(object sender, EventArgs e)
{
    Response.Redirect("useredit.aspx?id=" + GridUsers.SelectedDataKey.Value.ToString());
}

protected void Page_Load(object sender, EventArgs e)
{
    if (!IsPostBack)
    {
        divNewUser.Visible = false;
        if (Request.QueryString["u"] == "y")
        {
            lblMessage.Text = "Users was updated successfully.";
        }
    }
}

protected void cmdAddUser_Click(object sender, EventArgs e)
{
    divNewUser.Visible = true;
    cmdAddUser.Visible = false;
}

protected void cmdSave_Click(object sender, EventArgs e)
{
    
    DataClassesDataContext myDB = new DataClassesDataContext();
    myDB.spInsertUser(Convert.ToInt32(DropEmployee.SelectedItem.Value), DropRegion.SelectedItem.Value.ToString(), DropHomeDistrict.SelectedItem.Value.ToString(), Convert.ToInt32(DropAccessLevel.SelectedItem.Value));
    GridUsers.DataBind();
    divNewUser.Visible = false;
    cmdAddUser.Visible = true;
    
}

protected void cmdCancel_Click(object sender, EventArgs e)
{
    divNewUser.Visible = false;
    cmdAddUser.Visible = true;
}
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1>User Maintenance</h1>
<table cellpadding="5" cellspacing="0" border="0">
    <tr>
        <td class="center">
            <font color="red">
                <asp:Label ID="lblMessage" runat="server"></asp:Label></font>
        </td>
    </tr>
    <tr>
        <td>
            <asp:SqlDataSource ID="SqlUsers" runat="server" 
                ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                SelectCommand="spSelectUsers" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:GridView ID="GridUsers" runat="server" AutoGenerateColumns="False" 
                GridLines="None" DataKeyNames="FCS_u_ID" ForeColor="#333333" CellPadding="4" 
                DataSourceID="SqlUsers" 
                onselectedindexchanged="GridUsers_SelectedIndexChanged">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="FCS_u_ID" HeaderText="FCS_u_ID" 
                        InsertVisible="False" ReadOnly="True" SortExpression="FCS_u_ID" 
                        Visible="False" />
                    <asp:BoundField DataField="FCS_u_emp_ID" HeaderText="FCS_u_emp_ID" 
                        SortExpression="FCS_u_emp_ID" Visible="False" />
                    <asp:BoundField DataField="FCS_u_access_level" HeaderText="FCS_u_access_level" 
                        SortExpression="FCS_u_access_level" Visible="False" />
                    <asp:BoundField DataField="FullName" HeaderText="Name" ReadOnly="True" 
                        SortExpression="FullName" />
                    <asp:BoundField DataField="FCS_u_district" HeaderText="Access District(s)" 
                        SortExpression="FCS_u_district" />
                    <asp:BoundField DataField="FCS_u_home_district" HeaderText="Main District"
                        SortExpression="FCS_u_home_district" />
                    <asp:BoundField DataField="FCS_al_access_level_name" HeaderText="Access Level" 
                        SortExpression="FCS_al_access_level_name" />
                    <asp:CommandField ShowSelectButton="True" />
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
    <tr>
        <td class="center"><asp:Button ID="cmdAddUser" Text="Add New User" runat="server" 
                onclick="cmdAddUser_Click" /></td>
    </tr>
</table>
<div id="divNewUser" runat="server">
<table cellpadding="5" cellspacing="0" border="0">
    <tr>
        <td>Employee: 
            <asp:SqlDataSource ID="SqlEmployee" runat="server" 
                ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                SelectCommand="spSelectEmployees" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:DropDownList ID="DropEmployee" runat="server" DataSourceID="SqlEmployee" 
                DataTextField="FullName" AppendDataBoundItems="true" DataValueField="ID">
            </asp:DropDownList>
        </td>    
    </tr>
    <tr>
        <td>Access District: 
            <asp:SqlDataSource ID="SqlRegion" runat="server" 
                ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                SelectCommand="spSelectRegions" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:DropDownList ID="DropRegion" runat="server" DataSourceID="SqlRegion" 
                DataTextField="ag_Region" AppendDataBoundItems="true" DataValueField="ag_Region">
                <asp:ListItem Text="All" Value="00" Selected="True"></asp:ListItem>
            </asp:DropDownList>
        </td>    
    </tr>
    <tr>
        <td>Home District: 
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                SelectCommand="spSelectRegions" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:DropDownList ID="DropHomeDistrict" runat="server" DataSourceID="SqlDataSource1" 
                DataTextField="ag_Region" AppendDataBoundItems="true" DataValueField="ag_Region">
                <asp:ListItem Text="All" Value="00" Selected="True"></asp:ListItem>
            </asp:DropDownList>
        </td>    
    </tr>
    <tr>
        <td>Access Level: 
            <asp:SqlDataSource ID="SqlAccessLevel" runat="server" 
                ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                SelectCommand="spSelectAccessLevels" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:DropDownList ID="DropAccessLevel" runat="server" 
                DataSourceID="SqlAccessLevel" AppendDataBoundItems="true" DataTextField="FCS_al_access_level_name" 
                DataValueField="FCS_al_access_level">
            </asp:DropDownList>
        </td>    
    </tr>
    <tr>
        <td class="center"><asp:Button ID="cmdSave" Text="Save" runat="server" 
                onclick="cmdSave_Click" /><img src="images/spacer.gif" width="15" alt="" /><asp:Button 
                ID="cmdCancel" Text="Cancel" runat="server" onclick="cmdCancel_Click" /></td>
    </tr>
</table>
</div>
</asp:Content>

