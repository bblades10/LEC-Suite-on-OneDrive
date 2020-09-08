<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<% Response.ContentType = "application/vnd.ms-excel"; 
   Response.AddHeader ("Content-Disposition", "attachment; filename=rissafe.xls"); %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        double dblTotal;
        dblTotal = 0;
        string strResult;
        strResult = "<table border=0 cellspacing=1 cellpadding=1><tr><td colspan='6' align='center'><b>RISSafe Report from " + Request.QueryString["bd"] + " to " + Request.QueryString["ed"] + "</b></td></tr>";
        strResult += "<tr><td><u>Date</u></td><td><u>Name</u></td><td><u>City</u></td><td><u>State</u></td><td><u>Coordinator</u></td><td><u>Hours</u></td></tr>";
        
        DataClassesDataContext myDB = new DataClassesDataContext();
        var objRS = myDB.spSelectRISSafeReport(Convert.ToDateTime(Request.QueryString["bd"]), Convert.ToDateTime(Request.QueryString["ed"]));

        foreach (spSelectRISSafeReportResult record in objRS)
        {
            strResult+= "<tr><td>" + record.DateEntered.Value.ToShortDateString() + "</td><td nowrap>" + record.Name + "</td><td>" + record.City + "</td><td>" + record.State + "</td><td>" + record.FieldCoor + "</td><td>" + record.Hours + "</td></tr>";
            dblTotal += Convert.ToDouble(record.Hours);
        }

        strResult += "<tr><td colspan='4'></td><td align='right'><b>Total:</b></td><td align='left'><b>" + dblTotal + "</b></td></tr></table>";

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
