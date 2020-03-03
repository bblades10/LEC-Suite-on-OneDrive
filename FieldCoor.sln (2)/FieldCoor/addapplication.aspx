<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<script runat="server">
    
    protected void dropOfficer_OnChange(object sender, EventArgs e)
    {
        DataClassesDataContext myDB = new DataClassesDataContext();
        var objRS = myDB.spSelectOfficerInfo(Convert.ToInt32(dropOfficer.SelectedItem.Value));

        foreach (spSelectOfficerInfoResult record in objRS)
        {
            txtHeadTitle.Text = record.of_Title;
            txtFirstName.Text = record.of_FirstName;
            txtLastName.Text = record.of_LastName;
            txtMI.Text = record.of_MiddleName.Substring(0, 1);
            break;
        }
    }
    
    protected void dropAgency_SelectedIndexChanged(object sender, EventArgs e)
    {
        dropOfficer.DataBind();
        dropOfficer.Items.Insert(0, new ListItem(String.Empty, String.Empty));
        dropOfficer.SelectedIndex = 0;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            dropAgency.DataBind();
            dropAgency.Items.Insert(0, new ListItem(String.Empty, "0"));
            dropAgency.SelectedIndex = 0;

            if (Request.QueryString["id"] != "")
            {
                DataClassesDataContext myDB = new DataClassesDataContext();
                var objRS = myDB.spSelectApplication(Convert.ToInt32(Request.QueryString["id"]));
                foreach (spSelectApplicationResult record in objRS)
                {
                    txtDate.Text = Convert.ToString(record.FCS_app_Date.Value.ToShortDateString());
                    dropType.SelectedValue = record.FCS_app_Type;
                    dropAgency.SelectedValue = record.FCS_app_agKey.ToString();
                    dropOfficer.DataBind();
                    txtAgencyName.Text = record.FCS_app_Agency_Name;
                    dropAgencyState.SelectedValue = record.FCS_app_State;
                    txtHeadTitle.Text = record.FCS_app_Admin_Title;
                    txtFirstName.Text = record.FCS_app_Admin_First_Name;
                    txtLastName.Text = record.FCS_app_Admin_Last_Name;
                    txtMI.Text = record.FCS_app_Admin_MI;
                    dropTempAccess.SelectedValue = record.FCS_app_Temp_Access;
                    txtReason.Text = record.FCS_app_Reason;
                    txtCaseNumber.Text = record.FCS_app_Case_Num;
                    txtPopulation.Text = record.FCS_app_Population;
                    txtSworn.Text = record.FCS_app_Sworn;
                    txtNonSworn.Text = record.FCS_app_Non_Sworn;
                    dropIntel.SelectedValue = record.FCS_app_Intel;
                    dropFilesMaintained.SelectedValue = record.FCS_app_Maintain_Intel;
                    dropFilesSecure.SelectedValue = record.FCS_app_Intel_Secured;
                    dropFilesSeparated.SelectedValue = record.FCS_app_Intel_Separated;
                    dropFileAccessLimited.SelectedValue = record.FCS_app_Intel_Access_Limited;
                    dropParticipation.SelectedValue = record.FCS_app_Participation;
                    txtSource.Text = record.FCS_app_Source;
                    dropAgencyCooperation.SelectedValue = record.FCS_app_Cooprative;
                    txtSubmissions.Text = record.FCS_app_Submissions;
                    txtInquiries.Text = record.FCS_app_Inquiries;
                    dropAgencyReputation.SelectedValue = record.FCS_app_Reputation;
                    dropAgencyHeadReputation.SelectedValue = record.FCS_app_Admin_Reputation;
                    dropKnowAgency.SelectedValue = record.FCS_app_Know_Agency;
                    dropKnowAgencyHead.SelectedValue = record.FCS_app_Know_Agency_Head;
                    chkComplete.Checked = Convert.ToBoolean(record.FCS_app_Completed);

                    cmdSave.Text = "Update";

                    break;
                }
            }
            
            if (cmdSave.Text == "Save")
            {
                panAgencyContacts.Visible = false;
            }
        }
    }

    protected void cmdCancel_OnClick(object sender, EventArgs e)
    {
        Response.Redirect("default.aspx");
    }

    protected void cmdSave_OnClick(object sender, EventArgs e)
    {
        if (dropAgency.SelectedItem.Value == "0" & txtAgencyName.Text == "")
        {
            lblMessage.Text = "You must either select an agency from the list of type in the agency name.";
        }
        else
        {
            Nullable<int> intAppID = null;
            
            DataClassesDataContext myDB = new DataClassesDataContext();
            myDB.spInsertApplication( Convert.ToDateTime(txtDate.Text), dropType.SelectedItem.Value.ToString(), Convert.ToInt32(dropAgency.SelectedItem.Value), txtAgencyName.Text, dropAgencyState.SelectedItem.Value.ToString(), dropTempAccess.SelectedItem.Value.ToString(), txtReason.Text, txtCaseNumber.Text, txtHeadTitle.Text, txtLastName.Text, txtFirstName.Text, txtMI.Text, txtPopulation.Text, txtSworn.Text, txtNonSworn.Text, dropIntel.SelectedItem.Value.ToString(), dropFilesMaintained.SelectedItem.Value.ToString(), dropFilesSecure.SelectedItem.Value.ToString(), dropFilesSeparated.SelectedItem.Value.ToString(), dropFileAccessLimited.SelectedItem.Value.ToString(), dropParticipation.SelectedItem.Value.ToString(), txtSource.Text, txtSubmissions.Text, txtInquiries.Text, dropAgencyReputation.SelectedItem.Value.ToString(), dropAgencyHeadReputation.SelectedItem.Value.ToString(), dropKnowAgency.SelectedItem.Value.ToString(), dropKnowAgencyHead.SelectedItem.Value.ToString(), dropAgencyCooperation.SelectedItem.Value.ToString(), "", chkComplete.Checked, Convert.ToInt32(Session["EmpID"]), ref intAppID);

            Response.Redirect("addapplication.aspx?id=" + intAppID);
        }
    }

    protected void cmdAddSupportLetter_Click(object sender, EventArgs e)
    {
        Response.Redirect("addappcontact.aspx?id=" + Request.QueryString["id"] + "&type=1");
    }


    protected void gridSupportLetter_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "MyDelete")
        {
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            string val = this.gridSupportLetter.DataKeys[rowIndex].Values["FCS_cm_ID"].ToString();

            DataClassesDataContext myDB = new DataClassesDataContext();
            myDB.spDeleteContactedMember(Convert.ToInt32(Session["EmpID"]), Convert.ToInt32(val));

            gridSupportLetter.DataBind();
        }
    }

    protected void gridStateMember_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "MyDelete")
        {
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            string val = this.gridStateMember.DataKeys[rowIndex].Values["FCS_cm_ID"].ToString();

            DataClassesDataContext myDB = new DataClassesDataContext();
            myDB.spDeleteContactedMember(Convert.ToInt32(Session["EmpID"]), Convert.ToInt32(val));

            gridStateMember.DataBind();
        }
    }

    protected void gridSurroundingMember_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "MyDelete")
        {
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            string val = this.gridSurroundingMember.DataKeys[rowIndex].Values["FCS_cm_ID"].ToString();

            DataClassesDataContext myDB = new DataClassesDataContext();
            myDB.spDeleteContactedMember(Convert.ToInt32(Session["EmpID"]), Convert.ToInt32(val));

            gridSurroundingMember.DataBind();
        }
    }

    protected void gridOther_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "MyDelete")
        {
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            string val = this.gridOther.DataKeys[rowIndex].Values["FCS_coa_ID"].ToString();

            DataClassesDataContext myDB = new DataClassesDataContext();
            myDB.spDeleteOtherAgency(Convert.ToInt32(Session["EmpID"]), Convert.ToInt32(val));

            gridOther.DataBind();
        }
    }

    protected void cmdAddStateMember_Click(object sender, EventArgs e)
    {
        Response.Redirect("addappcontact.aspx?id=" + Request.QueryString["id"] + "&type=2");
    }

    protected void cmdAddSurroundingMember_Click(object sender, EventArgs e)
    {
        Response.Redirect("addappcontact.aspx?id=" + Request.QueryString["id"] + "&type=3");
    }

    protected void cmdAddOther_Click(object sender, EventArgs e)
    {
        Response.Redirect("addappcontact.aspx?id=" + Request.QueryString["id"] + "&type=4");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Add Application/Reapplication</h1>
    <asp:Panel ID="panPage" CssClass="left" runat="server">
        <table cellpadding="5" cellspacing="0" border="0">
            <tr>
                <td>
                    <font color="red">
                        <asp:Label ID="lblMessage" runat="server"></asp:Label></font>
                </td>
            </tr>
            <tr>
                <td class="center">
                    <i>
                        <asp:ValidationSummary ID="valSum" runat="server" HeaderText="Please complete all required fields!"
                            DisplayMode="SingleParagraph" CssClass="validation" Font-Size="12px" />
                    </i>
                </td>
            </tr>
            <tr>
                <td>
                    Type:
                    <asp:DropDownList ID="dropType" runat="server">
                        <asp:ListItem Value="Application" Text="Application"></asp:ListItem>
                        <asp:ListItem Value="Reapplication" Text="Reapplication"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    Date:
                    <asp:TextBox ID="txtDate" Columns="10" MaxLength="10" runat="server" />
                    <asp:CalendarExtender ID="CalendarExtender1" TargetControlID="txtDate" PopupButtonID="cal"
                        runat="server">
                    </asp:CalendarExtender>
                    <asp:ImageButton ImageUrl="images/Calendar_scheduleHS.png" ID="cal" CausesValidation="false" runat="server" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtDate"
                        CssClass="validation" Text="*" runat="Server" /><asp:RegularExpressionValidator
                                                ID="RegularExpressionValidator6" runat="server" CssClass="validation" ErrorMessage="MM/DD/YYYY" ValidationExpression="\d{1,2}\/\d{1,2}/\d{4}"
                                                ControlToValidate="txtDate" />
                </td>
            </tr>
            <tr>
                <td>
                    <br />Agency:
                    <asp:DropDownList ID="dropAgency" runat="server" DataSourceID="SqlDataSource2" DataTextField="AgencyName"
                        DataValueField="ag_Key" AutoPostBack="true"
                        onselectedindexchanged="dropAgency_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>"
                        SelectCommand="spSelectAgencies" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:SessionParameter DefaultValue="00" Name="District" SessionField="District" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td> - OR - </td>
            </tr>
            <tr>
                <td>
                    Agency Name: <asp:TextBox ID="txtAgencyName" Columns="40" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Agency State: <asp:DropDownList ID="dropAgencyState" runat="server">
                            <asp:ListItem Value="" Text=""></asp:ListItem>
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
                    <br />Admin. Head:
                        <asp:SqlDataSource ID="sqlOfficer" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                            SelectCommand="spSelectAgencyOfficersWithSCC" 
                            SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="dropAgency" Name="ag_Key" 
                                    PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:DropDownList ID="dropOfficer" runat="server" DataSourceID="sqlOfficer" 
                            DataTextField="FullName" DataValueField="of_Key" AutoPostBack="true" OnSelectedIndexChanged="dropOfficer_OnChange">
                        </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td> - OR - </td>
            </tr>
            <tr>
                <td>
                    Admin. Head Title: <asp:TextBox ID="txtHeadTitle" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Admin. First Name: <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Admin. Last Name: <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Admin. MI: <asp:TextBox ID="txtMI" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <img src="images/spacer.gif" height="7" />
                </td>
            </tr>
            <tr>
                <td>
                    <img src="images/bar.jpg" height="3" width="800" />
                </td>
            </tr>
            <tr>
                <td>
                    <img src="images/spacer.gif" height="7" />
                </td>
            </tr>
            <tr>
                <td>Request Temp Access: 
                    <asp:DropDownList ID="dropTempAccess" runat="server">
                        <asp:ListItem Value="" Text=""></asp:ListItem>
                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    Reason for Request:<br /> <asp:TextBox ID="txtReason" TextMode="MultiLine" Columns="40" Rows="5" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Case Number: <asp:TextBox ID="txtCaseNumber" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <img src="images/spacer.gif" height="7" />
                </td>
            </tr>
            <tr>
                <td>
                    <img src="images/bar.jpg" height="3" width="800" />
                </td>
            </tr>
            <tr>
                <td>
                    <img src="images/spacer.gif" height="7" />
                </td>
            </tr>
            <tr>
                <td>
                    <table cellpadding="4" cellspacing="0" border="0">
                        <tr>
                            <td>
                                Area Population: <asp:TextBox ID="txtPopulation" Columns="10" runat="server"></asp:TextBox>
                            </td>
                            <td><img src="images/spacer.gif" width="30" height="0" /></td>
                            <td>
                                Sworn Personnel: <asp:TextBox ID="txtSworn" Columns="10" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Non-Sworn Personnel: <asp:TextBox ID="txtNonSworn" Columns="10" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                Has Intel. Unit: <asp:DropDownList ID="dropIntel" runat="server">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <img src="images/spacer.gif" width="30" height="0" />
                            </td>
                            <td>
                                Maintain Intel. Files: <asp:DropDownList ID="dropFilesMaintained" runat="server">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Intel Files Secure: <asp:DropDownList ID="dropFilesSecure" runat="server">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <img src="images/spacer.gif" width="30" height="0" />
                            </td>
                            <td>
                                Intel. Files Separated: <asp:DropDownList ID="dropFilesSeparated" runat="server">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Intel. File Access Limited: <asp:DropDownList ID="dropFileAccessLimited" runat="server">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <img src="images/spacer.gif" width="30" height="0" />
                            </td>
                            <td>
                                MOCIC Participation: <asp:DropDownList ID="dropParticipation" runat="server">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                    <asp:ListItem Value="Excellent" Text="Excellent"></asp:ListItem>
                                    <asp:ListItem Value="Good" Text="Good"></asp:ListItem>
                                    <asp:ListItem Value="Average" Text="Average"></asp:ListItem>
                                    <asp:ListItem Value="Poor" Text="Poor"></asp:ListItem>
                                    <asp:ListItem Value="N/A" Text="N/A"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Source: <asp:TextBox ID="txtSource" Columns="10" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                <img src="images/spacer.gif" width="30" height="0" />
                            </td>
                            <td>
                                Agency Cooperation: 
                                <asp:DropDownList ID="dropAgencyCooperation" runat="server">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Submissions: <asp:TextBox ID="txtSubmissions" Columns="10" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                <img src="images/spacer.gif" width="30" height="0" />
                            </td>
                            <td>
                                Inquiries: <asp:TextBox ID="txtInquiries" Columns="10" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Agency Reputation: <asp:DropDownList ID="dropAgencyReputation" runat="server">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                    <asp:ListItem Value="Excellent" Text="Excellent"></asp:ListItem>
                                    <asp:ListItem Value="Good" Text="Good"></asp:ListItem>
                                    <asp:ListItem Value="Average" Text="Average"></asp:ListItem>
                                    <asp:ListItem Value="Poor" Text="Poor"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <img src="images/spacer.gif" width="30" height="0" />
                            </td>
                            <td>
                                Agency Head Reputation: <asp:DropDownList ID="dropAgencyHeadReputation" runat="server">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                    <asp:ListItem Value="Excellent" Text="Excellent"></asp:ListItem>
                                    <asp:ListItem Value="Good" Text="Good"></asp:ListItem>
                                    <asp:ListItem Value="Average" Text="Average"></asp:ListItem>
                                    <asp:ListItem Value="Poor" Text="Poor"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>I Know Agency: 
                                <asp:DropDownList ID="dropKnowAgency" runat="server">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <img src="images/spacer.gif" width="30" height="0" />
                            </td>
                            <td>
                                I Know Agency Head: 
                                <asp:DropDownList ID="dropKnowAgencyHead" runat="server">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <br /><asp:CheckBox ID="chkComplete" Text="This app/reapp is complete." runat="server" />
                </td>
            </tr>
            <caption>
                <br />
                <tr>
                    <td class="center">
                        <asp:Button ID="cmdSave" runat="server" OnClick="cmdSave_OnClick" Text="Save" />
                        <img src="images/spacer.gif" width="30" height="0" />
                        <asp:Button ID="cmdCancel" runat="server" OnClick="cmdCancel_OnClick" 
                            Text="Cancel" />
                    </td>
                </tr>
            </caption>
            </tr>
            <tr>
                <td><img src="images/spacer.gif" width="0" height="50" /></td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="panAgencyContacts" CssClass="left" runat="server">
        <table cellpadding="5" cellspacing="0" border="0">
            <tr>
                <td>
                    <img src="images/spacer.gif" height="7" />
                </td>
            </tr>
            <tr>
                <td>
                    <img src="images/bar.jpg" height="3" width="800" />
                </td>
            </tr>
            <tr>
                <td>
                    <img src="images/spacer.gif" height="7" />
                </td>
            </tr>
            <tr>
                <td class="center">
                    Support Letters<br /><br />
                    <asp:SqlDataSource ID="sqlSupportLetter" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                        SelectCommand="spSelectSponsoredLetters" SelectCommandType="StoredProcedure" >
                        <SelectParameters>
                            <asp:QueryStringParameter Name="ID" QueryStringField="id" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:GridView ID="gridSupportLetter" runat="server" AutoGenerateColumns="False" HorizontalAlign="Center"
                        EmptyDataText="No data available." OnRowCommand="gridSupportLetter_RowCommand" 
                        CellPadding="4" ForeColor="#333333" GridLines="None" DataKeyNames="FCS_cm_ID"
                        DataSourceID="sqlSupportLetter">
                        <Columns>
                            <asp:BoundField DataField="FCS_cm_ID" HeaderText="FCS_cm_ID" 
                                InsertVisible="False" ReadOnly="True" SortExpression="FCS_cm_ID" 
                                Visible="False" />
                            <asp:BoundField DataField="FCS_cm_Contact_Type" 
                                HeaderText="FCS_cm_Contact_Type" SortExpression="FCS_cm_Contact_Type" 
                                Visible="False" />
                            <asp:BoundField DataField="FCS_ct_Type" HeaderText="FCS_ct_Type" 
                                SortExpression="FCS_ct_Type" Visible="False" />
                            <asp:BoundField DataField="FCS_cm_agKey" HeaderText="FCS_cm_agKey" 
                                SortExpression="FCS_cm_agKey" Visible="False" />
                            <asp:BoundField DataField="ag_Name" HeaderText="Agency Name" 
                                SortExpression="ag_Name" />
                            <asp:BoundField DataField="FCS_cm_Name" HeaderText="Contact" 
                                SortExpression="FCS_cm_Name" />
                            <asp:BoundField DataField="FCS_cm_Date" DataFormatString="{0:d}" 
                                HeaderText="Date" SortExpression="FCS_cm_Date" />
                            <asp:BoundField DataField="FCS_cm_Date_Entered" 
                                HeaderText="FCS_cm_Date_Entered" SortExpression="FCS_cm_Date_Entered" 
                                Visible="False" />
                            <asp:TemplateField><ItemTemplate>
                                <asp:imageButton ID="cmdDeleteSupportLetter" runat="server" ImageUrl="~/images/redxgrey.gif" OnClientClick="return confirm('Are you sure you want to delete this record?');" CommandName="MyDelete" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"></asp:imageButton>
                            </ItemTemplate></asp:TemplateField>
                        </Columns>
                        <EditRowStyle BackColor="#999999" />
                        <FooterStyle BackColor="#234e6c" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#234e6c" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#234e6c" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                    </asp:GridView>
                    <br /><br />
                    <asp:Button ID="cmdAddSupportLetter" Text="Add Letter" runat="server" OnClick="cmdAddSupportLetter_Click" />
                </td>
            </tr>
            <tr>
                <td>
                    <img src="images/spacer.gif" height="7" />
                </td>
            </tr>
            <tr>
                <td>
                    <img src="images/bar.jpg" height="3" width="800" />
                </td>
            </tr>
            <tr>
                <td>
                    <img src="images/spacer.gif" height="7" />
                </td>
            </tr>
            <tr>
                <td class="center">
                    Contacted State Member Agencies<br /><br />
                    <asp:SqlDataSource ID="sqlStateMember" runat="server"
                    ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                        SelectCommand="spSelectContactedStateAgencies" 
                        SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="ID" QueryStringField="id" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:GridView ID="gridStateMember" runat="server"  HorizontalAlign="Center"
                    EmptyDataText="No data available." OnRowCommand="gridStateMember_RowCommand" 
                        CellPadding="4" ForeColor="#333333" GridLines="None"
                    DataSourceID="sqlStateMember" AutoGenerateColumns="False">
                    <Columns>
                            <asp:BoundField DataField="FCS_cm_ID" HeaderText="FCS_cm_ID" 
                                InsertVisible="False" ReadOnly="True" SortExpression="FCS_cm_ID" 
                                Visible="False" />
                            <asp:BoundField DataField="FCS_cm_Contact_Type" 
                                HeaderText="FCS_cm_Contact_Type" SortExpression="FCS_cm_Contact_Type" 
                                Visible="False" />
                            <asp:BoundField DataField="FCS_ct_Type" HeaderText="FCS_ct_Type" 
                                SortExpression="FCS_ct_Type" Visible="False" />
                            <asp:BoundField DataField="FCS_cm_agKey" HeaderText="FCS_cm_agKey" 
                                SortExpression="FCS_cm_agKey" Visible="False" />
                            <asp:BoundField DataField="ag_Name" HeaderText="Agency Name" 
                                SortExpression="ag_Name" />
                            <asp:BoundField DataField="FCS_cm_Name" HeaderText="Contact Name" 
                                SortExpression="FCS_cm_Name" />
                            <asp:BoundField DataField="FCS_cm_Date" DataFormatString="{0:d}" 
                                HeaderText="Date" SortExpression="FCS_cm_Date" />
                            <asp:BoundField DataField="FCS_cm_Date_Entered" 
                                HeaderText="FCS_cm_Date_Entered" SortExpression="FCS_cm_Date_Entered" 
                                Visible="False" />
                            <asp:TemplateField><ItemTemplate>
                                <asp:imageButton ID="cmdDeleteStateMember" runat="server" ImageUrl="~/images/redxgrey.gif" OnClientClick="return confirm('Are you sure you want to delete this record?');" CommandName="MyDelete" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"></asp:imageButton>
                            </ItemTemplate></asp:TemplateField>
                        </Columns>
                        <EditRowStyle BackColor="#999999" />
                        <FooterStyle BackColor="#234e6c" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#234e6c" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#234e6c" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                    </asp:GridView>
                    <br /><br />
                    <asp:Button ID="cmdAddStateMember" Text="Add State Member" runat="server" OnClick="cmdAddStateMember_Click" />
                </td>
            </tr>
            <tr>
                <td>
                    <img src="images/spacer.gif" height="7" />
                </td>
            </tr>
            <tr>
                <td>
                    <img src="images/bar.jpg" height="3" width="800" />
                </td>
            </tr>
            <tr>
                <td>
                    <img src="images/spacer.gif" height="7" />
                </td>
            </tr>
            <tr>
                <td class="center">
                    Contacted Surrounding Member Agencies<br /><br />
                    <asp:SqlDataSource ID="sqlSurroundingMember" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                        SelectCommand="spSelectContactedSurroundingAgencies" 
                        SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="ID" QueryStringField="id" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:GridView ID="gridSurroundingMember" runat="server"  HorizontalAlign="Center"
                        EmptyDataText="No data available." OnRowCommand="gridSurroundingMember_RowCommand" 
                        CellPadding="4" ForeColor="#333333" GridLines="None"
                        DataSourceID="sqlSurroundingMember" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="FCS_cm_ID" HeaderText="FCS_cm_ID" 
                                InsertVisible="False" ReadOnly="True" SortExpression="FCS_cm_ID" 
                                Visible="False" />
                            <asp:BoundField DataField="FCS_cm_Contact_Type" 
                                HeaderText="FCS_cm_Contact_Type" SortExpression="FCS_cm_Contact_Type" 
                                Visible="False" />
                            <asp:BoundField DataField="FCS_ct_Type" HeaderText="FCS_ct_Type" 
                                SortExpression="FCS_ct_Type" Visible="False" />
                            <asp:BoundField DataField="FCS_cm_agKey" HeaderText="FCS_cm_agKey" 
                                SortExpression="FCS_cm_agKey" Visible="False" />
                            <asp:BoundField DataField="ag_Name" HeaderText="Agency Name" 
                                SortExpression="ag_Name" />
                            <asp:BoundField DataField="FCS_cm_Name" HeaderText="Contact Name" 
                                SortExpression="FCS_cm_Name" />
                            <asp:BoundField DataField="FCS_cm_Date" DataFormatString="{0:d}" 
                                HeaderText="Date" SortExpression="FCS_cm_Date" />
                            <asp:BoundField DataField="FCS_cm_Date_Entered" 
                                HeaderText="FCS_cm_Date_Entered" SortExpression="FCS_cm_Date_Entered" 
                                Visible="False" />
                            <asp:TemplateField><ItemTemplate>
                                <asp:imageButton ID="cmdDeleteSurroundingMember" runat="server" ImageUrl="~/images/redxgrey.gif" OnClientClick="return confirm('Are you sure you want to delete this record?');" CommandName="MyDelete" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"></asp:imageButton>
                            </ItemTemplate></asp:TemplateField>
                        </Columns>
                        <EditRowStyle BackColor="#999999" />
                        <FooterStyle BackColor="#234e6c" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#234e6c" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#234e6c" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                    </asp:GridView>
                    <br /><br />
                    <asp:Button ID="cmdAddSurroundingMember" Text="Add Surrounding Member" runat="server" OnClick="cmdAddSurroundingMember_Click" />
                </td>
            </tr>
            <tr>
                <td>
                    <img src="images/spacer.gif" height="7" />
                </td>
            </tr>
            <tr>
                <td>
                    <img src="images/bar.jpg" height="3" width="800" />
                </td>
            </tr>
            <tr>
                <td>
                    <img src="images/spacer.gif" height="7" />
                </td>
            </tr>
            <tr>
                <td class="center">
                    Contacted Other Agencies<br /><br />
                    <asp:SqlDataSource ID="sqlOther" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>" 
                        SelectCommand="spSelectContactedOtherAgencies" 
                        SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="ID" QueryStringField="id" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:GridView ID="gridOther" runat="server"  HorizontalAlign="Center"
                    EmptyDataText="No data available." OnRowCommand="gridOther_RowCommand" 
                        CellPadding="4" ForeColor="#333333" GridLines="None"
                    DataSourceID="sqlOther" AutoGenerateColumns="False">
                    <Columns>
                            <asp:BoundField DataField="FCS_coa_ID" HeaderText="FCS_coa_ID" 
                                InsertVisible="False" ReadOnly="True" SortExpression="FCS_coa_ID" 
                                Visible="False" />
                            <asp:BoundField DataField="FCS_coa_Agency_Name" 
                                HeaderText="Agency Name" SortExpression="FCS_coa_Agency_Name" />
                            <asp:BoundField DataField="FCS_coa_Name" HeaderText="Contact Name" 
                                SortExpression="FCS_coa_Name" />
                            <asp:BoundField DataField="FCS_coa_Date" HeaderText="Date" 
                                SortExpression="FCS_coa_Date" DataFormatString="{0:d}" />
                            <asp:BoundField DataField="FCS_coa_Date_Entered" HeaderText="FCS_coa_Date_Entered" 
                                SortExpression="FCS_coa_Date_Entered" Visible="False" />
                            <asp:BoundField DataField="FCS_coa_Entered_By" HeaderText="FCS_coa_Entered_By" 
                                SortExpression="FCS_coa_Entered_By" Visible="False" />
                            <asp:BoundField DataField="FCS_coa_Date_Deleted" 
                                HeaderText="FCS_coa_Date_Deleted" SortExpression="FCS_coa_Date_Deleted" 
                                Visible="False" />
                            <asp:BoundField DataField="FCS_coa_Deleted_By" 
                                HeaderText="FCS_coa_Deleted_By" SortExpression="FCS_coa_Deleted_By" 
                                Visible="False" />
                            <asp:TemplateField><ItemTemplate>
                                <asp:imageButton ID="cmdDeleteOther" runat="server" ImageUrl="~/images/redxgrey.gif" OnClientClick="return confirm('Are you sure you want to delete this record?');" CommandName="MyDelete" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"></asp:imageButton>
                            </ItemTemplate></asp:TemplateField>
                        </Columns>
                        <EditRowStyle BackColor="#999999" />
                        <FooterStyle BackColor="#234e6c" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#234e6c" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#234e6c" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                    </asp:GridView>
                    <br /><br />
                    <asp:Button ID="cmdAddOther" Text="Add Other Agency" runat="server" OnClick="cmdAddOther_Click" />
                </td>
            </tr>
            
        </table>
    </asp:Panel>

</asp:Content>

