<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<script runat="server">
    
    protected void cmdSave_Click(object sender, EventArgs e)
    {
        if (cmdSave.Text == "Save")
        {
            DataClassesDataContext myDB = new DataClassesDataContext();
            myDB.spInsertVehicleMileage(Convert.ToInt32(Session["EmpID"]), Convert.ToDateTime(txtDate.Text), txtMileage.Text);

            txtDate.Text = "";
            txtMileage.Text = "";
            gridMileage.DataBind();
        }
        else
        {
            DataClassesDataContext myDB = new DataClassesDataContext();
            myDB.spUpdateVehicleMileage(Convert.ToInt32(gridMileage.SelectedDataKey.Value), Convert.ToDateTime(txtDate.Text), txtMileage.Text, Convert.ToInt32(Session["EmpID"]));

            txtDate.Text = "";
            txtMileage.Text = "";
            cmdSave.Text = "Save";
            gridMileage.DataBind();
        }
    }

    protected void gridMileage_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataClassesDataContext myDB = new DataClassesDataContext();
        var objRS = myDB.spSelectVehicleMileage(Convert.ToInt32(gridMileage.SelectedDataKey.Value));
        
        foreach (spSelectVehicleMileageResult record in objRS)
        {
            txtDate.Text = Convert.ToString(record.FCS_vm_Date.Value.ToShortDateString());
            txtMileage.Text = record.FCS_vm_Mileage;
            cmdSave.Text = "Update";
            break;
        }
    }

    protected void gridMileage_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "MyDelete")
        {
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            string val = this.gridMileage.DataKeys[rowIndex].Values["FCS_vm_ID"].ToString();

            DataClassesDataContext myDB = new DataClassesDataContext();
            myDB.spDeleteVehicleMileage(Convert.ToInt32(val), Convert.ToInt32(Session["EmpID"]));
            
            gridMileage.DataBind();
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1>Add Vehicle Mileage</h1>
<table cellpadding="5" cellspacing="0" border="0">
    <tr>
        <td>At a minimum, mileage should be recorded once per week.</td>
    </tr>
    <tr>
        <td><font color="red"><asp:Label ID="lblMessage" runat="server"></asp:Label></font></td>
    </tr>
    <tr>
        <td>Date: <asp:TextBox ID="txtDate" Columns="10" MaxLength="10" runat="server" />
            <asp:CalendarExtender ID="CalendarExtender1" TargetControlID="txtDate" PopupButtonID="cal" runat="server"></asp:CalendarExtender>
            <asp:imagebutton ImageUrl="images/Calendar_scheduleHS.png" CausesValidation="false" id="cal" runat="server" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtDate" ForeColor="Red" Text="*" Runat="Server" />
        </td>
    </tr>
    <tr>
        <td>Mileage: <asp:TextBox ID="txtMileage" runat="server" /><asp:RequiredFieldValidator ID="reqMileage" ControlToValidate="txtMileage" ForeColor="Red" Text="*" runat="server"></asp:RequiredFieldValidator></td>
    </tr>
    <tr>
        <td class="center"><asp:Button ID="cmdSave" Text="Save" runat="server" onclick="cmdSave_Click" /></td>
    </tr>
</table>
    <asp:SqlDataSource ID="sqlMileage" runat="server"
        ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
        SelectCommand="spSelectAllVehicleMileage" 
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="EmpID" SessionField="EmpID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="gridMileage" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" CellPadding="4" DataSourceID="sqlMileage" EmptyDataText="No data available."
        ForeColor="#333333" GridLines="None" DataKeyNames="FCS_vm_ID" 
        onselectedindexchanged="gridMileage_SelectedIndexChanged" 
        OnRowCommand="gridMileage_RowCommand" HorizontalAlign="Center" >
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="FCS_vm_ID" HeaderText="ActivityID" ReadOnly="True" 
                SortExpression="FCS_vm_ID" Visible="False" />
            <asp:BoundField DataField="FCS_vm_Date" HeaderText="Date" ReadOnly="True" 
                SortExpression="FCS_vm_Date" DataFormatString="{0:d}" />
            <asp:BoundField DataField="FCS_vm_Mileage" HeaderText="Mileage" ReadOnly="true"
                SortExpression="FCS_vm_Mileage" />
            <asp:CommandField ShowSelectButton="True" />
            <asp:TemplateField><ItemTemplate>
                <asp:imageButton ID="cmdDeleteActivity" CausesValidation="false" runat="server" ImageUrl="~/images/redxgrey.gif" OnClientClick="return confirm('Are you sure you want to delete this record?');" CommandName="MyDelete" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"></asp:imageButton>
            </ItemTemplate></asp:TemplateField>
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#234e6c" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#234e6c" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
</asp:Content>

