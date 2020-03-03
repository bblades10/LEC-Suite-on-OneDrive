<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>

<script runat="server">

    protected void btnAddRecord_Click(object sender, EventArgs e)
    {
        Response.Redirect("addcalendarnew.aspx");
    }

    protected void grdEmployeeCalendar_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //Removing the colons left over from the dataset to make it look cleaner
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TableCell statusCell = e.Row.Cells[3];
            if (statusCell.Text == ": ")
            {
                statusCell.Text = "";
            }
            TableCell statusCell2 = e.Row.Cells[4];
            if (statusCell2.Text == ": ")
            {
                statusCell2.Text = "";
            }
            if (statusCell2.Text == ":* ")
            {
                statusCell2.Text = "Not Returning";
            }
            TableCell statusCell3 = e.Row.Cells[2];
            if (statusCell3.Text == "Yes")
            {
                statusCell3.Text = "Yes";
            }
        }
    }

    protected void grdEmployeeCalendar_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            Response.Redirect("EditRecord.aspx?i=" + Convert.ToInt32(e.CommandArgument));
        }

        if (e.CommandName == "Delete")
        {
            int lc_ID = Convert.ToInt32(e.CommandArgument);
            int intEmployeeID = Convert.ToInt32(Session["EmpID"]);
            //now perform the delete operation using ID value
            try
            {
                LeaveCalendarDataContext myDB = new LeaveCalendarDataContext();
                myDB.spDeleteCalendarRecord(lc_ID, intEmployeeID);
                Response.Redirect("listcalendarnew.aspx");
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message +
                    "<br><br>" +
                    Environment.NewLine +
                    "Contact the IT department.";
                lblError.ForeColor = System.Drawing.Color.Red;
            }
        }
    }

    protected void grdEmployeeCalendar_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        //Leave it blank
    }

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Personal Calendar</h1>
    <asp:Label ID="lblError" runat="server" />
    <asp:Button ID="btnAddRecord" runat="server" class="btn btn-primary btn-xs" Text="Add Record" OnClick="btnAddRecord_Click" />
    <asp:GridView ID="grdEmployeeCalendar" runat="server" AutoGenerateColumns="False" GridLines="None" 
        DataSourceID="SqlDataSource1" AllowSorting="True" BorderStyle="None" Width="925px" 
        OnRowDataBound="grdEmployeeCalendar_RowDataBound" OnRowCommand="grdEmployeeCalendar_RowCommand" 
        OnRowDeleting="grdEmployeeCalendar_RowDeleting" EmptyDataText="No records found." DataKeyNames="lc_ID" 
        AllowPaging="True" PageSize="20">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="lc_StartDate" DataFormatString="{0:d}" HeaderText="Start Date" SortExpression="lc_StartDate" />
            <asp:BoundField DataField="lc_EndDate" DataFormatString="{0:d}" HeaderText="End Date" SortExpression="lc_EndDate" />
            <asp:BoundField DataField="lc_AllDayEvent" HeaderText="All Day" SortExpression="lc_AllDayEvent" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="StartTime" HeaderText="Leave Start Time" ReadOnly="True" SortExpression="StartTime" />
            <asp:BoundField DataField="EndTime" HeaderText="Leave End Time" ReadOnly="True" SortExpression="EndTime" />
            <asp:BoundField DataField="lt_Name" HeaderText="Leave Type" SortExpression="lt_Name" />
            <asp:BoundField DataField="lc_Comment" HeaderText="Comment" SortExpression="lc_Comment" />
            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkedit" runat="server" CommandName="Edit" CommandArgument='<%#Eval("lc_ID")%>' Text="Edit" ToolTip="Edit"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkdelete" runat="server" CommandName="Delete" CommandArgument='<%#Eval("lc_ID")%>' Text="Delete" ToolTip="Delete"></asp:LinkButton>
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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LeaveCalendarDBConnectionString %>" SelectCommand="spSelectEmployeeCalendarRecords" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="emp_ID" SessionField="EmpID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

