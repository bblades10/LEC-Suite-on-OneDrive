<%@ Page Title="" Language="C#" ViewStateMode="Disabled"  MasterPageFile="~/Main.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<% @Import Namespace="System.Net.Mail" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        lblFrom.Text = Session["Email"].ToString();
        
        DataClassesDataContext myDB = new DataClassesDataContext();
        var objRS = myDB.spSelectEmailGroupUserCount();

        foreach (spSelectEmailGroupUserCountResult record in objRS)
        {
            switch (record.ag_State)
            {
                case "IA":
                    lblIA.Text = record.Users.ToString();
                    break;
                case "IL":
                    lblIL.Text = record.Users.ToString();
                    break;
                case "KS":
                    lblKS.Text = record.Users.ToString();
                    break;
                case "MN":
                    lblMN.Text = record.Users.ToString();
                    break;
                case "MO":
                    lblMO.Text = record.Users.ToString();
                    break;
                case "NE":
                    lblNE.Text = record.Users.ToString();
                    break;
                case "ND":
                    lblND.Text = record.Users.ToString();
                    break;
                case "SD":
                    lblSD.Text = record.Users.ToString();
                    break;
                case "WI":
                    lblWI.Text = record.Users.ToString();
                    break;
            }
        }
    }

    protected void cmdRefresh_Click(object sender, EventArgs e)
    {
        //do nothing
    }

    protected void cmdSend_Click(object sender, EventArgs e)
    {
        //try
        //{
        
            string strEmailAddresses;
            strEmailAddresses = "";
            MailMessage objMM = new MailMessage();
            //var objMM = new System.Net.Mail.SmtpClient();
            
            //string strTo;

            //strTo = "";

            foreach (ListItem myitem in ListStates.Items)
            {
                if (myitem.Selected == true)
                {
                    switch (myitem.Value)
                    {
                        case "IA":
                            objMM.To.Add("IA_Users@mocic.riss.net");
                            break;
                        case "IL":
                            objMM.To.Add("IL_Users@mocic.riss.net");
                            break;
                        case "KS":
                            objMM.To.Add("KS_Users@mocic.riss.net");
                            break;
                        case "MN":
                            objMM.To.Add("MN_Users@mocic.riss.net");
                            break;
                        case "MO":
                            objMM.To.Add("MO_Users@mocic.riss.net");
                            break;
                        case "NE":
                            objMM.To.Add("NE_Users@mocic.riss.net");
                            break;
                        case "ND":
                            objMM.To.Add("ND_Users@mocic.riss.net");
                            break;
                        case "SD":
                            objMM.To.Add("SD_Users@mocic.riss.net");
                            break;
                        case "Wi":
                            objMM.To.Add("WI_Users@mocic.riss.net");
                            break;
                        case "Staff":
                            objMM.To.Add("allstaff@mocic.riss.net");
                            break;
                        case "Brad":
                            objMM.To.Add("bblades@mocic.riss.net");
                            break;
                        case "02":
                            DataClassesDataContext myDB02 = new DataClassesDataContext();
                            var objRS02 = myDB02.spSelectOfficerEmailAddress("02");

                            foreach (spSelectOfficerEmailAddressResult email02 in objRS02)
                            {
                                strEmailAddresses += email02.oi_eMail + ";";
                            }
                            objMM.Bcc.Add(strEmailAddresses);
                            break;
                        case "03":
                            DataClassesDataContext myDB03 = new DataClassesDataContext();
                            var objRS03 = myDB03.spSelectOfficerEmailAddress("03");

                            foreach (spSelectOfficerEmailAddressResult email03 in objRS03)
                            {
                                strEmailAddresses += email03.oi_eMail + ";";
                            }
                            objMM.Bcc.Add(strEmailAddresses);
                            break;
                        case "04":
                            DataClassesDataContext myDB04 = new DataClassesDataContext();
                            var objRS04 = myDB04.spSelectOfficerEmailAddress("04");

                            foreach (spSelectOfficerEmailAddressResult email04 in objRS04)
                            {
                                strEmailAddresses += email04.oi_eMail + ";";
                            }
                            objMM.Bcc.Add(strEmailAddresses);
                            break;
                    }
                }
            }

            //objMM.To.Add("bblades@mocic.riss.net");
        
            objMM.From = new MailAddress(lblFrom.Text);
            objMM.CC.Add(lblFrom.Text);
            objMM.IsBodyHtml = true;
            objMM.Priority = MailPriority.Normal;
            objMM.Subject = txtSubject.Text;
        

            string strBody = "";
            strBody = "<HTML><HEAD><TITLE>fromthedeskof</TITLE><META HTTP-EQUIV='Content-Type' CONTENT='text/html; charset=iso-8859-1'></HEAD>";
            strBody += "<BODY BGCOLOR=#FFFFFF LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0><!-- ImageReady Slices (fromthedeskof.psd) -->";
            strBody += "<TABLE WIDTH=737 BORDER=0 CELLPADDING=0 CELLSPACING=0><TR><TD COLSPAN=2><IMG SRC='http://www.mocictraining.com/email-images/" + Session["LastName"] + ".gif' WIDTH=516 HEIGHT=109 ALT=''></TD><TD COLSPAN=2><IMG SRC='http://www.mocictraining.com/email-images/" + DropEmailType.SelectedItem.Value + ".gif' WIDTH=221 HEIGHT=109 ALT=''></TD>";
            strBody += "</TR><TR><TD COLSPAN=4>";
            strBody += txtBody.Text;
            strBody += "<br /><br /></TD></TR><TR><TD COLSPAN=2><a href='mailto:success@mocic.riss.net'><IMG SRC='http://www.mocictraining.com/email-images/fromthedeskof_04.gif' WIDTH=516 HEIGHT=108 ALT='' BORDER='0'></a></TD><TD COLSPAN=2><IMG SRC='http://www.mocictraining.com/email-images/fromthedeskof_05.gif' WIDTH=221 HEIGHT=108 ALT=''></TD>";
            strBody += "</TR><TR><TD><IMG SRC='http://www.mocictraining.com/email-images/fromthedeskof_06.gif' WIDTH=162 HEIGHT=69 ALT=''></TD><TD COLSPAN=2><IMG SRC='http://www.mocictraining.com/email-images/fromthedeskof_07.gif' WIDTH=408 HEIGHT=69 ALT=''></TD><TD><IMG SRC='http://www.mocictraining.com/email-images/fromthedeskof_08.gif' WIDTH=167 HEIGHT=69 ALT=''></TD>";
            strBody += "</TR><TR><TD><IMG SRC='http://www.mocictraining.com/email-images/spacer.gif' WIDTH=162 HEIGHT=1 ALT=''></TD><TD><IMG SRC='http://www.mocictraining.com/email-images/spacer.gif' WIDTH=354 HEIGHT=1 ALT=''></TD><TD><IMG SRC='http://www.mocictraining.com/email-images/spacer.gif' WIDTH=54 HEIGHT=1 ALT=''></TD><TD><IMG SRC='http://www.mocictraining.com/email-images/spacer.gif' WIDTH=167 HEIGHT=1 ALT=''></TD></TR></TABLE><!-- End ImageReady Slices --></BODY></HTML>";

            
        
            objMM.Body = strBody;

            if (FileUpload1.HasFile)
            {
                objMM.Attachments.Add(new System.Net.Mail.Attachment(FileUpload1.PostedFile.InputStream, FileUpload1.FileName));
            }
            if (FileUpload2.HasFile)
            {
                objMM.Attachments.Add(new System.Net.Mail.Attachment(FileUpload2.PostedFile.InputStream, FileUpload2.FileName));
            }
            if (FileUpload3.HasFile)
            {
                objMM.Attachments.Add(new System.Net.Mail.Attachment(FileUpload3.PostedFile.InputStream, FileUpload3.FileName));
            }
        
        

            SmtpClient mySmtpClient = new SmtpClient("mail.mocic2003.net");
            mySmtpClient.Timeout = int.MaxValue;
            mySmtpClient.Send(objMM);
            lblMessage.Text = "Email was sent successfully.";
        
        //}
        //catch (Exception ex)
        //{

        //    lblMessage.Text = "Error occured while sending your message." + ex.Message;
        
        //}

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<h1>Email Generator</h1>
    <font color="red"><asp:Label ID="lblMessage" runat="server" /></font>
    
<div id="divEmail" class="leftmargin" align="left" runat="server">
    <table cellpadding="5" cellspacing="5" border="0">
        <tr>
            <td align="center" colspan="2" class="column">Select State(s) below you want to send your email to. Must hold down the "CTRL" key to select multiple states.</td>
        </tr>
        <tr>
            <td>
                <asp:ListBox ID="ListStates" SelectionMode="Multiple" Rows="10" runat="server">
                    <asp:ListItem Text="IA" Value="IA"></asp:ListItem>
                    <asp:ListItem Text="IL" Value="IL"></asp:ListItem>
                    <asp:ListItem Text="KS" Value="KS"></asp:ListItem>
                    <asp:ListItem Text="MN" Value="MN"></asp:ListItem>
                    <asp:ListItem Text="MO" Value="MO"></asp:ListItem>
                    <asp:ListItem Text="NE" Value="NE"></asp:ListItem>
                    <asp:ListItem Text="ND" Value="ND"></asp:ListItem>
                    <asp:ListItem Text="SD" Value="SD"></asp:ListItem>
                    <asp:ListItem Text="WI" Value="WI"></asp:ListItem>
                    <asp:ListItem Text="District 2" Value="02"></asp:ListItem>
                    <asp:ListItem Text="District 3" Value="03"></asp:ListItem>
                    <asp:ListItem Text="District 4" Value="04"></asp:ListItem>
                    <asp:ListItem Text="MOCIC Staff" Value="Staff"></asp:ListItem>
                    <asp:ListItem Text="Brad Test" Value="Brad"></asp:ListItem>
                </asp:ListBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="ListStates" runat="server" ForeColor="Red" ErrorMessage="*"></asp:RequiredFieldValidator>
            </td>
            <td>
                <ul>
                    <li>IA - <asp:Label ID="lblIA" runat="server"></asp:Label></li>
                    <li>IL - <asp:Label ID="lblIL" runat="server"></asp:Label></li>
                    <li>KS - <asp:Label ID="lblKS" runat="server"></asp:Label></li>
                    <li>MN - <asp:Label ID="lblMN" runat="server"></asp:Label></li>
                    <li>MO - <asp:Label ID="lblMO" runat="server"></asp:Label></li>
                    <li>NE - <asp:Label ID="lblNE" runat="server"></asp:Label></li>
                    <li>ND - <asp:Label ID="lblND" runat="server"></asp:Label></li>
                    <li>SD - <asp:Label ID="lblSD" runat="server"></asp:Label></li>
                    <li>WI - <asp:Label ID="lblWI" runat="server"></asp:Label></li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>
                From: &nbsp;<asp:Label ID="lblFrom" runat="server"></asp:Label>
                <br />
                <br />
                Type of Message:<br />
                <asp:DropDownList ID="DropEmailType" runat="server">
                    <asp:ListItem Text="Confidential" Value="confidential"></asp:ListItem>
                    <asp:ListItem Text="Law Enforcement Distribution Only" Value="lawenforcement"></asp:ListItem>
                    <asp:ListItem Text="Training Opportunity" Value="trainingopp"></asp:ListItem>
                    <asp:ListItem Text="Urgent" Value="urgent"></asp:ListItem>
                </asp:DropDownList><asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="DropEmailType" ForeColor="Red" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>
    
    <br />
    Subject: <asp:TextBox ID="txtSubject" runat="server" Columns="70"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtSubject" ForeColor="Red" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
    <br />
    <br />
    <ajaxToolkit:HtmlEditorExtender ID="HtmlEditorExtender1" TargetControlID="txtBody">
    <Toolbar>
        <ajaxToolkit:Undo />
        <ajaxToolkit:Redo />
        <ajaxToolkit:Bold />
        <ajaxToolkit:Italic />
        <ajaxToolkit:Underline />
        <ajaxToolkit:StrikeThrough />
        <ajaxToolkit:Subscript />
        <ajaxToolkit:Superscript />
        <ajaxToolkit:JustifyLeft />
        <ajaxToolkit:JustifyCenter />
        <ajaxToolkit:JustifyRight />
        <ajaxToolkit:JustifyFull />
        <ajaxToolkit:InsertOrderedList />
        <ajaxToolkit:InsertUnorderedList />
        <ajaxToolkit:CreateLink />
        <ajaxToolkit:UnLink />
        <ajaxToolkit:RemoveFormat />
        <ajaxToolkit:SelectAll />
        <ajaxToolkit:UnSelect />
        <ajaxToolkit:Delete />
        <ajaxToolkit:Cut />
        <ajaxToolkit:Copy />
        <ajaxToolkit:Paste />
        <ajaxToolkit:BackgroundColorSelector />
        <ajaxToolkit:ForeColorSelector />
        <ajaxToolkit:FontNameSelector />
        <ajaxToolkit:FontSizeSelector />
        <ajaxToolkit:Indent />
        <ajaxToolkit:Outdent />
        <ajaxToolkit:InsertHorizontalRule />
        <ajaxToolkit:HorizontalSeparator />
    </Toolbar>
    </ajaxToolkit:HtmlEditorExtender>
    <asp:TextBox ID="txtBody" runat="server" Columns="70" TextMode="MultiLine" Rows="20"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="txtBody" ForeColor="Red" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
    <br />
    <br />
    <asp:Button ID="cmdRefresh" Text="Refresh Body for Review" CausesValidation="false" runat="server" onclick="cmdRefresh_Click" />
    <br />
    <br />
    Attachment 1:&nbsp;<asp:FileUpload ID="FileUpload1" runat="server" />
    <br />
    Attachment 2:&nbsp;<asp:FileUpload ID="FileUpload2" runat="server" />
    <br />
    Attachment 3:&nbsp;<asp:FileUpload ID="FileUpload3" runat="server" />
    <br />
    <br />
    <asp:Button ID="cmdSend" Text="Send" runat="server" onclick="cmdSend_Click" />
</div>

</asp:Content>

