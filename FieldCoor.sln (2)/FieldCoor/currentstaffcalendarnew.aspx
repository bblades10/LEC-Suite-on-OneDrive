<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>

<script runat="server">

    DateTime dbdate = System.DateTime.Now;


    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!IsPostBack)
        //{
        //    SqlDataSource1.SelectParameters["theDate"].DefaultValue = DateTime.Today.ToShortDateString();
        //}

        //string DayWeek = System.DateTime.Now.DayOfWeek.ToString();
        //if (DayWeek == "Friday")
        //{
        //    lblDayofWeek.Text = "Monday";
        //    DateTime today = DateTime.Now;
        //    DateTime answer = today.AddDays(3);
        //    SqlDataSource2.SelectParameters["TheDate"].DefaultValue = answer.ToShortDateString();
        //}
        //else
        //{
        //    lblDayofWeek.Text = "Tomorrow";
        //    DateTime today = DateTime.Now;
        //    DateTime answer = today.AddDays(1);
        //    SqlDataSource2.SelectParameters["TheDate"].DefaultValue = answer.ToShortDateString();
        //}
    }

    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        //Pass today's date to parameter
        DateTime date = DateTime.Now;
        e.Command.Parameters["@theDate"].Value = date;
    }

    protected void SqlDataSource2_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        //Show records for tomorrow or Monday and change label
        //Pass the next day's date to parameter
        DateTime date = DateTime.Now;
        String strDayOfWeek = date.ToString("dddd");

        if (strDayOfWeek == "Friday")
        {
            date = date.AddDays(3);
            lblDay.Text = "Leave Calendar - Monday";
        }
        else
        {
            date = date.AddDays(1);
            lblDay.Text = "Leave Calendar - " + date.ToString("dddd");
        }
        e.Command.Parameters["@theDate"].Value = date;
    }

    protected void grdEmployeeCalendar_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //Removing the colons left over from the dataset to make it look cleaner
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TableCell statusCell = e.Row.Cells[5];
            if (statusCell.Text == ": ")
            {
                statusCell.Text = "";
            }
            TableCell statusCell2 = e.Row.Cells[6];
            if (statusCell2.Text == ": ")
            {
                statusCell2.Text = "";
            }
            if (statusCell2.Text == ":* ")
            {
                statusCell2.Text = "Not Returning";
            }
            TableCell statusCell3 = e.Row.Cells[4];
            if (statusCell3.Text == "Yes")
            {
                statusCell3.Text = "Yes";
            }
            
            grdEmployeeCalendar.Columns[9].Visible = false;
            //grdEmployeeCalendar.Columns[7].Visible = false;
            grdEmployeeCalendarTomorrow.Columns[9].Visible = false;
            //grdEmployeeCalendarTomorrow.Columns[7].Visible = false;
            
        }
    }

    protected void grdEmployeeCalendar_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            Response.Redirect("EditRecord.aspx?i=" + Convert.ToInt32(e.CommandArgument));
        }
    }

    protected void grdEmployeeCalendar_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        //Leave it blank
    }

    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception != null)
        {
            lblError.Text = e.Exception.Message +
                "<br><br>" +
                Environment.NewLine +
                "Contact the IT department.";
            lblError.ForeColor = System.Drawing.Color.Red;
            //lblErrorText.Text = "Database connection error";
            lblError.Visible = true;
            e.ExceptionHandled = true;
        }
    }

    protected void SqlDataSource2_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception != null)
        {
            lblError.Text = e.Exception.Message +
                "<br><br>" +
                Environment.NewLine +
                "Contact the IT department.";
            lblError.ForeColor = System.Drawing.Color.Red;
            //lblErrorText.Text = "Database connection error";
            lblError.Visible = true;
            e.ExceptionHandled = true;
        }
    }


