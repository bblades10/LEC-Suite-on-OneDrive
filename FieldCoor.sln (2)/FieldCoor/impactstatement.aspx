<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<% Response.ContentType = "application/vnd.ms-excel"; %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string strResult;
        strResult = "<table border=0 cellspacing=1 cellpadding=1><tr><td colspan='6' align='center'><b>Impact Statement Service Contacts Report from " + Request.QueryString["bd"] + " to " + Request.QueryString["ed"] + "</b></td></tr>";
        strResult += "<tr><td colspan='6' align='center'>Includes On-site visits, Visits by Phone, and Not-on-site visits</td></tr>";
        strResult += "<tr><td><u>State</u></td><td><u>Contacts</u></td></tr>";
        
        DataClassesDataContext myDB = new DataClassesDataContext();
        var objRS = myDB.spSelectImpactStatementReport(Convert.ToDateTime(Request.QueryString["bd"]), Convert.ToDateTime(Request.QueryString["ed"]));

        foreach (spSelectImpactStatementReportResult record in objRS)
        {
            strResult+= "<tr><td>" + record.ag_State + "</td><td>" + record.Contacts + "</td></tr>";
            
        }

        strResult += "</table>";

        divResult.InnerHtml = strResult;
    }

</script>

<html>
<head runat="server">
    <title></title>
</head>
<body>
    
    <div id="divResult" runat="server">
    
    </div>
</body>
</html>
