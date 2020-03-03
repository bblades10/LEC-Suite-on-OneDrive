<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>

<script runat="server">
    
protected void Page_Load(object sender, EventArgs e)
{
    if (!IsPostBack)
    {
        lblTitle.Text = "Officers Certificate Expiration Date";
        divGrid.Visible = false;
    }
}

protected void  cmdGrid_Click(object sender, EventArgs e)
{
    divGrid.Visible = true;
    gridCert.DataBind();
}

protected void cmdReport_Click(object sender, EventArgs e)
{
    Response.Redirect("certexpirereport.aspx?s=" + dropState.SelectedItem.Value + "&r=" + dropRegion.SelectedItem.Value);
}
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1><asp:Label ID="lblTitle" runat="server"></asp:Label></h1>

<div id="divDistrict" runat="server">
<table cellpadding="10" cellspacing="0" border="0">
    <tr>
        <td>
            <asp:SqlDataSource ID="SqlRegion" runat="server" 
                ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                SelectCommand="spSelectRegions" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            District: <asp:DropDownList ID="dropRegion" runat="server" DataSourceID="SqlRegion" 
                DataTextField="ag_Region" AppendDataBoundItems="true" DataValueField="ag_Region">
                <asp:ListItem Text="All" Value="00" Selected="True"></asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
</table>
</div>

<div id="divState" runat="server">
<table cellpadding="10" cellspacing="0" border="0">
    <tr>
        <td>
            State: <asp:DropDownList ID="dropState" runat="server">
                <asp:ListItem Value="**"></asp:ListItem>
                <asp:ListItem Value="IA">IA</asp:ListItem>
                <asp:ListItem Value="IL">IL</asp:ListItem>
                <asp:ListItem Value="KS">KS</asp:ListItem>
                <asp:ListItem Value="MN">MN</asp:ListItem>
                <asp:ListItem Value="MO">MO</asp:ListItem>
                <asp:ListItem Value="NE">NE</asp:ListItem>
                <asp:ListItem Value="ND">ND</asp:ListItem>
                <asp:ListItem Value="SD">SD</asp:ListItem>
                <asp:ListItem Value="WI">WI</asp:ListItem>
                <asp:ListItem Value="MB">MB</asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
</table>
</div>

<div id="divButtons" runat="server">
<table cellpadding="10" cellspacing="0" border="0">
    <tr>
        <td>
            <asp:Button ID="cmdGrid" Text="View Grid" runat="server" 
                onclick="cmdGrid_Click" />
        </td>
        <td>
            <asp:Button ID="cmdReport" Text="View Report" runat="server" 
                onclick="cmdReport_Click" />
        </td>
    </tr>
    <tr>
        <td colspan="2">Reports can take a while to load.</td>
    </tr>
</table>
</div>
<div id="divGrid" runat="server">
    <asp:SqlDataSource ID="sqlCert" runat="server" 
        ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
        SelectCommand="spSelectRemoteUserCertificateInfo" 
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="dropRegion" Name="District" 
                PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="dropState" Name="State" 
                PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="gridCert" runat="server" Font-Size="Small" AutoGenerateColumns="False"  AllowSorting="True" ForeColor="#333333" GridLines="None"
        CellPadding="2" DataSourceID="sqlCert">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="OfficerName" HeaderText="Officer Name" 
                ReadOnly="True" SortExpression="OfficerName" />
            <asp:BoundField DataField="ag_Name" ItemStyle-Font-Size="Smaller" HeaderText="Agency Name" 
                SortExpression="ag_Name" />
            <asp:BoundField DataField="ag_State" HeaderText="State" 
                SortExpression="ag_State" />
            <asp:BoundField DataField="AgencyPhone" HeaderText="Agency Phone" 
                ReadOnly="True" SortExpression="AgencyPhone" />
            <asp:BoundField DataField="of_key" HeaderText="of_key" 
                SortExpression="of_key" Visible="False" />
            <asp:BoundField DataField="oi_ConDate" HeaderText="oi_ConDate" 
                SortExpression="oi_ConDate" Visible="False" />
            <asp:BoundField DataField="expired" HeaderText="Cert. Exp. Date" ReadOnly="True" 
                SortExpression="expired" DataFormatString="{0:d}" />
            <asp:BoundField DataField="OffPhone" HeaderText="Officer Phone" ReadOnly="True" 
                SortExpression="OffPhone" />
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

