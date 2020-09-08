<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<% Response.ContentType = "application/vnd.ms-excel"; 
   Response.AddHeader ("Content-Disposition", "attachment; filename=excstatecommittee.xls"); %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string strResult;
        strResult = "<table border=1 cellspacing=1 cellpadding=1><tr><td colspan=22 align=center><b>Excutive Board/State Review Committee Members</td></tr>";
        strResult += "<tr><td><b><u>Last Name</b></u></td><td><b><u>Suffix</b></u></td><td><b><u>First Name</b></u></td><td><b><u>Title</b></u></td><td><b><u>Email</b></u></td><td><b><u>Agency Name</b></u></td><td><b><u>Work Address Line 1</b></u></td><td><b><u>Work Address Line 2</b></u></td><td><b><u>Work City</b></u></td><td><b><u>Work State</b></u></td><td><b><u>Work Zip</b></u></td><td><b><u>Home Address Line 1</b></u></td><td><b><u>Home Address Line 2</b></u></td><td><b><u>Home City</b></u></td><td><b><u>Home State</b></u></td><td><b><u>Home Zip</b></u></td><td><b><u>Voice Phone</u></b></td><td><b><u>Fax</u></b></td><td><b><u>Business Mobile</u></b></td><td><b><u>Personal Mobile</u></b></td><td><b><u>Spouse</u></b></td><td><b><u>Type</u></b></td></tr>";


        SqlConnection myConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["RissCenterDBConnectionString"].ConnectionString);
        SqlCommand myCmd = new SqlCommand("spSelectExcStateCommittee", myConn);
        myCmd.CommandType = CommandType.StoredProcedure;
        myCmd.CommandTimeout = 240;

        SqlDataReader myRS;

        myConn.Open();

        myRS = myCmd.ExecuteReader();
        
        while (myRS.Read())
        {

            strResult += "<tr><td>" + myRS["Last Name"] + "</td><td>" + myRS["Suffix"] + "</td><td>" + myRS["First Name"] + "</td><td>" + myRS["Title"] + "</td><td>" + myRS["Email"] + "</td><td>" + myRS["Agency Name"] + "</td><td>" + myRS["Work Address Line 1"] + "</td><td>" + myRS["Work Address Line 2"] + "</td><td>" + myRS["Work City"] + "</td><td>" + myRS["Work State"] + "</td><td>" + myRS["Work Zip"] + "</td><td>" + myRS["Home Address Line 1"] + "</td><td>" + myRS["Home Address Line 2"] + "</td><td>" + myRS["Home City"] + "</td><td>" + myRS["Home State"] + "</td><td>" + myRS["Home Zip"] + "</td><td>" + myRS["Voice Phone"] + "</td><td>" + myRS["Fax"] + "</td><td>" + myRS["Business Mobile"] + "</td><td>" + myRS["Personal Mobile"] + "</td><td>" + myRS["Spouse"] + "</td><td>" + myRS["Type"] + "</td></tr>";
            
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
