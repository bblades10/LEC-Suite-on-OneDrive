<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<script runat="server">

    protected void cmdGo_Click(object sender, EventArgs e)
    {
        switch (Request.QueryString["rname"])
        {
            case "summaryreport":
                if (Convert.ToInt16(Session["AccessLevel"]) == 1)
                {
                    Response.Redirect("summaryreport.aspx?fc=" + Session["EmpID"] + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                }
                else
                {
                    Response.Redirect("summaryreport.aspx?fc=" + DropFieldCoordinator.SelectedItem.Value + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                }
                break;
            case "agencyvisits":
                //if (Convert.ToInt16(Session["AccessLevel"]) == 1)
                //{
                //    Response.Redirect("agencyvisitsreport.aspx?fc=" + Session["EmpID"] + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                //}
                //else
                //{
                Response.Redirect("agencyvisitsreport.aspx?fc=" + DropFieldCoordinator.SelectedItem.Value + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                //}
                break;
            case "agencyvisitdetail":
                //if (Convert.ToInt16(Session["AccessLevel"]) == 1)
                //{
                //    Response.Redirect("agencyvisitdetail.aspx?fc=" + Session["EmpID"] + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                //}
                //else
                //{
                Response.Redirect("agencyvisitdetail.aspx?fc=" + DropFieldCoordinator.SelectedItem.Value + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                //}
                break;
            case "agencyvisitsummary":
                //if (Convert.ToInt16(Session["AccessLevel"]) == 1)
                //{
                //    Response.Redirect("agencyvisitsummary.aspx?fc=" + Session["EmpID"] + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                //}
                //else
                //{
                Response.Redirect("agencyvisitsummary.aspx?fc=" + DropFieldCoordinator.SelectedItem.Value + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                //}
                break;
            case "demoed":
                //if (Convert.ToInt16(Session["AccessLevel"]) == 1)
                //{
                //    Response.Redirect("demoedreport.aspx?fc=" + Session["EmpID"] + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                //}
                //else
                //{
                Response.Redirect("demoedreport.aspx?fc=" + DropFieldCoordinator.SelectedItem.Value + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                //}
                break;
            case "onsite":
                //if (Convert.ToInt16(Session["AccessLevel"]) == 1)
                //{
                //    Response.Redirect("onsitereport.aspx?fc=" + Session["EmpID"] + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                //}
                //else
                //{
                Response.Redirect("onsitereport.aspx?fc=" + DropFieldCoordinator.SelectedItem.Value + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                //}
                break;
            case "onsitenonmember":
                //if (Convert.ToInt16(Session["AccessLevel"]) == 1)
                //{
                //    Response.Redirect("onsitenonmember.aspx?fc=" + Session["EmpID"] + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                //}
                //else
                //{
                Response.Redirect("onsitenonmember.aspx?fc=" + DropFieldCoordinator.SelectedItem.Value + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                //}
                break;
            case "notonsite":
                //if (Convert.ToInt16(Session["AccessLevel"]) == 1)
                //{
                //    Response.Redirect("notonsitereport.aspx?fc=" + Session["HomeDistrict"] + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                //}
                //else
                //{
                Response.Redirect("notonsitereport.aspx?fc=" + dropRegion.SelectedItem.Value + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                //}
                break;
            case "attemptedonsite":
                //if (Convert.ToInt16(Session["AccessLevel"]) == 1)
                //{
                //    Response.Redirect("attemptedonsitereport.aspx?fc=" + Session["EmpID"] + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                //}
                //else
                //{
                Response.Redirect("attemptedonsitereport.aspx?fc=" + DropFieldCoordinator.SelectedItem.Value + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                //}
                break;
            case "activity":
                //if (Convert.ToInt16(Session["AccessLevel"]) == 1)
                //{
                //    Response.Redirect("activityreport.aspx?fc=" + Session["EmpID"] + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                //}
                //else
                //{
                Response.Redirect("activityreport.aspx?fc=" + DropFieldCoordinator.SelectedItem.Value + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                //}
                break;
            case "withcisop":
                Response.Redirect("withcisop.aspx?fc=" + dropRegion.SelectedItem.Value + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                break;
            case "withoutcisop":
                Response.Redirect("withoutcisop.aspx?fc=" + dropRegion.SelectedItem.Value + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                break;
            case "withcisopfromsuite":
                Response.Redirect("withcisopfromsuite.aspx?fc=" + dropRegion.SelectedItem.Value + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                break;
            case "training":
                Response.Redirect("trainingreport.aspx?fc=" + DropFieldCoordinator.SelectedItem.Value + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                break;
            case "meetings":
                Response.Redirect("meetingreport.aspx?fc=" + DropFieldCoordinator.SelectedItem.Value + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                break;
            case "historicschedule":
                Response.Redirect("schedulehistoryreport.aspx?fc=" + DropFieldCoordinator.SelectedItem.Value + "&fcn=" + DropFieldCoordinator.SelectedItem.Text + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                break;
            case "vehiclemileagereport":
                //Response.Redirect("vehiclemileagereport.aspx?fc=" + DropFieldCoordinator.SelectedItem.Value + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                Response.Redirect("vehiclemileagereport.aspx?fc=0&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                break;
            case "rissafereport":
                Response.Redirect("rissafereport.aspx?fc=0&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                break;
            case "participation":
                Response.Redirect("participation.aspx?bd=" + txtDate.Text + "&ed=" + txtEndDate.Text + "&fc=" + dropRegion.SelectedItem.Value);
                break;
            case "participationbystate":
                Response.Redirect("participationbystate.aspx?bd=" + txtDate.Text + "&ed=" + txtEndDate.Text + "&st=" + dropState.SelectedItem.Value);
                break;
            case "presentationreport":
                Response.Redirect("presentationreport.aspx?fc=" + DropFieldCoordinator.SelectedItem.Value + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                break;
            case "liaisoncontacts":
                Response.Redirect("liaisonreport.aspx?fc=0&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                break;
            case "info":
                if (Convert.ToInt16(Session["AccessLevel"]) == 1)
                {
                    Response.Redirect("inforeport.aspx?fc=" + Session["EmpID"] + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                }
                else
                {
                    Response.Redirect("inforeport.aspx?fc=" + DropFieldCoordinator.SelectedItem.Value + "&bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                }
                break;
            case "impact":
                Response.Redirect("impactstatement.aspx?bd=" + txtDate.Text + "&ed=" + txtEndDate.Text);
                break;
            case "state":
                Response.Redirect("stateusers.aspx?s=" + dropState.SelectedItem.Value);
                break;
            case "agencycontactdates":
                Response.Redirect("agencycontactdates.aspx?fc=" + dropRegion.SelectedItem.Value);
                break;
            case "officertype":
                Response.Redirect("headexcrepaltreport.aspx?d=" + dropRegion.SelectedItem.Value + "&type=" + dropOfficerType.SelectedItem.Value);
                break;
        }

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        divDistrict.Visible = false;
        divState.Visible = false;
        divFieldCoor.Visible = true;
        divDates.Visible = true;
        divCISOPOverdue.Visible = false;
        divOfficerType.Visible = false;
        switch (Request.QueryString["rname"])
        {
            case "summaryreport":
                lblTitle.Text = "Summary Report Selection";
                if (Convert.ToInt16(Session["AccessLevel"]) == 1)
                {
                    divFieldCoor.Visible = false;
                }
                else
                {
                    DropFieldCoordinator.Items.Add(new ListItem("All", "0"));
                }
                break;
            case "agencyvisits":
                lblTitle.Text = "Agency Visits Report Selection";
                //if (Convert.ToInt16(Session["AccessLevel"]) == 1)
                //{
                //    divFieldCoor.Visible = false;
                //}
                //else
                //{
                DropFieldCoordinator.Items.Add(new ListItem("All", "0"));
                //}
                break;
            case "agencyvisitdetail":
                lblTitle.Text = "Agency Visit Detail Report Selection";
                //if (Convert.ToInt16(Session["AccessLevel"]) == 1)
                //{
                //    divFieldCoor.Visible = false;
                //}
                //else
                //{
                DropFieldCoordinator.Items.Add(new ListItem("All", "0"));
                //}
                break;
            case "agencyvisitsummary":
                lblTitle.Text = "Agency Visit Summary Report Selection";
                //if (Convert.ToInt16(Session["AccessLevel"]) == 1)
                //{
                //    divFieldCoor.Visible = false;
                //}
                //else
                //{
                DropFieldCoordinator.Items.Add(new ListItem("All", "0"));
                //}
                break;
            case "demoed":
                lblTitle.Text = "Orientations/Reorientations Report Selection";
                //if (Convert.ToInt16(Session["AccessLevel"]) == 1)
                //{
                //    divFieldCoor.Visible = false;
                //}
                //else
                //{
                DropFieldCoordinator.Items.Add(new ListItem("All", "0"));
                //}
                break;
            case "onsite":
                lblTitle.Text = "On Site Report Selection";
                //if (Convert.ToInt16(Session["AccessLevel"]) == 1)
                //{
                //    divFieldCoor.Visible = false;
                //}
                //else
                //{
                DropFieldCoordinator.Items.Add(new ListItem("All", "0"));
                //}
                break;
            case "onsitenonmember":
                lblTitle.Text = "On Site Non Member Report Selection";
                //if (Convert.ToInt16(Session["AccessLevel"]) == 1)
                //{
                //    divFieldCoor.Visible = false;
                //}
                //else
                //{
                DropFieldCoordinator.Items.Add(new ListItem("All", "0"));
                //}
                break;
            case "notonsite":
                lblTitle.Text = "Agencies Not Contacted Report Selection";
                //if (Convert.ToInt16(Session["AccessLevel"]) == 1)
                //{
                //    divFieldCoor.Visible = false;
                //}
                //else
                //{
                divFieldCoor.Visible = false;
                divDistrict.Visible = true;
                //}
                break;
            case "attemptedonsite":
                lblTitle.Text = "Attempted On Site Report Selection";
                //if (Convert.ToInt16(Session["AccessLevel"]) == 1)
                //{
                //    divFieldCoor.Visible = false;
                //}
                //else
                //{
                DropFieldCoordinator.Items.Add(new ListItem("All", "0"));
                //}
                break;
            case "activity":
                lblTitle.Text = "Activity Report Selection";
                //if (Convert.ToInt16(Session["AccessLevel"]) == 1)
                //{
                //    divFieldCoor.Visible = false;
                //}
                //else
                //{
                DropFieldCoordinator.Items.Add(new ListItem("All", "0"));
                //}
                break;
            case "withcisop":
                lblTitle.Text = "With CISOP Report Selection";
                divDates.Visible = true;
                divDistrict.Visible = true;
                divFieldCoor.Visible = false;
                break;
            case "withoutcisop":
                lblTitle.Text = "Without CISOP Report Selection";
                divDates.Visible = true;
                divDistrict.Visible = true;
                divFieldCoor.Visible = false;
                divCISOPOverdue.Visible = true;
                break;
            case "withcisopfromsuite":
                lblTitle.Text = "With CISOP from Suite Report Selection";
                divDistrict.Visible = true;
                divFieldCoor.Visible = false;
                break;
            case "training":
                lblTitle.Text = "Training Report";
                DropFieldCoordinator.Items.Add(new ListItem("All", "0"));
                break;
            case "meetings":
                lblTitle.Text = "Meetings";
                DropFieldCoordinator.Items.Add(new ListItem("All", "0"));
                break;
            case "vehiclemileagereport":
                lblTitle.Text = "Vehicle Mileage Report";
                divFieldCoor.Visible = false;
                break;
            case "rissafereport":
                lblTitle.Text = "RISSafe Report";
                divFieldCoor.Visible = false;
                break;
            case "participation":
                lblTitle.Text = "Participation Report";
                divFieldCoor.Visible = false;
                divDistrict.Visible = true;
                break;
            case "presentationreport":
                lblTitle.Text = "Presentation Requirement Report";
                DropFieldCoordinator.Items.Add(new ListItem("All", "0"));
                break;
            case "participationbystate":
                lblTitle.Text = "Participation By State Report";
                divFieldCoor.Visible = false;
                divDistrict.Visible = false;
                divState.Visible = true;
                break;
            case "liaisoncontacts":
                lblTitle.Text = "Liaison Contacts Report";
                divFieldCoor.Visible = false;
                break;
            case "info":
                lblTitle.Text = "Info/Intel Report Selection";
                if (Convert.ToInt16(Session["AccessLevel"]) == 1)
                {
                    divFieldCoor.Visible = false;
                }
                else
                {
                    DropFieldCoordinator.Items.Add(new ListItem("All", "0"));
                }
                break;
            case "impact":
                lblTitle.Text = "Impact Statement Selection";
                divDistrict.Visible = false;
                divFieldCoor.Visible = false;
                break;
            case "state":
                lblTitle.Text = "Users by State";
                divDates.Visible = false;
                divFieldCoor.Visible = false;
                divDistrict.Visible = false;
                divState.Visible = true;
                break;
            case "agencycontactdates":
                lblTitle.Text = "Agency Contact Dates";
                divDates.Visible = false;
                divFieldCoor.Visible = false;
                divDistrict.Visible = true;
                divState.Visible = false;
                break;
            case "officertype":
                lblTitle.Text = "Agency Head/Exec/Rep/Alt Report";
                divDistrict.Visible = true;
                divDates.Visible = false;
                divState.Visible = false;
                divFieldCoor.Visible = false;
                divOfficerType.Visible = true;
                break;
        }
    }

    protected void cmdCisopOverdue_Click(object sender, EventArgs e)
    {
        DateTime thisDay = DateTime.Today;
        DateTime twoyearsago = thisDay.AddYears(-2);

        Response.Redirect("withoutcisop.aspx?fc=" + dropRegion.SelectedItem.Value + "&bd=" + twoyearsago.ToString("d") + "&ed=" + thisDay.ToString("d"));
    }

    protected void cmdWillBeDue_Click(object sender, EventArgs e)
    {
        DateTime thisDay = Convert.ToDateTime(txtWillBeDate.Text);
        DateTime twoyearsago = thisDay.AddYears(-2);

        Response.Redirect("withoutcisop.aspx?fc=" + dropRegion.SelectedItem.Value + "&bd=" + twoyearsago.ToString("d") + "&ed=" + thisDay.ToString("d"));
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1><asp:Label ID="lblTitle" runat="server"></asp:Label></h1>

<div id="divFieldCoor" runat="server">
<table cellpadding="10" cellspacing="0" border="0">
    <tr>
        <td>Law Enforcement Coordinator:
            <asp:SqlDataSource ID="SqlFieldCoordinator" runat="server" 
                ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                SelectCommand="spSelectFieldCoordinators" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:DropDownList ID="DropFieldCoordinator" runat="server" AppendDataBoundItems="true"
                DataSourceID="SqlFieldCoordinator" DataTextField="FullName" 
                DataValueField="FCS_u_emp_ID">
            </asp:DropDownList>
        </td>
    </tr>
</table>
</div>

<div id="divDistrict" runat="server">
<table cellpadding="10" cellspacing="0" border="0">
    <tr>
        <td>
            <asp:SqlDataSource ID="SqlRegion" runat="server" 
                ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                SelectCommand="spSelectRegions" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            District: <asp:DropDownList ID="dropRegion" runat="server" DataSourceID="SqlRegion" 
                DataTextField="ag_Region" AppendDataBoundItems="true" DataValueField="ag_Region">
                <asp:ListItem Text="All" Value="00" Selected="True"></asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
</table>
</div>
<div id="divState" runat="server">
<table cellpadding="10" cellspacing="0" border="0">
    <tr>
        <td>
            State: <asp:DropDownList ID="dropState" runat="server">
                        <asp:ListItem Value="00" Selected="True">All</asp:ListItem>        
                        <asp:ListItem Value="IA">IA</asp:ListItem>
                        <asp:ListItem Value="IL">IL</asp:ListItem>
                        <asp:ListItem Value="KS">KS</asp:ListItem>
                        <asp:ListItem Value="MN">MN</asp:ListItem>
                        <asp:ListItem Value="MO">MO</asp:ListItem>
                        <asp:ListItem Value="ND">ND</asp:ListItem>
                        <asp:ListItem Value="NE">NE</asp:ListItem>
                        <asp:ListItem Value="SD">SD</asp:ListItem>
                        <asp:ListItem Value="WI">WI</asp:ListItem>
                        <asp:ListItem Value="MB">MB</asp:ListItem>
                   </asp:DropDownList>
        </td>
    </tr>
</table>
</div>
<div id="divCISOPOverdue" runat="server">
<table cellpadding="10" cellspacing="0" border="0">
    <tr>
        <td>
            <asp:Button ID="cmdCisopOverdue" runat="server" CausesValidation="false" Text="Show All Overdue" 
                onclick="cmdCisopOverdue_Click" />
        </td>
    </tr>
    <tr>
        <td>
            Will be due by: <asp:TextBox ID="txtWillBeDate" Columns="10" ValidationGroup="WillBe" runat="server"></asp:TextBox>
            <asp:CalendarExtender ID="CalendarExtender3" TargetControlID="txtWillBeDate" PopupButtonID="callwill"
                        runat="server">
                    </asp:CalendarExtender>
                    <asp:ImageButton ImageUrl="images/Calendar_scheduleHS.png" ID="callwill" CausesValidation="false" runat="server" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtWillBeDate"
                        CssClass="validation" Text="*" runat="Server" />
                    
            <asp:Button ID="cmdWillBeDue" runat="server" ValidationGroup="WillBe" Text="Show Upcoming Due" OnClick="cmdWillBeDue_Click" />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" CssClass="validation" ErrorMessage="MM/DD/YYYY" ValidationExpression="\d{1,2}\/\d{1,2}/\d{4}"
                        ControlToValidate="txtWillBeDate" />
        </td>
    </tr>
</table>
</div>
<div id="divDates" runat="server">
<table cellpadding="10" cellspacing="0" border="0">
    <tr>
        <td>
            Begin Date: <asp:TextBox ID="txtDate" Columns="10" runat="server"></asp:TextBox>
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
    <tr>
        <td>
            End Date: <asp:TextBox ID="txtEndDate" Columns="10" runat="server"></asp:TextBox>
            <asp:CalendarExtender ID="CalendarExtender2" TargetControlID="txtEndDate" PopupButtonID="cal1"
                        runat="server">
                    </asp:CalendarExtender>
                    <asp:ImageButton ImageUrl="images/Calendar_scheduleHS.png" ID="cal1" CausesValidation="false" runat="server" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtEndDate"
                        CssClass="validation" Text="*" runat="Server" /><asp:RegularExpressionValidator
                                                ID="RegularExpressionValidator1" runat="server" CssClass="validation" ErrorMessage="MM/DD/YYYY" ValidationExpression="\d{1,2}\/\d{1,2}/\d{4}"
                                                ControlToValidate="txtEndDate" />
        </td>
    </tr>
</table>
</div>

<div id="divOfficerType" runat="server">
<table cellpadding="10" cellspacing="0" border="0">
    <tr>
        <td>
            Type: <asp:DropDownList ID="dropOfficerType" runat="server">
                        <asp:ListItem Value="1">Head</asp:ListItem>
                        <asp:ListItem Value="5">Exec</asp:ListItem>
                        <asp:ListItem Value="6">Rep</asp:ListItem>
                        <asp:ListItem Value="7">Alt</asp:ListItem>
                   </asp:DropDownList>
        </td>
    </tr>
</table>
</div>



<table cellpadding="10" cellspacing="0" border="0">
    <tr>
        <td class="center"><asp:Button ID="cmdGo" Text="Go" runat="server" 
                onclick="cmdGo_Click" /></td>
    </tr>
</table>
</asp:Content>

