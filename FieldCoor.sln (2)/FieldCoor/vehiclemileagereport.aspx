﻿<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<% Response.ContentType = "application/vnd.ms-excel"; 
   Response.AddHeader ("Content-Disposition", "attachment; filename=mileage.xls"); %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string strResult;
        strResult = "<table border=1 cellspacing=1 cellpadding=1><tr>";

        SqlConnection myConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["FieldCoorSuiteConnectionString"].ConnectionString);
        SqlCommand myCmd = new SqlCommand("spSelectVehicleMileageReport", myConn);
        myCmd.CommandType = CommandType.StoredProcedure;
        SqlParameter myParam = new SqlParameter();
        myParam = myCmd.Parameters.Add("@StartDate", SqlDbType.DateTime);
        myParam.Direction = ParameterDirection.Input;
        myParam.Value = Request.QueryString["bd"];
        myParam = myCmd.Parameters.Add("@EndDate", SqlDbType.DateTime);
        myParam.Direction = ParameterDirection.Input;
        myParam.Value = Request.QueryString["ed"];
        myParam = myCmd.Parameters.Add("@EmpID", SqlDbType.Int);
        myParam.Direction = ParameterDirection.Input;
        myParam.Value = 0;

        SqlDataReader myRS;

        myConn.Open();

        myRS = myCmd.ExecuteReader();
        
        string[] arName = new string[20];
        DateTime[] arDate = new DateTime[20];
        string[] arMileage = new string[20];
        int intCounter;
        intCounter = 0;

        while (myRS.Read())
        {

            intCounter += 1;
            arName[intCounter] = myRS["temp_vm_LastName"].ToString();
            arDate[intCounter] =  Convert.ToDateTime(myRS["temp_vm_DateEntered"]);
            arMileage[intCounter] = myRS["temp_vm_Mileage"].ToString();

        }
        
        myRS.Close();
        myConn.Close();

        intCounter += 1;

        for (int i = 1; i < intCounter; i++)
        {
            strResult += "<td>" + arName[i] + "</td>";
        }

        strResult += "</tr>";

        for (int j = 1; j < intCounter; j++)
        {
            strResult += "<td>" + arDate[j] + "</td>";
        }

        strResult += "</tr>";

        for (int k = 1; k < intCounter; k++)
        {
            strResult += "<td>" + arMileage[k] + "</td>";
        }
        
        strResult += "</tr></table>";

        divResult.InnerHtml = strResult;
    }
    
</script>

<html>
<head runat="server">
    <title></title>
</head>
<body>
    <div id="divResult" runat="server"></div>
</body>
</html>
