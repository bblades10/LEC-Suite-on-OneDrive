<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DropHomeDistrict.DataBind();
            DropRegion.DataBind();
            DataClassesDataContext myDB = new DataClassesDataContext();
            var objRS = myDB.spSelectUser(Convert.ToInt32(Request.QueryString["id"]));
            foreach (spSelectUserResult record in objRS)
            {
                DropEmployee.SelectedValue = record.FCS_u_emp_ID.ToString();
                DropRegion.SelectedValue = record.FCS_u_district;
                DropHomeDistrict.SelectedValue = record.FCS_u_home_district;
                DropAccessLevel.SelectedValue = record.FCS_u_access_level.ToString();
            }
        }
    }

    protected void cmdCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("users.aspx");
    }

    protected void cmdSave_Click(object sender, EventArgs e)
    {
        DataClassesDataContext myDB = new DataClassesDataContext();
        myDB.spUpdateUser(Convert.ToInt32(Request.QueryString["id"]), Convert.ToInt32(DropEmployee.SelectedItem.Value), Convert.ToInt32(DropAccessLevel.SelectedItem.Value), DropRegion.SelectedItem.Value.ToString(), DropHomeDistrict.SelectedItem.Value.ToString());
        Response.Redirect("users.aspx?u=y");
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
                <asp:ListItem Text="All" Value="00"></asp:ListItem>
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
</asp:Content>

