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
        objMM.Subject = "Forms & Brochures Order Form for Law Enforcement Coordinators";

        string strBody = "";
        strBody = "Forms & Brochures Order Form for " + Session["FirstName"] + " " + Session["LastName"] + "<br /><br />";

        if (txtAtix.Text != "0" && txtAtix.Text != "")
        {
            strBody += txtAtix.Text + " RISS ATIX Flier (each set contains 50 Fliers)<br />";
        }
        if (txtGang.Text != "0" && txtGang.Text != "")
        {
            strBody += txtGang.Text + " RISS Gang Flier (each set contains 50 Fliers)<br />";
        }
        if (txtSafe.Text != "0" && txtSafe.Text != "")
        {
            strBody += txtSafe.Text + " RISS Safe Flier (each set contains 50 Fliers)<br />";
        }
        if (txtProgram.Text != "0" && txtProgram.Text != "")
        {
            strBody += txtProgram.Text + " RISS Program Flier (each set contains 50 fliers)<br />";
        }
        //if (txtRiss7.Text != "0" && txtRiss7.Text != "")
        //{
        //    strBody += txtRiss7.Text + " RISS 7 Flier (each set contains 50 fliers)<br />";
        //}
        //if (txtBrochure.Text != "0" && txtBrochure.Text != "")
        //{
        //    strBody += txtBrochure.Text + " MOCIC Brochure (each set contains 50 brochures)<br />";
        //}
        if (txtAddress.Text != "0" && txtAddress.Text != "")
        {
            strBody += txtAddress.Text + " MOCIC Address Labels (each set contains 30 labels)<br />";
        }
        if (txtIntelligence.Text != "0" && txtIntelligence.Text != "")
        {
            strBody += txtIntelligence.Text + " MOCIC Analytical Services RAC Card (each set contains 25 Cards)<br />";
        }
        if (txtDigital.Text != "0" && txtDigital.Text != "")
        {
            strBody += txtDigital.Text + " MOCIC Digital Forensic Services RAC Card (each set contains 25 Cards)<br />";
        }
        if (txtEquipment.Text != "0" && txtEquipment.Text != "")
        {
            strBody += txtEquipment.Text + " MOCIC Equipment Services Unit RAC Card (each set contains 25 Cards)<br />";
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

        if (txtInformationSharing.Text != "0" && txtInformationSharing.Text != "")
        {
            strBody += txtInformationSharing.Text + " MOCIC Information Sharing RAC Card (each set contains 25 Cards)<br />";
        }
        if (txtInvestigative.Text != "0" && txtInvestigative.Text != "")
        {
            strBody += txtInvestigative.Text + " MOCIC Investigative Services RAC Card (each set contains 25 Cards)<br />";
        }
        //if (txtTraining.Text != "0" && txtTraining.Text != "")
        //{
        //    strBody += txtTraining.Text + " MOCIC Training Section Brochure (each set contains 25 Brochures)<br />";
        //}
        if (txtMiranda.Text != "0" && txtMiranda.Text != "")
        {
            strBody += txtMiranda.Text + " MOCIC Miranda Cards (each set contains 50 cards)<br />";
        }

        if (txtOfficerSafety.Text != "0" && txtOfficerSafety.Text != "")
        {
            strBody += txtOfficerSafety.Text + " MOCIC Officer Safety RAC Card (each set contains 25 Cards)<br />";
        }
        if (txtOverview.Text != "0" && txtOverview.Text != "")
        {
            strBody += txtOverview.Text + " MOCIC Overview RAC Card (each set contains 25 Cards)<br />";
        }
        if (txtCriminal.Text != "0" && txtCriminal.Text != "")
        {
            strBody += txtCriminal.Text + " MOCIC Research Services RAC Card (each set contains 25 Cards)<br />";
        }



        if (txtHolder.Text != "0" && txtHolder.Text != "")
        {
            strBody += txtHolder.Text + " RAC Card Holder (set contains 25 Holders)<br />";
        }
        if (txtSafety.Text != "0" && txtSafety.Text != "")
        {
            strBody += txtSafety.Text + " Officer Safety Website Flier (each set contains 50 Fliers)<br />";
        }
        if (txtRISSIntel.Text != "0" && txtRISSIntel.Text != "")
        {
            strBody += txtRISSIntel.Text + " RISSIntel Flier (each set contains 50 Fliers)<br />";
        }
        //if (txt28.Text != "0" && txt28.Text != "")
        //{
        //    strBody += txt28.Text + " 28 CFR CD (each set contains 10 CDs)<br />";
        //}
        //if (txtCISOP.Text != "0" && txtCISOP.Text != "")
        //{
        //    strBody += txtCISOP.Text + " CISOP Form (each set contains 50 Forms)<br />";
        //}
        //if (txtSecondary.Text != "0" && txtSecondary.Text != "")
        //{
        //    strBody += txtSecondary.Text + " Secondary Agency Form (each set contains 10 Forms)<br />";
        //}
        //if (txtInterim.Text != "0" && txtInterim.Text != "")
        //{
        //    strBody += txtInterim.Text + " Interim Agreement Form (each set contains 20 Forms)<br />";
        //}
        if (txtBatchBrochure.Text != "0" && txtBatchBrochure.Text != "")
        {
            strBody += txtBatchBrochure.Text + " Batch Upload Brochure (each set contains 50 Brochures)<br />";
        }
        //if (txtBatchSubmission.Text != "0" && txtBatchSubmission.Text != "")
        //{
        //    strBody += txtBatchSubmission.Text + " Batch Upload Submission Form (each set contains 50 Forms)<br />";
        //}
        if (txtBelong.Text != "0" && txtBelong.Text != "")
        {
            strBody += txtBelong.Text + " I Belong To MOCIC Flier (each set contains 25 Fliers)<br />";
        }
        //if (txtSubmission.Text != "0" && txtSubmission.Text != "")
        //{
        //    strBody += txtSubmission.Text + " Submission Form (each set contains 50 Forms)<br />";
        //}
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


        objMM.Body = strBody;

        SmtpMail.SmtpServer = "mail.mocic2003.net";
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
        <td>
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
        <td>
            <asp:TextBox ID="txtAtix" Columns="3" runat="server"></asp:TextBox>RISS ATIX Flier (each set contains 50 Fliers)
        </td>
    </tr>
    <tr>
        <td>
            <asp:TextBox ID="txtGang" Columns="3" runat="server"></asp:TextBox>RISS Gang Flier (each set contains 50 Fliers)
        </td>
    </tr>
    <tr>
        <td>
            <asp:TextBox ID="txtSafe" Columns="3" runat="server"></asp:TextBox>RISS Safe Flier (each set contains 50 Fliers)
        </td>
    </tr>
    <tr>
        <td>
            <asp:TextBox ID="txtProgram" Columns="3" runat="server"></asp:TextBox>RISS Program Flier (each set contains 50 fliers)
        </td>
    </tr>
    <%--<tr>
        <td>
            <asp:TextBox ID="txtRiss7" Columns="3" runat="server"></asp:TextBox>RISS 7 Flier (each set contains 50 fliers)
        </td>
    </tr>
    <tr>
        <td>
            <asp:TextBox ID="txtBrochure" Columns="3" runat="server"></asp:TextBox>MOCIC Brochure (each set contains 50 brochures)
        </td>
    </tr>--%>
    <tr>
        <td>
            <asp:TextBox ID="txtAddress" Columns="3" runat="server"></asp:TextBox>MOCIC Address Labels (each set contains 30 labels)
        </td>
    </tr>
    <tr>
        <td>
            <asp:TextBox ID="txtIntelligence" Columns="3" runat="server"></asp:TextBox>MOCIC Analytical Services RAC Card (each set contains 25 Cards)
        </td>
    </tr>
    <tr>
        <td>
            <asp:TextBox ID="txtDigital" Columns="3" runat="server"></asp:TextBox>MOCIC Digital Forensic Services RAC Card (each set contains 25 Cards)
        </td>
    </tr>
    <tr>
        <td>
            <asp:TextBox ID="txtEquipment" Columns="3" runat="server"></asp:TextBox>MOCIC Equipment Services Unit RAC Card (each set contains 25 Cards)
        </td>
    </tr>
    <tr>
        <td>
            <asp:TextBox ID="txtImpact" Columns="3" runat="server"></asp:TextBox>MOCIC Impact Statement Fliers (each set contains 50 Fliers)<br />
                <asp:CheckBox ID="chkIllinois" runat="server" Text="Illinois" />
                <asp:CheckBox ID="chkIowa" runat="server" Text="Iowa" />
                <asp:CheckBox ID="chkKansas" runat="server" Text="Kansas" />
                <asp:CheckBox ID="chkMinnesota" runat="server" Text="Minnesota" />
                <asp:CheckBox ID="chkMissouri" runat="server" Text="Missouri" /><br />
                <asp:CheckBox ID="chkNebraska" runat="server" Text="Nebraska" />
                <asp:CheckBox ID="chkNorthDakota" runat="server" Text="North Dakota" />
                <asp:CheckBox ID="chkSouthDakota" runat="server" Text="South Dakota" />
                <asp:CheckBox ID="chkWisconsin" runat="server" Text="Wisconsin" />
        </td>
    </tr>

    <tr>
        <td>
            <asp:TextBox ID="txtInformationSharing" Columns="3" runat="server"></asp:TextBox>MOCIC Information Sharing RAC Card (each set contains 25 Cards)
        </td>
    </tr>
    <tr>
        <td>
            <asp:TextBox ID="txtInvestigative" Columns="3" runat="server"></asp:TextBox>MOCIC Investigative Services RAC Card (each set contains 25 Cards)
        </td>
    </tr>
    <%--<tr>
        <td>
            <asp:TextBox ID="txtTraining" Columns="3" runat="server"></asp:TextBox>MOCIC Training Section Brochure (each set contains 25 Brochures)
        </td>
    </tr>--%>
    <tr>
        <td>
            <asp:TextBox ID="txtMiranda" Columns="3" runat="server"></asp:TextBox>MOCIC Miranda Cards (each set contains 50 Cards)
        </td>
    </tr>
    <tr>
        <td>
            <asp:TextBox ID="txtOfficerSafety" Columns="3" runat="server"></asp:TextBox>MOCIC Officer Safety RAC Card (each set contains 25 Cards)
        </td>
    </tr>
    
    <tr>
        <td>
            <asp:TextBox ID="txtOverview" Columns="3" runat="server"></asp:TextBox>MOCIC Overview RAC Card (each set contains 25 Cards)
        </td>
    </tr>
    <tr>
        <td>
            <asp:TextBox ID="txtCriminal" Columns="3" runat="server"></asp:TextBox>MOCIC Research Services RAC Card (each set contains 25 Cards)
        </td>
    </tr>
    <tr>
        <td>
            <asp:TextBox ID="txtHolder" Columns="3" runat="server"></asp:TextBox>RAC Card Holder (set contains 25 Holders)
        </td>
    </tr>
    <tr>
        <td>
            <asp:TextBox ID="txtSafety" Columns="3" runat="server"></asp:TextBox>Officer Safety Website Flier (each set contains 50 Fliers)
        </td>
    </tr>
    <tr>
        <td>
            <asp:TextBox ID="txtRISSIntel" Columns="3" runat="server"></asp:TextBox>RISSIntel Flier (each set contains 50 Fliers)
        </td>
    </tr>
    <%--<tr>
        <td>
            <asp:TextBox ID="txt28" Columns="3" runat="server"></asp:TextBox>28 CFR CD (each set contains 10 CDs)
        </td>
    </tr>
    <tr>
        <td>
            <asp:TextBox ID="txtCISOP" Columns="3" runat="server"></asp:TextBox>CISOP Form (each set contains 50 Forms)
        </td>
    </tr>
    <tr>
        <td>
            <asp:TextBox ID="txtSecondary" Columns="3" runat="server"></asp:TextBox>Secondary Agency Form (each set contains 10 Forms)
        </td>
    </tr>
    <tr>
        <td>
            <asp:TextBox ID="txtInterim" Columns="3" runat="server"></asp:TextBox>Interim Agreement Form (each set contains 20 Forms)
        </td>
    </tr>--%>
    <tr>
        <td>
            <asp:TextBox ID="txtBatchBrochure" Columns="3" runat="server"></asp:TextBox>Batch Upload Brochure (each set contains 50 Brochures)
        </td>
    </tr>
    <%--<tr>
        <td>
            <asp:TextBox ID="txtBatchSubmission" Columns="3" runat="server"></asp:TextBox>Batch Upload Submission Form (each set contains 50 Forms)
        </td>
    </tr>--%>
    <tr>
        <td>
            <asp:TextBox ID="txtBelong" Columns="3" runat="server"></asp:TextBox>I Belong To MOCIC Flier (each set contains 50 Fliers)
        </td>
    </tr>
    <%--<tr>
        <td>
            <asp:TextBox ID="txtSubmission" Columns="3" runat="server"></asp:TextBox>Submission Form (each set contains 50 Forms)
        </td>
    </tr>--%>

    <tr>
        <td>
            <asp:TextBox ID="txtStaff" Columns="3" runat="server"></asp:TextBox>Staff Roster (each set contains 50 Forms - please select color below)<br />
            <asp:CheckBox ID="chkWhite" runat="server" Text="White" />
            <asp:CheckBox ID="chkGray" runat="server" Text="Gray" />
            <asp:CheckBox ID="chkGoldenrod" runat="server" Text="Goldenrod" />
            <asp:CheckBox ID="chkYellow" runat="server" Text="Yellow" /><br />
            <asp:CheckBox ID="chkGreen" runat="server" Text="Green" />
            <asp:CheckBox ID="chkBlue" runat="server" Text="Blue" />
            <asp:CheckBox ID="chkPink" runat="server" Text="Pink" />
        </td>
    </tr>
    <tr>
        <td class="center"><asp:Button ID="cmdSubmit" Text="Submit" runat="server" 
                onclick="cmdSubmit_Click" /></td>
    </tr>
</table>
    
</asp:Content>

