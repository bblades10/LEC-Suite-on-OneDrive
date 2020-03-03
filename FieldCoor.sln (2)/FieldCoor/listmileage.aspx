<%@ Page Title="" Debug="true" Language="C#" MasterPageFile="~/Main.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<script runat="server">
    
    protected void cmdSave_Click(object sender, EventArgs e)
    {
       DataClassesDataContext myDB = new DataClassesDataContext();
       myDB.spUpdateVehicleMileage(Convert.ToInt32(gridAdmin.SelectedDataKey.Value), Convert.ToDateTime(txtDate.Text), txtMileage.Text, Convert.ToInt32(Session["EmpID"]));

       divUpdate.Visible = false;
       gridAdmin.DataBind();
       
    }

    protected void cmdFieldSave_Click(object sender, EventArgs e)
    {
        DataClassesDataContext myDB = new DataClassesDataContext();
        myDB.spUpdateVehicleMileage(Convert.ToInt32(gridActivity.SelectedDataKey.Value), Convert.ToDateTime(txtFieldDate.Text), txtFieldMileage.Text, Convert.ToInt32(Session["EmpID"]));

        divFieldUpdate.Visible = false;
        gridActivity.DataBind();

    }
    
    protected void gridActivity_SelectedIndexChanged(object sender, EventArgs e)
    {
        divFieldUpdate.Visible = true;

        DataClassesDataContext myDB = new DataClassesDataContext();
        var objRS = myDB.spSelectVehicleMileage(Convert.ToInt32(gridActivity.SelectedDataKey.Value));

        foreach (spSelectVehicleMileageResult record in objRS)
        {
            txtFieldDate.Text = Convert.ToString(record.FCS_vm_Date.Value.ToShortDateString());
            txtFieldMileage.Text = record.FCS_vm_Mileage;
            break;
        }
    }
    
    protected void gridAdmin_SelectedIndexChanged(object sender, EventArgs e)
    {
        divUpdate.Visible = true;

        DataClassesDataContext myDB = new DataClassesDataContext();
        var objRS = myDB.spSelectVehicleMileage(Convert.ToInt32(gridAdmin.SelectedDataKey.Value));

        foreach (spSelectVehicleMileageResult record in objRS)
        {
            txtDate.Text = Convert.ToString(record.FCS_vm_Date.Value.ToShortDateString());
            txtMileage.Text = record.FCS_vm_Mileage;
            break;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Convert.ToInt32(Session["AccessLevel"]) == 1)
            {
                divCoor.Visible = true;
                divAdmin.Visible = false;
                divUpdate.Visible = false;
                divFieldUpdate.Visible = false;
            }
            else
            {
                divCoor.Visible = false;
                divAdmin.Visible = true;
                divUpdate.Visible = false;
                divFieldUpdate.Visible = false;
            }
        }
    }

    protected void  DropFieldCoordinator_SelectedIndexChanged(object sender, EventArgs e)
    {
        gridAdmin.DataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1>Vehicle Mileage</h1>
    <asp:Label ID="lblMessage" runat="server" />
    
<div id="divCoor" runat="server">
    <div id="divFieldUpdate" runat="server">
        <table cellpadding="5" cellspacing="0" border="0">
            <tr>
                <td>Date: <asp:TextBox ID="txtFieldDate" Columns="10" MaxLength="10" runat="server" />
                    <asp:CalendarExtender ID="CalendarExtender2" TargetControlID="txtFieldDate" PopupButtonID="cal" runat="server"></asp:CalendarExtender>
                    <asp:imagebutton ImageUrl="images/Calendar_scheduleHS.png" CausesValidation="false" id="Imagebutton1" runat="server" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtFieldDate" ForeColor="Red" Text="*" Runat="Server" />
                </td>
            </tr>
            <tr>
                <td>Mileage: <asp:TextBox ID="txtFieldMileage" runat="server" /><asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtFieldMileage" ForeColor="Red" Text="*" runat="server"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td class="center"><asp:Button ID="cmdFieldSave" Text="Update" runat="server" onclick="cmdFieldSave_Click" /></td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
        SelectCommand="spSelectAllVehicleMileage" 
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="EmpID" SessionField="EmpID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="gridActivity" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" EmptyDataText="No data available."
        ForeColor="#333333" GridLines="None" DataKeyNames="FCS_vm_ID" AllowPaging="True" PageSize="15"
        onselectedindexchanged="gridActivity_SelectedIndexChanged" HorizontalAlign="Center" >
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="FCS_vm_ID" HeaderText="FCS_vm_ID" ReadOnly="True" 
                SortExpression="FCS_vm_ID" Visible="False" />
            <asp:BoundField DataField="FCS_vm_Date" HeaderText="Date" ReadOnly="True" 
                SortExpression="FCS_vm_Date" DataFormatString="{0:d}" />
            <asp:BoundField DataField="FCS_vm_Mileage" HeaderText="Mileage" ReadOnly="True" 
                SortExpression="FCS_vm_Mileage" />
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
<div id="divAdmin" runat="server">
    <div id="divUpdate" runat="server">
        <table cellpadding="5" cellspacing="0" border="0">
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
                <td class="center"><asp:Button ID="cmdSave" Text="Update" runat="server" onclick="cmdSave_Click" /></td>
            </tr>
        </table>
    </div>
<table cellpadding="10" cellspacing="0" border="0">
    <tr>
        <td>Law Enforcement Coordinator:
            <asp:SqlDataSource ID="SqlFieldCoordinator" runat="server" 
                ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                SelectCommand="spSelectFieldCoordinators" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:DropDownList ID="DropFieldCoordinator" runat="server" AppendDataBoundItems="true"
                DataSourceID="SqlFieldCoordinator" DataTextField="FullName" 
                DataValueField="FCS_u_emp_ID" AutoPostBack="true"
                onselectedindexchanged="DropFieldCoordinator_SelectedIndexChanged">
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                SelectCommand="spSelectAllVehicleMileage" 
                SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropFieldCoordinator" Name="EmpID" 
                                    PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="gridAdmin" runat="server" AllowSorting="True" 
                AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" EmptyDataText="No data available."
                ForeColor="#333333" GridLines="None" DataKeyNames="FCS_vm_ID" AllowPaging="True" PageSize="15"
                onselectedindexchanged="gridAdmin_SelectedIndexChanged" HorizontalAlign="Center" >
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="FCS_vm_ID" HeaderText="FCS_vm_ID" ReadOnly="True" 
                        SortExpression="FCS_vm_ID" Visible="False" />
                    <asp:BoundField DataField="FCS_vm_Date" HeaderText="Date" ReadOnly="True" 
                        SortExpression="FCS_vm_Date" DataFormatString="{0:d}" />
                    <asp:BoundField DataField="FCS_vm_Mileage" HeaderText="Mileage" ReadOnly="True" 
                        SortExpression="FCS_vm_Mileage" />
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
        </td>
    </tr>
</table>

</div>

</asp:Content>

