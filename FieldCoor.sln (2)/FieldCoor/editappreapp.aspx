<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>
<% @Import Namespace="System.Net.Mail" %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataClassesDataContext myDB = new DataClassesDataContext();
            var objRS = myDB.spSelectAppReapp(Convert.ToInt32(Request.QueryString["id"])).FirstOrDefault();

            lblEntryDate.Text = Convert.ToString(objRS.ChangeDate.Value.ToShortDateString());
            dropType.SelectedValue = objRS.Type;
            txtAgencyNumber.Text = objRS.AgencyNumber;
            dropState.SelectedValue = objRS.AgencyState;
            txtAgencyName.Text = objRS.AgencyName;
            dropDistrict.SelectedValue = objRS.District;
            rdlInterim.SelectedValue = objRS.Interim;
            txtDateInterimStarted.Text = objRS.InterimStartDate;
            txtDateInterimRemoved.Text = objRS.InterimDate;
            rblLEC.SelectedValue = objRS.app_fc_report;
            rblCompleted.SelectedValue = objRS.app_completed;

            if ((Convert.ToInt16(Session["AccessLevel"]) == 4) || (Convert.ToInt16(Session["AccessLevel"]) == 3))
            {
                cmdCancel.Visible = true;
                cmdSave.Visible = true;
            }
            else
            {
                cmdCancel.Visible = false;
                cmdSave.Visible = false;
            }

            divAddStatus.Visible = false;
        }
    }

    protected void cmdSave_Click(object sender, EventArgs e)
    {
        DataClassesDataContext myDB = new DataClassesDataContext();
        myDB.spUpdateAppReappEntry(Convert.ToInt32(Request.QueryString["id"]), dropType.SelectedItem.Text, txtAgencyNumber.Text, dropState.SelectedItem.Text, txtAgencyName.Text, dropDistrict.SelectedItem.Text, rdlInterim.SelectedItem.Text, txtDateInterimStarted.Text, txtDateInterimRemoved.Text, rblLEC.SelectedItem.Text, rblCompleted.SelectedItem.Text);

        lblMessage.Text = "Record has been updated.";

    }



    protected void cmdCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("appreapp.aspx");
    }

    protected void cmdAddStatus_Click(object sender, EventArgs e)
    {
        divAddStatus.Visible = true;
        cmdAddStatus.Visible = false;
    }

    protected void cmdAdd_Click(object sender, EventArgs e)
    {
        DataClassesDataContext myDB = new DataClassesDataContext();
        myDB.spInsertAppReappStatus(Convert.ToInt32(Request.QueryString["id"]), txtStatus.Text, Session["UserName"].ToString());

        divAddStatus.Visible = false;
        cmdAddStatus.Visible = true;
        GridStatus.DataBind();

        string strBody = "";

        MailMessage objMM = new MailMessage();
        //objMM.To.Add("bblades@mocic.riss.net");
        objMM.To.Add("tlong@mocic.riss.net");
        objMM.To.Add("lterhune@mocic.riss.net");

        objMM.From = new MailAddress(Session["EMail"].ToString());
        objMM.CC.Add(Session["EMail"].ToString());

        //if (dropType.SelectedItem.Value == "Suspension" || dropType.SelectedItem.Value == "Failure to Pay")
        //{
        //    objMM.CC.Add("lecs@mocic.riss.net");
        //}

        DataClassesDataContext myLEC = new DataClassesDataContext();
        var objRS = myDB.spSelectDistrictsLecInfo(dropDistrict.SelectedValue.ToString()).FirstOrDefault();

        objMM.CC.Add(objRS.EmailAddress);

        //if (dropDistrict.SelectedValue == "01")
        //{
        //    objMM.CC.Add("sbritton@mocic.riss.net");
        //}

        objMM.IsBodyHtml = false;
        objMM.Priority = MailPriority.Normal;
        objMM.Subject = "Membership Transition Tracking Update";

        strBody = "There has been an status update to a membership transition tracking entry.\r\n\r\nAgency Number: " + txtAgencyNumber.Text + "\r\n\r\nAgency Name: " + txtAgencyName.Text + "\r\n\r\nAgency State: " + dropState.SelectedItem.Value + "\r\n\r\nAgency District: " + dropDistrict.SelectedItem.Value + "\r\n\r\nAction Type: " + dropType.SelectedItem.Value + "\r\n\r\nLEC Report Completed: " + rblLEC.SelectedItem.Text + "\r\n\r\nInterim Agreement: " + rdlInterim.SelectedItem.Text + "\r\n\r\nCompleted:  " + rblCompleted.SelectedItem.Text + "\r\n\r\nStatus:  " + txtStatus.Text;

        objMM.Body = strBody;
        SmtpClient mySmtpClient = new SmtpClient("rpe.riss.net");
        mySmtpClient.Timeout = int.MaxValue;
        mySmtpClient.Send(objMM);
    }

    protected void cmdCancelStatus_Click(object sender, EventArgs e)
    {
        divAddStatus.Visible = false;
        cmdAddStatus.Visible = true;
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Edit Membership Transition Tracking Entry</h1>
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
                    Agency Number: <asp:Textbox ID="txtAgencyNumber" runat="server"></asp:Textbox>
                </td>
            </tr>
            <tr>
                <td>State:
                    <asp:DropDownList ID="dropState" runat="server" >
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
                <td class="center">
                    <asp:Button ID="cmdSave" Text="Save" runat="server" OnClick="cmdSave_Click" style="height: 26px" />&nbsp;&nbsp;&nbsp;<asp:Button ID="cmdCancel" Text="Cancel" runat="server" OnClick="cmdCancel_Click"></asp:Button>
                </td>
            </tr>
        </table>
        <p><img src="images/bar.jpg" height="3" width="800" /></p>
        <div id="divAddStatus" runat="server">
            <p>Status: <asp:TextBox id="txtStatus" TextMode="MultiLine" Columns="50" Rows="5" runat="server"></asp:TextBox></p>
            <p><asp:Button ID="cmdAdd" Text="Add" runat="server" OnClick="cmdAdd_Click" />&nbsp;&nbsp;&nbsp;<asp:Button ID="cmdCancelStatus" Text="Cancel" runat="server" OnClick="cmdCancelStatus_Click" /></p>
        </div>
        <div id="divStatus" runat="server">
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" SelectCommand="spSelectAppReappStatus" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter Name="ID" QueryStringField="id" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Button ID="cmdAddStatus" Text="Add Status Update" CssClass="buttonlink" runat="server" OnClick="cmdAddStatus_Click" />
            <asp:GridView ID="GridStatus" ForeColor="#333333" runat="server" GridLines="None" CellPadding="5" AutoGenerateColumns="False" DataSourceID="SqlDataSource2">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="app_status_key" HeaderText="app_status_key" Visible="false" InsertVisible="False" ReadOnly="True" SortExpression="app_status_key" />
                    <asp:BoundField DataField="app_status_date" HeaderText="Date" SortExpression="app_status_date" DataFormatString="{0:d}" />
                    <asp:BoundField DataField="app_entered_by" HeaderText="Entered By" SortExpression="app_entered_by" />
                    <asp:BoundField DataField="app_status" HeaderText="Status" SortExpression="app_status" />
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#234e6c" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#234e6c" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
        </div>

    </asp:Panel>

</asp:Content>

