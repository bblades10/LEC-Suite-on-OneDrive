<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>
<% @Import Namespace="System.Web.Mail" %>

<script runat="server">

    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        MailMessage objMM = new MailMessage();

        objMM.To = "outreach@mocic.riss.net";
        //objMM.To = "bblades@mocic.riss.net";
        objMM.From = Session["UserName"] + "@mocic.riss.net";
        objMM.Cc = Session["UserName"] + "@mocic.riss.net";
        //objMM.Bcc = "bblades@mocic.riss.net";
        objMM.BodyFormat = MailFormat.Html;
        objMM.Priority = MailPriority.Normal;
        objMM.Subject = "Promotional Materials Order Form for Law Enforcement Coordinators";

        string strBody = "";
        strBody = "Promotional Materials Order Form for " + Session["FirstName"] + " " + Session["LastName"] + "<br /><br />";




        if (txtOverview.Text != "0" && txtOverview.Text != "")
        {
            strBody += txtOverview.Text + " MOCIC Overview RAC Card (each set contains 25 Cards)<br />";
        }
        if (txtInformationSharing.Text != "0" && txtInformationSharing.Text != "")
        {
            strBody += txtInformationSharing.Text + " MOCIC Information Sharing RAC Card (each set contains 25 Cards)<br />";
        }
        if (txtOfficerSafety.Text != "0" && txtOfficerSafety.Text != "")
        {
            strBody += txtOfficerSafety.Text + " MOCIC Officer Safety RAC Card (each set contains 25 Cards)<br />";
        }
        if (txtInvestigative.Text != "0" && txtInvestigative.Text != "")
        {
            strBody += txtInvestigative.Text + " MOCIC Investigative Services RAC Card (each set contains 25 Cards)<br />";
        }
        if (txtIntelligence.Text != "0" && txtIntelligence.Text != "")
        {
            strBody += txtIntelligence.Text + " MOCIC Analytical Services RAC Card (each set contains 25 Cards)<br />";
        }
        if (txtCriminal.Text != "0" && txtCriminal.Text != "")
        {
            strBody += txtCriminal.Text + " MOCIC Research Services RAC Card (each set contains 25 Cards)<br />";
        }
        if (txtEquipment.Text != "0" && txtEquipment.Text != "")
        {
            strBody += txtEquipment.Text + " MOCIC Equipment Services Unit RAC Card (each set contains 25 Cards)<br />";
        }
        if (txtDigital.Text != "0" && txtDigital.Text != "")
        {
            strBody += txtDigital.Text + " MOCIC Digital Forensic Services RAC Card (each set contains 25 Cards)<br />";
        }
        if (txtHolder.Text != "0" && txtHolder.Text != "")
        {
            strBody += txtHolder.Text + " RAC Card Folder (set contains 25 Folders)<br />";
        }
        if (txtMiranda.Text != "0" && txtMiranda.Text != "")
        {
            strBody += txtMiranda.Text + " MOCIC Miranda Cards (each set contains 50 cards)<br />";
        }
        if (txtAddress.Text != "0" && txtAddress.Text != "")
        {
            strBody += txtAddress.Text + " MOCIC Address Labels (each set contains 30 labels)<br />";
        }
        if (txtStaff.Text != "0" && txtStaff.Text != "")
        {
            strBody += txtStaff.Text + " Staff Roster (each set contains 25 Forms)<br />";
            if (chkBlue.Checked)
            {
                strBody += " - Blue<br />";
            }
            if (chkWhite.Checked)
            {
                strBody += " - White<br />";
            }
            if (chkGray.Checked)
            {
                strBody += " - Gray<br />";
            }
            if (chkGoldenrod.Checked)
            {
                strBody += " - Goldenrod<br />";
            }
            if (chkYellow.Checked)
            {
                strBody += " - Yellow<br />";
            }
            if (chkGreen.Checked)
            {
                strBody += " - Green<br />";
            }
            if (chkPink.Checked)
            {
                strBody += " - Pink<br />";
            }
        }
        if (txtBatchBrochure.Text != "0" && txtBatchBrochure.Text != "")
        {
            strBody += txtBatchBrochure.Text + " Batch Upload Flier (each set contains 50 Fliers)<br />";
        }
        if (txtBelong.Text != "0" && txtBelong.Text != "")
        {
            strBody += txtBelong.Text + " I Belong To MOCIC Flier (each set contains 50 Fliers)<br />";
        }
        if (txtNationalLFWeek.Text != "0" && txtNationalLFWeek.Text != "")
        {
            strBody += txtNationalLFWeek.Text + " National Law Enforcement Week (each set contains 50 Fliers)<br />";
        }
        if (txtSafe.Text != "0" && txtSafe.Text != "")
        {
            strBody += txtSafe.Text + " RISSafe Flier (each set contains 50 Fliers)<br />";
        }
        if (txtGang.Text != "0" && txtGang.Text != "")
        {
            strBody += txtGang.Text + " RISSGang Flier (each set contains 50 Fliers)<br />";
        }
        if (txtRISSIntel.Text != "0" && txtRISSIntel.Text != "")
        {
            strBody += txtRISSIntel.Text + " RISSIntel Flier (each set contains 50 Fliers)<br />";
        }
        if (txtSafety.Text != "0" && txtSafety.Text != "")
        {
            strBody += txtSafety.Text + " Officer Safety Website Flier (each set contains 50 Fliers)<br />";
        }
        if (txtProgram.Text != "0" && txtProgram.Text != "")
        {
            strBody += txtProgram.Text + " RISS Program Flier (each set contains 50 fliers)<br />";
        }
        if (txtRISSWebsite.Text != "0" && txtRISSWebsite.Text != "")
        {
            strBody += txtRISSWebsite.Text + " RISS Website Informational Flier (each set contains 50 fliers)<br />";
        }
        if (txtImpact.Text != "0" && txtImpact.Text != "")
        {
            strBody += txtImpact.Text + " MOCIC Impact Statement Fliers (each set contains 50 Fliers)<br />";
            if (chkIllinois.Checked)
            {
                strBody += " - Illinois<br />";
            }
            if (chkIowa.Checked)
            {
                strBody += " - Iowa<br />";
            }
            if (chkKansas.Checked)
            {
                strBody += " - Kansas<br />";
            }
            if (chkMinnesota.Checked)
            {
                strBody += " - Minnesota<br />";
            }
            if (chkMissouri.Checked)
            {
                strBody += " - Missouri<br />";
            }
            if (chkNebraska.Checked)
            {
                strBody += " - Nebraska<br />";
            }
            if (chkNorthDakota.Checked)
            {
                strBody += " - North Dakota<br />";
            }
            if (chkSouthDakota.Checked)
            {
                strBody += " - South Dakota<br />";
            }
            if (chkWisconsin.Checked)
            {
                strBody += " - Wisconsin<br />";
            }
        }
        




        objMM.Body = strBody;

        SmtpMail.SmtpServer = "10.12.1.2";
        SmtpMail.Send(objMM);

        lblMessage.Text = "Request has been sent.";
    }


