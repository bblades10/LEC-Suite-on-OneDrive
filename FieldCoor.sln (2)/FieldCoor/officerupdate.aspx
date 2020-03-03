<%@ Page Language="C#" Debug="true" %>

<% @Import Namespace="System.Net.Mail" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    protected void cmdSend_OnClick(object sender, EventArgs e)
    {
        DataClassesDataContext myOfficer = new DataClassesDataContext();
        var objOfficer = myOfficer.spSelectOfficerName(Convert.ToInt32(Request.QueryString["ofkey"]));
        foreach (spSelectOfficerNameResult recordOfficer in objOfficer)
        {
            string strMessage = "";
            
            MailMessage objMM = new MailMessage();

            if (Session["EmpID"] == null)
            {
                string UserID = HttpContext.Current.User.Identity.Name;
                UserID = UserID.Replace("MOCIC2003\\", "");

                DataClassesDataContext FCSUser = new DataClassesDataContext();
                var records = FCSUser.spSelectSuiteUserInfo(UserID);

                foreach (spSelectSuiteUserInfoResult record in records)
                {
                    Session["EmpID"] = record.ID;
                    Session["EMail"] = record.EmailAddress;
                    Session["UserName"] = record.UserName;
                    Session["FirstName"] = record.FirstName;
                    Session["LastName"] = record.LastName;
                    Session["District"] = record.FCS_u_district;
                    Session["AccessLevel"] = record.FCS_u_access_level;
                }

            }       
                
            string strUserAddress = Session["UserName"] + "@mocic.riss.net";
            
            objMM.From = new MailAddress(strUserAddress);
            objMM.To.Add(new MailAddress("tlong@mocic.riss.net"));
            objMM.To.Add(new MailAddress("lterhune@mocic.riss.net"));
            //objMM.To.Add(new MailAddress("lglenn@mocic.riss.net"));
            objMM.CC.Add(new MailAddress(strUserAddress)); 
            objMM.IsBodyHtml = true;
            objMM.Priority = MailPriority.Normal;
        
            switch (rdoAction.SelectedItem.Value.ToString())
            {
                case "Remove Member":
                    objMM.Subject = recordOfficer.ag_Name + " - REMOVAL - Membership Removal";
                    strMessage = "---- REMOVAL - Membership Update ----<br /><br />";
                    break;
                case "Update Member":
                    objMM.Subject = recordOfficer.ag_Name + " - UPDATE - Membership Update";
                    strMessage = "---- UPDATE - Membership Update ----<br /><br />";
                    break;
                case "Remove User ID Member":
                    objMM.Subject = recordOfficer.ag_Name + " - USER ID Removal - Membership Removal";
                    strMessage = "---- USER ID REMOVAL - Membership Update ----<br /><br />";
                    break;
                case "RISSafe Trained":
                    objMM.Subject = recordOfficer.ag_Name + " - RISSafe Trained";
                    strMessage = "---- RISSafe Trained ----<br /><br />";
                    break;
            }
            
            
            DateTime now = DateTime.Now;
            strMessage += "Date: " + now.Month.ToString() + "/" + now.Day.ToString() + "/" + now.Year.ToString() + "<br /><br />Law Enforcement Coordinator: " + Session["UserName"] + "<br /><br />Agency ID: " + recordOfficer.ag_ID + "<br />Agency Name: " + recordOfficer.ag_Name + "<br /><br />Member: " + recordOfficer.of_Title + " " + recordOfficer.of_FirstName + " " + recordOfficer.of_LastName + "<br /><br />Comments:<br /><br />" + txtComments.Text;
            
            objMM.Body = strMessage;
            
            SmtpClient mSmtpClient = new SmtpClient();
            mSmtpClient.Host = "10.12.1.2";
            mSmtpClient.Send(objMM);

            divMember.Visible = false;
            divMessage.Visible = true;
            
        }
        
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        divMessage.Visible = false;
        
        DataClassesDataContext myOfficer = new DataClassesDataContext();
        var objOfficer = myOfficer.spSelectOfficerName(Convert.ToInt32(Request.QueryString["ofkey"]));
        foreach (spSelectOfficerNameResult record in objOfficer)
        {
            lblUser.Text = record.of_Title + " " + record.of_FirstName + " " + record.of_LastName;
            break;
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Member Update</title>
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div id="divMember" runat="server">
    <h1 class="center">Update Member</h1>
    <table cellpadding="3" cellspacing="0" border="0" width="100%">
        <tr>
            <td class="center">Member: <asp:Label ID="lblUser" CssClass="lighttext" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td class="center">
                <asp:RadioButtonList ID="rdoAction" RepeatDirection="Vertical" RepeatLayout="Table" Width="100%" runat="server">
                    <asp:ListItem Text="Remove Member" Value="Remove Member"></asp:ListItem>
                    <asp:ListItem Text="Update Member" Value="Update Member"></asp:ListItem>
                    <asp:ListItem Text="Remove User ID Member" Value="Remove User ID Member"></asp:ListItem>
                    <asp:ListItem Text="RISSafe Trained" Value="RISSafe Trained"></asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td class="center">Comments:<br /><asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" Columns="28" Rows="6"></asp:TextBox></td>
        </tr>
        <tr>
            <td class="center"><asp:Button ID="cmdSend" Text="Send" runat="server" OnClick="cmdSend_OnClick" /></td>
        </tr>
    </table>
    </div>
    <div id="divMessage" runat="server">
    Email was sent successfully.
    </div>
    </form>
</body>
</html>
