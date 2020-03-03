<%@ Page Language="C#" %>


<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string strResult = "<table cellpadding='2' cellspacing='0' border='0'><tr><td>";
        string strOfficerCodes = Request.QueryString["oc"];
        int pos = strOfficerCodes.IndexOf("A", 0);
        if (pos != -1)
        {
            strResult += "A = Alternate<br />";
        }
        pos = strOfficerCodes.IndexOf("B", 0);
        if (pos != -1)
        {
            strResult += "B = Digest Recipient<br />";
        }
        pos = strOfficerCodes.IndexOf("C", 0);
        if (pos != -1)
        {
            strResult += "C = RISS Center Staff<br />";
        }
        pos = strOfficerCodes.IndexOf("E", 0);
        if (pos != -1)
        {
            strResult += "E = Executive<br />";
        }
        pos = strOfficerCodes.IndexOf("H", 0);
        if (pos != -1)
        {
            strResult += "H = Admin. Head<br />";
        }
        pos = strOfficerCodes.IndexOf("M", 0);
        if (pos != -1)
        {
            strResult += "M = Board Member<br />";
        }
        pos = strOfficerCodes.IndexOf("P", 0);
        if (pos != -1)
        {
            strResult += "P = Phone User<br />";
        }
        pos = strOfficerCodes.IndexOf("R", 0);
        if (pos != -1)
        {
            strResult += "R = Representative<br />";
        }
        pos = strOfficerCodes.IndexOf("S", 0);
        if (pos != -1)
        {
            strResult += "S = SCC Form<br />";
        }
        pos = strOfficerCodes.IndexOf("U", 0);
        if (pos != -1)
        {
            strResult += "U = Remote User<br />";
        }
        strResult += "</td></tr></table>";
        divCodes.InnerHtml = strResult;
    }
</script>

<html>
<head runat="server">
    <title>Officer Codes</title>
</head>
<body>
    <form id="form1"  Method="Post" EncType="Multipart/Form-Data" runat="Server">
    <div id="divCodes" runat="server">
    
    </div>
    </form>
</body>
</html>
