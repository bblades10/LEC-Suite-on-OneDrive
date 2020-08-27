<%@ Page Title="" Language="C#" Debug="true" MasterPageFile="~/Main.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<% @Import Namespace="System.Web.Mail" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<script runat="server">

    protected void panel_display(int activity_type)
    {
        switch (activity_type)
        {
            case 1:
                panInfoDist.Visible = false;
                lblHours.Visible = true;
                panAgency.Visible = true;
                panButtons.Visible = true;
                panNonMember.Visible = false;
                panVisitInfo.Visible = true;
                panTraining.Visible = false;
                panMisc.Visible = false;
                panRISSafe.Visible = true;
                lblMessage.Text = "";
                break;
            case 2:
                panInfoDist.Visible = false;
                lblHours.Visible = true;
                panNonMember.Visible = true;
                panAgency.Visible = false;
                panButtons.Visible = true;
                panVisitInfo.Visible = true;
                panTraining.Visible = false;
                panMisc.Visible = false;
                panRISSafe.Visible = true;
                lblMessage.Text = "";
                break;
            case 3:
                panInfoDist.Visible = false;
                lblHours.Visible = true;
                panNonMember.Visible = false;
                panAgency.Visible = false;
                panVisitInfo.Visible = false;
                panButtons.Visible = true;
                panTraining.Visible = true;
                panSponsored.Visible = true;
                panMisc.Visible = false;
                panRISSafe.Visible = true;
                lblMessage.Text = "";
                break;
            case 4:
                panInfoDist.Visible = false;
                lblHours.Visible = true;
                panMisc.Visible = true;
                panButtons.Visible = true;
                panVisitInfo.Visible = false;
                panAgency.Visible = false;
                panNonMember.Visible = false;
                panTraining.Visible = false;
                panRISSafe.Visible = false;
                panOtherType.Visible = false;
                lblMessage.Text = "Personal items like vacation need to be entered into your time sheet on BambooHR.";
                break;
            case 5:
                panInfoDist.Visible = true;
                lblHours.Visible = false;
                panNonMember.Visible = false;
                panAgency.Visible = false;
                panVisitInfo.Visible = false;
                panButtons.Visible = true;
                panTraining.Visible = false;
                panMisc.Visible = false;
                panRISSafe.Visible = false;
                lblMessage.Text = "";
                break;
            default:
                panInfoDist.Visible = false;
                lblHours.Visible = true;
                panAgency.Visible = true;
                panButtons.Visible = true;
                panVisitInfo.Visible = true;
                panNonMember.Visible = false;
                panTraining.Visible = false;
                panMisc.Visible = false;
                panRISSafe.Visible = true;
                lblMessage.Text = "";
                break;
        }

    }

    protected void dropActivityType_SelectedIndexChanged(object sender, EventArgs e)
    {
        panel_display( Convert.ToInt32(dropActivityType.SelectedItem.Value));
    }


    protected void rdoSponsored_OnClick(object sender, EventArgs e)
    {
        //if (rdoSponsored.SelectedItem.Value == "1")
        //{
        //    panSponsored.Visible = true;
        //}
        //else
        //{
        //    panSponsored.Visible = false;
        //}
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["sid"] != "" && Request.QueryString["sid"] != null)
            {
                dropActivityType.DataBind();
                dropAgency.DataBind();
                dropMisc.DataBind();
                panOtherType.Visible = false;

                DataClassesDataContext myDB = new DataClassesDataContext();
                var objRS = myDB.spSelectScheduleActivity(Convert.ToInt32(Request.QueryString["sid"]));

                foreach (spSelectScheduleActivityResult record in objRS)
                {
                    panel_display(Convert.ToInt32(record.FCS_s_atype_ID));
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
                            rdoSponsored.SelectedValue = "0";
                            panSponsored.Visible = true;
                            panAttendedMeeting.Visible = true;
                            panAttendedTraining.Visible = false;
                            txtMeetingName.Text = record.FCS_s_nm_name;
                            txtMeetingCity.Text = record.FCS_s_nm_city;
                            txtMeetingState.Text = record.FCS_s_nm_state;
                            txtGain.Text = record.FCS_s_training_gain;
                            break;
                        case 4:
                            dropMisc.SelectedValue = Convert.ToString(record.FCS_s_atm_ID);
                            break;
                    }
                    lblMessage.Text = "After completing, you must click “Save” before the record will be added to your activity.";
                    lblCancelMessage.Text = "Selecting “cancel” will permanently delete this record.";
                    DataClassesDataContext myDelete = new DataClassesDataContext();
                    myDelete.spDeleteScheduledActivity(Convert.ToInt32(Session["EmpID"]), Convert.ToInt32(Request.QueryString["sid"]));
                    break;
                }
            }
            else if (Request.QueryString["mid"] != "" && Request.QueryString["mid"] != null)
            {
                dropActivityType.DataBind();
                dropAgency.DataBind();
                dropMisc.DataBind();

                panel_display(1);
                dropActivityType.SelectedValue = "1";

                txtDate.Text = Request.QueryString["date"];
                dropAgency.SelectedValue = Request.QueryString["mid"];

            }
            else if (Request.QueryString["nmid"] != "" && Request.QueryString["nmid"] != null)
            {
                dropActivityType.DataBind();
                dropAgency.DataBind();
                dropMisc.DataBind();

                panel_display(2);
                dropActivityType.SelectedValue = "2";

                txtDate.Text = Request.QueryString["date"];
                txtNonMemberName.Text = Request.QueryString["name"];
                txtNonMemberState.Text = Request.QueryString["state"];
                txtPersonContacted.Text = Request.QueryString["pc"];

            }
            else
            {
                panInfoDist.Visible = false;
                lblHours.Visible = true;
                panAgency.Visible = true;
                panButtons.Visible = true;
                panVisitInfo.Visible = true;
                panNonMember.Visible = false;
                panTraining.Visible = false;
                panMisc.Visible = false;
                panAttendedTraining.Visible = false;
                panSponsored.Visible = false;
            }
        }
    }

    protected void dropTrainingType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (dropTrainingType.SelectedValue == "2")
        {
            panAttendedMeeting.Visible = false;
            panAttendedTraining.Visible = true;
        }
        else
        {
            panAttendedMeeting.Visible = true;
            panAttendedTraining.Visible = false;
        }
    }

    protected void cmdSave_Click(object sender, EventArgs e)
    {
        cmdSave.Enabled = false;
        
        Nullable<int> intActivityID = null;
        DataClassesDataContext myDB = new DataClassesDataContext();

        if (chkRISSafe.Checked && txtRISSafe.Text == "0")
        {
            lblMessage.Text = "When checking the RISSafe box you must enter time.";
            cmdSave.Enabled = true;
        }
        else if (txtRISSafe.Text != "0" && chkRISSafe.Checked == false)
        {
            lblMessage.Text = "Must check the RISSafe box when entering time for RISSafe.";
            cmdSave.Enabled = true;
        }
        else if (dropActivityType.SelectedItem.ToString() == "Meeting/Training" && txtNotes.Text == "")
        {
            lblMessage.Text = "Must enter notes about the meeting/training.";
            cmdSave.Enabled = true;
        }
        //else if (chkNotOnSite.Checked == false && chkOnSite.Checked == false && chkPhone.Checked == false && chkAttempted.Checked == false)
        //{
        //    lblMessage.Text = "You must select either phone contact, on-site, attempted on-site, or not on-site.";
        //}
        else
        {
            if (dropActivityType.SelectedItem.ToString() == "Info/Intel Distributed")
            {
                lblHours.Visible = true;
                txtHours.Text = "0";
            }


            switch (dropActivityType.SelectedItem.ToString())
            {
                case "Agency Visit":
                    if (chkNotOnSite.Checked == false && chkOnSite.Checked == false && chkPhone.Checked == false && chkAttempted.Checked == false)
                    {
                        lblMessage.Text = "You must select either phone contact, on-site, attempted on-site, or not on-site.";
                        cmdSave.Enabled = true;
                    }
                    else if ((chkRISSafe.Checked == true || chkPhone.Checked == true || chkCISOP.Checked == true || chkAtix.Checked == true || chkDemoed.Checked == true || chkBackground.Checked == true) && txtOther.Text == "")
                    {
                        lblMessage.Text = "Must enter notes in the Other field about your visit.";
                        cmdSave.Enabled = true;
                    }
                    else
                    {
                        myDB.spInsertActivity(Convert.ToInt32(Session["EmpID"]), Convert.ToDateTime(txtDate.Text), Convert.ToInt32(dropActivityType.SelectedItem.Value), Convert.ToDouble(txtHours.Text), ref intActivityID);
                        DataClassesDataContext myAgency = new DataClassesDataContext();
                        myAgency.spInsertActivityAgencyVisit(intActivityID, Convert.ToInt32(dropAgency.SelectedItem.Value), "", "", "", dropOfficer.SelectedItem.Value.ToString(), chkAttemptedContact.Checked, chkPhone.Checked, chkOnSite.Checked, chkAttempted.Checked, chkNotOnSite.Checked, chkAtix.Checked, chkCISOP.Checked, Convert.ToInt32(txtSSLSetup.Text), "", chkDemoed.Checked, chkBackground.Checked, txtOther.Text, Convert.ToInt32(Session["EmpID"]));
                        myAgency.spInsertRISSafeHours(intActivityID, chkRISSafe.Checked, Convert.ToDouble(txtRISSafe.Text));
                        Response.Redirect("editactivity.aspx?id=" + intActivityID);
                    }
                    break;
                case "Non Member Agency Visit":
                    if (chkNotOnSite.Checked == false && chkOnSite.Checked == false && chkPhone.Checked == false && chkAttempted.Checked == false)
                    {
                        lblMessage.Text = "You must select either phone contact, on-site, attempted on-site, or not on-site.";
                        cmdSave.Enabled = true;
                    }
                    else if ((chkRISSafe.Checked == true || chkPhone.Checked == true || chkCISOP.Checked == true || chkAtix.Checked == true || chkDemoed.Checked == true || chkBackground.Checked == true) && txtOther.Text == "")
                    {
                        lblMessage.Text = "Must enter notes in the Other field about your visit.";
                        cmdSave.Enabled = true;
                    }
                    else
                    {
                        //DataClassesDataContext myDB = new DataClassesDataContext();
                        myDB.spInsertActivity(Convert.ToInt32(Session["EmpID"]), Convert.ToDateTime(txtDate.Text), Convert.ToInt32(dropActivityType.SelectedItem.Value), Convert.ToDouble(txtHours.Text), ref intActivityID);
                        DataClassesDataContext myNonMember = new DataClassesDataContext();
                        myNonMember.spInsertActivityAgencyVisit(intActivityID, 0, txtNonMemberName.Text, txtNonMemberCity.Text, txtNonMemberState.Text.ToUpper(), txtPersonContacted.Text, chkAttemptedContact.Checked, chkPhone.Checked, chkOnSite.Checked, chkAttempted.Checked, chkNotOnSite.Checked, chkAtix.Checked, chkCISOP.Checked, Convert.ToInt32(txtSSLSetup.Text), "", chkDemoed.Checked, chkBackground.Checked, txtOther.Text, Convert.ToInt32(Session["EmpID"]));
                        myNonMember.spInsertRISSafeHours(intActivityID, chkRISSafe.Checked, Convert.ToDouble(txtRISSafe.Text));
                        Response.Redirect("listactivity.aspx");
                    }
                    break;
                case "Meeting/Training":
                    //DataClassesDataContext myDB = new DataClassesDataContext();
                    myDB.spInsertActivity(Convert.ToInt32(Session["EmpID"]), Convert.ToDateTime(txtDate.Text), Convert.ToInt32(dropActivityType.SelectedItem.Value), Convert.ToDouble(txtHours.Text), ref intActivityID);
                    DataClassesDataContext myTraining = new DataClassesDataContext();
                    if (dropTrainingType.SelectedItem.Value == "1")
                    {
                        //if (rdoSponsored.SelectedItem.Value == "1")
                        //{
                        myTraining.spInsertActivityTrainingNew(intActivityID, Convert.ToInt32(dropTrainingType.SelectedItem.Value), Convert.ToInt32(rdoSponsored.SelectedItem.Value), dropParticipated.SelectedItem.Value, txtMeetingName.Text, Convert.ToInt32(txtMeetingAgencies.Text), Convert.ToInt32(txtMeetingAttendees.Text), 0, Convert.ToInt32(dropValue.SelectedItem.Value), txtGain.Text, txtNotes.Text, txtMeetingState.Text.ToUpper(), txtMeetingCity.Text, Convert.ToInt32(Session["EmpID"]));
                        myTraining.spInsertRISSafeHours(intActivityID, chkRISSafe.Checked, Convert.ToDouble(txtRISSafe.Text));
                        //}
                        //else
                        //{
                        //    myTraining.spInsertActivityTrainingNew(intActivityID, Convert.ToInt32(dropTrainingType.SelectedItem.Value), Convert.ToInt32(rdoSponsored.SelectedItem.Value), dropParticipated.SelectedItem.Value, txtMeetingName.Text, Convert.ToInt32(txtMeetingAgencies.Text), Convert.ToInt32(txtMeetingAttendees.Text), 0, txtNotes.Text, txtMeetingState.Text.ToUpper(), txtMeetingCity.Text);
                        //    myTraining.spInsertRISSafeHours(intActivityID, chkRISSafe.Checked, Convert.ToDouble(txtRISSafe.Text));
                        //}
                    }
                    else
                    {
                        myTraining.spInsertActivityTrainingNew(intActivityID, Convert.ToInt32(dropTrainingType.SelectedItem.Value), 0, "", txtTrainingAttended.Text, 0, 0, 0, 0, "", txtNotes.Text, txtTrainingState.Text.ToUpper(), txtTrainingCity.Text, Convert.ToInt32(Session["EmpID"]));
                        myTraining.spInsertRISSafeHours(intActivityID, chkRISSafe.Checked, Convert.ToDouble(txtRISSafe.Text));
                        DataClassesDataContext myRecordofTraining = new DataClassesDataContext();
                        myRecordofTraining.spInsertRecordofTraining(Session["FirstName"].ToString() + " " + Session["LastName"].ToString(), txtTrainingAttended.Text, txtLocation.Text, Convert.ToDateTime(txtStartDate.Text), Convert.ToDateTime(txtEndDate.Text), Convert.ToDecimal(txtTrainingHours.Text), txtSynopsis.Text, radInstructor.SelectedItem.Value, radContent.SelectedItem.Value, Convert.ToDecimal(txtCost.Text), txtNotes.Text, Session["UserName"].ToString());

                        using (SqlConnection objConn = new SqlConnection(ConfigurationManager.ConnectionStrings["FieldCoorSuiteConnectionString"].ConnectionString))
                        {
                            string strSupervisorEmail = "";

                            objConn.Open();

                            SqlCommand objCmd = new SqlCommand("[srv-dbs1].RecordOfTraining.dbo.spSelectSupervisor", objConn);
                            objCmd.CommandType = CommandType.StoredProcedure;
                            SqlParameter objParam = objCmd.Parameters.Add("@UserName", SqlDbType.VarChar, 50);
                            objParam.Direction = ParameterDirection.Input;
                            objParam.Value = Session["UserName"];
                            SqlDataReader objRS = objCmd.ExecuteReader();

                            while (objRS.Read())
                            {
                                strSupervisorEmail = (string)objRS["SupervisorEmail"];
                                break;
                            }

                            objRS.Close();
                            objConn.Close();

                            MailMessage objMM = new MailMessage();

                            objMM.To = strSupervisorEmail;
                            objMM.From = Session["UserName"] + "@mocic.riss.net";
                            objMM.Cc = Session["UserName"] + "@mocic.riss.net;ccurtis@mocic.riss.net";
                            //objMM.Bcc = "amcnew@mocic.riss.net";
                            objMM.BodyFormat = MailFormat.Html;
                            objMM.Priority = MailPriority.Normal;
                            objMM.Subject = "New Record of Training Entered";

                            string strBody = "";
                            strBody = "Name: " + Session["FirstName"] + " " + Session["LastName"] + "<br><br>" +
                                         "Training Name: " + txtTrainingAttended.Text + "<br>" +
                                         "Location: " + txtLocation.Text + "<br>" +
                                         "Start Date: " + txtStartDate.Text + "<br>" +
                                         "End Date: " + txtEndDate.Text + "<br><br>" +
                                         "Hours Completed: " + txtHours.Text + "<br><br>" +
                                         "Synopsis: <br>" + txtSynopsis.Text + "<br><br>" +
                                         "Instructor Rating: " + radInstructor.Text + "<br>" +
                                         "Content Rating: " + radContent.Text + "<br><br>" +
                                         "Cost: $" + txtCost.Text + "<br><br>" +
                                         "Additional Comments: <br>" + txtNotes.Text;

                            objMM.Body = strBody;

                            SmtpMail.SmtpServer = "10.12.1.2";
                            SmtpMail.Send(objMM);
                        }
                    }
                    Response.Redirect("editactivity.aspx?id=" + intActivityID);
                    break;
                case "Other":
                    //DataClassesDataContext myDB = new DataClassesDataContext();
                    myDB.spInsertActivity(Convert.ToInt32(Session["EmpID"]), Convert.ToDateTime(txtDate.Text), Convert.ToInt32(dropActivityType.SelectedItem.Value), Convert.ToDouble(txtHours.Text), ref intActivityID);
                    DataClassesDataContext myOtherDB = new DataClassesDataContext();
                    panOtherType.Visible = true;
                    myOtherDB.spInsertActivityMisc(Convert.ToInt32(intActivityID.ToString()), Convert.ToInt32(dropMisc.SelectedItem.Value), txtType.Text, Convert.ToInt32(Session["EmpID"]));
                    Response.Redirect("listactivity.aspx");
                    break;
                case "Info/Intel Distributed":
                    //DataClassesDataContext myDB = new DataClassesDataContext();
                    myDB.spInsertActivity(Convert.ToInt32(Session["EmpID"]), Convert.ToDateTime(txtDate.Text), Convert.ToInt32(dropActivityType.SelectedItem.Value), Convert.ToDouble(txtHours.Text), ref intActivityID);
                    DataClassesDataContext myInfoDB = new DataClassesDataContext();
                    myInfoDB.spInsertActivityInfoDist(Convert.ToInt32(intActivityID.ToString()), Convert.ToInt32(txtFaxes.Text), Convert.ToInt32(txtRecipients.Text), Convert.ToInt32(Session["EmpID"]));
                    Response.Redirect("listactivity.aspx");
                    break;
                default:
                    Response.Redirect("listactivity.aspx");
                    break;
            }
        }
    }

    protected void cmdCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("default.aspx");
    }

    protected void dropAgency_SelectedIndexChanged(object sender, EventArgs e)
    {
        dropOfficer.DataBind();
    }

    protected void dropMisc_SelectedIndexChanged(object sender, EventArgs e)
    {
        switch (dropMisc.SelectedItem.ToString())
        {
            case "Office Time":
                panOtherType.Visible = true;
                break;
            default:
                panOtherType.Visible = false;
                break;
        }
    }

    protected void chkPhone_CheckedChanged(object sender, EventArgs e)
    {
        chkOnSite.Checked = false;
        chkNotOnSite.Checked = false;
        chkAttempted.Checked = false;
    }

    protected void chkOnSite_CheckedChanged(object sender, EventArgs e)
    {
        chkPhone.Checked = false;
        chkNotOnSite.Checked = false;
        chkAttempted.Checked = false;
    }

    protected void chkAttempted_CheckedChanged(object sender, EventArgs e)
    {
        chkOnSite.Checked = false;
        chkNotOnSite.Checked = false;
        chkPhone.Checked = false;
    }

    protected void chkNotOnSite_CheckedChanged(object sender, EventArgs e)
    {
        chkOnSite.Checked = false;
        chkPhone.Checked = false;
        chkAttempted.Checked = false;
    }

