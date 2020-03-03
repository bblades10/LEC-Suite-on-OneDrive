<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>

<script runat="server">

    protected void cmdSearch_Click(object sender, EventArgs e)
    {
        if (txtAgencyID.Text == "")
        {
            txtAgencyID.Text = "**";
        }
        if (txtAgencyName.Text == "")
        {
            txtAgencyName.Text = "**";
        }
        if (txtCity.Text == "")
        {
            txtCity.Text = "**";
        }
        if (txtORI.Text == "")
        {
            txtORI.Text = "**";
        }
        divGrid.Visible = true;
        GridAgency.DataBind();
        if (txtAgencyID.Text == "**")
        {
            txtAgencyID.Text = "";
        }
        if (txtAgencyName.Text == "**")
        {
            txtAgencyName.Text = "";
        }
        if (txtCity.Text == "**")
        {
            txtCity.Text = "";
        }
        if (txtORI.Text == "**")
        {
            txtORI.Text = "";
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
    <h1>Agency Search</h1>
<table cellpadding="5" cellspacing="0" border="0">
    <tr>
        <td>Agency Name: <asp:TextBox ID="txtAgencyName" runat="server"></asp:TextBox></td>
    </tr>
    <tr>
        <td>Agency ID: <asp:TextBox ID="txtAgencyID" runat="server"></asp:TextBox></td>
    </tr>
    <tr>
        <td>Agency ORI: <asp:TextBox ID="txtORI" runat="server"></asp:TextBox></td>
    </tr>
    <tr>
        <td>Agency State: <asp:DropDownList ID="dropState" runat="server">
                <asp:ListItem Value="**" Text=""></asp:ListItem>
                <asp:ListItem Value="IA" Text="IA"></asp:ListItem>
                <asp:ListItem Value="IL" Text="IL"></asp:ListItem>
                <asp:ListItem Value="KS" Text="KS"></asp:ListItem>
                <asp:ListItem Value="MN" Text="MN"></asp:ListItem>
                <asp:ListItem Value="MO" Text="MO"></asp:ListItem>
                <asp:ListItem Value="NE" Text="NE"></asp:ListItem>
                <asp:ListItem Value="ND" Text="ND"></asp:ListItem>
                <asp:ListItem Value="SD" Text="SD"></asp:ListItem>
                <asp:ListItem Value="WI" Text="WI"></asp:ListItem>
                <asp:ListItem Value="MB" Text="MB"></asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td>Agency City: <asp:TextBox ID="txtCity" runat="server"></asp:TextBox></td>
    </tr>
    <tr>
        <td><asp:SqlDataSource ID="SqlRegion" runat="server" 
                ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                SelectCommand="spSelectRegions" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            District: <asp:DropDownList ID="dropRegion" runat="server" DataSourceID="SqlRegion" 
                DataTextField="ag_Region" AppendDataBoundItems="true" DataValueField="ag_Region">
                <asp:ListItem Text="" Value="**" Selected="True"></asp:ListItem>
            </asp:DropDownList>
        </td>
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
<h1>Members</h1>
<div id="divGrid" runat="server">
    <asp:SqlDataSource ID="SqlAgency" runat="server" 
        ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
        SelectCommand="spSelectSearchAgency" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtAgencyName" DefaultValue="**" 
                Name="ag_Name" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtAgencyID" DefaultValue="**" Name="ag_ID" 
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="dropRegion" DefaultValue="**" 
                Name="ag_Region" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="dropState" DefaultValue="**" Name="aa_State" 
                PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="txtORI" DefaultValue="**" Name="ag_ORI" 
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtCity" DefaultValue="**" Name="ag_City" 
                PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView ID="GridAgency" runat="server" AutoGenerateColumns="False" EmptyDataText="No Agency(s) Found"
        CellPadding="4" HorizontalAlign="Center" DataSourceID="SqlAgency" DataKeyNames="ag_Key"
        ForeColor="#333333" GridLines="None" 
        onselectedindexchanged="GridAgency_SelectedIndexChanged">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="ag_Key" HeaderText="ag_Key" 
                SortExpression="ag_Key" Visible="False" />
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
            <asp:BoundField DataField="Phone" HeaderText="Phone" ReadOnly="True" 
                SortExpression="Phone" />
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
    </asp:GridView><br /><br />
    <h1>ATIX/Non Members</h1>

    <asp:SqlDataSource ID="SqlNonMemberAgency" runat="server" 
        ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
        SelectCommand="spSelectSearchNonMemberAgency" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtAgencyName" DefaultValue="**" 
                Name="ag_Name" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtAgencyID" DefaultValue="**" Name="ag_ID" 
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="dropRegion" DefaultValue="**" 
                Name="ag_Region" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="dropState" DefaultValue="**" Name="aa_State" 
                PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="txtORI" DefaultValue="**" Name="ag_ORI" 
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtCity" DefaultValue="**" Name="ag_City" 
                PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView ID="GridNonMemberAgency" runat="server" AutoGenerateColumns="False" EmptyDataText="No Agency(s) Found"
        CellPadding="4" HorizontalAlign="Center" DataSourceID="SqlNonMemberAgency" DataKeyNames="ag_Key"
        ForeColor="#333333" GridLines="None" 
        onselectedindexchanged="GridNonMemberAgency_SelectedIndexChanged">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="ag_Key" HeaderText="ag_Key" 
                SortExpression="ag_Key" Visible="False" />
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
            <asp:BoundField DataField="Phone" HeaderText="Phone" ReadOnly="True" 
                SortExpression="Phone" />
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

