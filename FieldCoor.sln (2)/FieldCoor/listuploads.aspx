<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if ((Convert.ToInt32(Session["AccessLevel"]) == 4) || (Convert.ToInt32(Session["AccessLevel"]) == 3))
        {
            GridAdmin.Visible = true;
            GridUser.Visible = false;
        }
        else
        {
            GridAdmin.Visible = false;
            GridUser.Visible = true;
        }
    }

protected void  GridAdmin_SelectedIndexChanged(object sender, EventArgs e)
{
    Response.Redirect("uploaddetail.aspx?id=" + GridAdmin.SelectedDataKey.Value.ToString());
}
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Uploaded App/Reapp(s)</h1>
<asp:SqlDataSource ID="SqlUploads" runat="server" 
        ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
        SelectCommand="spSelectAllUploadedAppReapp" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="AccessLevel" SessionField="AccessLevel" 
            Type="Int32" />
        <asp:SessionParameter Name="empID" SessionField="EmpID" Type="Int32" />
    </SelectParameters>
    </asp:SqlDataSource>
<div id="divUser" runat="server">
    <asp:GridView ID="GridUser" runat="server" ForeColor="#333333" AutoGenerateColumns="False"
        CellPadding="4" GridLines="None" AllowSorting="true"
        DataSourceID="SqlUploads">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="FCS_apd_ID" HeaderText="FCS_apd_ID" 
                InsertVisible="False" ReadOnly="True" SortExpression="FCS_apd_ID" 
                Visible="False" />
            <asp:BoundField DataField="FCS_apd_Date_Entered" DataFormatString="{0:d}" 
                HeaderText="Date Entered" SortExpression="FCS_apd_Date_Entered" />
            <asp:BoundField DataField="FullName" HeaderText="Name" ReadOnly="True" 
                SortExpression="FullName" />
            <asp:BoundField DataField="FCS_apd_File_Name" HeaderText="FCS_apd_File_Name" 
                SortExpression="FCS_apd_File_Name" Visible="False" />
            <asp:BoundField DataField="FCS_apd_Status" HeaderText="FCS_apd_Status" 
                SortExpression="FCS_apd_Status" Visible="False" />
            <asp:BoundField DataField="ag_Name" HeaderText="Agency Name" 
                SortExpression="ag_Name" />
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
    <asp:GridView ID="GridAdmin" runat="server" ForeColor="#333333" AutoGenerateColumns="False" 
        DataSourceID="SqlUploads" DataKeyNames="FCS_apd_ID" CellPadding="4" AllowSorting="true" GridLines="None"
        onselectedindexchanged="GridAdmin_SelectedIndexChanged">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="FCS_apd_ID" HeaderText="FCS_apd_ID" 
                InsertVisible="False" ReadOnly="True" SortExpression="FCS_apd_ID" 
                Visible="False" />
            <asp:BoundField DataField="FCS_apd_Date_Entered" DataFormatString="{0:d}" 
                HeaderText="Date Entered" SortExpression="FCS_apd_Date_Entered" />
            <asp:BoundField DataField="FullName" HeaderText="Name" ReadOnly="True" 
                SortExpression="FullName" />
            <asp:BoundField DataField="FCS_apd_File_Name" HeaderText="FCS_apd_File_Name" 
                SortExpression="FCS_apd_File_Name" Visible="False" />
            <asp:BoundField DataField="ag_Name" HeaderText="Agency Name" 
                SortExpression="ag_Name" />
            <asp:BoundField DataField="FCS_apd_Status" HeaderText="Status" 
                SortExpression="FCS_apd_Status" Visible="True" />
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

