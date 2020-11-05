<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>

<script runat="server">
    string strFileName;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        DataClassesDataContext myDB = new DataClassesDataContext();
        var objRS = myDB.spSelectUploadedAppReappDetail(Convert.ToInt32(Request.QueryString["id"]));
        foreach (spSelectUploadedAppReappDetailResult record in objRS)
        {
            lblDateUploaded.Text = Convert.ToString(record.FCS_apd_Date_Entered.Value.ToShortDateString());
            lblAgencyName.Text = record.ag_Name;
            lblCoordinator.Text = record.FullName;
            strFileName = record.FCS_apd_File_Name;
        }
    }

    protected void cmdDownload_Click(object sender, EventArgs e)
    {
        if (Convert.ToInt16(Session["EmpID"]) == 119 || Convert.ToInt16(Session["EmpID"]) == 43 )
        {
            DataClassesDataContext myDB = new DataClassesDataContext();
            myDB.spEditUploadAppReapp(Convert.ToInt32(Request.QueryString["id"]));
            
        }
        
        Response.ContentType = "application/msword";
        Response.AppendHeader("Content-Disposition", "attachment; filename=" + strFileName);
        Response.TransmitFile(@"F:\appreappreports\" + strFileName);
        Response.End();
        Response.Redirect("listuploads.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>App/Reapp Detail</h1>
<table cellpadding="5" cellspacing="0" border="0">
    <tr>
        <td>Date Uploaded: <u><asp:Label ID="lblDateUploaded" runat="server"></asp:Label></u></td>
    </tr>
    <tr>
        <td>Agency: <u><asp:Label ID="lblAgencyName" runat="server"></asp:Label></u></td>
    </tr>
    <tr>
        <td>Coordinator: <u><asp:Label ID="lblCoordinator" runat="server"></asp:Label></u></td>
    </tr>
    <tr>
        <td>Report: <asp:Button ID="cmdDownload" runat="server" Text="Download Report" 
                onclick="cmdDownload_Click" /></td>
    </tr>
</table>
</asp:Content>

