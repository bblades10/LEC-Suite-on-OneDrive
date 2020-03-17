<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>


<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Request.QueryString["s"] == "y")
                {
                    lblSuccess.Text = "The record has been added.";
                }
                
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message +
                    "<br><br>" +
                    Environment.NewLine +
                    "Contact the IT department.";
                lblError.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void chkAllDayEvent_CheckedChanged(object sender, EventArgs e)
        {
            //Disable leave time hours and minutes dropdowns if all day event selected
            if (chkAllDayEvent.Checked == true)
            {
                drpLeaveStartHour.Attributes.Add("disabled", "disabled");
                drpLeaveStartMinutes.Attributes.Add("disabled", "disabled");
                drpLeaveEndHour.Attributes.Add("disabled", "disabled");
                drpLeaveEndMinutes.Attributes.Add("disabled", "disabled");
                chkNotReturning.Attributes.Add("disabled", "disabled");
            }
            //Enable leave time hours and minutes dropdowns if all day event not selected
            else
            {
                drpLeaveStartHour.Attributes.Remove("disabled");
                drpLeaveStartMinutes.Attributes.Remove("disabled");
                drpLeaveEndHour.Attributes.Remove("disabled");
                drpLeaveEndMinutes.Attributes.Remove("disabled");
                chkNotReturning.Attributes.Remove("disabled");
            }
        }
            

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            LeaveCalendarDataContext myDB = new LeaveCalendarDataContext();
            try
            {
                //Pass value for all day event
                //Don't pass value for time if it's an all day event
                int intAllDayEvent = 0;
                string strLeaveStartHour = "", strLeaveStartMinutes = "", strLeaveEndHour = "", strLeaveEndMinutes = "";
                if (chkAllDayEvent.Checked == true)
                {
                    intAllDayEvent = 1;
                }
                else
                {
                    strLeaveStartHour = drpLeaveStartHour.SelectedValue;
                    strLeaveStartMinutes = drpLeaveStartMinutes.SelectedValue;

                    //Don't pass values for endhour and endminutes if not returning is checked
                    if (chkNotReturning.Checked == true)
                    {
                        strLeaveEndHour = "";
                        strLeaveEndMinutes = "*";
                    }
                    else
                    {
                        strLeaveEndHour = drpLeaveEndHour.SelectedValue;
                        strLeaveEndMinutes = drpLeaveEndMinutes.SelectedValue;
                    }
                       
                }

                //Pass number of times to repeat this event in the future
                int intRepeatNumber = 0, intHowOften = 0;
                
                //Determine which employee id to use
                int intEmployeeID = Convert.ToInt32(Session["EmpID"]);
                //For audit record
                int intUserID = Convert.ToInt32(Session["EmpID"]);
                
                

                //Create calendar record(s)
                myDB.spInsertCalendarRecord(intEmployeeID, intUserID, Convert.ToDateTime(txtStartDate.Text), Convert.ToDateTime(txtEndDate.Text), intAllDayEvent, strLeaveStartHour, strLeaveStartMinutes, strLeaveEndHour, strLeaveEndMinutes, Convert.ToInt32(drpLeaveType.SelectedValue), txtComment.Text, intRepeatNumber, intHowOften);
                //Response.Redirect("PersonalCalendar");                
                Response.Redirect("addcalendarnew.aspx?s=y");
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message +
                    "<br><br>" +
                    Environment.NewLine +
                    "Contact the IT department.";
                lblError.ForeColor = System.Drawing.Color.Red;
            }
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
            
        protected void chkNotReturning_CheckedChanged(object sender, EventArgs e)
        {
            //Disable leave end time if not returning checked
            if (chkNotReturning.Checked == true)
            {
                drpLeaveEndHour.Attributes.Add("disabled", "disabled");
                drpLeaveEndMinutes.Attributes.Add("disabled", "disabled");
            }
            //Enable leave end time if not returning unchecked
            else
            {
                drpLeaveEndHour.Attributes.Remove("disabled");
                drpLeaveEndMinutes.Attributes.Remove("disabled");
            }
        }

</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
    $(document).ready(function () {
        $("#txtStartDate").datepicker({
            minDate: 0,
            numberOfMonths: 2,
            dateFormat: 'm/dd/yy',
            onSelect: function (selected) {
                $("#txtEndDate").datepicker("option", "minDate", selected)
            }
        });
        $("#txtEndDate").datepicker({
            minDate: 0,
            numberOfMonths: 2,
            dateFormat: 'm/dd/yy',
            onSelect: function (selected) {
                $("#txtStartDate").datepicker("option", "maxDate", selected)
            }
        });
    });