</script>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<script type="text/javascript" language="javascript">

        Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
        function BeginRequestHandler(sender, args) { var oControl = args.get_postBackElement(); oControl.disabled = true; }

    </script>--%>
    <script type="text/javascript">
       var submit = 0;
       function CheckDouble() {
        if (++submit > 1) {
            document.getElementById("ContentPlaceHolder1_cmdSave").disabled = true;
            alert('This sometimes takes a few seconds - please be patient.');
            return false;
            }
        }
     </script>
    <h1>
        Add Activity Event</h1>
    <asp:Panel ID="panPage" CssClass="left" runat="server">
        <table cellpadding="5" cellspacing="0" border="0">
            <tr>
                <td>
                    <font color="red">
                        <asp:Label ID="lblMessage" runat="server"></asp:Label></font>
                </td>
            </tr>
            <tr>
                <td class="center">
                    <i>
                        <asp:ValidationSummary ID="valSum" runat="server" HeaderText="Please complete all required fields!"
                            DisplayMode="SingleParagraph" CssClass="validation" Font-Size="12px" />
                    </i>
                </td>
            </tr>
            <tr>
                <td>
                    Activity Type:
                    <asp:DropDownList ID="dropActivityType" runat="server" DataSourceID="SqlDataSource1"
                        DataTextField="FCS_atype_Type" DataValueField="FCS_atype_ID" AutoPostBack="true"
                        OnSelectedIndexChanged="dropActivityType_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>"
                        SelectCommand="spSelectActivityType" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
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
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtDate"
                        CssClass="validation" Text="*" runat="Server" /><asp:RegularExpressionValidator
                                                ID="RegularExpressionValidator6" runat="server" CssClass="validation" ErrorMessage="MM/DD/YYYY" ValidationExpression="\d{1,2}\/\d{1,2}/\d{4}"
                                                ControlToValidate="txtDate" />
                </td>
            </tr>
            <asp:Panel ID="lblHours" runat="server">
            <tr>
                <td>
                    Hours:
                    <asp:TextBox ID="txtHours" Columns="5" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ControlToValidate="txtHours"
                        CssClass="validation" Text="*" runat="Server" /><asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                    ErrorMessage="*" CssClass="validation" ValidationExpression="(^\d*\.?\d*[0-9]+\d*$)|(^[0-9]+\d*\.\d*$)"
                                    ControlToValidate="txtHours" />
                </td>
            </tr>
            </asp:Panel>
        </table>
        <asp:Panel ID="panInfoDist" runat="server">
            <table cellpadding="5" cellspacing="0" border="0">
                <tr>
                    <td>
                        # E-mails/Faxes/Etc.:
                        <asp:TextBox ID="txtFaxes" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        # Recipients:
                        <asp:TextBox ID="txtRecipients" runat="server"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="panAgency" runat="server">
            <asp:UpdatePanel runat="server" ID="upPanAgency">
                <ContentTemplate>
                    <table cellpadding="5" cellspacing="0" border="0">
                        <tr>
                            <td>
                                Agency:
                                <asp:DropDownList ID="dropAgency" runat="server" DataSourceID="SqlDataSource2" DataTextField="AgencyName"
                                    DataValueField="ag_Key" AutoPostBack="true"
                                    onselectedindexchanged="dropAgency_SelectedIndexChanged">
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
                                Person Contacted:
                                <asp:SqlDataSource ID="sqlOfficer" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                                    SelectCommand="spSelectAgencyOfficersWithSCC" 
                                    SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="dropAgency" Name="ag_Key" 
                                            PropertyName="SelectedValue" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:DropDownList ID="dropOfficer" runat="server" DataSourceID="sqlOfficer" 
                                    DataTextField="FullName" DataValueField="FullName">
                                </asp:DropDownList>
                                <img src="images/spacer.gif" height="0" width="20" />
                                <asp:CheckBox ID="chkAttemptedContact" Text="Attempted" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <img src="images/spacer.gif" height="7" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <img src="images/bar.jpg" height="3" width="800" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <img src="images/spacer.gif" height="7" />
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="dropAgency" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </asp:Panel>
        <asp:Panel ID="panNonMember" runat="server">
            <table cellpadding="5" cellspacing="0" border="0">
                <tr>
                    <td>
                        Non-Member Agency Name:
                        <asp:TextBox ID="txtNonMemberName" Columns="50" MaxLength="100" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtNonMemberName"
                        CssClass="validation" Text="*" runat="Server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Non-Member Agency City:
                        <asp:TextBox ID="txtNonMemberCity" Columns="50" MaxLength="50" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ControlToValidate="txtNonMemberCity"
                        CssClass="validation" Text="*" runat="Server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Non-Member Agency State:
                        <asp:TextBox ID="txtNonMemberState" Columns="2" MaxLength="2" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ControlToValidate="txtNonMemberState"
                        CssClass="validation" Text="*" runat="Server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Person Contacted:
                        <asp:TextBox ID="txtPersonContacted" Columns="50" MaxLength="100" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator22" ControlToValidate="txtPersonContacted"
                        CssClass="validation" Text="*" runat="Server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="images/spacer.gif" height="7" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="images/bar.jpg" height="3" width="800" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="images/spacer.gif" height="7" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="panRISSafe" runat="server">
            <table cellpadding="5" cellspacing="0" border="0">
                <tr>
                    <td>
                        <asp:CheckBox ID="chkRISSafe" runat="server" Text="RISSafe" />
                    </td>
                    <td>
                        <img src="images/spacer.gif" height="0" width="100" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtRISSafe" Columns="5" Text="0" runat="server"></asp:TextBox># RISSafe Hours<asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server"
                                    ErrorMessage="*" CssClass="validation" ValidationExpression="(^\d*\.?\d*[0-9]+\d*$)|(^[0-9]+\d*\.\d*$)"
                                    ControlToValidate="txtRISSafe" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="panVisitInfo" runat="server">
            <asp:UpdatePanel ID="upVisitInfo" runat="server">
                <ContentTemplate>
                    <table cellpadding="5" cellspacing="0" border="0">
                        <tr>
                            <td>
                                <asp:CheckBox ID="chkPhone" runat="server" Text="Phone Contact" AutoPostBack="true" OnCheckedChanged="chkPhone_CheckedChanged" />
                            </td>
                            <td>
                                <img src="images/spacer.gif" height="0" width="100" />
                            </td>
                            <td>
                                <asp:CheckBox ID="chkOnSite" runat="server" Text="On-Site" AutoPostBack="true" OnCheckedChanged="chkOnSite_CheckedChanged" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="chkAttempted" runat="server" Text="Attempted On-Site" AutoPostBack="true" OnCheckedChanged="chkAttempted_CheckedChanged" />
                            </td>
                            <td>
                                <img src="images/spacer.gif" height="0" width="100" />
                            </td>
                            <td>
                                <asp:CheckBox ID="chkNotOnSite" runat="server" AutoPostBack="true" Text="Not On-Site (agency contact during intel meeting, etc.)" OnCheckedChanged="chkNotOnSite_CheckedChanged" />
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="chkPhone" EventName="CheckedChanged" />
                    <asp:AsyncPostBackTrigger ControlID="chkOnSite" EventName="CheckedChanged" />
                    <asp:AsyncPostBackTrigger ControlID="chkAttempted" EventName="CheckedChanged" />
                    <asp:AsyncPostBackTrigger ControlID="chkNotOnSite" EventName="CheckedChanged" />
                </Triggers>
            </asp:UpdatePanel>
            <table cellpadding="5" cellspacing="0" border="0">
                <tr>
                    <td>
                        <asp:CheckBox ID="chkCISOP" runat="server" Text="CISOP Completed" />
                    </td>
                    <td>
                        <img src="images/spacer.gif" height="0" width="100" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtSSLSetup" Columns="5" Text="0" runat="server"></asp:TextBox>
                        # of SSL Accounts set this Visit<asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                                    ErrorMessage="*" CssClass="validation" ValidationExpression="(^\d*\.?\d*[0-9]+\d*$)|(^[0-9]+\d*\.\d*$)"
                                    ControlToValidate="txtSSLSetup" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:CheckBox ID="chkAtix" runat="server" Text="ATIX" />
                    </td>
                </tr>
            </table>
            <table cellpadding="5" cellspacing="0" border="0">
                <%--<tr>
                    <td>
                        Remote Connection&nbsp;<asp:DropDownList ID="dropRemote" runat="server">
                            <asp:ListItem Value="" Text=""></asp:ListItem>
                            <asp:ListItem Value="Working Properly" Text="Working Properly"></asp:ListItem>
                            <asp:ListItem Value="Working Partially" Text="Working Partially"></asp:ListItem>
                            <asp:ListItem Value="Not Working" Text="Not Working"></asp:ListItem>
                            <asp:ListItem Value="Not Verified" Text="Not Verified"></asp:ListItem>
                            <asp:ListItem Value="Not Connected" Text="Not Connected"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>--%>
                <tr>
                    <td>
                        <asp:CheckBox ID="chkDemoed" runat="server" Text="Demoed/Discussed MOCIC/RISS Services (orientations/reorientations)" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:CheckBox ID="chkBackground" runat="server" Text="LEC Report, app/reapp process" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Other<br />
                        <asp:TextBox TextMode="MultiLine" Rows="4" Columns="50" ID="txtOther" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="images/spacer.gif" height="7" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <img src="images/bar.jpg" height="3" width="800" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="images/spacer.gif" height="7" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="panMisc" runat="server">
            <table cellpadding="5" cellspacing="0" border="0">
                <tr>
                    <td>
                        <asp:SqlDataSource ID="sqlMisc" runat="server" ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>"
                            SelectCommand="spSelectActivityMiscTypes" SelectCommandType="StoredProcedure">
                        </asp:SqlDataSource>
                        Other Type:
                        <asp:DropDownList ID="dropMisc" runat="server" DataSourceID="sqlMisc" DataTextField="FCS_amt_Type" AutoPostBack="true"
                        OnSelectedIndexChanged="dropMisc_SelectedIndexChanged" DataValueField="FCS_amt_ID">
                        </asp:DropDownList>
                    </td>
                </tr>
                <asp:Panel ID="panOtherType" runat="server">
                <tr>
                    <td>
                        Type: <asp:TextBox ID="txtType" runat="server"></asp:TextBox>
                    </td>
                </tr>
                </asp:Panel>
                <tr>
                    <td>
                        <img src="images/spacer.gif" height="7" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="images/bar.jpg" height="3" width="800" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="images/spacer.gif" height="7" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="panTraining" runat="server">
            <table cellpadding="5" cellspacing="0" border="0">
                <tr>
                    <td>
                        <asp:SqlDataSource ID="sqlTrainingType" runat="server" ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>"
                            SelectCommandType="StoredProcedure" SelectCommand="spSelectActivityTrainingTypes">
                        </asp:SqlDataSource>
                        Meetings/Conferences/Trainings Type
                        <asp:DropDownList ID="dropTrainingType" DataSourceID="sqlTrainingType" DataTextField="FCS_att_Type"
                            DataValueField="FCS_att_ID" runat="server" AutoPostBack="true" OnSelectedIndexChanged="dropTrainingType_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="panAttendedMeeting" runat="server">
                <table cellpadding="5" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <img src="images/spacer.gif" height="0" width="20" />
                        </td>
                        <td>
                            <%--<asp:RadioButtonList ID="RadioButtonList1" OnSelectedIndexChanged="rdoSponsored_OnClick" AutoPostBack="true" runat="server">--%>
                            <asp:RadioButtonList ID="rdoSponsored" runat="server">
                                <asp:ListItem Value="0" Text="NOT sponsored or co-sponsored by MOCIC/RISS (i.e. USAO LECC meeting, NSA, IACP, IALEA, etc.)"></asp:ListItem>
                                <asp:ListItem Value="1" Text="Sponsored or co-sponsored by MOCIC/RISS(i.e. SLATT, NW3C, etc. - check with Training Dept. if unsure)"></asp:ListItem>
                            </asp:RadioButtonList><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator13" CssClass="validation" ControlToValidate="rdoSponsored" Text="*"
                                runat="Server" />

                        </td>
                    </tr>
                    <%--<tr>
                        <td>
                            <img src="images/spacer.gif" height="0" width="20" />
                        </td>
                        <td>
                            <asp:CheckBox ID="chkPresenter" Text="I was a Presenter" runat="server" />
                            
                        </td>--%>
                    <tr>
                        <td colspan="2">
                            Participated as <asp:DropDownList ID="dropParticipated" runat="server">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                                <asp:ListItem Text="Presenter" Value="Presenter"></asp:ListItem>
                                <asp:ListItem Text="Vendor" Value="Vendor"></asp:ListItem>
                                <asp:ListItem Text="Attendee" Value="Attendee"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            Name of Meeting
                            <asp:TextBox ID="txtMeetingName" Columns="75" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator14" CssClass="validation" ControlToValidate="txtMeetingName" Text="*"
                                runat="Server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            Meeting City
                            <asp:TextBox ID="txtMeetingCity" Columns="50" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator15" CssClass="validation" ControlToValidate="txtMeetingCity" Text="*"
                                runat="Server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            Meeting State
                            <asp:TextBox ID="txtMeetingState" Columns="2" MaxLength="2" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator16" CssClass="validation" ControlToValidate="txtMeetingState" Text="*"
                                runat="Server" />
                        </td>
                    </tr>
                </table>
                <asp:Panel ID="panSponsored" runat="server">
                    <table cellpadding="5" cellspacing="0" border="0">
                        <tr>
                            <td>
                                # of agencies in attendance
                                <asp:TextBox ID="txtMeetingAgencies" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator17" CssClass="validation" ControlToValidate="txtMeetingAgencies" Text="*"
                                runat="Server" /><asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server"
                                    ErrorMessage="*" CssClass="validation" ValidationExpression="(^\d*\.?\d*[1-9]+\d*$)|(^[1-9]+\d*\.\d*$)"
                                    ControlToValidate="txtMeetingAgencies" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                # of attendees
                                <asp:TextBox ID="txtMeetingAttendees" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator18" CssClass="validation" ControlToValidate="txtMeetingAttendees" Text="*"
                                runat="Server" /><asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server"
                                    ErrorMessage="*" CssClass="validation" ValidationExpression="(^\d*\.?\d*[1-9]+\d*$)|(^[1-9]+\d*\.\d*$)"
                                    ControlToValidate="txtMeetingAttendees" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                How do you rate the value of your attendance at this event? (1=no value - 10=very significant value) 
                                <asp:DropDownList ID="dropValue" runat="server">
                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                    <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                    <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                    <asp:ListItem Text="9" Value="9"></asp:ListItem>
                                    <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                In your opinion what did RISS/MOCIC gain from your participation?<br></br><asp:TextBox ID="txtGain" TextMode="MultiLine" Rows="4" Columns="50" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <%--<tr>
                            <td>
                                # of hours
                                <asp:TextBox ID="txtMeetingHours" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator19" CssClass="validation" ControlToValidate="txtMeetingHours" Text="*"
                                runat="Server" /><asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server"
                                    ErrorMessage="*" CssClass="validation" ValidationExpression="(^\d*\.?\d*[1-9]+\d*$)|(^[1-9]+\d*\.\d*$)"
                                    ControlToValidate="txtMeetingHours" />
                            </td>
                        </tr>--%>
                    </table>
                </asp:Panel>
            </asp:Panel>
            <asp:Panel ID="panAttendedTraining" runat="server">
                <table cellpadding="5" cellspacing="0" border="0">
                    <tr>
                        <td>
                            Training name:
                            <asp:TextBox ID="txtTrainingAttended" MaxLength="50" runat="server" /><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator3" CssClass="validation" ControlToValidate="txtTrainingAttended" Text="*"
                                runat="Server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Location:
                            <asp:TextBox ID="txtLocation" MaxLength="50" runat="server" /><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator4" CssClass="validation" ControlToValidate="txtLocation" Text="*" runat="Server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            City:
                            <asp:TextBox ID="txtTrainingCity" Columns="50" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator20" CssClass="validation" ControlToValidate="txtTrainingCity" Text="*" runat="Server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            State:
                            <asp:TextBox ID="txtTrainingState" Columns="2" MaxLength="2" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator21" CssClass="validation" ControlToValidate="txtTrainingState" Text="*" runat="Server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Dates Attended:<br />
                            <table border="0">
                                <tr>
                                    <td>
                                        Start Date:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtStartDate" Columns="10" MaxLength="11" runat="server" /><asp:CalendarExtender ID="CalendarExtender2" TargetControlID="txtStartDate" PopupButtonID="cal1" runat="server">
                                                </asp:CalendarExtender><asp:ImageButton ImageUrl="images/Calendar_scheduleHS.png" ID="cal1" CausesValidation="false" runat="server" /><asp:RequiredFieldValidator
                                            ID="RequiredFieldValidator5" CssClass="validation" ControlToValidate="txtStartDate" Text="*" runat="Server" /><asp:RegularExpressionValidator
                                                ID="DateRegex1" runat="server" CssClass="validation" ErrorMessage="MM/DD/YYYY" ValidationExpression="\d{1,2}\/\d{1,2}/\d{4}"
                                                ControlToValidate="txtStartDate" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        End Date:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtEndDate" Columns="10" MaxLength="11" runat="server" /><asp:CalendarExtender ID="CalendarExtender3" TargetControlID="txtEndDate" PopupButtonID="cal2" runat="server">
                                                </asp:CalendarExtender><asp:ImageButton ImageUrl="images/Calendar_scheduleHS.png" ID="cal2" CausesValidation="false" runat="server" /><asp:RequiredFieldValidator
                                            ID="RequiredFieldValidator6" CssClass="validation" ControlToValidate="txtEndDate" Text="*" runat="Server" /><asp:RegularExpressionValidator
                                                ID="DateRegex2" runat="server" CssClass="validation" ErrorMessage="MM/DD/YYYY" ValidationExpression="\d{1,2}\/\d{1,2}/\d{4}"
                                                ControlToValidate="txtEndDate" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Number of hours completed:
                            <asp:TextBox ID="txtTrainingHours" value="0" Columns="3" MaxLength="6"
                                runat="server" /><asp:RegularExpressionValidator ID="NumberRegex" runat="server"
                                    ErrorMessage="*" CssClass="validation" ValidationExpression="(^\d*\.?\d*[1-9]+\d*$)|(^[1-9]+\d*\.\d*$)"
                                    ControlToValidate="txtTrainingHours" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Synopsis of Training Attended:<asp:RequiredFieldValidator ID="RequiredFieldValidator7"
                                ControlToValidate="txtSynopsis" CssClass="validation" Text="*" runat="Server" /><br />
                            <asp:TextBox ID="txtSynopsis" TextMode="multiline" Rows="5" Columns="50"
                                runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Instructor:<asp:RequiredFieldValidator ID="RequiredFieldValidator8" CssClass="validation" ControlToValidate="radInstructor"
                                Text="*" runat="Server" />
                            <asp:RadioButtonList ID="radInstructor" RepeatDirection="horizontal"
                                runat="server">
                                <asp:ListItem id="Poor" runat="server" Value="Poor" />
                                <asp:ListItem id="Average" runat="server" Value="Average" />
                                <asp:ListItem id="AboveAverage" runat="server" Value="Above Average" />
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Content:<asp:RequiredFieldValidator ID="RequiredFieldValidator9" CssClass="validation" ControlToValidate="radContent"
                                Text="*" runat="Server" />
                            <asp:RadioButtonList ID="radContent" RepeatDirection="horizontal"
                                runat="server">
                                <asp:ListItem id="NotUseful" runat="server" Value="Not Useful" />
                                <asp:ListItem id="Useful" runat="server" Value="Useful" />
                                <asp:ListItem id="VeryUseful" runat="server" Value="Very Useful" />
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Cost: $<asp:TextBox ID="txtCost" value="0.00" onBlur="this.value=formatCurrency(this.value);"
                                Columns="7" MaxLength="7" runat="server" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <table cellpadding="5" cellspacing="0" border="0">
                <tr>
                    <td>
                        Notes<br />
                        <asp:TextBox ID="txtNotes" TextMode="MultiLine" Columns="75" Rows="5" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="images/spacer.gif" height="7" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <img src="images/bar.jpg" height="3" width="800" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="images/spacer.gif" height="7" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="panButtons" runat="server">
            <table cellpadding="5" cellspacing="0" border="0" width="800px">
                <tr class="center">
                    <td class="center"><font color="red"><asp:Label ID="lblCancelMessage" runat="server"></asp:Label></font></td>
                </tr>
                <tr class="center">
                    <td class="center">
                        <asp:Button ID="cmdSave" runat="server" Text="Save" OnClick="cmdSave_Click" OnClientClick="return CheckDouble();" /><img
                            src="images/spacer.gif" height="0" width="50" />
                        <asp:Button ID="cmdCancel" runat="server" CausesValidation="false" Text="Cancel" OnClick="cmdCancel_Click" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="images/spacer.gif" height="5" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </asp:Panel>
</asp:Content>
