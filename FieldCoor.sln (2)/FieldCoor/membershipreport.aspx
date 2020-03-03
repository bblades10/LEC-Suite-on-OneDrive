<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    protected void Button1_Click(object sender, EventArgs e)
    {
        int i;
        string strRegions;

        strRegions = "";

        for (i = 0; i < listRegion.Items.Count; i++)
        {
            if (listRegion.Items[i].Selected)
            {
                strRegions = strRegions + listRegion.Items[i].Value + ",";
            }
        }
        Response.Redirect("detailedregionreport.aspx?r=" + strRegions);
        //Response.Redirect("regionreport.aspx?r=" + strRegions);
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        int i;
        string strRegions;

        strRegions = "";

        for (i = 0; i < listRegion.Items.Count; i++)
        {
            if (listRegion.Items[i].Selected)
            {
                strRegions = strRegions + listRegion.Items[i].Value + ",";
            }
        }

        Response.Redirect("regionagencyselection.aspx?r=" + strRegions);
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        Response.Redirect("statereport.aspx?s=" + dropState.SelectedItem.Value);
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
                                <asp:ListBox ID="listRegion" runat="server" Height="200px" 
                                    SelectionMode="Multiple">
                                    <asp:ListItem Value="01">01</asp:ListItem>
                                    <asp:ListItem Value="02">02</asp:ListItem>
                                    <asp:ListItem Value="03">03</asp:ListItem>
                                    <asp:ListItem Value="04">04</asp:ListItem>
                                    <asp:ListItem Value="05">05</asp:ListItem>
                                    <asp:ListItem Value="06">06</asp:ListItem>
                                    <asp:ListItem Value="07">07</asp:ListItem>
                                    <asp:ListItem Value="08">08</asp:ListItem>
                                    <asp:ListItem Value="09">09</asp:ListItem>
                                    <asp:ListItem Value="10">10</asp:ListItem>
                                    <asp:ListItem Value="11">11</asp:ListItem>
                                    
                                </asp:ListBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                    ControlToValidate="listRegion" ErrorMessage="RequiredFieldValidator" 
                                    ForeColor="Red">*</asp:RequiredFieldValidator>
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
                                <asp:Button ID="Button1" runat="server" Text="View All Agencies in Region(s) Selected Above" onclick="Button1_Click" />
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
                                <asp:Button ID="Button2" runat="server" Text="Select Agencies from Region(s) Selected Above" onclick="Button2_Click" />
                            </td>
                        </tr>

                        <tr>
                            <td class="style1">
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>

                        <tr>
                            <td class="style1" align="right" valign="top">
                                State:</td>
                            <td>
                                <asp:DropDownList ID="dropState" runat="server">
                                    <asp:ListItem Value="IA">IA</asp:ListItem>
                                    <asp:ListItem Value="IL">IL</asp:ListItem>
                                    <asp:ListItem Value="KS">KS</asp:ListItem>
                                    <asp:ListItem Value="MB">MB</asp:ListItem>
                                    <asp:ListItem Value="MN">MN</asp:ListItem>
                                    <asp:ListItem Value="MO">MO</asp:ListItem>
                                    <asp:ListItem Value="NE">NE</asp:ListItem>
                                    <asp:ListItem Value="ND">ND</asp:ListItem>
                                    <asp:ListItem Value="SD">SD</asp:ListItem>
                                    <asp:ListItem Value="WI">WI</asp:ListItem>
                                </asp:DropDownList>
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
                                <asp:Button ID="Button3" runat="server" CausesValidation="false" Text="View State Directory" 
                                    onclick="Button3_Click" />
                            </td>
                        </tr>

                        
                    </table>
                </td>
                <td width="300" valign="top">To select more than one Region hold down the "CTRL" key and click on the Region you would like to include.</td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
