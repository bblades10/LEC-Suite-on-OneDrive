<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h1>RMS System Totals</h1>
    
    <div id="gridRMS" runat="server">
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
            SelectCommand="spSelectRMSSystemTotals" 
            SelectCommandType="StoredProcedure">
            
        </asp:SqlDataSource>
        <asp:GridView ID="gridAdmin" runat="server" AllowSorting="True" 
            AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" 
            ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="RMS_Name" HeaderText="System" ReadOnly="True" 
                    SortExpression="RMS_Name" />
                <asp:BoundField DataField="IA" HeaderText="IA" ReadOnly="True" 
                    SortExpression="IA" />
                <asp:BoundField DataField="IL" HeaderText="IL" ReadOnly="True" 
                    SortExpression="IL" />
                <asp:BoundField DataField="KS" HeaderText="KS" ReadOnly="True" 
                    SortExpression="KS" />
                <asp:BoundField DataField="MN" HeaderText="MN" ReadOnly="True" 
                    SortExpression="MN" />
                <asp:BoundField DataField="MO" HeaderText="MO" ReadOnly="True" 
                    SortExpression="MO" />
                <asp:BoundField DataField="NE" HeaderText="NE" ReadOnly="True" 
                    SortExpression="NE" />
                <asp:BoundField DataField="ND" HeaderText="ND" ReadOnly="True" 
                    SortExpression="ND" />
                <asp:BoundField DataField="SD" HeaderText="SD" ReadOnly="True" 
                    SortExpression="SD" />
                <asp:BoundField DataField="WI" HeaderText="WI" ReadOnly="True" 
                    SortExpression="WI" />
                <asp:BoundField DataField="Total" HeaderText="Total" ReadOnly="True" 
                    SortExpression="Total" />
                
                    
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