</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1>Promotional Materials Order Form</h1>

<table cellpadding="5" cellspacing="0" border="0">
    <tr>
        <td colspan="3">
            <font color="red">
                <asp:Label ID="lblMessage" runat="server"></asp:Label></font>
        </td>
    </tr>
    <%--<tr>
        <td>
            <asp:CheckBoxList ID="CheckBoxList1" runat="server" DataSourceID="SqlDataSource1" 
                DataTextField="FCS_Forms_Name" DataValueField="FCS_Forms_ID">
            </asp:CheckBoxList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                SelectCommand="spSelectFormOrderFormList" SelectCommandType="StoredProcedure">
            </asp:SqlDataSource>
        </td>
    </tr>--%>
    <tr>
        <td valign="top">
            <table cellpadding="5">
                <tr>
                    <td colspan="3"><b><u>MOCIC RACK CARDS</u></b><br /><i>(Each set contains 25 cards.  Enter # of sets.)</i></td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtOverview" Columns="3" runat="server"></asp:TextBox></td>
                    <td></td>
                    <td>Overview</td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtInformationSharing" Columns="3" runat="server"></asp:TextBox></td>
                    <td></td>
                    <td>Information Sharing</td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtOfficerSafety" Columns="3" runat="server"></asp:TextBox></td>
                    <td></td>
                    <td>Officer Safety</td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtInvestigative" Columns="3" runat="server"></asp:TextBox></td>
                    <td></td>
                    <td>Investigative Services</td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtIntelligence" Columns="3" runat="server"></asp:TextBox></td>
                    <td></td>
                    <td>Analytical Services</td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtCriminal" Columns="3" runat="server"></asp:TextBox></td>
                    <td></td>
                    <td>Research Services</td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtEquipment" Columns="3" runat="server"></asp:TextBox></td>
                    <td></td>
                    <td>Equipment Services</td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtDigital" Columns="3" runat="server"></asp:TextBox></td>
                    <td></td>
                    <td>Digital Forensic Services</td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtHolder" Columns="3" runat="server"></asp:TextBox></td>
                    <td></td>
                    <td>Rack Card Folder<br /><i>(Each set contains 25 folders.  Enter # of sets.)</i></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="3"><b><u>OTHER</u></b><br /><i>(Enter # of sets.)</i></td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtMiranda" Columns="3" runat="server"></asp:TextBox></td>
                    <td></td>
                    <td>Miranda Cards<br /><i>(each set contains 50 cards)</i></td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtAddress" Columns="3" runat="server"></asp:TextBox></td>
                    <td></td>
                    <td>MOCIC Address Labels<br /><i>(each set contains 30 labels)</i></td>
                </tr>
                <tr>
                    <td valign="top"><asp:TextBox ID="txtStaff" Columns="3" runat="server"></asp:TextBox></td>
                    <td></td>
                    <td>
                        <table>
                            <tr>
                                <td colspan="3" style="text-align:left">MOCIC Staff Roster</td>
                            </tr>
                            <tr>
                                <td colspan="3" style="text-align:center"><i>(each set contains 50 rosters)</i><br />Select Color:</td>
                            </tr>
                            <tr>
                                <td><asp:CheckBox ID="chkBlue" runat="server" Text="Blue" /></td>
                                <td></td>
                                <td><asp:CheckBox ID="chkPink" runat="server" Text="Pink" /></td>
                            </tr>
                            <tr>
                                <td><asp:CheckBox ID="chkGoldenrod" runat="server" Text="Goldenrod" /></td>
                                <td></td>
                                <td><asp:CheckBox ID="chkYellow" runat="server" Text="Yellow" /></td>
                            </tr>
                            <tr>
                                <td><asp:CheckBox ID="chkGray" runat="server" Text="Gray" /></td>
                                <td></td>
                                <td><asp:CheckBox ID="chkWhite" runat="server" Text="White" /></td>
                            </tr>
                            <tr>
                                <td><asp:CheckBox ID="chkGreen" runat="server" Text="Green" /></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
        <td></td>
        <td valign="top">
            <table cellpadding="5">
                <tr>
                    <td colspan="3"><b><u>FLYERS</u></b><br /><i>(Each set contains 50 flyers.  Enter # of sets.)</i></td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtBatchBrochure" Columns="3" runat="server"></asp:TextBox></td>
                    <td></td>
                    <td>Batch Upload</td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtBelong" Columns="3" runat="server"></asp:TextBox></td>
                    <td></td>
                    <td>I Belong to MOCIC...Now What</td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtNationalLFWeek" Columns="3" runat="server"></asp:TextBox></td>
                    <td></td>
                    <td>National Law Enforcement Week</td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtSafe" Columns="3" runat="server"></asp:TextBox></td>
                    <td></td>
                    <td>RISSafe</td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtGang" Columns="3" runat="server"></asp:TextBox></td>
                    <td></td>
                    <td>RISSGang</td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtRISSIntel" Columns="3" runat="server"></asp:TextBox></td>
                    <td></td>
                    <td>RISSIntel</td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtSafety" Columns="3" runat="server"></asp:TextBox></td>
                    <td></td>
                    <td>RISS Officer Safety Website</td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtProgram" Columns="3" runat="server"></asp:TextBox></td>
                    <td></td>
                    <td>RISS Program</td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtRISSWebsite" Columns="3" runat="server"></asp:TextBox></td>
                    <td></td>
                    <td>RISS Website</td>
                </tr>
                <tr>
                    <td valign="top"><asp:TextBox ID="txtImpact" Columns="3" runat="server"></asp:TextBox></td>
                    <td></td>
                    <td>
                        <table>
                            <tr>
                                <td colspan="3" style="text-align:left">MOCIC Impact Statements</td>
                            </tr>
                            <tr>
                                <td colspan="3" style="text-align:center">Select which state:</td>
                            </tr>
                            <tr>
                                <td><asp:CheckBox ID="chkIllinois" runat="server" Text="Illinois" /></td>
                                <td></td>
                                <td><asp:CheckBox ID="chkNebraska" runat="server" Text="Nebraska" /></td>
                            </tr>
                            <tr>
                                <td><asp:CheckBox ID="chkIowa" runat="server" Text="Iowa" /></td>
                                <td></td>
                                <td><asp:CheckBox ID="chkNorthDakota" runat="server" Text="North Dakota" /></td>
                            </tr>
                            <tr>
                                <td><asp:CheckBox ID="chkKansas" runat="server" Text="Kansas" /></td>
                                <td></td>
                                <td><asp:CheckBox ID="chkSouthDakota" runat="server" Text="South Dakota" /></td>
                            </tr>
                            <tr>
                                <td><asp:CheckBox ID="chkMinnesota" runat="server" Text="Minnesota" /></td>
                                <td></td>
                                <td><asp:CheckBox ID="chkWisconsin" runat="server" Text="Wisconsin" /></td>
                            </tr>
                            <tr>
                                <td><asp:CheckBox ID="chkMissouri" runat="server" Text="Missouri" /></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <%--<tr>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="3"><b><u>BROCHURES</u></b><br /><i>(Each set contains 25 brochures.  Enter # of sets.)</i></td>
                </tr>--%>
                
            </table>
        </td>
    </tr>

</table>
<table>
    
    
    <tr>
        <td class="center"><asp:Button ID="cmdSubmit" Text="Submit" runat="server" 
                onclick="cmdSubmit_Click" /></td>
    </tr>
</table>
    
</asp:Content>

