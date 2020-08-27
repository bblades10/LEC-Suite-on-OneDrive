<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>

<script runat="server">
    protected void cmdGo_Click(object sender, EventArgs e)
    {
        gridAdmin.DataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

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
    <table cellpadding="10" cellspacing="0" border="0">
        <tr>
            <td class="center"><asp:Button ID="cmdGo" Text="Go" runat="server" onclick="cmdGo_Click" /></td>
        </tr>
    </table>
    <div id="gridRMS" runat="server">
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                SelectCommand="spSelectRMSSystems" 
                SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="dropRegion" Name="ag_Region" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="gridAdmin" runat="server" AllowSorting="True" 
                AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" 
                ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="AgencyName" HeaderText="Agency Name" ReadOnly="True" 
                        SortExpression="AgencyName" />
                    <asp:BoundField DataField="AgencyCity" HeaderText="City" ReadOnly="True" 
                        SortExpression="AgencyCity" />
                    <asp:BoundField DataField="AgencyState" HeaderText="State" 
                        ReadOnly="True" SortExpression="AgencyState" />
                    <asp:BoundField DataField="au_Value" HeaderText="RMS System" 
                        ReadOnly="True" SortExpression="au_Value" />
                    
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
    </div>
</asp:Content>

