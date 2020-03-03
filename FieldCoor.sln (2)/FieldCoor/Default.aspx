<%@ Page Title="" Language="C#" Debug="true" MasterPageFile="~/Main.master" %>

<script runat="server">
    int TotalAgencys = 0;
    int TotalMembers = 0;


    protected void  gridSchedule_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (gridSchedule.DataKeys[gridSchedule.SelectedIndex].Values["TypeID"].ToString() == "0")
        {
            Response.Redirect("editcalendar.aspx?id=" + gridSchedule.SelectedDataKey.Value.ToString());
        }
        else
        {
            Response.Redirect("editschedule.aspx?id=" + gridSchedule.SelectedDataKey.Value.ToString());
        }
    }


    protected void gridSchedule_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "MyDelete")
        {

            int rowIndex = int.Parse(e.CommandArgument.ToString());
            string val = this.gridSchedule.DataKeys[rowIndex].Values["RecordID"].ToString();

            if (gridSchedule.DataKeys[rowIndex].Values["TypeID"].ToString() == "0")
            {
                 LeaveCalendarDataContext myDB = new LeaveCalendarDataContext();
                myDB.spDeleteCalendarRecord(Convert.ToInt32(val), Convert.ToInt32(Session["EmpID"]));
            }
            else
            {
                DataClassesDataContext myDB = new DataClassesDataContext();
                myDB.spDeleteScheduledActivity(Convert.ToInt32(Session["EmpID"]), Convert.ToInt32(val));
            }

            gridSchedule.DataBind();

        }

    }

    protected void gridActivity_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "MyDelete2")
        {

            int rowIndex = int.Parse(e.CommandArgument.ToString());
            string val = this.gridActivity.DataKeys[rowIndex].Values["ActivityID"].ToString();

            if (gridActivity.DataKeys[rowIndex].Values["TypeID"].ToString() == "0")
            {
                //DataClasses2DataContext myDB = new DataClasses2DataContext();
                //myDB.sp_INT_DeletePersonalRecord(Convert.ToInt32(val), Convert.ToInt32(Session["EmpID"]));
                lblMessage2.Text = "Calendar records can't be deleted after they have occured.";
            }
            else
            {
                DataClassesDataContext myDB = new DataClassesDataContext();
                myDB.spDeleteActivity(Convert.ToInt32(Session["EmpID"]), Convert.ToInt32(val));
            }

            gridActivity.DataBind();

        }
    }

    protected void gridActivity_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (gridActivity.DataKeys[gridActivity.SelectedIndex].Values["TypeID"].ToString() == "0")
        {
            //Response.Redirect("editcalendar.aspx?id=" + gridActivity.SelectedDataKey.Value.ToString());
            lblMessage2.Text = "Calendar records can't be edited after they have occured.";
        }
        else
        {
            Response.Redirect("editactivity.aspx?id=" + gridActivity.SelectedDataKey.Value.ToString());
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToInt32(Session["AccessLevel"]) == 1)
        {
            divFieldCoor.Visible = true;
            divOther.Visible = false;
        }
        else
        {
            divOther.Visible = true;
            divFieldCoor.Visible = false;
        }

        //System.DirectoryServices.DirectoryEntry Entry = new System.DirectoryServices.DirectoryEntry("LDAP://RootDSE");
        //String DomainPath = "LDAP://DC=MOCIC2003,DC=NET";
        //System.DirectoryServices.SearchResult Result;
        //Entry = new System.DirectoryServices.DirectoryEntry(DomainPath);
        //System.DirectoryServices.DirectorySearcher Searcher = new System.DirectoryServices.DirectorySearcher(Entry);

        //Searcher.Filter = "(&(sAMAccountName=" + Session["UserName"] + "))";
        //Result = Searcher.FindOne();

        //DateTime hacked;

        //hacked = DateTime.FromFileTime((long)Result.Properties["pwdLastSet"][0]);

        //int intDifference = 0;

        //TimeSpan ts = DateTime.Now - hacked;

        //intDifference = ts.Days;
        //intDifference = 42 - intDifference;

        //lblPassword.Text = "Your Password will Expire in " + intDifference + " days.";

    }

    protected void gridFieldCoorInfo_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TotalAgencys += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "DistrictTotal"));
            TotalMembers += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "MemberTotal"));
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[4].Text = "Total:";
            e.Row.Cells[5].Text = TotalAgencys.ToString();
            e.Row.Cells[6].Text = TotalMembers.ToString();
            e.Row.Cells[4].ForeColor = System.Drawing.Color.White;
            e.Row.Cells[5].ForeColor = System.Drawing.Color.White;
            e.Row.Cells[6].ForeColor = System.Drawing.Color.White;
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div id="divPassword" runat="server">
    <font color="red"><asp:Label ID="lblPassword" runat="server"></asp:Label></font>
