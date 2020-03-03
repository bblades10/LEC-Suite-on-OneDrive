<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<script runat="server">
    
    protected void Page_Load(object sender, EventArgs e)
    {
        switch (Request.QueryString["type"])
        {
            case "4":
                panMember.Visible = false;
                panOther.Visible = true;
                lblTitle.Text = "Contacted Other Agencies";
                break;
            case "3":
                panMember.Visible = true;
                panOther.Visible = false;
                lblTitle.Text = "Contacted Surrounding Member Agencies";
                break;
            case "2":
                panMember.Visible = true;
                panOther.Visible = false;
                lblTitle.Text = "Contacted State Member Agencies";
                break;
            case "1":
                panMember.Visible = true;
                panOther.Visible = false;
                lblTitle.Text = "Support Letter";
                break;
        }
    }

    protected void cmdSaveMember_OnClick(object sender, EventArgs e)
    {
        DataClassesDataContext myDB = new DataClassesDataContext();
        myDB.spInsertContactedMembers(Convert.ToInt32(Request.QueryString["id"]), Convert.ToInt32(Request.QueryString["type"]), Convert.ToInt32(dropAgency.SelectedItem.Value), txtContactName.Text, Convert.ToDateTime(txtDate.Text), Convert.ToInt32(Session["EmpID"]));
        Response.Redirect("addapplication.aspx?id=" + Request.QueryString["id"]);
    }

    protected void cmdSaveOther_OnClick(object sender, EventArgs e)
    {
        DataClassesDataContext myDB = new DataClassesDataContext();
        myDB.spInsertContactedOtherAgency(Convert.ToInt32(Request.QueryString["id"]), txtAgency.Text, txtContactName2.Text, Convert.ToDateTime(txtDate2.Text), Convert.ToInt32(Session["EmpID"]));
        Response.Redirect("addapplication.aspx?id=" + Request.QueryString["id"]);
    }
    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1><asp:Label ID="lblTitle" runat="server"></asp:Label></h1>
<asp:Panel ID="panMember" runat="server">
    <table cellpadding="4" cellspacing="0" border="0">
        <tr>
            <td>
                Agency:
                <asp:DropDownList ID="dropAgency" runat="server" DataSourceID="SqlDataSource2" DataTextField="AgencyName"
                    DataValueField="ag_Key">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>"
                    SelectCommand="spSelectAgencies" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="00" Name="District" SessionField="District" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                Contact: <asp:TextBox ID="txtContactName" Columns="50" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Date:
                    <asp:TextBox ID="txtDate" Columns="10" MaxLength="10" runat="server" />
                    <asp:CalendarExtender ID="CalendarExtender1" TargetControlID="txtDate" PopupButtonID="cal"
                        runat="server">
                    </asp:CalendarExtender>
                    <asp:ImageButton ImageUrl="images/Calendar_scheduleHS.png" ID="cal" CausesValidation="false" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="center"><asp:Button ID="cmdSaveMember" Text="Save" OnClick="cmdSaveMember_OnClick" runat="server" /></td>
        </tr>
    </table>
</asp:Panel>
<asp:Panel ID="panOther" runat="server">
    <table cellpadding="4" cellspacing="0" border="0">
        <tr>
            <td>Agency: <asp:TextBox ID="txtAgency" Columns="50" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td>
                Contact: <asp:TextBox ID="txtContactName2" Columns="50" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Date:
                    <asp:TextBox ID="txtDate2" Columns="10" MaxLength="10" runat="server" />
                    <asp:CalendarExtender ID="CalendarExtender2" TargetControlID="txtDate2" PopupButtonID="ImageButton1"
                        runat="server">
                    </asp:CalendarExtender>
                    <asp:ImageButton ImageUrl="images/Calendar_scheduleHS.png" ID="ImageButton1" CausesValidation="false" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="center"><asp:Button ID="cmdSaveOther" Text="Save" OnClick="cmdSaveOther_OnClick" runat="server" /></td>
        </tr>
    </table>
</asp:Panel>
</asp:Content>

