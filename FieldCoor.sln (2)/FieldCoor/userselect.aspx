<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>

<script runat="server">

protected void  cmdSubmit_Click(object sender, EventArgs e)
{
    if (rdAccess.SelectedValue == "fc")
    {
        Session["HomeDistrict"] = 02;
        Session["AccessLevel"] = 1;

        Response.Redirect("default.aspx");
    }
}
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1>Select Access Level</h1>
<table cellpadding="5" cellspacing="0" border="0">
    <tr>
        <td>
            <asp:RadioButtonList ID="rdAccess" runat="server">
                <asp:ListItem Text="Admin" Value="ad" Selected="True"></asp:ListItem>
                <asp:ListItem Text="Law Enforcement Coordinator" Value="fc"></asp:ListItem>
            </asp:RadioButtonList>
        </td>
    </tr>
    <tr>
        <td><asp:Button ID="cmdSubmit" Text="Submit" runat="server" 
                onclick="cmdSubmit_Click" /></td>
    </tr>
</table>
</asp:Content>

