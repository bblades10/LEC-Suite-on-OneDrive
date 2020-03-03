<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<% Response.ContentType = "application/vnd.ms-excel"; %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        double dblTotal;
        dblTotal = 0;
        string strResult;
        strResult = "<table border=0 cellspacing=1 cellpadding=1><tr><td colspan='6' align='center'><b>Liaison Contact Report from " + Request.QueryString["bd"] + " to " + Request.QueryString["ed"] + "</b></td></tr>";
        strResult += "<tr><td><u>State</u></td><td><u>Contacts</u></td></tr>";
        
        DataClassesDataContext myDB = new DataClassesDataContext();
        var objRS = myDB.spSelectLiaisonContactsReport(Convert.ToDateTime(Request.QueryString["bd"]), Convert.ToDateTime(Request.QueryString["ed"]));

        foreach (spSelectLiaisonContactsReportResult record in objRS)
        {
            strResult+= "<tr><td>" + record.ag_State + "</td><td>" + record.Contacts + "</td></tr>";
            dblTotal += Convert.ToDouble(record.Contacts);
        }

        strResult += "<tr><td align='right'><b>Total:</b></td><td align='left'><b>" + dblTotal + "</b></td></tr></table>";

        divResult.InnerHtml = strResult;
    }

</script>

<html>
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    
    <div id="divResult" runat="server">
    
    </div>
</body>
</html>
