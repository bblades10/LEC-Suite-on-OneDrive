<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SqlDataSource1.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToShortDateString();
        }
    }

    protected void gridSchedule_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "MyDelete")
        {
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            string val = this.GridView1.DataKeys[rowIndex].Values["ID"].ToString();

            DataClasses2DataContext myDB = new DataClasses2DataContext();
            myDB.sp_INT_DeletePersonalRecord(Convert.ToInt32(val), Convert.ToInt32(Session["EmpID"]));

            GridView1.DataBind();
        }
    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("editcalendar.aspx?id=" + GridView1.SelectedDataKey.Value.ToString());
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Personal Calendar</h1>
    <asp:Label ID="lblMessage" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:EmployeeConnectionString %>" 
    SelectCommand="sp_INT_DisplayPersCalendar" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="ID" SessionField="EmpID" Type="Int32" />
            <asp:SessionParameter Name="TheDate" SessionField="Date" Type="DateTime" />
        </SelectParameters>
</asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" DataKeyNames="ID"
        GridLines="None" onselectedindexchanged="GridView1_SelectedIndexChanged" OnRowCommand="gridSchedule_RowCommand">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" 
                ReadOnly="True" SortExpression="ID" Visible="False" />
            <asp:BoundField DataField="StartDate" DataFormatString="{0:d}" 
                HeaderText="Start Date" SortExpression="StartDate" />
            <asp:BoundField DataField="EndDate" DataFormatString="{0:d}" 
                HeaderText="End Date" SortExpression="EndDate" />
            <asp:BoundField DataField="StartTime" HeaderText="Start Time" 
                SortExpression="StartTime" />
            <asp:BoundField DataField="ReturnTime" HeaderText="Return Time" 
                SortExpression="ReturnTime" />
            <asp:BoundField DataField="cc_Category" HeaderText="Category" 
                SortExpression="cc_Category" />
            <asp:BoundField DataField="cs_SubCategory" HeaderText="Sub Category" 
                SortExpression="cs_SubCategory" />
            <asp:BoundField DataField="Comment" HeaderText="Comment" 
                SortExpression="Comment" />
            <asp:CommandField ShowSelectButton="True" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:ImageButton ID="cmdDeleteCalRecord" runat="server" CausesValidation="False" 
                        ImageUrl="~/images/redxgrey.gif" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this record?');" CommandName="MyDelete" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                </ItemTemplate>
            </asp:TemplateField>
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
</asp:Content>

