<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>
<% @Import Namespace="System.Net.Mail" %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        lblEntryDate.Text = DateTime.Now.ToString("M/d/yyyy");
        if(Session["AccessLevel"].ToString() == "1")
        {
            Response.Redirect("appreapp.aspx");
        }
    }

    protected void dropState_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtAgencyName.Text = "";
        lblAgencyNumber.Text = "";
        dropAgencyName.Items.Clear();
        dropAgencyName.Items.Add(new ListItem("", ""));
        dropAgencyName.DataBind();
    }

    protected void dropAgencyName_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (dropAgencyName.SelectedValue != "")
        {
            DataClassesDataContext myDB = new DataClassesDataContext();
            var objRS = myDB.spSelectAgencyNumber(dropAgencyName.SelectedItem.Value).FirstOrDefault();

            txtAgencyName.Text = dropAgencyName.SelectedItem.Text;
            lblAgencyNumber.Text = dropAgencyName.SelectedItem.Value;
            dropDistrict.SelectedValue = objRS.ag_Region;
            dropState.SelectedValue = objRS.ag_State;
        }
        else
        {
            txtAgencyName.Text = "";
            lblAgencyNumber.Text = "";
        }

    }

    protected void cmdSave_Click(object sender, EventArgs e)
    {
        DataClassesDataContext myDB = new DataClassesDataContext();
        myDB.spInsertAppReappEntry(Convert.ToDateTime(lblEntryDate.Text), dropType.SelectedItem.Value, lblAgencyNumber.Text, dropState.SelectedItem.Value, txtAgencyName.Text, dropDistrict.SelectedItem.Value, rdlInterim.SelectedItem.Value, txtDateInterimStarted.Text, txtDateInterimRemoved.Text, rblLEC.SelectedItem.Value, rblCompleted.SelectedItem.Value, txtStatus.Text, Session["UserName"].ToString());

        string strBody = "";

        MailMessage objMM = new MailMessage();
        //objMM.To.Add("bblades@mocic.riss.net");
        objMM.To.Add("tlong@mocic.riss.net");
        objMM.To.Add("lterhune@mocic.riss.net");

        objMM.From = new MailAddress(Session["EMail"].ToString());
        objMM.CC.Add(Session["EMail"].ToString());

        if (dropType.SelectedItem.Value == "Suspension" || dropType.SelectedItem.Value == "Failure to Pay")
        {
            objMM.CC.Add("lecs@mocic.riss.net");
        }

        DataClassesDataContext myLEC = new DataClassesDataContext();
        var objRS = myDB.spSelectDistrictsLecInfo(dropDistrict.SelectedValue.ToString()).FirstOrDefault();

        objMM.CC.Add(objRS.EmailAddress);

        objMM.IsBodyHtml = false;
        objMM.Priority = MailPriority.Normal;
        objMM.Subject = "New Membership Transition Tracking Entry";

        strBody = "There has been a new membership transition tracking entry made.\r\n\r\nAgency Number: " + lblAgencyNumber.Text + "\r\n\r\nAgency Name: " + txtAgencyName.Text + "\r\n\r\nAgency State: " + dropState.SelectedItem.Value + "\r\n\r\nAgency District: " + dropDistrict.SelectedItem.Value + "\r\n\r\nAction Type: " + dropType.SelectedItem.Value + "\r\n\r\nStatus Update: " + txtStatus.Text;

        objMM.Body = strBody;
        SmtpClient mySmtpClient = new SmtpClient("mail.mocic2003.net");
        mySmtpClient.Timeout = int.MaxValue;
        mySmtpClient.Send(objMM);
        Response.Redirect("appreapp.aspx");
    }

    protected void cmdCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("appreapp.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Add Membership Transition Tracking Entry</h1>
    <asp:Panel ID="panPage" CssClass="left" runat="server">
        <table cellpadding="5" cellspacing="0" border="0">
            <tr>
                <td>
                    <asp:Label ID="lblMessage" CssClass="validation" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Entry Date: <asp:Label ID="lblEntryDate" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>Entry Type: <asp:dropdownlist id="dropType" runat="server">
                        <asp:ListItem text="" value="" />
                        <asp:ListItem text="Application" value="Application" />
                        <asp:ListItem text="Inactive" value="Inactive" />
                        <asp:ListItem text="Re-application" value="Re-application" />
                        <asp:ListItem text="Requested Application" value="Requested Application" />
                        <asp:ListItem text="Failure to Pay" value="Failure to Pay" />
                        <asp:ListItem text="Suspension" value="Suspension" />
                    </asp:dropdownlist>
                </td>
            </tr>
            <tr>
                <td>
                    Agency Number: <asp:Label ID="lblAgencyNumber" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>State:
                    <asp:DropDownList ID="dropState" runat="server" AutoPostBack="true" OnSelectedIndexChanged="dropState_SelectedIndexChanged">
                        <asp:ListItem Value="11" Text="" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="IA" Text="IA"></asp:ListItem>
                        <asp:ListItem Value="IL" Text="IL"></asp:ListItem>
                        <asp:ListItem Value="KS" Text="KS"></asp:ListItem>
                        <asp:ListItem Value="MB" Text="MB"></asp:ListItem>
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
                <td>
                    <asp:SqlDataSource ID="sqlAgnecyName" runat="server" ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" SelectCommand="spSelectAllAgencyNames" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="dropState" DefaultValue="11" Name="State" PropertyName="SelectedValue" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    Agency:
                    <asp:DropDownList ID="dropAgencyName" runat="server" DataSourceID="sqlAgnecyName" AppendDataBoundItems="true" DataTextField="ag_Name" AutoPostBack="true" DataValueField="ag_ID" OnSelectedIndexChanged="dropAgencyName_SelectedIndexChanged">
                        <asp:ListItem Value="" Selected="True"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    - or -
                </td>
            </tr>
            <tr>
                <td>
                    Agency Name: <asp:TextBox ID="txtAgencyName" runat="server" Columns="50"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" SelectCommand="spSelectDistricts" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    District: <asp:DropDownList ID="dropDistrict" runat="server" DataSourceID="SqlDataSource1" DataTextField="ag_Region" DataValueField="ag_Region"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    Interim: <asp:RadioButtonList ID="rdlInterim" RepeatDirection="Horizontal" RepeatLayout="Flow" runat="server">
                                <asp:ListItem Text="No" Value="No" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                             </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td>
                    Date Interim Started: <asp:TextBox ID="txtDateInterimStarted" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Date Interim Status Removed: <asp:TextBox ID="txtDateInterimRemoved" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Completed LEC Report: <asp:RadioButtonList ID="rblLEC" RepeatDirection="Horizontal" RepeatLayout="Flow" runat="server">
                                <asp:ListItem Text="No" Value="No" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                             </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td>
                    Completed: <asp:RadioButtonList ID="rblCompleted" RepeatDirection="Horizontal" RepeatLayout="Flow" runat="server">
                        <asp:ListItem Text="No" Value="No" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td>
                    Status:  <asp:TextBox id="txtStatus" TextMode="MultiLine" Columns="50" Rows="5" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="center">
                    <asp:Button ID="cmdSave" Text="Save" runat="server" OnClick="cmdSave_Click" />&nbsp;&nbsp;&nbsp;<asp:Button ID="cmdCancel" Text="Cancel" runat="server" OnClick="cmdCancel_Click"></asp:Button>
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>

