<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>

<script runat="server">

    DateTime dbdate = System.DateTime.Now;


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SqlCurrent.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToShortDateString();
        }

        string DayWeek = System.DateTime.Now.DayOfWeek.ToString();
        if (DayWeek == "Friday")
        {
            lblDayofWeek.Text = "Monday";
            DateTime today = DateTime.Now;
            DateTime answer = today.AddDays(3);
            SqlDataSource1.SelectParameters["TheDate"].DefaultValue = answer.ToShortDateString();
        }
        else
        {
            lblDayofWeek.Text = "Tomorrow";
            DateTime today = DateTime.Now;
            DateTime answer = today.AddDays(1);
            SqlDataSource1.SelectParameters["TheDate"].DefaultValue = answer.ToShortDateString();
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
                            <img height="1" alt="" src="images/spacer.gif" width="1" border="0" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:SqlDataSource ID="SqlCurrent" runat="server" ConnectionString="<%$ ConnectionStrings:EmployeeConnectionString %>"
                                SelectCommand="sp_INT_CurStatus" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:Parameter Name="TheDate" Type="DateTime" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" GridLines="None"
                                CellPadding="4" ForeColor="#333333" DataSourceID="SqlCurrent">
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                <Columns>
                                    <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
                                    <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
                                    <asp:BoundField DataField="StartDate" HeaderText="Depart Date" DataFormatString="{0:d}"
                                        SortExpression="StartDate" />
                                    <asp:BoundField DataField="EndDate" HeaderText="End Date" DataFormatString="{0:d}"
                                        SortExpression="EndDate" />
                                    <asp:BoundField DataField="StartTime" HeaderText="Depart Time" SortExpression="StartTime" />
                                    <asp:BoundField DataField="ReturnTime" HeaderText="Return Time" SortExpression="ReturnTime" />
                                    <asp:BoundField DataField="cc_Category" HeaderText="Category" SortExpression="cc_Category" />
                                    <asp:BoundField DataField="Comment" HeaderText="Comment" SortExpression="Comment" />
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
                                <asp:Label ID="lblDayofWeek" runat="server" />
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
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:EmployeeConnectionString %>"
                                SelectCommand="sp_INT_CurStatus" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:Parameter Name="TheDate" Type="DateTime" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" GridLines="None"
                                CellPadding="4" ForeColor="#333333" DataSourceID="SqlDataSource1">
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                <Columns>
                                    <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
                                    <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
                                    <asp:BoundField DataField="StartDate" HeaderText="Depart Date" DataFormatString="{0:d}"
                                        SortExpression="StartDate" />
                                    <asp:BoundField DataField="EndDate" HeaderText="End Date" DataFormatString="{0:d}"
                                        SortExpression="EndDate" />
                                    <asp:BoundField DataField="StartTime" HeaderText="Depart Time" SortExpression="StartTime" />
                                    <asp:BoundField DataField="ReturnTime" HeaderText="Return Time" SortExpression="ReturnTime" />
                                    <asp:BoundField DataField="cc_Category" HeaderText="Category" SortExpression="cc_Category" />
                                    <asp:BoundField DataField="Comment" HeaderText="Comment" SortExpression="Comment" />
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
            </td>
        </tr>
    </table>
</asp:Content>
