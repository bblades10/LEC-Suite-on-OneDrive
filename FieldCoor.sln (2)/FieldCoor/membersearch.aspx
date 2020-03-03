<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>
<script runat="server">

    protected void cmdSearch_Click(object sender, EventArgs e)
    {
        if (txtFirstName.Text == "")
        {
            txtFirstName.Text = "**";
        }
        if (txtLastName.Text == "")
        {
            txtLastName.Text = "**";
        }
        divGrid.Visible = true;
        GridAgency.DataBind();
        if (txtFirstName.Text == "**")
        {
            txtFirstName.Text = "";
        }
        if (txtLastName.Text == "**")
        {
            txtLastName.Text = "";
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            divGrid.Visible = false;
        }
    }

protected void  GridAgency_SelectedIndexChanged(object sender, EventArgs e)
{
    Response.Redirect("agencyinfo.aspx?agkey=" + GridAgency.SelectedDataKey.Value);
}

protected void  GridNonMemberAgency_SelectedIndexChanged(object sender, EventArgs e)
{
    Response.Redirect("agencyinfo.aspx?agkey=" + GridNonMemberAgency.SelectedDataKey.Value);
}
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Member Search</h1>
<table cellpadding="5" cellspacing="0" border="0">
    <tr>
        <td>First Name: <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox></td>
    </tr>
    <tr>
        <td>Last Name: <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="center"><asp:Button ID="cmdSearch" Text="Search" runat="server" 
                onclick="cmdSearch_Click" /></td>
    </tr>
    <tr>
        <td><img src="images/spacer.gif" height="20" /></td>
    </tr>
</table>
<table cellpadding="5" cellspacing="0" border="0">
    <tr>
        <td colspan="2">
            <img src="images/bar.jpg" height="3" width="800" />
        </td>
    </tr>
    <tr>
        <td>
            <img src="images/spacer.gif" height="20" />
        </td>
    </tr>
</table>
<div id="divGrid" runat="server">
    <h1>Members</h1>
    <asp:SqlDataSource ID="SqlAgency" runat="server" 
        ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
        SelectCommand="spSelectSearchMember" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtFirstName" DefaultValue="**" 
                Name="First_Name" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtLastName" DefaultValue="**" Name="Last_Name" 
                PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView ID="GridAgency" runat="server" AutoGenerateColumns="False" EmptyDataText="No Member(s) Found"
        CellPadding="4" HorizontalAlign="Center" DataSourceID="SqlAgency" DataKeyNames="ag_Key"
        ForeColor="#333333" GridLines="None" 
        onselectedindexchanged="GridAgency_SelectedIndexChanged">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="ag_Key" HeaderText="ag_Key" 
                SortExpression="ag_Key" Visible="False" />
            <asp:BoundField DataField="FullName" HeaderText="Officer" 
                SortExpression="FullName" />
            <asp:BoundField DataField="ag_Name" HeaderText="Agency Name" 
                SortExpression="ag_Name" />
            <asp:BoundField DataField="ag_ID" HeaderText="Agency ID" 
                SortExpression="ag_ID" />
            <asp:BoundField DataField="ag_Region" HeaderText="District" 
                SortExpression="ag_Region" />
            <asp:BoundField DataField="aa_City" HeaderText="City" 
                SortExpression="aa_City" />
            <asp:BoundField DataField="aa_State" HeaderText="State" 
                SortExpression="aa_State" />
            <asp:BoundField DataField="ap_Type" HeaderText="ap_Type" 
                SortExpression="ap_Type" Visible="False" />
            <asp:BoundField DataField="ag_Status" HeaderText="ag_Status" 
                SortExpression="ag_Status" Visible="False" />
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
    <h1>ATIX/Non Members</h1>
    <asp:SqlDataSource ID="SqlNonMemberAgency" runat="server" 
        ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
        SelectCommand="spSelectSearchNonMember" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtFirstName" DefaultValue="**" 
                Name="First_Name" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtLastName" DefaultValue="**" Name="Last_Name" 
                PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView ID="GridNonMemberAgency" runat="server" AutoGenerateColumns="False" EmptyDataText="No Non Member(s) Found"
        CellPadding="4" HorizontalAlign="Center" DataSourceID="SqlNonMemberAgency" DataKeyNames="ag_Key"
        ForeColor="#333333" GridLines="None" 
        onselectedindexchanged="GridNonMemberAgency_SelectedIndexChanged">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="ag_Key" HeaderText="ag_Key" 
                SortExpression="ag_Key" Visible="False" />
            <asp:BoundField DataField="FullName" HeaderText="Officer" 
                SortExpression="FullName" />
            <asp:BoundField DataField="ag_Name" HeaderText="Agency Name" 
                SortExpression="ag_Name" />
            <asp:BoundField DataField="ag_ID" HeaderText="Agency ID" 
                SortExpression="ag_ID" />
            <asp:BoundField DataField="ag_Region" HeaderText="District" 
                SortExpression="ag_Region" />
            <asp:BoundField DataField="aa_City" HeaderText="City" 
                SortExpression="aa_City" />
            <asp:BoundField DataField="aa_State" HeaderText="State" 
                SortExpression="aa_State" />
            <asp:BoundField DataField="ap_Type" HeaderText="ap_Type" 
                SortExpression="ap_Type" Visible="False" />
            <asp:BoundField DataField="ag_Status" HeaderText="ag_Status" 
                SortExpression="ag_Status" Visible="False" />
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

</div>
</asp:Content>

