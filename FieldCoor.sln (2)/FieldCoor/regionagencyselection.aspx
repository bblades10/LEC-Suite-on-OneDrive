<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    protected void Button1_Click(object sender, EventArgs e)
    {
        int i;
        string strRegions;
        strRegions = "";

        for (i = 0; i < ListBox1.Items.Count; i++)
        {
            if (ListBox1.Items[i].Selected)
            {
                strRegions = strRegions + ListBox1.Items[i].Value + ",";
            }
        }

        Response.Redirect("selecteddetailedregionreport.aspx?r=" + strRegions);
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <td colspan="3" align="center"><font size="16"><b>Membership Directory</b></font></td>
            </tr>
            <tr>
                <td class="style1">
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td><img src="images/spacer.gif" width="50" /></td>
                <td>
                    <table width="200">
                        <tr>
                            <td class="style1" align="right" valign="top">
                                Region:</td>
                            <td>
                                <asp:ListBox ID="ListBox1" runat="server" DataSourceID="SqlDataSource1" 
                                        DataTextField="AgencyNameState" DataValueField="ag_key" Height="400px" 
                                    SelectionMode="Multiple"></asp:ListBox>
                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:RissCenterDBConnectionString %>" 
                                        SelectCommand="spSelectAgenciesByRegion" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:QueryStringParameter Name="ag_Region" QueryStringField="r" Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td class="style1">
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="style1">
                                &nbsp;</td>
                            <td>
                                <asp:Button ID="Button1" runat="server" Text="Create Report" onclick="Button1_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>