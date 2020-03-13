<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>

<script runat="server">

    protected void dropState_SelectedIndexChanged(object sender, EventArgs e)
    {
        dropCounty.DataBind();
    }



    protected void gridAgencies_SelectedIndexChanged(object sender, EventArgs e)
    {
        Page.ClientScript.RegisterStartupScript(this.GetType(), "openlink", "window.open('agencyinfo.aspx?agkey=" + gridAgencies.SelectedDataKey.Value.ToString() + "', 'newwindow', 'scrollbars=yes, resizable=yes, width=1000, height=700')", true);
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Agencies by County</h1>
    <div id="divState" runat="server">
        <table cellpadding="10" cellspacing="0" border="0">
            <tr>
                <td>
                    State: <asp:DropDownList ID="dropState" runat="server" AutoPostBack="true" OnSelectedIndexChanged="dropState_SelectedIndexChanged">
                                <asp:ListItem Value="00" Selected="True">All</asp:ListItem>        
                                <asp:ListItem Value="IA">IA</asp:ListItem>
                                <asp:ListItem Value="IL">IL</asp:ListItem>
                                <asp:ListItem Value="KS">KS</asp:ListItem>
                                <asp:ListItem Value="MN">MN</asp:ListItem>
                                <asp:ListItem Value="MO">MO</asp:ListItem>
                                <asp:ListItem Value="ND">ND</asp:ListItem>
                                <asp:ListItem Value="NE">NE</asp:ListItem>
                                <asp:ListItem Value="SD">SD</asp:ListItem>
                                <asp:ListItem Value="WI">WI</asp:ListItem>
                                <asp:ListItem Value="MB">MB</asp:ListItem>
                           </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    County:
                    <asp:DropDownList ID="dropCounty" runat="server" DataSourceID="SqlDataSource2" DataTextField="ag_County"
                        DataValueField="ag_County" AutoPostBack="true">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>"
                        SelectCommand="spSelectCountiesByState" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="dropState" Name="State" PropertyName="SelectedValue" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:SqlDataSource ID="sqlAgenciesInCounty" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                        SelectCommand="spSelectAgenciesByCounty" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="dropCounty" Name="ag_County" PropertyName="SelectedValue" Type="String" />
                        </SelectParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="dropState" Name="ag_State" PropertyName="SelectedValue" Type="String" />
                        </SelectParameters>
                        </asp:SqlDataSource>
                    <asp:GridView ID="gridAgencies" runat="server" AutoGenerateColumns="False" DataKeyNames="ag_Key"
                        CellPadding="4" DataSourceID="sqlAgenciesInCounty" ForeColor="#333333" GridLines="None" AllowSorting="True" OnSelectedIndexChanged="gridAgencies_SelectedIndexChanged">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            
                            <asp:CommandField ShowSelectButton="True" />
                            <asp:BoundField DataField="ag_Key" HeaderText="Agency Key" ReadOnly="True" 
                                SortExpression="ag_Key" Visible="False" />
                            <asp:BoundField DataField="ag_ID" HeaderText="Agency ID" ReadOnly="True" 
                                SortExpression="ag_ID" />
                            <asp:BoundField DataField="ag_Name" HeaderText="Agency Name" ReadOnly="True" 
                                SortExpression="ag_Name" />
                            <asp:BoundField DataField="aa_Line1" HeaderText="Address" ReadOnly="True" 
                                SortExpression="aa_Line1" />
                            <asp:BoundField DataField="aa_City" HeaderText="City" ReadOnly="True" 
                                SortExpression="aa_City" />
                            
                            
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

