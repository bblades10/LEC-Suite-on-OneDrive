<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<% Response.ContentType = "application/vnd.ms-excel"; %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string strResult;
        strResult = "<table border=1 cellspacing=1 cellpadding=1><tr><td colspan=12 align=center><b>Activity from " + Request.QueryString["bd"] + " to " + Request.QueryString["ed"] + "</b></td></tr>" ;
        
        strResult += "<tr><td><b><u>Activity Type</b></u></td><td><b><u>Date</b></u></td><td><b><u>Hours</b></u></td><td><b><u>Agency Name</b></u></td><td><b><u>Phone</b></u></td><td><b><u>OnSite</b></u></td><td><b><u>Attemp</b></u></td><td><b><u>Atix</b></u></td><td><b><u>CISOP</b></u></td><td><b><u>SSL</b></u></td><td><b><u>Demoed</b></u></td><td><b><u>FCR</b></u></td></tr>";


        //SqlConnection myConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["RissCenterDBConnectionString"].ConnectionString);
        //SqlCommand myCmd = new SqlCommand("spSelectParticipationReport", myConn);
        //myCmd.CommandType = CommandType.StoredProcedure;
        //SqlParameter myParam = new SqlParameter();
        //myParam = myCmd.Parameters.Add("@StartDate", SqlDbType.DateTime);
        //myParam.Direction = ParameterDirection.Input;
        //myParam.Value = Convert.ToDateTime(Request.QueryString["bd"]);
        //myParam = myCmd.Parameters.Add("@EndDate", SqlDbType.DateTime);
        //myParam.Direction = ParameterDirection.Input;
        //myParam.Value = Convert.ToDateTime(Request.QueryString["ed"]);
        //myParam = myCmd.Parameters.Add("@Region", SqlDbType.VarChar);
        //myParam.Direction = ParameterDirection.Input;
        //myParam.Value = Request.QueryString["fc"];
        //myCmd.CommandTimeout = 240;

        //SqlDataReader myRS;

        //myConn.Open();

        //myRS = myCmd.ExecuteReader();

        //Int32 intTotal = 0;

        //while (myRS.Read())
        //{

        //    intTotal = Convert.ToInt32(myRS["Submittals"]) + Convert.ToInt32(myRS["Inquiry"]) + Convert.ToInt32(myRS["Operations"]) + Convert.ToInt32(myRS["CIS"]) + Convert.ToInt32(myRS["Analytical"]) + Convert.ToInt32(myRS["Forensics"]) + Convert.ToInt32(myRS["Training"]) + Convert.ToInt32(myRS["AnnualConference"]) + Convert.ToInt32(myRS["Equipment"]) + Convert.ToInt32(myRS["Funds"]) + Convert.ToInt32(myRS["Audio"]) + Convert.ToInt32(myRS["Video"]);
        //    strResult += "<tr><td>" + myRS["ag_ID"] + "</td><td>" + myRS["ag_Name"] + "</td><td>" + myRS["ag_City"] + "</td><td>" + myRS["ag_State"] + "</td><td>" + myRS["ag_Region"] + "</td><td>" + myRS["Submittals"] + "</td><td>" + myRS["Inquiry"] + "</td><td>" + myRS["Operations"] + "</td><td>" + myRS["CIS"] + "</td><td>" + myRS["Analytical"] + "</td><td>" + myRS["Forensics"] + "</td><td>" + myRS["Training"] + "</td><td>" + myRS["AnnualConference"] + "</td><td>" + myRS["Equipment"] + "</td><td>" + myRS["Funds"] + "</td><td>" + myRS["Audio"] + "</td><td>" + myRS["Video"] + "</td><td>" + intTotal + "</td></tr>";

        //}

        //myRS.Close();
        //myConn.Close();

        DataClassesDataContext myDB = new DataClassesDataContext();
        var objRS = myDB.spSelectAllActivityDetailsReport(Convert.ToInt32(Session["EmpID"]), Convert.ToDateTime(Request.QueryString["bd"]), Convert.ToDateTime(Request.QueryString["ed"]));

        foreach (spSelectAllActivityDetailsReportResult record in objRS)
        {
            strResult += "<tr><td>" + record.ActivityType + "</td><td>" + record.VisitDate + "</td><td>" + record.VisitHours + "</td><td>" + record.AgencyName + "</td><td>" + record.Phone + "</td><td>" + record.OnSite + "</td><td>" + record.Attempted + "</td><td>" + record.Atix + "</td><td>" + record.CISOP + "</td><td>" + record.SSL + "</td><td>" + record.Demoed + "</td><td>" + record.Background + "</td></tr>";
        }

        strResult += "</table>";

        divResult.InnerHtml = strResult;
    }

</script>

<html>
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <div id="divResult" runat="server"></div>
</body>
</html>