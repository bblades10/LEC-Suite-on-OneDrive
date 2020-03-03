<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>

<script runat="server">



    protected void GridApps_DataBinding(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.Cells[13].Text == "Yes")
            {
                e.Row.Cells[4].ForeColor = System.Drawing.Color.Gray;
            }
            if (e.Row.Cells[11].Text == "Yes")
            {
                e.Row.Cells[4].ForeColor = System.Drawing.Color.Red;
            }
        }

        e.Row.Cells[13].Visible = false;
        e.Row.Cells[11].Visible = false;
    }

    protected void cmdShowPending_Click(object sender, EventArgs e)
    {
        divPending.Visible = true;
        cmdShowCompleted.Visible = true;
        divComplete.Visible = false;
        cmdShowPending.Visible = false;
    }

    protected void cmdShowCompleted_Click(object sender, EventArgs e)
    {
        divPending.Visible = false;
        cmdShowCompleted.Visible = false;
        divComplete.Visible = true;
        cmdShowPending.Visible = true;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            divComplete.Visible = false;
            cmdShowPending.Visible = false;
            if((Convert.ToInt16(Session["AccessLevel"]) == 4) || (Convert.ToInt16(Session["AccessLevel"]) == 3))
            {
                cmdAdd.Visible = true;
            }
            else
            {
                cmdAdd.Visible = false;
            }
        }
    }

    protected void cmdAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("addappreapp.aspx");
    }



    protected void GridComplete_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("editappreapp.aspx?id=" + GridComplete.SelectedDataKey.Value.ToString());
    }

    protected void GridApps_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("editappreapp.aspx?id=" + GridApps.SelectedDataKey.Value.ToString());
    }


</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1>Membership Transition Tracking</h1>
    <p><font color="red">Red = LEC report complete</font>&nbsp;&nbsp;&nbsp;<font color="gray">Gray = Working under interim agreement</font></p>
    
    <table width="95%">
        <tr>
            <td>
                <asp:Button CssClass="buttonlink" runat="server" ID="cmdShowCompleted" Text="Show All Completed" OnClick="cmdShowCompleted_Click" />
                <asp:Button CssClass="buttonlink" runat="server" ID="cmdShowPending" Text="Show All Pending" OnClick="cmdShowPending_Click" />
            </td>
            <td style="text-align: right">
                <asp:Button CssClass="buttonlink" runat="server" ID="cmdAdd" Text="Add Entry" OnClick="cmdAdd_Click" />
            </td>
        </tr>
    </table>
    
    <div id="divPending" runat="server">
        <asp:SqlDataSource ID="SqlApps" runat="server" ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" SelectCommand="spSelectAppReappGeneralInfoPending" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        <asp:GridView ID="GridApps" runat="server" AutoGenerateColumns="False" ForeColor="#333333" GridLines="None" DataKeyNames="app_key" Font-Size="10" RowStyle-BackColor="DarkGray"
            OnRowDataBound="GridApps_DataBinding" DataSourceID="SqlApps" AllowSorting="True" OnSelectedIndexChanged="GridApps_SelectedIndexChanged">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="app_key" HeaderText="app_key" InsertVisible="False" ReadOnly="True" SortExpression="app_key" Visible="False" />
                <asp:BoundField DataField="EnteredBy" HeaderText="EnteredBy" SortExpression="EnteredBy" Visible="False" />
                <asp:BoundField DataField="ChangeDate" HeaderText="Origination Date" HeaderStyle-Wrap="true" SortExpression="ChangeDate" DataFormatString="{0:d}" >
<HeaderStyle Wrap="True"></HeaderStyle>
                </asp:BoundField>
                <asp:BoundField DataField="AgencyName" HeaderText="Agency Name" SortExpression="AgencyName" />
                <asp:BoundField DataField="AgencyNumber" HeaderText="Agency #" SortExpression="AgencyNumber" />
                <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />
                <asp:BoundField DataField="AgencyState" HeaderText="State" SortExpression="AgencyState" />
                <asp:BoundField DataField="District" HeaderText="District" SortExpression="District" />
                <asp:BoundField DataField="StatusUpdate" HeaderText="Last Update" SortExpression="StatusUpdate" DataFormatString="{0:d}" />
                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" Visible="false" />
                <asp:BoundField DataField="app_fc_report" HeaderText="Lec Report" SortExpression="app_fc_report" />
                <asp:BoundField DataField="app_completed" HeaderText="app_completed" SortExpression="app_completed" Visible="false" />
                <asp:BoundField DataField="Interim" HeaderText="Interim" SortExpression="Interim" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#234e6c" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#234e6c" Font-Size="Small" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="Silver" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
    </div>
    <div id="divComplete" runat="server">
        <asp:SqlDataSource ID="SqlComplete" runat="server" ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" SelectCommand="spSelectAppReappGeneralInfoCompleted" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        <asp:GridView ID="GridComplete" runat="server" AutoGenerateColumns="False" ForeColor="#333333" GridLines="None" DataKeyNames="app_key"
            DataSourceID="SqlComplete" AllowPaging="true" PageSize="30" AllowSorting="True" OnSelectedIndexChanged="GridComplete_SelectedIndexChanged">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="app_key" HeaderText="app_key" InsertVisible="False" ReadOnly="True" SortExpression="app_key" Visible="False" />
                <asp:BoundField DataField="ChangeDate" HeaderText="Origination Date" HeaderStyle-Wrap="true" SortExpression="ChangeDate" DataFormatString="{0:d}" >
<HeaderStyle Wrap="True"></HeaderStyle>
                </asp:BoundField>
                <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />
                <asp:BoundField DataField="AgencyNumber" HeaderText="Agency #" SortExpression="AgencyNumber" />
                <asp:BoundField DataField="AgencyName" HeaderText="Agency Name" SortExpression="AgencyName" />
                <asp:BoundField DataField="AgencyState" HeaderText="State" SortExpression="AgencyState" />
                <asp:BoundField DataField="District" HeaderText="District" SortExpression="District" />
                <asp:BoundField DataField="StatusUpdate" HeaderText="Last Update" SortExpression="StatusUpdate" DataFormatString="{0:d}" />
                <asp:CommandField ShowSelectButton="True" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#234e6c" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#234e6c" Font-Size="Small" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="Silver" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
    </div>
</asp:Content>

