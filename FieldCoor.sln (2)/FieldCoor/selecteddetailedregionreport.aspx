<%@ Page Language="C#" debug="true"%>
<%@ Import Namespace="CrystalDecisions.CrystalReports.Engine" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    ReportDocument rd = new ReportDocument();

    protected void Page_Unload(object sender, EventArgs e)
    {
        rd.Close();
        rd.Dispose();
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        rd.Load(Server.MapPath("selecteddetailregionreport.rpt"));
        rd.SetDatabaseLogon("MOCIC_IT", "!it_MOCIC!", "srv-dbs1", "FieldCoorSuite");
        //rd.SetParameterValue("@StartDate", "12/1/2011");
        //rd.SetParameterValue("@EndDate", "2/1/2012");
        rd.SetParameterValue("@ag_Region", Request.QueryString["r"]);
        CrystalReportViewer1.ReportSource = rd;
    }
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" 
            AutoDataBind="True" EnableDatabaseLogonPrompt="False" 
            Height="1055px" HasCrystalLogo="False" HasToggleGroupTreeButton="False"
            ReportSourceID="CrystalReportSource1" Width="901px" ToolPanelView="None" />
        <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
            <Report FileName="selecteddetailedregionreport.rpt">
            </Report>
        </CR:CrystalReportSource>
    </div>
    </form>
</body>
</html>
