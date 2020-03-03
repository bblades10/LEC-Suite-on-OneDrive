<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<script runat="server">
    protected void panel_display(int activity_type)
    {
        switch (activity_type)
        {
            case 1:
                panAgency.Visible = true;
                panButtons.Visible = true;
                panNonMember.Visible = false;
                panTraining.Visible = false;
                panMisc.Visible = false;
                lblMessage.Text = "";
                break;
            case 2:
                panNonMember.Visible = true;
                panAgency.Visible = false;
                panButtons.Visible = true;
                panTraining.Visible = false;
                panMisc.Visible = false;
                lblMessage.Text = "";
                break;
            case 3:
                panNonMember.Visible = false;
                panAgency.Visible = false;
                panButtons.Visible = true;
                panTraining.Visible = true;
                panMisc.Visible = false;
                lblMessage.Text = "";
                break;
            case 4:
                panButtons.Visible = true;
                panAgency.Visible = false;
                panNonMember.Visible = false;
                panTraining.Visible = false;
                panMisc.Visible = true;
                lblMessage.Text = "Personal items like vacation need to be entered into your personal calendar.";
                break;
            default:
                panAgency.Visible = true;
                panButtons.Visible = true;
                panNonMember.Visible = false;
                panTraining.Visible = false;
                panMisc.Visible = false;
                lblMessage.Text = "";
                break;
        }

    }
    protected void dropActivityType_SelectedIndexChanged(object sender, EventArgs e)
    {
        //lblMessage.Text = dropActivityType.SelectedItem.ToString();
        panel_display( Convert.ToInt32(dropActivityType.SelectedValue));
        
    }

    protected void cmdCancel_onClick(object sender, EventArgs e)
    {
        if (Request.QueryString["l"] == "y")
        {
            Response.Redirect("listschedule.aspx");
        }
        else
        {
            Response.Redirect("default.aspx");
        }
    }

    protected void cmdImport_onClick(object sender, EventArgs e)
    {
        Response.Redirect("addactivity.aspx?sid=" + Request.QueryString["id"]);
    }

    protected void cmdSave_onClick(object sender, EventArgs e)
    {
        DataClassesDataContext myDB = new DataClassesDataContext();

        switch (dropActivityType.SelectedItem.ToString())
        {
            case "Agency Visit":
                myDB.spUpdateScheduleActivityNew(Convert.ToInt32(Request.QueryString["id"]), Convert.ToInt32(Session["EmpID"]), Convert.ToInt32(dropActivityType.SelectedItem.Value), Convert.ToInt32(dropAgency.SelectedItem.Value), "", "", "", Convert.ToDateTime(txtDate.Text), 0, "", Convert.ToInt32(Session["EmpID"]));
                break;
            case "Non Member Agency Visit":
                myDB.spUpdateScheduleActivityNew(Convert.ToInt32(Request.QueryString["id"]), Convert.ToInt32(Session["EmpID"]), Convert.ToInt32(dropActivityType.SelectedItem.Value), 0, txtNonMemberName.Text, txtNonMemberCity.Text, txtNonMemberState.Text, Convert.ToDateTime(txtDate.Text), 0, "", Convert.ToInt32(Session["EmpID"]));
                break;
            case "Meeting/Training":
                myDB.spUpdateScheduleActivityNew(Convert.ToInt32(Request.QueryString["id"]), Convert.ToInt32(Session["EmpID"]), Convert.ToInt32(dropActivityType.SelectedItem.Value), 0, txtMeetingName.Text, txtMeetingCity.Text, txtMeetingState.Text, Convert.ToDateTime(txtDate.Text), 0, txtGain.Text, Convert.ToInt32(Session["EmpID"]));
                break;
            case "Other":
                myDB.spUpdateScheduleActivityNew(Convert.ToInt32(Request.QueryString["id"]), Convert.ToInt32(Session["EmpID"]), Convert.ToInt32(dropActivityType.SelectedItem.Value), 0, txtMeetingName.Text, txtMeetingCity.Text, txtMeetingState.Text, Convert.ToDateTime(txtDate.Text), Convert.ToInt32(dropMiscType.SelectedItem.Value), "", Convert.ToInt32(Session["EmpID"]));
                break;
        }

        if (Request.QueryString["l"] == "y")
        {
            Response.Redirect("listschedule.aspx");
        }
        else
        {
            Response.Redirect("default.aspx");
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            if (Convert.ToInt32(Session["AccessLevel"]) == 3)
            {
                cmdSave.Visible = false;
            }
            
            dropActivityType.DataBind();
            dropAgency.DataBind();
            dropMiscType.DataBind();

            DataClassesDataContext myDB = new DataClassesDataContext();
            var objRS = myDB.spSelectScheduleActivity(Convert.ToInt32(Request.QueryString["id"]));

            foreach (spSelectScheduleActivityResult record in objRS)
            {
                panel_display( Convert.ToInt32(record.FCS_s_atype_ID));
                dropActivityType.SelectedValue = Convert.ToString(record.FCS_s_atype_ID);
                txtDate.Text = Convert.ToString(record.FCS_s_visit_date.Value.ToShortDateString());

                switch (record.FCS_s_atype_ID)
                { 
                    case 1:
                        dropAgency.SelectedValue = Convert.ToString(record.FCS_s_ag_Key);
                        break;
                    case 2:
                        txtNonMemberName.Text = record.FCS_s_nm_name;
                        txtNonMemberCity.Text = record.FCS_s_nm_city;
                        txtNonMemberState.Text = record.FCS_s_nm_state;
                        break;
                    case 3:
                        txtMeetingName.Text = record.FCS_s_nm_name;
                        txtMeetingCity.Text = record.FCS_s_nm_city;
                        txtMeetingState.Text = record.FCS_s_nm_state;
                        txtGain.Text = record.FCS_s_training_gain;
                        break;
                    case 4:
                        dropMiscType.SelectedValue = Convert.ToString(record.FCS_s_atm_ID);
                        break;
                }
            }
        }
    }
    
    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h1>Edit Schedule Event</h1>