</div>
<div id="divFieldCoor" runat="server">
    <div style="height: 250px;  overflow: auto" >
    <asp:SqlDataSource ID="sqlFieldCoorAgencys" runat="server" 
        ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
        SelectCommand="spSelectFieldCoordinatorInfo" 
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="ID" SessionField="EmpID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="gridFieldCoorAgencys" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataSourceID="sqlFieldCoorAgencys" ForeColor="#333333" 
        GridLines="None">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="FCS_u_emp_ID" HeaderText="FCS_u_emp_ID" 
                SortExpression="FCS_u_emp_ID" Visible="False" />
            <asp:BoundField DataField="FCS_u_district" HeaderText="FCS_u_district" 
                SortExpression="FCS_u_district" Visible="False" />
            <asp:BoundField DataField="FullName" HeaderText="Name" ReadOnly="True" 
                SortExpression="FullName" Visible="False"/>
            <asp:BoundField DataField="Extension" HeaderText="Extension" 
                SortExpression="Extension"  Visible="False"/>
            <asp:BoundField DataField="FCS_u_home_district" HeaderText="District" 
                SortExpression="FCS_u_home_district"  Visible="False"/>
            <asp:BoundField DataField="DistrictTotal" HeaderText="Agencies" ReadOnly="True" 
                SortExpression="DistrictTotal" />
            <asp:BoundField DataField="MemberTotal" HeaderText="Members" ReadOnly="True" 
                SortExpression="MemberTotal" />
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
    <h1>Scheduled Activities</h1>
    <asp:Label ID="lblMessage" CssClass="label" runat="server"></asp:Label>
    <asp:SqlDataSource ID="sqlSchedule" runat="server" 
        ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
        SelectCommand="spSelectScheduledActivity" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="EmpID" SessionField="EmpID" Type="Int32" />
        </SelectParameters>
        </asp:SqlDataSource>
    <asp:GridView ID="gridSchedule" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataSourceID="sqlSchedule" ForeColor="#333333" DataKeyNames="RecordID,TypeID"
        GridLines="None" AllowSorting="True" 
            onselectedindexchanged="gridSchedule_SelectedIndexChanged" OnRowCommand="gridSchedule_RowCommand">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="RecordID" HeaderText="RecordID" ReadOnly="True" 
                SortExpression="RecordID" Visible="False" />
            <asp:BoundField DataField="TypeID" HeaderText="TypeID" ReadOnly="True" 
                SortExpression="TypeID" Visible="false" />
            <asp:BoundField DataField="ActivityType" HeaderText="Activity Type" 
                ReadOnly="True" SortExpression="ActivityType" />
            <asp:BoundField DataField="VisitDate" HeaderText="Date" ReadOnly="True" 
                SortExpression="VisitDate" DataFormatString="{0:d}" />
            <asp:BoundField DataField="AgencyName" HeaderText="Agency Name" ReadOnly="True" 
                SortExpression="AgencyName" />
            <asp:BoundField DataField="AgencyCity" HeaderText="City" ReadOnly="True" 
                SortExpression="AgencyCity" />
            <asp:BoundField DataField="AgencyState" HeaderText="State" 
                ReadOnly="True" SortExpression="AgencyState" />
            <asp:CommandField ShowSelectButton="True" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" OnClientClick="return confirm('Are you sure you want to delete this record?');"
                        CommandName="MyDelete" ImageUrl="~/images/redxgrey.gif" Text="Delete" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
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
    </div>
    <h1>Activities</h1>
    <asp:Label ID="lblMessage2" ForeColor="Red" runat="server"></asp:Label>
    <asp:SqlDataSource ID="sqlActivity" runat="server"
        ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
        SelectCommand="spSelectAllActivityPast3Weeks" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="EmpID" SessionField="EmpID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="gridActivity" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataSourceID="sqlActivity" ForeColor="#333333" DataKeyNames="ActivityID,TypeID"
        GridLines="None" AllowSorting="True" 
            onselectedindexchanged="gridActivity_SelectedIndexChanged" OnRowCommand="gridActivity_RowCommand">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="ActivityID" HeaderText="ActivityID" ReadOnly="True" 
                SortExpression="ActivityID" Visible="False" />
            <asp:BoundField DataField="TypeID" HeaderText="TypeID" ReadOnly="True" 
                SortExpression="TypeID" Visible="false" />
            <asp:BoundField DataField="VisitDate" HeaderText="Date" ReadOnly="True" 
                SortExpression="VisitDate" DataFormatString="{0:d}" />
            <asp:BoundField DataField="VisitHours" HeaderText="Hours" ReadOnly="True" 
                SortExpression="VisitHours" />
            <asp:BoundField DataField="ActivityType" HeaderText="Activity Type" 
                ReadOnly="True" SortExpression="ActivityType" />
            <asp:BoundField DataField="AgencyName" HeaderText="Agency Name" ReadOnly="True" 
                SortExpression="AgencyName" />
            <asp:BoundField DataField="AgencyCity" HeaderText="City" ReadOnly="True" 
                SortExpression="AgencyCity" />
            <asp:BoundField DataField="AgencyState" HeaderText="State" 
                ReadOnly="True" SortExpression="AgencyState" />
            <asp:CommandField ShowSelectButton="True" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton2" runat="server" CausesValidation="False" OnClientClick="return confirm('Are you sure you want to delete this record?');" 
                        CommandName="MyDelete2" ImageUrl="~/images/redxgrey.gif" Text="Delete" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
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
</div>    
<div id="divOther" runat="server">
    <h1>Law Enforcement Coordinators</h1>
    <asp:SqlDataSource ID="sqlFieldCoorInfo" runat="server" 
        ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
        SelectCommand="spSelectFieldCoordinatorsInfo" 
        SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:GridView ID="gridFieldCoorInfo" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataSourceID="sqlFieldCoorInfo" ForeColor="#333333"  ShowFooter="true" 
        GridLines="None" OnRowDataBound="gridFieldCoorInfo_RowDataBound">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="FCS_u_emp_ID" HeaderText="FCS_u_emp_ID" 
                SortExpression="FCS_u_emp_ID" Visible="False" />
            <asp:BoundField DataField="FCS_u_district" HeaderText="FCS_u_district" 
                SortExpression="FCS_u_district" Visible="False" />
            <asp:BoundField DataField="FullName" HeaderText="Name" ReadOnly="True" 
                SortExpression="FullName" />
            <asp:BoundField DataField="Extension" HeaderText="Extension" 
                SortExpression="Extension" />
            <asp:BoundField DataField="FCS_u_home_district" HeaderText="District" 
                SortExpression="FCS_u_home_district" />
            <asp:BoundField DataField="DistrictTotal" HeaderText="Agencies" ReadOnly="True" 
                SortExpression="DistrictTotal" />
            <asp:BoundField DataField="MemberTotal" HeaderText="Members" ReadOnly="True" 
                SortExpression="MemberTotal" />
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

