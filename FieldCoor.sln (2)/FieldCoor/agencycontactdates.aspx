<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<% Response.ContentType = "application/vnd.ms-excel"; %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string strResult;
        strResult = "<table border=1 cellspacing=1 cellpadding=1><tr><td colspan=7 align=center><b>Agency Contact Dates";
        if (Request.QueryString["fc"] != "00")
        {
            strResult += " for Region " + Request.QueryString["fc"] + "</b></td></tr>";
        }
        else
        {
            strResult += "</b></td></tr>";
        }

        strResult += "<tr><td><b><u>Agency ID</b></u></td><td><b><u>Agency Name</b></u></td><td><b><u>Region</b></u></td><td><b><u>On Site</b></u></td><td><b><u>Phone</b></u></td><td><b><u>Not On Site</b></u></td><td><b><u>Attempted</b></u></td></tr>";


        SqlConnection myConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["RissCenterDBConnectionString"].ConnectionString);
        SqlCommand myCmd = new SqlCommand("spSelectAgencyContactDates", myConn);
        myCmd.CommandType = CommandType.StoredProcedure;
        SqlParameter myParam = new SqlParameter();
        myParam = myCmd.Parameters.Add("@Region", SqlDbType.VarChar);
        myParam.Direction = ParameterDirection.Input;
        myParam.Value = Request.QueryString["fc"];
        myCmd.CommandTimeout = 240;

        SqlDataReader myRS;

        myConn.Open();

        myRS = myCmd.ExecuteReader();
        
        while (myRS.Read())
        {
            strResult += "<tr><td align=left>" + myRS["ag_ID"] + "</td><td nowrap>" + myRS["agencynamestate"] + "</td><td>" + myRS["ag_Region"] + "</td><td>" + Convert.ToDateTime(myRS["onsite"]).ToString("MM/dd/yyyy") + "</td><td>" + Convert.ToDateTime(myRS["phone"]).ToString("MM/dd/yyyy") + "</td><td>" + Convert.ToDateTime(myRS["notonsite"]).ToString("MM/dd/yyyy") + "</td><td>" + Convert.ToDateTime(myRS["attempted"]).ToString("MM/dd/yyyy") + "</td></tr>";
        }

        myRS.Close();
        myConn.Close();

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