</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1>
        Current Staff Calendar</h1>
    <table cellspacing="0" cellpadding="0" border="0">
        <tr>
            <td valign="top">
                <table cellspacing="0" cellpadding="0" border="0">
                    <tr>
                        <td>
                            <font class="LARGE"><b>Employee Status - Today</b></font>
                        </td>
                    </tr>
                    <tr>
                        <td height="5">
                            <img height="1" alt="" src="images/spacer.gif" width="1" border="0" /><asp:Label ID="lblError" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="grdEmployeeCalendar" runat="server" AutoGenerateColumns="False" GridLines="None" DataSourceID="SqlDataSource1" AllowSorting="True" BorderStyle="None" Width="925px" OnRowDataBound="grdEmployeeCalendar_RowDataBound" OnRowCommand="grdEmployeeCalendar_RowCommand" OnRowDeleting="grdEmployeeCalendar_RowDeleting" EmptyDataText="No records found." DataKeyNames="lc_ID">
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                <Columns>
                                    <asp:BoundField DataField="lc_StartDate" DataFormatString="{0:d}" HeaderText="Start Date" SortExpression="lc_StartDate" />
                                    <asp:BoundField DataField="lc_EndDate" DataFormatString="{0:d}" HeaderText="End Date" SortExpression="lc_EndDate" />
                                    <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
                                    <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
                                    <asp:BoundField DataField="lc_AllDayEvent" HeaderText="All Day" SortExpression="lc_AllDayEvent" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="StartTime" HeaderText="Leave Start Time" ReadOnly="True" SortExpression="StartTime" />
                                    <asp:BoundField DataField="EndTime" HeaderText="Leave End Time" ReadOnly="True" SortExpression="EndTime" />
                                    <asp:BoundField DataField="lt_Name" HeaderText="Leave Type" SortExpression="lt_Name" />
                                    <asp:BoundField DataField="lc_Comment" Visible="false" HeaderText="Comment" SortExpression="lc_Comment" />
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkedit" runat="server" CommandName="Edit" CommandArgument='<%#Eval("lc_ID")%>' ToolTip="Edit"><span class="glyphicon glyphicon-pencil"></span></asp:LinkButton>
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
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LeaveCalendarDBConnectionString %>" SelectCommand="spSelectCalendarRecordsForToday" SelectCommandType="StoredProcedure" OnSelecting="SqlDataSource1_Selecting" OnSelected="SqlDataSource1_Selected">
                                <SelectParameters>
                                    <asp:Parameter Name="theDate" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td height="25">
                <img height="1" alt="" src="images/spacer.gif" width="1" border="0" />
            </td>
        </tr>
        <tr height="100%">
            <td valign="top">
                <table cellspacing="0" cellpadding="0" border="0">
                    <tr>
                        <td>
                            <font class="LARGE"><b>Employee Status -
                                <asp:Label ID="lblDay" runat="server" />
                            </b></font>
                        </td>
                    </tr>
                    <tr>
                        <td height="5">
                            <img height="1" alt="" src="images/spacer.gif" width="1" border="0" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="grdEmployeeCalendarTomorrow" runat="server" AutoGenerateColumns="False" GridLines="None" DataSourceID="SqlDataSource2" AllowSorting="True" BorderStyle="None" Width="925px" OnRowDataBound="grdEmployeeCalendar_RowDataBound" OnRowCommand="grdEmployeeCalendar_RowCommand" OnRowDeleting="grdEmployeeCalendar_RowDeleting" EmptyDataText="No records found." DataKeyNames="lc_ID">
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                <Columns>
                                    <asp:BoundField DataField="lc_StartDate" DataFormatString="{0:d}" HeaderText="Start Date" SortExpression="lc_StartDate" />
                                    <asp:BoundField DataField="lc_EndDate" DataFormatString="{0:d}" HeaderText="End Date" SortExpression="lc_EndDate" />
                                    <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
                                    <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
                                    <asp:BoundField DataField="lc_AllDayEvent" HeaderText="All Day" SortExpression="lc_AllDayEvent" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="StartTime" HeaderText="Leave Start Time" ReadOnly="True" SortExpression="StartTime" />
                                    <asp:BoundField DataField="EndTime" HeaderText="Leave End Time" ReadOnly="True" SortExpression="EndTime" />
                                    <asp:BoundField DataField="lt_Name" HeaderText="Leave Type" SortExpression="lt_Name" />
                                    <asp:BoundField DataField="lc_Comment" Visible="false" HeaderText="Comment" SortExpression="lc_Comment" />
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkedit" runat="server" CommandName="Edit" CommandArgument='<%#Eval("lc_ID")%>' ToolTip="Edit"><span class="glyphicon glyphicon-pencil"></span></asp:LinkButton>
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
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:LeaveCalendarDBConnectionString %>" SelectCommand="spSelectCalendarRecordsForToday" SelectCommandType="StoredProcedure" OnSelecting="SqlDataSource2_Selecting" OnSelected="SqlDataSource2_Selected">
                                <SelectParameters>
                                    <asp:Parameter Name="theDate" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
