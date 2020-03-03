<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>
<%@ Import Namespace="System.Web.UI.WebControls"  %>
<% @Import Namespace="System.Web.Mail" %>

<script runat="server">

    protected void cmdUpload_Click(object sender, EventArgs e)
    {
        if (FileUploadControl.HasFile)
        {
            try
            {
                string timestamp = DateTime.Now.ToString("yyyyMMddhhmmss");
                string filename = timestamp + FileUploadControl.FileName.ToString();
                FileUploadControl.SaveAs(@"D:\appreappreports\" + filename);
                lblStatus.Text = "File Uploaded Successfully!";
                //lblStatus.Text = "File path = " + Server.MapPath("~/../appreappreports/") + DateTime.Now.ToString("yyyyMMddhhmmss") + filename;
                DataClassesDataContext myDB = new DataClassesDataContext();
                myDB.spUploadAppReapp(Convert.ToInt32(Session["EmpID"]), filename, "Pending", Convert.ToInt32(dropAgency.SelectedItem.Value), txtNewAgency.Text.ToString());

                MailMessage objMM = new MailMessage();

                objMM.To = "tlong@mocic.riss.net";
                objMM.To = "lterhune@mocic.riss.net";
                objMM.From = Session["UserName"] + "@mocic.riss.net";
                objMM.Cc = Session["UserName"] + "@mocic.riss.net";
                objMM.BodyFormat = MailFormat.Html;
                objMM.Priority = MailPriority.Normal;
                objMM.Subject = "New App/Reapp Uploaded";

                string strBody = "";
                strBody = Session["FirstName"] + " " + Session["LastName"] + " has uploaded a new App/Reapp.";

                objMM.Body = strBody;

                SmtpMail.SmtpServer = "10.12.1.2";
                SmtpMail.Send(objMM);
                 
            }
            catch (Exception ex)
            {
                lblStatus.Text = "Upload status: The file could not be uploaded.  The following error occured: " + ex.Message;
            }
        }
    }

    protected void dropAgency_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtNewAgency.Text = dropAgency.SelectedItem.Text;
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1>App/Reapp Upload</h1>
<table cellpadding="5" cellspacing="0" border="0">
    <tr>
        <td class="center">
            <font color="red">
                <asp:Label ID="lblStatus" runat="server"></asp:Label></font>
        </td>
    </tr>
    <tr>
        <td>
            Select Agency:
            <asp:DropDownList ID="dropAgency" runat="server" DataSourceID="SqlDataSource2" DataTextField="AgencyName"
                DataValueField="ag_Key" AppendDataBoundItems="true" AutoPostBack="true"
                onselectedindexchanged="dropAgency_SelectedIndexChanged">
                <asp:ListItem Text="" Value="9999" Selected="True"></asp:ListItem>
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
        <td class="center">OR</td>
    </tr>
    <tr>
        <td>Type Agency:<asp:TextBox ID="txtNewAgency" Columns="80" runat="server"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="center"><asp:FileUpload ID="FileUploadControl" runat="server" /></td>
    </tr>
    <tr>
        <td class="center"><asp:Button ID="cmdUpload" Text="Upload" runat="server" onclick="cmdUpload_Click" /></td>
    </tr>
</table>
        
</asp:Content>

