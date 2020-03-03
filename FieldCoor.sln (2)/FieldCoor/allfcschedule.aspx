<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>All Law Enforcement Coordinator Schedules</h1>
    <asp:SqlDataSource ID="sqlSchedule" runat="server" 
        ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
        SelectCommand="spSelectAllFCScheduledActivity" 
        SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:GridView ID="gridSchedule" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataSourceID="sqlSchedule" ForeColor="#333333"
        GridLines="None" AllowSorting="True">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="RecordID" HeaderText="RecordID" ReadOnly="True" 
                SortExpression="RecordID" Visible="False" />
            <asp:BoundField DataField="TypeID" HeaderText="TypeID" ReadOnly="True" 
                SortExpression="TypeID" Visible="false" />
            <asp:BoundField DataField="EmpID" HeaderText="Coordinator" ReadOnly="true" SortExpression="EmpID" />
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

