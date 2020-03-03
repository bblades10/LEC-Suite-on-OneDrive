<%@ Page Language="C#" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        System.Security.PermissionSet sec = new System.Security.PermissionSet(System.Security.Permissions.PermissionState.Unrestricted);
        ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(sec);
        ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(SetSubDataSource);
        this.ReportViewer1.LocalReport.Refresh();
    }

    public void SetSubDataSource(object sender, SubreportProcessingEventArgs e)
    {
        e.DataSources.Add(new ReportDataSource("DataSet2", "ObjectDataSource2"));
        //    var mainSource = ((LocalReport) sender).DataSources["ObjectDataSource1"];
    //    var orderId = int.Parse(e.Parameters["OrderID"].Values.First());
    //    var subSource = ((List<Order>)mainSource.Value).Single(o => o.OrderID == orderId).Suppliers;
    //    e.DataSources.Add(new ReportDataSource("SubDataSet1", subSource));
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" SizeToReportContent="True" AsyncRendering="False" Width="100%" Height="600px" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
            <LocalReport ReportPath="regionreport.rdlc">
                <DataSources>
                    <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="DataSet1" />
                    <rsweb:ReportDataSource DataSourceId="ObjectDataSource2" Name="DataSet2" />
                </DataSources>
            </LocalReport>
        </rsweb:ReportViewer>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetData" TypeName="regionreportTableAdapters.spSelectAgenciesByRegionTableAdapter" OldValuesParameterFormatString="original_{0}" >
            <SelectParameters>
                <asp:QueryStringParameter Name="ag_Region" QueryStringField="r" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="regionreportTableAdapters.spSelectAgencyOfficersByGUIDTableAdapter"></asp:ObjectDataSource>
    </div>
    </form>
</body>
</html>
