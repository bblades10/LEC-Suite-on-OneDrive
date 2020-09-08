<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<% Response.ContentType = "application/vnd.ms-excel"; 
   Response.AddHeader ("Content-Disposition", "attachment; filename=stateusers.xls"); %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string strResult;
        strResult = "<table border=1 cellspacing=1 cellpadding=1><tr><td colspan=14 align=center><b>State users report for " + Request.QueryString["s"] + "</b></td></tr>";
        
        strResult += "<tr><td><b><u>Agency Name</b></u></td><td><b><u>Vetting Type</u></b></td><td><b><u>City</b></u></td><td><b><u>State</b></u></td><td><b><u>Title</b></u></td><td><b><u>Last Name</b></u></td><td><b><u>First Name</b></u></td><td><b><u>Mobile Phone</b></u></td><td><b><u>Work Phone</b></u></td><td><b><u>OTP by SMS</b></u></td><td><b><u>OTP by Voice</b></u></td><td><b><u>Work Email</b></u></td><td><b><u>RISSNET Email</b></u></td><td><b><u>OTP by Email</b></u></td><td><b><u>Create Date</b></u></td></tr>";


        SqlConnection myConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["RissCenterDBConnectionString"].ConnectionString);
        SqlCommand myCmd = new SqlCommand("spSelectStateUsers", myConn);
        myCmd.CommandType = CommandType.StoredProcedure;
        SqlParameter myParam = new SqlParameter();
        myParam = myCmd.Parameters.Add("@State", SqlDbType.VarChar);
        myParam.Direction = ParameterDirection.Input;
        myParam.Value = Request.QueryString["s"];
        myCmd.CommandTimeout = 180;

        SqlDataReader myRS;

        myConn.Open();

        myRS = myCmd.ExecuteReader();
        
        Int32 intTotal = 0;

        while (myRS.Read())
        {

            strResult += "<tr><td>" + myRS["Agency Name"] + "</td><td>" + myRS["Vetting Type"] + "</td><td>" + myRS["City"] + "</td><td>" + myRS["State"] + "</td><td>" + myRS["Title"] + "</td><td>" + myRS["Last Name"] + "</td><td>" + myRS["First Name"] + "</td><td>" + myRS["Mobile Phone"] + "</td><td>" + myRS["Work Phone"] + "</td><td>" + myRS["OTPBySMS"] + "</td><td>" + myRS["OTPByVoice"] + "</td><td>" + myRS["Work Email"] + "</td><td>" + myRS["RISSNET Email"] + "</td><td>" + myRS["OTPByEmail"] + "</td><td>" + myRS["CreateDate"] + "</td></tr>";
            
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
