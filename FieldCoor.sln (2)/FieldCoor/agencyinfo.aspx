<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>
<%@ Import Namespace="System.Net.Mail" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["u"] == "y")
        {
            lblMessage.Text = "Update email was sent successfully";
        }
        else
        {
            lblMessage.Text = "";
        }
        
        DataClassesDataContext myAgencyInfo = new DataClassesDataContext();
        var objAgencyInfo = myAgencyInfo.spSelectAgencyAddressPhone(Convert.ToInt32(Request.QueryString["agkey"]));
        foreach (spSelectAgencyAddressPhoneResult recordAgencyInfo in objAgencyInfo)
        {
            lblAgencyName.Text = recordAgencyInfo.ag_Name + " - " + recordAgencyInfo.ag_ID;
            lblAddress1.Text = recordAgencyInfo.aa_Line1;
            lblAddress2.Text = recordAgencyInfo.aa_Line2;
            lblAddress3.Text = recordAgencyInfo.aa_Line3;
            lblCity.Text = recordAgencyInfo.aa_City + ", " + recordAgencyInfo.aa_State + " " + recordAgencyInfo.aa_Zip;
            lblPhone.Text = "Phone: (" + recordAgencyInfo.ap_AreaCode + ") " + recordAgencyInfo.ap_Number;
            break;
        }

        DataClassesDataContext myAgencyFax = new DataClassesDataContext();
        var objAgencyFax = myAgencyFax.spSelectAgencyFax(Convert.ToInt32(Request.QueryString["agkey"]));
        foreach (spSelectAgencyFaxResult recordAgencyFax in objAgencyFax)
        {
            lblFax.Text = "Fax: (" + recordAgencyFax.ap_AreaCode + ") " + recordAgencyFax.ap_Number;
            break;
        }

        Boolean blnOfficerFirst = true;
        Boolean blnRemoteFirst = true;
        String strResult = "<table width='800px' cellpadding='2' cellspacing='0' border='0'>";

        DataClassesDataContext myNonRemote = new DataClassesDataContext();
        var objNonRemote = myNonRemote.spSelectAgencyOfficersWithoutRISSNET(Convert.ToInt32(Request.QueryString["agkey"]));
        foreach (spSelectAgencyOfficersWithoutRISSNETResult recordNonRemote in objNonRemote)
        {

            if (blnOfficerFirst)
            {
                strResult += "<tr><td class='tableheadings'>Officers</td><td class='tableheadings'>Information</td><td class='tableheadings'>Address</td><td class='tableheadings'>Edit</td></tr>";
                blnOfficerFirst = false;
            }

            strResult += "<tr><td class='text' valign='top'>" + recordNonRemote.temp_of_LastName + ", " + recordNonRemote.temp_of_FirstName + ", " + recordNonRemote.temp_of_Title + "<br />" + recordNonRemote.temp_of_eMail + "</td><td class='text'><a class='tablelink' href='#' onclick=NewWindow('officercode.aspx?oc=" + recordNonRemote.temp_of_Codes.Replace("P", "").Replace("S","").Replace("B","").Replace("X","") + "','name','125','250','no');return false;>" + recordNonRemote.temp_of_Codes.Replace("P", "").Replace("S", "").Replace("B","").Replace("X","") + "</a>";
            if (recordNonRemote.temp_PhoneNumber != null)
            {
                strResult += "<br>" + recordNonRemote.temp_PhoneNumber;
            }
            else
            {
                strResult += "</td>";
            }
            if (recordNonRemote.temp_oa_Line1 != null & recordNonRemote.temp_oa_Line1 != "")
            {
                strResult += "<td class='text'>" + recordNonRemote.temp_oa_Line1;
                if (recordNonRemote.temp_oa_Line2 != null & recordNonRemote.temp_oa_Line2 != "")
                {
                    strResult += "<br />" + recordNonRemote.temp_oa_Line2;
                    if (recordNonRemote.temp_oa_Line3 != null & recordNonRemote.temp_oa_Line3 != "")
                    {
                        strResult += "<br />" + recordNonRemote.temp_oa_Line3;
                    }
                }
                strResult += "<br />" + recordNonRemote.temp_oa_City + ", " + recordNonRemote.temp_oa_State + " " + recordNonRemote.temp_oa_Zip + "</td>";
            }
            else
            {
                strResult += "<td></td>";
            }

            strResult += "<td class='text'><a href='#' onclick=NewWindow('officerupdate.aspx?ofkey=" + recordNonRemote.temp_of_Key + "','name','325','350','no');return false; title='Notify membership clerk that " + recordNonRemote.temp_of_Title + " " + recordNonRemote.temp_of_FirstName + " " + recordNonRemote.temp_of_LastName + " needs to be updated.'>Select</a></td>";
            strResult += "</tr><tr><td colspan='4'><img src='images/bar.jpg' height='3' width='800' /></td></tr>";
        }

        strResult += "<tr><td colspan='4'><img src='images/spacer.gif' height='20' /></td></tr>";
        

        DataClassesDataContext myRemote = new DataClassesDataContext();
        var objRemote = myRemote.spSelectAgencyOfficersWithRISSNET(Convert.ToInt32(Request.QueryString["agkey"]));
        foreach (spSelectAgencyOfficersWithRISSNETResult recordRemote in objRemote)
        {

            if (blnRemoteFirst)
            {
                strResult += "<tr><td class='tableheadings'>Remote User</td><td class='tableheadings'>Information</td><td class='tableheadings'>Address</td><td class='tableheadings'>Edit</td></tr>";
                blnRemoteFirst = false;
            }

            strResult += "<tr><td class='text' valign='top'>" + recordRemote.temp_of_LastName + ", " + recordRemote.temp_of_FirstName + ", " + recordRemote.temp_of_Title + "<br />" + recordRemote.temp_of_eMail + "<br />" + recordRemote.temp_OTP + "</td><td class='text'><a href=mailto:" + recordRemote.temp_oi_eMail + " title='" + recordRemote.temp_of_Title + " " + recordRemote.temp_of_FirstName + " " + recordRemote.temp_of_LastName + "'>" + recordRemote.temp_oi_eMail + "</a><br /><a class='tablelink' href='#' onclick=NewWindow('officercode.aspx?oc=" + recordRemote.temp_of_Codes.Replace("P", "").Replace("S", "").Replace("B","").Replace("X","") + "','name','125','250','no');return false;>" + recordRemote.temp_of_Codes.Replace("P", "").Replace("S", "").Replace("B","").Replace("X","") + "</a>";
            if (recordRemote.temp_PhoneNumber != null)
            {
                strResult += "<br>" + recordRemote.temp_PhoneNumber;
            }
            else
            {
                strResult += "</td>";
            }
            if (recordRemote.temp_oa_Line1 != null & recordRemote.temp_oa_Line1 != "")
            {
                strResult += "<td class='text'>" + recordRemote.temp_oa_Line1;
                if (recordRemote.temp_oa_Line2 != null & recordRemote.temp_oa_Line2 != "")
                {
                    strResult += "<br />" + recordRemote.temp_oa_Line2;
                    if (recordRemote.temp_oa_Line3 != null & recordRemote.temp_oa_Line3 != "")
                    {
                        strResult += "<br />" + recordRemote.temp_oa_Line3;
                    }
                }
                strResult += "<br />" + recordRemote.temp_oa_City + ", " + recordRemote.temp_oa_State + " " + recordRemote.temp_oa_Zip + "</td>";
            }
            else
            {
                strResult += "<td></td>";
            }

            strResult += "<td class='text'><a href='#' onclick=NewWindow('officerupdate.aspx?ofkey=" + recordRemote.temp_of_Key + "','name','325','350','no');return false; title='Notify membership clerk that " + recordRemote.temp_of_Title + " " + recordRemote.temp_of_FirstName + " " + recordRemote.temp_of_LastName + " needs to be updated.'>Select</a></td>";
            strResult += "</tr><tr><td colspan='4'><img src='images/bar.jpg' height='3' width='800' /></td></tr>";


        }

        strResult += "</table>";

        divNonRemote.InnerHtml = strResult;
    }

    protected void cmdAgencyCommentsSave_onClick(object sender, EventArgs e)
    {
        string strMessage = "";

        MailMessage objMM = new MailMessage();

        string strUserAddress = Session["UserName"] + "@mocic.riss.net";

        objMM.From = new MailAddress(strUserAddress);
        objMM.To.Add(new MailAddress("tlong@mocic.riss.net"));
        objMM.To.Add(new MailAddress("lterhune@mocic.riss.net"));
        //objMM.To.Add(new MailAddress("lglenn@mocic.riss.net"));
        objMM.CC.Add(new MailAddress(strUserAddress));
        objMM.IsBodyHtml = true;
        objMM.Priority = MailPriority.Normal;


        objMM.Subject = lblAgencyName.Text + " - OTHER UPDATE - Membership Update";
        strMessage = "---- OTHER UPDATE - Membership Update ----<br /><br />";

        DateTime now = DateTime.Now;
        strMessage += "Date: " + now.Month.ToString() + "/" + now.Day.ToString() + "/" + now.Year.ToString() + "<br /><br />Law Enforcement Coordinator: " + Session["UserName"] + "<br /><br />Agency: " + lblAgencyName.Text + "<br /><br />Other Updates:<br /><br />" + txtAgencyUpdateComments.Text;

        if (chkInterim.Checked)
        {
            strMessage += "<br /><br />Send Interim Agreement";
        }
        if (chkReapplication.Checked)
        {
            strMessage += "<br /><br />Send Reapplication Paperwork";
        }
        
        objMM.Body = strMessage;

        SmtpClient mSmtpClient = new SmtpClient();
        mSmtpClient.Host = "10.12.1.2";
        mSmtpClient.Send(objMM);

        Response.Redirect("agencyinfo.aspx?agkey=" + Request.QueryString["agkey"] + "&u=y");
        
    }
    
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Panel ID="panUserUpdate" runat="server">
        <table cellpadding="2" cellspacing="0" border="0" width="800px">
            <tr>
                <td class="center">
                    <font color="red" size="3" >
                        <asp:Label ID="lblMessage" runat="server"></asp:Label></font>
                </td>
            </tr>
            <tr>
                <td class="center">
                    <asp:Label ID="lblAgencyName" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="center">
                    <asp:Label ID="lblAddress1" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="center">
                    <asp:Label ID="lblAddress2" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="center">
                    <asp:Label ID="lblAddress3" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="center">
                    <asp:Label ID="lblCity" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="center">
                    <asp:Label ID="lblPhone" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="center">
                    <asp:Label ID="lblFax" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
        <br />
        <%--<table cellpadding="2" cellspacing="0" border="0" width="800px">
                <tr>
                    <td>Officers</td>
                    <td>Information</td>
                    <td>Address</td>
                    <td>Remove</td>
                </tr>
                

            </table>--%>
        <div id="divNonRemote" runat="server">
        </div>
        <br />
        <table cellpadding="2" cellspacing="0" border="0">
            <tr>
                <td valign="top"><br />
                    <asp:CheckBox ID="chkInterim" Text="Send Interim Agreement" runat="server" /><br />
                    <asp:CheckBox ID="chkReapplication" Text="Send Reapplication Paperwork" runat="server" />
                </td>
                <td>&nbsp;</td>
                <td class="center">
                    Other Updates:<br />
                    <asp:TextBox ID="txtAgencyUpdateComments" TextMode="MultiLine" Rows="8" Columns="35"
                        runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="3" class="center">
                    <asp:Button ID="cmdAgencyCommentsSave" Text="Submit" runat="server" OnClick="cmdAgencyCommentsSave_onClick" /><br />
                    <br />
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
