<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<% Response.ContentType = "application/vnd.ms-excel"; 
   Response.AddHeader ("Content-Disposition", "attachment; filename=participation.xls"); %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string strResult;
        strResult = "<table border=1 cellspacing=1 cellpadding=1><tr><td colspan=18 align=center><b>Participation Report from " + Request.QueryString["bd"] + " to " + Request.QueryString["ed"];
        if (Request.QueryString["fc"] != "00")
        {
            strResult += " for Region " + Request.QueryString["fc"] + " (Does not include Node or Third-Party Submissions)</b></td></tr>";
        }
        else
        {
            strResult += " (Does not include Node or Third-Party Submissions)</b></td></tr>";
        }

        strResult += "<tr><td><b><u>Agency ID</b></u></td><td><b><u>Agency Name</b></u></td><td><b><u>City</b></u></td><td><b><u>State</b></u></td><td><b><u>Region</b></u></td><td><b><u>Submittals</b></u></td><td><b><u>Inquiry</b></u></td><td><b><u>RISSafe</b></u></td><td><b><u>CIS</b></u></td><td><b><u>Analytical</b></u></td><td><b><u>Forensics</b></u></td><td><b><u>Training</b></u></td><td><b><u>Conference</b></u></td><td><b><u>Equipment</b></u></td><td><b><u>Funds</b></u></td><td><b><u>Audio</b></u></td><td><b><u>Video</b></u></td><td><b><u>Totals</b></u></td></b></tr>";


        SqlConnection myConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["RissCenterDBConnectionString"].ConnectionString);
        SqlCommand myCmd = new SqlCommand("spSelectParticipationReport", myConn);
        myCmd.CommandType = CommandType.StoredProcedure;
        SqlParameter myParam = new SqlParameter();
        myParam = myCmd.Parameters.Add("@StartDate", SqlDbType.DateTime);
        myParam.Direction = ParameterDirection.Input;
        myParam.Value = Convert.ToDateTime(Request.QueryString["bd"]);
        myParam = myCmd.Parameters.Add("@EndDate", SqlDbType.DateTime);
        myParam.Direction = ParameterDirection.Input;
        myParam.Value = Convert.ToDateTime(Request.QueryString["ed"]);
        myParam = myCmd.Parameters.Add("@Region", SqlDbType.VarChar);
        myParam.Direction = ParameterDirection.Input;
        myParam.Value = Request.QueryString["fc"];
        myCmd.CommandTimeout = 240;

        SqlDataReader myRS;

        myConn.Open();

        myRS = myCmd.ExecuteReader();
        
        Int32 intTotal = 0;

        while (myRS.Read())
        {

            intTotal = Convert.ToInt32(myRS["Submittals"]) + Convert.ToInt32(myRS["Inquiry"]) + Convert.ToInt32(myRS["Operations"]) + Convert.ToInt32(myRS["CIS"]) + Convert.ToInt32(myRS["Analytical"]) + Convert.ToInt32(myRS["Forensics"]) + Convert.ToInt32(myRS["Training"]) + Convert.ToInt32(myRS["AnnualConference"]) + Convert.ToInt32(myRS["Equipment"]) + Convert.ToInt32(myRS["Funds"]) + Convert.ToInt32(myRS["Audio"]) + Convert.ToInt32(myRS["Video"]);
            strResult += "<tr><td>" + myRS["ag_ID"] + "</td><td>" + myRS["ag_Name"] + "</td><td>" + myRS["ag_City"] + "</td><td>" + myRS["ag_State"] + "</td><td>" + myRS["ag_Region"] + "</td><td>" + myRS["Submittals"] + "</td><td>" + myRS["Inquiry"] + "</td><td>" + myRS["Operations"] + "</td><td>" + myRS["CIS"] + "</td><td>" + myRS["Analytical"] + "</td><td>" + myRS["Forensics"] + "</td><td>" + myRS["Training"] + "</td><td>" + myRS["AnnualConference"] + "</td><td>" + myRS["Equipment"] + "</td><td>" + myRS["Funds"] + "</td><td>" + myRS["Audio"] + "</td><td>" + myRS["Video"] + "</td><td>" + intTotal + "</td></tr>";
            
        }

        myRS.Close();
        myConn.Close();
        
        //DataClassesDataContext myDB = new DataClassesDataContext();
        //var objRS = myDB.spSelectParticipationReport(Convert.ToDateTime(Request.QueryString["bd"]), Convert.ToDateTime(Request.QueryString["ed"]), Request.QueryString["fc"]);

        //foreach (spSelectActivityResult record in objRS)
        //{
           
        //}

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
