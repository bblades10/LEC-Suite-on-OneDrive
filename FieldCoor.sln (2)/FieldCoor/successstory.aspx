<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Mail" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Set the Type of Services values for the drop down box
            dropTypeService.Items.Add(new ListItem("", ""));
            dropTypeService.Items.Add(new ListItem("Analytical Services"));
            dropTypeService.Items.Add(new ListItem("Computer Forensics"));
            dropTypeService.Items.Add(new ListItem("Confidential Funds"));
            dropTypeService.Items.Add(new ListItem("Equipment Services"));
            dropTypeService.Items.Add(new ListItem("Information Inquiry Services"));
            dropTypeService.Items.Add(new ListItem("Information Sharing"));
            dropTypeService.Items.Add(new ListItem("Multiple Services"));
            dropTypeService.Items.Add(new ListItem("Publications"));
            dropTypeService.Items.Add(new ListItem("RISSLeads"));
            dropTypeService.Items.Add(new ListItem("Training"));
            dropTypeService.Items.Add(new ListItem("Other"));

            lblEnteredBy.Text = Session["UserName"].ToString();
            lblDateEntered.Text = DateTime.Today.ToString("d");

        }
    }

    protected void Button_Click_Save(object sender, EventArgs e)
    {
        string strFollowUp;
        string strReprint;
        
        if (chkFollowUp.Checked)
        {
            strFollowUp = "Y";
        }
        else
        {
            strFollowUp = "N";
        }
        
        if (chkReprint.Checked)
        {
            strReprint = "Y";
        }
        else
        {
            strReprint = "N";
        }
        
        
        DataClassesDataContext myDB = new DataClassesDataContext();
        myDB.spInsertSuccessStory(Convert.ToDateTime(lblDateEntered.Text), lblEnteredBy.Text, dropState.SelectedItem.Value,
            dropAgencyName.SelectedItem.Text, dropTypeService.SelectedItem.Value, txtContactName.Text, txtContactPhoneNumber.Text,
            txtContactEmailAddress.Text, txtSuccessStory.Text, Convert.ToChar(strFollowUp), Convert.ToChar(strReprint), Convert.ToChar("N"), "", "", "");

        MailMessage objMM = new MailMessage();

        objMM.To = "ccurtis@mocic.riss.net;";
        //objMM.To = "bblades@mocic.riss.net";
        objMM.From = Session["UserName"] + "@mocic.riss.net";
        objMM.Cc = Session["UserName"] + "@mocic.riss.net";
        objMM.Bcc = "bblades@mocic.riss.net";
        objMM.BodyFormat = MailFormat.Html;
        objMM.Priority = MailPriority.Normal;
        objMM.Subject = "New Success Story Entered";
        
        string strBody = "";
        strBody = "There has been a new Success Story entry made.<br><br>Date Entered: " + lblDateEntered.Text + "<br><br>Entered By: " + lblEnteredBy.Text + "<br><br>Agency Name: " + dropAgencyName.SelectedItem.Text + "<br><br>Agency State: " + dropState.SelectedItem.Value + "<br><br>Type of Service: " + dropTypeService.SelectedItem.Value + "<br><br>Contact Name: " + txtContactName.Text + "<br><br>Contact Phone Number: " + txtContactPhoneNumber.Text + "<br><br>Contact Email Address: " + txtContactEmailAddress.Text + "<br><br>Story: " + txtSuccessStory.Text + "<br><br>Needs Follow Up: " + strFollowUp + "<br><br>Reprint as Written: " + strReprint;
                    
        objMM.Body = strBody;

        SmtpMail.SmtpServer = "10.12.1.2";
        SmtpMail.Send(objMM);

        Response.Redirect("default.aspx");          
        
    }

    protected void Button_Click_Cancel(object sender, EventArgs e)
    {
        Response.Redirect("default.aspx");
    }
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1>
        Success Stories</h1>
    <asp:Panel ID="panPage" CssClass="left" runat="server">
        <table cellpadding="5" cellspacing="0" border="0">
            <tr>
                <td align="center" colspan="3">
                    <i>
                        <asp:ValidationSummary ID="valSum" runat="server" HeaderText="* Required Fields"
                            DisplayMode="SingleParagraph" Font-Size="12px" />
                    </i>
                </td>
            </tr>
            <tr>
                <td align="right" nowrap>
                    <font class="normal">Date Entered:</font>
                </td>
                <td width="10">
                    <img src="../images/spacer.gif" width="1" height="1" border="0">
                </td>
                <td>
                    <font class="normal">
                        <asp:Label ID="lblDateEntered" runat="server" /></font>
                </td>
            </tr>
            <tr>
                <td align="right" nowrap>
                    <font class="normal">Entered By:</font>
                </td>
                <td width="10">
                    <img src="../images/spacer.gif" width="1" height="1" border="0">
                </td>
                <td>
                    <font class="normal">
                        <asp:Label ID="lblEnteredBy" runat="server" /></font>
                </td>
            </tr>
            <tr>
                <td align="right" nowrap>
                    <font class="normal">Agency State:</font>
                </td>
                <td width="10">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="dropState"
                        Text="*" runat="Server" />
                </td>
                <td>
                    <asp:DropDownList ID="dropState" AutoPostBack=true runat="server">
                        <asp:ListItem Value="IA" Text="IA"></asp:ListItem>
                        <asp:ListItem Value="IL" Text="IL"></asp:ListItem>
                        <asp:ListItem Value="KS" Text="KS"></asp:ListItem>
                        <asp:ListItem Value="MB" Text="MB"></asp:ListItem>
                        <asp:ListItem Value="MN" Text="MN"></asp:ListItem>
                        <asp:ListItem Value="MO" Text="MO"></asp:ListItem>
                        <asp:ListItem Value="NE" Text="NE"></asp:ListItem>
                        <asp:ListItem Value="ND" Text="ND"></asp:ListItem>
                        <asp:ListItem Value="SD" Text="SD"></asp:ListItem>
                        <asp:ListItem Value="WI" Text="WI"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" nowrap>
                    <font class="normal">Agency Name:</font>
                </td>
                <td width="10">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="dropAgencyName"
                        Text="*" runat="Server" />
                </td>
                <td>
                    <asp:SqlDataSource ID="sqlAgnecyName" runat="server" ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>"
                        SelectCommand="spSelectAllAgencyNames" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="dropState" DefaultValue="IA" Name="State" PropertyName="SelectedValue"
                                Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:DropDownList ID="dropAgencyName" runat="server" DataSourceID="sqlAgnecyName"
                        DataTextField="ag_Name" DataValueField="ag_GUID">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" nowrap>
                    <font class="normal">Type of Service:</font>
                </td>
                <td width="10">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="dropTypeService"
                        Text="*" runat="Server" />
                </td>
                <td>
                    <asp:DropDownList ID="dropTypeService" Width="200" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="right" nowrap>
                    <font class="normal">Contact Name:</font>
                </td>
                <td width="10">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="txtContactName"
                        Text="*" runat="Server" />
                </td>
                <td>
                    <asp:TextBox ID="txtContactName" Columns="50" MaxLength="50" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="right" nowrap>
                    <font class="normal">Contact Phone Number:</font>
                </td>
                <td width="10">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="txtContactPhoneNumber"
                        Text="*" runat="Server" />
                </td>
                <td>
                    <asp:TextBox ID="txtContactPhoneNumber" Columns="25" MaxLength="50" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="right" nowrap>
                    <font class="normal">Contact Email Address:</font>
                </td>
                <td width="10">
                    <img src="../images/spacer.gif" width="1" height="1" border="0">
                </td>
                <td>
                    <asp:TextBox ID="txtContactEmailAddress" Columns="50" MaxLength="100" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="right" nowrap>
                    <font class="normal">Success Story:</font>
                </td>
                <td width="10">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ControlToValidate="txtSuccessStory"
                        Text="*" runat="Server" />
                </td>
                <td>
                    <asp:TextBox ID="txtSuccessStory" TextMode="multiline" Rows="5" Columns="40" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="right" nowrap>
                    <font class="normal">Follow Up:</font>
                </td>
                <td width="10">
                    <img src="../images/spacer.gif" width="1" height="1" border="0">
                </td>
                <td>
                    <font class="normal">
                        <asp:CheckBox ID="chkFollowUp" Text="Needs to be contacted" runat="server" /></font>
                </td>
            </tr>
            <tr>
                <td align="right" nowrap>
                    <font class="normal">Reprint:</font>
                </td>
                <td width="10">
                    <img src="../images/spacer.gif" width="1" height="1" border="0">
                </td>
                <td>
                    <font class="normal">
                        <asp:CheckBox ID="chkReprint" Text="Ok to reprint as written above per contact*"
                            runat="server" /></font>
                </td>
            </tr>
            <tr>
                <td colspan="3" height="40">
                    <img src="../images/spacer.gif" width="1" height="1" border="0">
                </td>
            </tr>
            <tr>
                <td colspan="3" class="center">
                    <asp:Button ID="btnSave" Text="Save" OnClick="Button_Click_Save" runat="Server" /><img
                        src="../images/spacer.gif" width="20" height="1" border="0"><asp:Button ID="btnCancel"
                            Text="Cancel" OnClick="Button_Click_Cancel" CausesValidation="False" runat="Server" />
                </td>
            </tr>
            <tr>
                <td colspan="3" height="20">
                    <img src="../images/spacer.gif" width="1" height="1" border="0">
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <font class="small">*Contact has been advised BJA Quarterly Report is subject to FOIA.</font>
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
