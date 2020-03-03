<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>

<script runat="server">
    protected void cmdState_Click(object sender, EventArgs e)
    {
        Response.Redirect("withoutcisopall.aspx?d=" + DropRegion.SelectedItem.Value.ToString() + "&s=" + dropState.SelectedItem.Value.ToString());
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1>Without CISOP Report Selection</h1>
<table cellpadding="10" cellspacing="0" border="0">
    <tr>
        <td>District: 
            <asp:SqlDataSource ID="SqlRegion" runat="server" 
                ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                SelectCommand="spSelectRegions" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:DropDownList ID="DropRegion" runat="server" DataSourceID="SqlRegion" 
                DataTextField="ag_Region" AppendDataBoundItems="true" DataValueField="ag_Region">
                <asp:ListItem Text="All" Value="00" Selected="True"></asp:ListItem>
            </asp:DropDownList>
        </td>    
    </tr>
    <tr>
        <td>State: <asp:DropDownList ID="dropState" runat="server">
                <asp:ListItem Value="**" Text="All"></asp:ListItem>
                <asp:ListItem Value="IA" Text="IA"></asp:ListItem>
                <asp:ListItem Value="IL" Text="IL"></asp:ListItem>
                <asp:ListItem Value="KS" Text="KS"></asp:ListItem>
                <asp:ListItem Value="MN" Text="MN"></asp:ListItem>
                <asp:ListItem Value="MO" Text="MO"></asp:ListItem>
                <asp:ListItem Value="NE" Text="NE"></asp:ListItem>
                <asp:ListItem Value="ND" Text="ND"></asp:ListItem>
                <asp:ListItem Value="SD" Text="SD"></asp:ListItem>
                <asp:ListItem Value="WI" Text="WI"></asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td class="center"><asp:Button ID="cmdState" Text="Go" runat="server" onclick="cmdState_Click" /></td>
    </tr>
</table>
</asp:Content>

