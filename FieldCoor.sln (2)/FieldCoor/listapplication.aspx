<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>

<script runat="server">
    
    protected void gridApplication_SelectedIndexChanged(object sender, EventArgs e)
    {
        //if (gridApplication.DataKeys[gridApplication.SelectedIndex].Values["TypeID"].ToString() == "0")
        //{
        //    Response.Redirect("editcalendar.aspx?l=y&id=" + gridApplication.SelectedDataKey.Value.ToString());
        //}
        //else
        //{
            Response.Redirect("addapplication.aspx?id=" + gridApplication.SelectedDataKey.Value.ToString());
        //}
    }

    protected void gridApplication_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "MyDelete")
        {
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            string val = this.gridApplication.DataKeys[rowIndex].Values["FCS_app_ID"].ToString();

            DataClassesDataContext myDB = new DataClassesDataContext();
            myDB.spDeleteApplication(Convert.ToInt32(Session["EmpID"]), Convert.ToInt32(val));

            gridApplication.DataBind();
        }
    }

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Applications / Reapplications</h1>
    <asp:SqlDataSource ID="sqlApplication" runat="server" 
        ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
        SelectCommand="spSelectAllApplications" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:GridView ID="gridApplication" runat="server" AllowPaging="True" EmptyDataText="No data available."
        CellPadding="4" ForeColor="#333333" GridLines="None" PageSize="15" DataKeyNames="FCS_app_ID"
         onselectedindexchanged="gridApplication_SelectedIndexChanged" 
        OnRowCommand="gridApplication_RowCommand" 
        AllowSorting="True" AutoGenerateColumns="False" DataSourceID="sqlApplication">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="FCS_app_ID" HeaderText="FCS_app_ID" ReadOnly="True" 
                SortExpression="FCS_app_ID" Visible="False" />
            <asp:BoundField DataField="FCS_app_Date" DataFormatString="{0:d}" 
                HeaderText="Date" ReadOnly="True" SortExpression="FCS_app_Date" />
            <asp:BoundField DataField="FCS_app_Type" HeaderText="Type" ReadOnly="True" 
                SortExpression="FCS_app_Type" />
            <asp:BoundField DataField="BoardName" HeaderText="Board Member" ReadOnly="True" 
                SortExpression="BoardName" />
            <asp:BoundField DataField="AgencyName" HeaderText="Agency Name" ReadOnly="True" 
                SortExpression="AgencyName" />
            <asp:BoundField DataField="AgencyState" HeaderText="State" ReadOnly="True" 
                SortExpression="AgencyState" />
            <asp:BoundField DataField="FCS_app_Temp_Access" HeaderText="Temp Access" 
                ReadOnly="True" SortExpression="FCS_app_Temp_Access" />
            <asp:TemplateField HeaderText="Completed" ItemStyle-CssClass="center" SortExpression="FCS_app_Completed">
                <ItemTemplate>
                    <asp:CheckBox ID="chkCompleted" runat="server" 
                        Checked='<%# Bind("FCS_app_Completed") %>' Enabled="false" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField><ItemTemplate>
                <asp:imageButton ID="cmdDeleteActivity" runat="server" ImageUrl="~/images/redxgrey.gif" OnClientClick="return confirm('Are you sure you want to delete this record?');" CommandName="MyDelete" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"></asp:imageButton>
            </ItemTemplate></asp:TemplateField>
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
</asp:Content>