</script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <h1>Add Personal Calendar</h1>
    <p style="color:red">Items entered below are for your own personel use within the suite.  You will still need to add everything appropriate to Bamboo HR for everyone else to see.</p>
    <table width="400" border="0" cellspacing="0" cellpadding="5">
        <tr>
            <td colspan="3">
                <i>
                    <asp:ValidationSummary ID="valSum" runat="server" HeaderText="* Required Fields"
                        DisplayMode="SingleParagraph" Font-Size="12px" />
                </i>
            </td>
        </tr>
        <tr>
            <td colspan="3"><asp:Label ID="lblSuccess" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td>
                <font class="normal">Start Date:</font>
            </td>
            <td>
                <asp:TextBox ID="txtStartDate" size="10" ClientIDMode="Static" MaxLength="10" runat="server" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorStartDate"
                        runat="server"
                        ErrorMessage="Please select a start date." ControlToValidate="txtStartDate"
                        Display="Dynamic" SetFocusOnError="True" CssClass="text-danger" />
                <%--<asp:CalendarExtender ID="CalendarExtenderStart" TargetControlID="txtStartDate" PopupButtonID="cal" runat="server"></asp:CalendarExtender>
                <asp:imagebutton ImageUrl="images/Calendar_scheduleHS.png" CausesValidation="false" id="cal" runat="server" /> --%>
            </td>
            <td>
                <img src="images/spacer.gif" width="1" height="1" border="0" alt=""><asp:RequiredFieldValidator
                    ID="RequiredFieldValidator1" ControlToValidate="txtStartDate" Text="*" runat="Server" />
            </td>
        </tr>
        <tr>
            <td>
                <font class="normal">End Date:</font>
            </td>
            <td>
                <asp:TextBox ID="txtEndDate" size="10" ClientIDMode="Static" MaxLength="10" runat="server" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorEndDate"
                        runat="server"
                        ErrorMessage="Please select an end date." ControlToValidate="txtEndDate"
                        Display="Dynamic" SetFocusOnError="True" CssClass="text-danger" />
                <%--<asp:CalendarExtender ID="CalendarExtenderEnd" TargetControlID="txtEndDate" PopupButtonID="cal2" runat="server"></asp:CalendarExtender>
                <asp:imagebutton ImageUrl="images/Calendar_scheduleHS.png" CausesValidation="false" id="cal2" runat="server" />--%>
            </td>
            <td>
                <img src="images/spacer.gif" width="1" height="1" border="0" alt=""><asp:RequiredFieldValidator
                    ID="RequiredFieldValidator2" ControlToValidate="txtEndDate" Text="*" runat="Server" />
            </td>
        </tr>
        <tr>
            <td>
                <font class="normal">All Day Event:</font>
            </td>
            <td>
                <asp:CheckBox ID="chkAllDayEvent" runat="server" OnCheckedChanged="chkAllDayEvent_CheckedChanged" AutoPostBack="True" />
            </td>
        </tr>
        <tr>
            <td>
                <font class="normal">Leave Start Time:</font>
            </td>
            <td>
                <asp:DropDownList ID="drpLeaveStartHour" class="form-control" runat="server">
                    <asp:ListItem>12 AM</asp:ListItem>
                    <asp:ListItem>1 AM</asp:ListItem>
                    <asp:ListItem>3 AM</asp:ListItem>
                    <asp:ListItem>4 AM</asp:ListItem>
                    <asp:ListItem>5 AM</asp:ListItem>
                    <asp:ListItem>6 AM</asp:ListItem>
                    <asp:ListItem>7 AM</asp:ListItem>
                    <asp:ListItem>8 AM</asp:ListItem>
                    <asp:ListItem>9 AM</asp:ListItem>
                    <asp:ListItem>10 AM</asp:ListItem>
                    <asp:ListItem>11 AM</asp:ListItem>
                    <asp:ListItem>12 PM</asp:ListItem>
                    <asp:ListItem>1 PM</asp:ListItem>
                    <asp:ListItem>2 PM</asp:ListItem>
                    <asp:ListItem>3 PM</asp:ListItem>
                    <asp:ListItem>4 PM</asp:ListItem>
                    <asp:ListItem>5 PM</asp:ListItem>
                    <asp:ListItem>6 PM</asp:ListItem>
                    <asp:ListItem>7 PM</asp:ListItem>
                    <asp:ListItem>8 PM</asp:ListItem>
                    <asp:ListItem>9 PM</asp:ListItem>
                    <asp:ListItem>10 PM</asp:ListItem>
                    <asp:ListItem>11 PM</asp:ListItem>
                </asp:DropDownList>
                &nbsp;&nbsp;
                <asp:DropDownList ID="drpLeaveStartMinutes" class="form-control" runat="server">
                    <asp:ListItem Selected="True">00</asp:ListItem>
                    <asp:ListItem>05</asp:ListItem>
                    <asp:ListItem>10</asp:ListItem>
                    <asp:ListItem>15</asp:ListItem>
                    <asp:ListItem>20</asp:ListItem>
                    <asp:ListItem>25</asp:ListItem>
                    <asp:ListItem>30</asp:ListItem>
                    <asp:ListItem>35</asp:ListItem>
                    <asp:ListItem>40</asp:ListItem>
                    <asp:ListItem>45</asp:ListItem>
                    <asp:ListItem>50</asp:ListItem>
                    <asp:ListItem>55</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <img src="images/spacer.gif" width="1" height="1" border="0" alt="">
            </td>
        </tr>
        <tr>
            <td>
                <font class="normal">Not Returning:</font>
            </td>
            <td>
                <asp:CheckBox ID="chkNotReturning" runat="server" AutoPostBack="True" OnCheckedChanged="chkNotReturning_CheckedChanged" />
            </td>
            <td>
                <img src="images/spacer.gif" width="1" height="1" border="0" alt="">
            </td>
        </tr>
        <tr>
            <td>
                <font class="normal">Leave End Time:</font>
            </td>
            <td>
                <asp:DropDownList ID="drpLeaveEndHour" class="form-control" runat="server">
                    <asp:ListItem>12 AM</asp:ListItem>
                    <asp:ListItem>1 AM</asp:ListItem>
                    <asp:ListItem>3 AM</asp:ListItem>
                    <asp:ListItem>4 AM</asp:ListItem>
                    <asp:ListItem>5 AM</asp:ListItem>
                    <asp:ListItem>6 AM</asp:ListItem>
                    <asp:ListItem>7 AM</asp:ListItem>
                    <asp:ListItem>8 AM</asp:ListItem>
                    <asp:ListItem>9 AM</asp:ListItem>
                    <asp:ListItem>10 AM</asp:ListItem>
                    <asp:ListItem>11 AM</asp:ListItem>
                    <asp:ListItem>12 PM</asp:ListItem>
                    <asp:ListItem>1 PM</asp:ListItem>
                    <asp:ListItem>2 PM</asp:ListItem>
                    <asp:ListItem>3 PM</asp:ListItem>
                    <asp:ListItem>4 PM</asp:ListItem>
                    <asp:ListItem>5 PM</asp:ListItem>
                    <asp:ListItem>6 PM</asp:ListItem>
                    <asp:ListItem>7 PM</asp:ListItem>
                    <asp:ListItem>8 PM</asp:ListItem>
                    <asp:ListItem>9 PM</asp:ListItem>
                    <asp:ListItem>10 PM</asp:ListItem>
                    <asp:ListItem>11 PM</asp:ListItem>
                </asp:DropDownList>
                &nbsp;&nbsp;
                <asp:DropDownList ID="drpLeaveEndMinutes" class="form-control" runat="server">
                    <asp:ListItem Selected="True">00</asp:ListItem>
                    <asp:ListItem>05</asp:ListItem>
                    <asp:ListItem>10</asp:ListItem>
                    <asp:ListItem>15</asp:ListItem>
                    <asp:ListItem>20</asp:ListItem>
                    <asp:ListItem>25</asp:ListItem>
                    <asp:ListItem>30</asp:ListItem>
                    <asp:ListItem>35</asp:ListItem>
                    <asp:ListItem>40</asp:ListItem>
                    <asp:ListItem>45</asp:ListItem>
                    <asp:ListItem>50</asp:ListItem>
                    <asp:ListItem>55</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <img src="images/spacer.gif" width="1" height="1" border="0" alt="">
            </td>
        </tr>
        <tr>
            <td>
                <font class="normal">Leave Type:</font>
            </td>
            <td>
                <asp:DropDownList ID="drpLeaveType" class="form-control" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource1" DataTextField="lt_Name" DataValueField="lt_ID">
                        <asp:ListItem Selected="True"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LeaveCalendarDBConnectionString %>" SelectCommand="spSelectLeaveType" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected"></asp:SqlDataSource>
            </td>
            <td>
                <img src="images/spacer.gif" width="1" height="1" border="0" alt="">
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorLeaveType"
                        runat="server"
                        ErrorMessage="Please select a leave type." ControlToValidate="drpLeaveType"
                        Display="Dynamic" SetFocusOnError="True" CssClass="text-danger" />
            </td>
        </tr>
        
        <tr>
            <td>
                <font class="normal">Comment:</font>
            </td>
            <td>
                <asp:TextBox ID="txtComment" MaxLength="50" runat="server" />
            </td>
            <td>
                <img src="images/spacer.gif" width="1" height="1" border="0" alt="">
            </td>
        </tr>
        <tr>
            <td>
                <img src="images/spacer.gif" width="1" height="1" border="0" alt="">
            </td>
            <td colspan="2">
                <asp:Button ID="cmdSubmit" Text="Add Record" OnClick="btnSubmit_Click" runat="server" />
                <asp:Label ID="lblError" runat="server" Text="" />
            </td>
        </tr>
    </table>

</asp:Content>