<table cellpadding="5" cellspacing="0" border="0">
    <tr>
        <td><font color="red"><asp:Label ID="lblMessage" runat="server"></asp:Label></font></td>
    </tr>
    <tr>
        <td>Date: <asp:TextBox ID="txtDate" Columns="10" MaxLength="10" runat="server" />
            <asp:CalendarExtender ID="CalendarExtender1" TargetControlID="txtDate" PopupButtonID="cal" runat="server"></asp:CalendarExtender>
            <asp:imagebutton ImageUrl="images/Calendar_scheduleHS.png" id="cal" runat="server" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtDate" ForeColor="Red" Text="*" Runat="Server" />
        </td>
    </tr>
    <tr>
        <td>Activity Type: <asp:DropDownList ID="dropActivityType" runat="server" 
                DataSourceID="SqlDataSource1" DataTextField="FCS_atype_Type" 
                DataValueField="FCS_atype_ID" AutoPostBack="true"
                onselectedindexchanged="dropActivityType_SelectedIndexChanged"></asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                SelectCommand="spSelectScheduleActivityType" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        </td>
    </tr>
    <asp:Panel ID="panAgency" runat="server">
    <tr>
        <td>Agency: <asp:DropDownList ID="dropAgency" runat="server"
                DataSourceID="SqlDataSource2" DataTextField="AgencyName" DataValueField="ag_Key"></asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server"
            ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                SelectCommand="spSelectAgencies" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="00" Name="District" SessionField="District" 
                        Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    </asp:Panel>
    <asp:Panel ID="panNonMember" runat="server">
    <tr>
        <td>Non-Member Agency Name: <asp:TextBox ID="txtNonMemberName" Columns="50" MaxLength="100" runat="server"></asp:TextBox></td>
    </tr>
    <tr>
        <td>Non-Member Agency City: <asp:TextBox ID="txtNonMemberCity" Columns="50" MaxLength="100" runat="server"></asp:TextBox></td>
    </tr>
    <tr>
        <td>Non-Member Agency State: <asp:TextBox ID="txtNonMemberState" Columns="2" MaxLength="2" runat="server"></asp:TextBox></td>
    </tr>
    </asp:Panel>
    <asp:Panel ID="panTraining" runat="server">
    <tr>
        <td>Meeting/Training Name: <asp:TextBox ID="txtMeetingName" Columns="50" MaxLength="100" runat="server"></asp:TextBox></td>
    </tr>
    <tr>
        <td>City: <asp:TextBox ID="txtMeetingCity" Columns="50" MaxLength="100" runat="server"></asp:TextBox></td>
    </tr>
    <tr>
        <td>State: <asp:TextBox ID="txtMeetingState" Columns="2" MaxLength="2" runat="server"></asp:TextBox></td>
    </tr>
    <tr>
        <td>In your opinion what will RISS/MOCIC gain from your participation?<br /><asp:TextBox ID="txtGain" TextMode="MultiLine" Columns="50" Rows="4" runat="server"></asp:TextBox></td>
    </tr>
    </asp:Panel>
    <asp:Panel ID="panMisc" runat="server">
    <tr>
        <td>Misc Type: <asp:SqlDataSource ID="sqlMisc" ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                SelectCommand="spSelectMiscActivityType" SelectCommandType="StoredProcedure" runat="server"></asp:SqlDataSource>
                <asp:DropDownList ID="dropMiscType" DataSourceID="sqlMisc" DataTextField="FCS_amt_Type" DataValueField="FCS_amt_ID" runat="server"></asp:DropDownList>
        </td>
    </tr>
    </asp:Panel>
    <asp:Panel ID="panButtons" runat="server">
    <tr>
        <td class="center"><asp:Button ID="cmdCancel" Text="Cancel" OnClick="cmdCancel_onClick" runat="server" /><img src="images/spacer.gif" width="15" /><asp:Button ID="cmdSave" Text="Save" OnClick="cmdSave_onClick" runat="server" /></td>
    </tr>
    <tr>
        <td class="center"><asp:Button ID="cmdImport" Text="Import into Activity" OnClick="cmdImport_onClick" runat="server" /></td>
    </tr>
    </asp:Panel>
</table>

</asp:Content>

