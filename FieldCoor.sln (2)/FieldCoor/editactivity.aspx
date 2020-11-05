<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" MaintainScrollPositionOnPostback="true" %>

<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Net.Mail" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<script runat="server">
    Int32 intAgencyKey;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Convert.ToInt32(Session["AccessLevel"]) == 3)
            {
                cmdSave.Visible = false;
            }

            DataClassesDataContext myDB = new DataClassesDataContext();
            var objRS = myDB.spSelectActivity(Convert.ToInt32(Request.QueryString["id"]));
            myDB.CommandTimeout = 0;
            foreach (spSelectActivityResult record in objRS)
            {
                txtDate.Text = Convert.ToString(record.FCS_a_Date.Value.ToShortDateString());
                txtHours.Text = record.FCS_a_time.ToString();

                int intTypeID = Convert.ToInt32(record.FCS_a_atype_ID);

                switch (intTypeID)
                {
                    case 1:
                        panInfoDist.Visible = false;
                        lblHours.Visible = true;
                        panAgency.Visible = true;
                        panButtons.Visible = true;
                        panNonMember.Visible = false;
                        panVisitInfo.Visible = true;
                        panTraining.Visible = false;
                        panMisc.Visible = false;
                        panUserUpdate.Visible = true;
                        panTrainingAgencyContacts.Visible = false;
                        panRISSafe.Visible = true;
                        lblMessage.Text = "";

                        if (Request.QueryString["au"] == "y")
                        {
                            lblMessage.Text = "Agency Update email was sent successfully";
                        }

                        dropAgency.DataBind();

                        DataClassesDataContext myAgencyVisit = new DataClassesDataContext();
                        var objAgencyVisit = myAgencyVisit.spSelectAgencyVisit(Convert.ToInt32(Request.QueryString["id"]));
                        foreach (spSelectAgencyVisitResult recordAgencyVisit in objAgencyVisit)
                        {
                            lblActivityType.Text = "Agency Visit";
                            dropAgency.SelectedValue = recordAgencyVisit.FCS_aav_ag_Key.ToString();
                            dropOfficer.DataBind();
                            dropOfficer.SelectedValue = recordAgencyVisit.FCS_aav_person_contacted;
                            chkAttemptedContact.Checked = Convert.ToBoolean(recordAgencyVisit.FCS_aav_attempted_contact);
                            chkPhone.Checked = Convert.ToBoolean(recordAgencyVisit.FCS_aav_phone);
                            chkAttempted.Checked = Convert.ToBoolean(recordAgencyVisit.FCS_aav_attempted);
                            chkCISOP.Checked = Convert.ToBoolean(recordAgencyVisit.FCS_aav_cisop);
                            chkOnSite.Checked = Convert.ToBoolean(recordAgencyVisit.FCS_aav_onsite);
                            chkNotOnSite.Checked = Convert.ToBoolean(recordAgencyVisit.FCS_aav_notonsite);
                            chkAtix.Checked = Convert.ToBoolean(recordAgencyVisit.FCS_aav_atix);
                            //dropRemote.SelectedValue = recordAgencyVisit.FCS_aav_remote;
                            chkDemoed.Checked = Convert.ToBoolean(recordAgencyVisit.FCS_aav_demoed);
                            chkBackground.Checked = Convert.ToBoolean(recordAgencyVisit.FCS_aav_background);
                            txtSSLSetup.Text = recordAgencyVisit.FCS_aav_ssl.ToString();
                            txtOther.Text = recordAgencyVisit.FCS_aav_other;
                            intAgencyKey = Convert.ToInt32(recordAgencyVisit.FCS_aav_ag_Key);

                            //DataClassesDataContext myAgencyInfo = new DataClassesDataContext();
                            //var objAgencyInfo = myAgencyInfo.spSelectAgencyAddressPhone(Convert.ToInt32(recordAgencyVisit.FCS_aav_ag_Key));
                            //foreach (spSelectAgencyAddressPhoneResult recordAgencyInfo in objAgencyInfo)
                            //{
                            //    lblAgencyName.Text = recordAgencyInfo.ag_Name + " - " + recordAgencyInfo.ag_ID;
                            //    lblAddress1.Text = recordAgencyInfo.aa_Line1;
                            //    lblAddress2.Text = recordAgencyInfo.aa_Line2;
                            //    lblAddress3.Text = recordAgencyInfo.aa_Line3;
                            //    lblCity.Text = recordAgencyInfo.aa_City + ", " + recordAgencyInfo.aa_State + " " + recordAgencyInfo.aa_Zip;
                            //    lblPhone.Text = "Phone: (" + recordAgencyInfo.ap_AreaCode + ") " + recordAgencyInfo.ap_Number;
                            //    break;
                            //}

                            //DataClassesDataContext myAgencyFax = new DataClassesDataContext();
                            //var objAgencyFax = myAgencyFax.spSelectAgencyFax(Convert.ToInt32(recordAgencyVisit.FCS_aav_ag_Key));
                            //foreach (spSelectAgencyFaxResult recordAgencyFax in objAgencyFax)
                            //{
                            //    lblFax.Text = "Fax: (" + recordAgencyFax.ap_AreaCode + ") " + recordAgencyFax.ap_Number;
                            //    break;
                            //}

                            //string strResult = "<table width='800px' cellpadding='2' cellspacing='0' border='0'><tr><td class='tableheadings'>Officers</td><td class='tableheadings'>Information</td><td class='tableheadings'>Address</td><td class='tableheadings'>Edit</td></tr>";

                            ////DataClassesDataContext myNonRemote = new DataClassesDataContext();
                            ////var objNonRemote = myNonRemote.spSelectAgencyNonRemoteUsers(Convert.ToInt32(recordAgencyVisit.FCS_aav_ag_Key));
                            ////foreach (spSelectAgencyNonRemoteUsersResult recordNonRemote in objNonRemote)
                            ////{

                            ////    strResult += "<tr><td class='text' valign='top'>" + recordNonRemote.of_LastName + ", " + recordNonRemote.of_FirstName + ", " + recordNonRemote.of_Title + "</td><td class='text'><a class='tablelink' href='#' onclick=NewWindow('officercode.aspx?oc=" + recordNonRemote.of_Codes + "','name','125','250','no');return false;>" + recordNonRemote.of_Codes + "</a>";
                            ////    if (recordNonRemote.op_Number != null)
                            ////    {
                            ////        strResult += "<br>(" + recordNonRemote.op_AreaCode + ") " + recordNonRemote.op_Number + "</td>";
                            ////    }
                            ////    else
                            ////    {
                            ////        strResult += "</td>";
                            ////    }
                            ////    if (recordNonRemote.oa_Line1 != null & recordNonRemote.oa_Line1 != "")
                            ////    {
                            ////        strResult += "<td class='text'>" + recordNonRemote.oa_Line1;
                            ////        if (recordNonRemote.oa_Line2 != null & recordNonRemote.oa_Line2 != "")
                            ////        {
                            ////            strResult += "<br />" + recordNonRemote.oa_Line2;
                            ////            if (recordNonRemote.oa_Line3 != null & recordNonRemote.oa_Line3 != "")
                            ////            {
                            ////                strResult += "<br />" + recordNonRemote.oa_Line3;
                            ////            }
                            ////        }
                            ////        strResult += "<br />" + recordNonRemote.oa_City + ", " + recordNonRemote.oa_State + " " + recordNonRemote.oa_Zip + "</td>";
                            ////    }
                            ////    else
                            ////    {
                            ////        strResult += "<td></td>";
                            ////    }

                            ////    strResult += "<td class='text'><a href='#' onclick=NewWindow('officerupdate.aspx?ofkey=" + recordNonRemote.of_Key + "','name','325','350','no');return false; title='Notify membership clerk that " + recordNonRemote.of_Title + " " + recordNonRemote.of_FirstName + " " + recordNonRemote.of_LastName + " needs to be updated.'>Select</a></td>";
                            ////    strResult += "</tr><tr><td colspan='4'><img src='images/bar.jpg' height='3' width='800' /></td></tr>";
                            ////}

                            ////strResult += "<tr><td colspan='4'><img src='images/spacer.gif' height='20' /></td></tr>";
                            ////strResult += "<tr><td class='tableheadings'>Remote User</td><td class='tableheadings'>Information</td><td class='tableheadings'>Address</td><td class='tableheadings'>Edit</td></tr>";

                            ////DataClassesDataContext myRemote = new DataClassesDataContext();
                            ////var objRemote = myRemote.spSelectAgencyRemoteUsers(Convert.ToInt32(recordAgencyVisit.FCS_aav_ag_Key));
                            ////foreach (spSelectAgencyRemoteUsersResult recordRemote in objRemote)
                            ////{
                            ////    strResult += "<tr><td class='text' valign='top'>" + recordRemote.of_LastName + ", " + recordRemote.of_FirstName + ", " + recordRemote.of_Title + "</td><td class='text'><a href=mailto:" + recordRemote.oi_eMail + " title='" + recordRemote.of_Title + " " + recordRemote.of_FirstName + " " + recordRemote.of_LastName + "'>" + recordRemote.oi_eMail + "</a><br /><a class='tablelink' href='#' onclick=NewWindow('officercode.aspx?oc=" + recordRemote.of_Codes + "','name','125','250','no');return false;>" + recordRemote.of_Codes + "</a>";
                            ////    if (recordRemote.op_Number != null)
                            ////    {
                            ////        strResult += "<br>(" + recordRemote.op_AreaCode + ") " + recordRemote.op_Number + "</td>";
                            ////    }
                            ////    else
                            ////    {
                            ////        strResult += "</td>";
                            ////    }
                            ////    if (recordRemote.oa_Line1 != null & recordRemote.oa_Line1 != "")
                            ////    {
                            ////        strResult += "<td class='text'>" + recordRemote.oa_Line1;
                            ////        if (recordRemote.oa_Line2 != null & recordRemote.oa_Line2 != "")
                            ////        {
                            ////            strResult += "<br />" + recordRemote.oa_Line2;
                            ////            if (recordRemote.oa_Line3 != null & recordRemote.oa_Line3 != "")
                            ////            {
                            ////                strResult += "<br />" + recordRemote.oa_Line3;
                            ////            }
                            ////        }
                            ////        strResult += "<br />" + recordRemote.oa_City + ", " + recordRemote.oa_State + " " + recordRemote.oa_Zip + "</td>";
                            ////    }
                            ////    else
                            ////    {
                            ////        strResult += "<td></td>";
                            ////    }

                            ////    strResult += "<td class='text'><a href='#' onclick=NewWindow('officerupdate.aspx?ofkey=" + recordRemote.of_Key + "','name','325','350','no');return false; title='Notify membership clerk that " + recordRemote.of_Title + " " + recordRemote.of_FirstName + " " + recordRemote.of_LastName + " needs to be updated.'>Select</a></td>";
                            ////    strResult += "</tr><tr><td colspan='4'><img src='images/bar.jpg' height='3' width='800' /></td></tr>";


                            ////}

                            //Boolean blnOfficerFirst = true;
                            //Boolean blnRemoteFirst = true;

                            //DataClassesDataContext myNonRemote = new DataClassesDataContext();
                            //myNonRemote.CommandTimeout = 0;
                            //var objNonRemote = myNonRemote.spSelectAgencyOfficersWithoutRISSNET(Convert.ToInt32(recordAgencyVisit.FCS_aav_ag_Key));
                            //foreach (spSelectAgencyOfficersWithoutRISSNETResult recordNonRemote in objNonRemote)
                            //{

                            //    //if (blnOfficerFirst)
                            //    //{
                            //    //    strResult += "<tr><td class='tableheadings'>Officers</td><td class='tableheadings'>Information</td><td class='tableheadings'>Address</td><td class='tableheadings'>Edit</td></tr>";
                            //    //    blnOfficerFirst = false;
                            //    //}

                            //    strResult += "<tr><td class='text' valign='top'>" + recordNonRemote.temp_of_LastName + ", " + recordNonRemote.temp_of_FirstName + ", " + recordNonRemote.temp_of_Title + "<br />" + recordNonRemote.temp_of_eMail + "</td><td class='text'><a class='tablelink' href='#' onclick=NewWindow('officercode.aspx?oc=" + recordNonRemote.temp_of_Codes + "','name','125','250','no');return false;>" + recordNonRemote.temp_of_Codes + "</a>";
                            //    if (recordNonRemote.temp_PhoneNumber != null)
                            //    {
                            //        strResult += "<br>" + recordNonRemote.temp_PhoneNumber;
                            //    }
                            //    else
                            //    {
                            //        strResult += "</td>";
                            //    }
                            //    if (recordNonRemote.temp_oa_Line1 != null & recordNonRemote.temp_oa_Line1 != "")
                            //    {
                            //        strResult += "<td class='text'>" + recordNonRemote.temp_oa_Line1;
                            //        if (recordNonRemote.temp_oa_Line2 != null & recordNonRemote.temp_oa_Line2 != "")
                            //        {
                            //            strResult += "<br />" + recordNonRemote.temp_oa_Line2;
                            //            if (recordNonRemote.temp_oa_Line3 != null & recordNonRemote.temp_oa_Line3 != "")
                            //            {
                            //                strResult += "<br />" + recordNonRemote.temp_oa_Line3;
                            //            }
                            //        }
                            //        strResult += "<br />" + recordNonRemote.temp_oa_City + ", " + recordNonRemote.temp_oa_State + " " + recordNonRemote.temp_oa_Zip + "</td>";
                            //    }
                            //    else
                            //    {
                            //        strResult += "<td></td>";
                            //    }

                            //    strResult += "<td class='text'><a href='#' onclick=NewWindow('officerupdate.aspx?ofkey=" + recordNonRemote.temp_of_Key + "','name','325','350','no');return false; title='Notify membership clerk that " + recordNonRemote.temp_of_Title + " " + recordNonRemote.temp_of_FirstName + " " + recordNonRemote.temp_of_LastName + " needs to be updated.'>Select</a></td>";
                            //    strResult += "</tr><tr><td colspan='4'><img src='images/bar.jpg' height='3' width='800' /></td></tr>";
                            //}

                            //strResult += "<tr><td colspan='4'><img src='images/spacer.gif' height='20' /></td></tr>";


                            //DataClassesDataContext myRemote = new DataClassesDataContext();
                            //myRemote.CommandTimeout = 0;
                            //var objRemote = myRemote.spSelectAgencyOfficersWithRISSNET(Convert.ToInt32(recordAgencyVisit.FCS_aav_ag_Key));
                            //foreach (spSelectAgencyOfficersWithRISSNETResult recordRemote in objRemote)
                            //{

                            //    if (blnRemoteFirst)
                            //    {
                            //        strResult += "<tr><td class='tableheadings'>Remote User</td><td class='tableheadings'>Information</td><td class='tableheadings'>Address</td><td class='tableheadings'>Edit</td></tr>";
                            //        blnRemoteFirst = false;
                            //    }

                            //    strResult += "<tr><td class='text' valign='top'>" + recordRemote.temp_of_LastName + ", " + recordRemote.temp_of_FirstName + ", " + recordRemote.temp_of_Title + "<br />" + recordRemote.temp_of_eMail + "</td><td class='text'><a href=mailto:" + recordRemote.temp_oi_eMail + " title='" + recordRemote.temp_of_Title + " " + recordRemote.temp_of_FirstName + " " + recordRemote.temp_of_LastName + "'>" + recordRemote.temp_oi_eMail + "</a><br /><a class='tablelink' href='#' onclick=NewWindow('officercode.aspx?oc=" + recordRemote.temp_of_Codes + "','name','125','250','no');return false;>" + recordRemote.temp_of_Codes + "</a>";
                            //    if (recordRemote.temp_PhoneNumber != null)
                            //    {
                            //        strResult += "<br>" + recordRemote.temp_PhoneNumber;
                            //    }
                            //    else
                            //    {
                            //        strResult += "</td>";
                            //    }
                            //    if (recordRemote.temp_oa_Line1 != null & recordRemote.temp_oa_Line1 != "")
                            //    {
                            //        strResult += "<td class='text'>" + recordRemote.temp_oa_Line1;
                            //        if (recordRemote.temp_oa_Line2 != null & recordRemote.temp_oa_Line2 != "")
                            //        {
                            //            strResult += "<br />" + recordRemote.temp_oa_Line2;
                            //            if (recordRemote.temp_oa_Line3 != null & recordRemote.temp_oa_Line3 != "")
                            //            {
                            //                strResult += "<br />" + recordRemote.temp_oa_Line3;
                            //            }
                            //        }
                            //        strResult += "<br />" + recordRemote.temp_oa_City + ", " + recordRemote.temp_oa_State + " " + recordRemote.temp_oa_Zip + "</td>";
                            //    }
                            //    else
                            //    {
                            //        strResult += "<td></td>";
                            //    }

                            //    strResult += "<td class='text'><a href='#' onclick=NewWindow('officerupdate.aspx?ofkey=" + recordRemote.temp_of_Key + "','name','325','350','no');return false; title='Notify membership clerk that " + recordRemote.temp_of_Title + " " + recordRemote.temp_of_FirstName + " " + recordRemote.temp_of_LastName + " needs to be updated.'>Select</a></td>";
                            //    strResult += "</tr><tr><td colspan='4'><img src='images/bar.jpg' height='3' width='800' /></td></tr>";


                            //}

                            //strResult += "</table>";

                            //divNonRemote.InnerHtml = strResult;

                            //break;
                            ShowAgencyOfficers();
                        }
                        var objRISSafeHours = myAgencyVisit.spSelectRISSafeHours(Convert.ToInt32(Request.QueryString["id"]));
                        foreach (spSelectRISSafeHoursResult recordRISSafeHours in objRISSafeHours)
                        {
                            chkRISSafe.Checked = Convert.ToBoolean(recordRISSafeHours.FCS_rs_Checked);
                            txtRISSafe.Text = recordRISSafeHours.FCS_rs_Hours.ToString();
                            break;
                        }

                        break;
                    case 2:
                        panInfoDist.Visible = false;
                        lblHours.Visible = true;
                        panNonMember.Visible = true;
                        panAgency.Visible = false;
                        panButtons.Visible = true;
                        panVisitInfo.Visible = true;
                        panTraining.Visible = false;
                        panMisc.Visible = false;
                        panUserUpdate.Visible = false;
                        panTrainingAgencyContacts.Visible = false;
                        panRISSafe.Visible = true;
                        lblMessage.Text = "";

                        DataClassesDataContext myNonVisit = new DataClassesDataContext();
                        var objNonVisit = myNonVisit.spSelectAgencyVisit(Convert.ToInt32(Request.QueryString["id"]));
                        foreach (spSelectAgencyVisitResult recordNonVisit in objNonVisit)
                        {
                            lblActivityType.Text = "Non Member Agency Visit";
                            txtNonMemberName.Text = recordNonVisit.FCS_aav_nm_name;
                            txtNonMemberCity.Text = recordNonVisit.FCS_aav_nm_city;
                            txtNonMemberState.Text = recordNonVisit.FCS_aav_nm_state;
                            txtPersonContacted.Text = recordNonVisit.FCS_aav_person_contacted;
                            chkAttemptedContact.Checked = Convert.ToBoolean(recordNonVisit.FCS_aav_attempted_contact);
                            chkPhone.Checked = Convert.ToBoolean(recordNonVisit.FCS_aav_phone);
                            chkAttempted.Checked = Convert.ToBoolean(recordNonVisit.FCS_aav_attempted);
                            chkCISOP.Checked = Convert.ToBoolean(recordNonVisit.FCS_aav_cisop);
                            chkOnSite.Checked = Convert.ToBoolean(recordNonVisit.FCS_aav_onsite);
                            chkNotOnSite.Checked = Convert.ToBoolean(recordNonVisit.FCS_aav_notonsite);
                            chkAtix.Checked = Convert.ToBoolean(recordNonVisit.FCS_aav_atix);
                            //dropRemote.SelectedValue = recordNonVisit.FCS_aav_remote;
                            chkDemoed.Checked = Convert.ToBoolean(recordNonVisit.FCS_aav_demoed);
                            chkBackground.Checked = Convert.ToBoolean(recordNonVisit.FCS_aav_background);
                            txtSSLSetup.Text = recordNonVisit.FCS_aav_ssl.ToString();
                            txtOther.Text = recordNonVisit.FCS_aav_other;
                            break;
                        }
                        var objRISSafeHours2 = myNonVisit.spSelectRISSafeHours(Convert.ToInt32(Request.QueryString["id"]));
                        foreach (spSelectRISSafeHoursResult recordRISSafeHours in objRISSafeHours2)
                        {
                            chkRISSafe.Checked = Convert.ToBoolean(recordRISSafeHours.FCS_rs_Checked);
                            txtRISSafe.Text = recordRISSafeHours.FCS_rs_Hours.ToString();
                            break;
                        }

                        break;
                    case 3:
                        panInfoDist.Visible = false;
                        lblHours.Visible = true;
                        panNonMember.Visible = false;
                        panAgency.Visible = false;
                        panVisitInfo.Visible = false;
                        panButtons.Visible = true;
                        panTraining.Visible = true;
                        panSponsored.Visible = true;
                        panMisc.Visible = false;
                        panUserUpdate.Visible = false;
                        panTrainingAgencyContacts.Visible = true;
                        panRISSafe.Visible = true;
                        lblMessage.Text = "";

                        DataClassesDataContext myTraining = new DataClassesDataContext();
                        var objTraining = myTraining.spSelectActivityTrainingNew(Convert.ToInt32(Request.QueryString["id"]));
                        foreach (spSelectActivityTrainingNewResult recordTraining in objTraining)
                        {
                            lblActivityType.Text = "Meeting/Training";
                            lblMeetings.Text = recordTraining.FCS_att_Type;
                            txtNotes.Text = recordTraining.FCS_at_notes;
                            if (recordTraining.FCS_at_att_ID.ToString() == "2")
                            {
                                panAttendedMeeting.Visible = false;
                                panAttendedTraining.Visible = true;
                                txtTrainingAttended.Text = recordTraining.FCS_at_meeting_name;
                                txtTrainingCity.Text = recordTraining.FCS_at_City;
                                txtTrainingState.Text = recordTraining.FCS_at_State;
                            }
                            else
                            {
                                panAttendedMeeting.Visible = true;
                                panAttendedTraining.Visible = false;

                                rdoSponsored.SelectedValue = recordTraining.FCS_at_sponsored.ToString();
                                //chkPresenter.Checked = Convert.ToBoolean(recordTraining.FCS_at_presenter);
                                dropParticipated.SelectedValue = recordTraining.FCS_at_participated.ToString();
                                txtMeetingName.Text = recordTraining.FCS_at_meeting_name;
                                txtMeetingCity.Text = recordTraining.FCS_at_City;
                                txtMeetingState.Text = recordTraining.FCS_at_State;
                                //if (recordTraining.FCS_at_sponsored.ToString() == "1")
                                //{
                                //    panSponsored.Visible = true;
                                txtMeetingAgencies.Text = recordTraining.FCS_at_agencies.ToString();
                                txtMeetingAttendees.Text = recordTraining.FCS_at_attendees.ToString();
                                dropValue.SelectedValue = recordTraining.FCS_at_value.ToString();
                                txtGain.Text = recordTraining.FCS_at_gain;
                                //txtMeetingHours.Text = recordTraining.FCS_at_hours.ToString();
                                //}
                                //else
                                //{
                                //    panSponsored.Visible = false;
                                //}
                            }
                            break;
                        }
                        var objRISSafeHours3 = myTraining.spSelectRISSafeHours(Convert.ToInt32(Request.QueryString["id"]));
                        foreach (spSelectRISSafeHoursResult recordRISSafeHours in objRISSafeHours3)
                        {
                            chkRISSafe.Checked = Convert.ToBoolean(recordRISSafeHours.FCS_rs_Checked);
                            txtRISSafe.Text = recordRISSafeHours.FCS_rs_Hours.ToString();
                            break;
                        }

                        break;
                    case 4:
                        panInfoDist.Visible = false;
                        lblHours.Visible = true;
                        panMisc.Visible = true;
                        panButtons.Visible = true;
                        panVisitInfo.Visible = false;
                        panAgency.Visible = false;
                        panNonMember.Visible = false;
                        panTraining.Visible = false;
                        panUserUpdate.Visible = false;
                        panTrainingAgencyContacts.Visible = false;
                        panRISSafe.Visible = false;
                        lblMessage.Text = "Personal items like vacation need to be entered into your time sheet on BambooHR.";

                        DataClassesDataContext myMisc = new DataClassesDataContext();
                        var objMisc = myMisc.spSelectActivityMisc(Convert.ToInt32(Request.QueryString["id"]));
                        foreach (spSelectActivityMiscResult recordMisc in objMisc)
                        {
                            lblActivityType.Text = "Other";
                            dropMisc.DataBind();
                            dropMisc.SelectedValue = recordMisc.FCS_am_amt_ID.ToString();
                            txtType.Text = recordMisc.FCS_am_Type.ToString();
                        }

                        switch (dropMisc.SelectedItem.ToString())
                        {
                            case "Office Time":
                                panOtherType.Visible = true;
                                break;
                            default:
                                panOtherType.Visible = false;
                                break;
                        }

                        break;
                    case 5:
                        panInfoDist.Visible = true;
                        lblHours.Visible = false;
                        panNonMember.Visible = false;
                        panAgency.Visible = false;
                        panVisitInfo.Visible = false;
                        panButtons.Visible = true;
                        panTraining.Visible = false;
                        panMisc.Visible = false;
                        panUserUpdate.Visible = false;
                        panTrainingAgencyContacts.Visible = false;
                        panRISSafe.Visible = false;
                        lblMessage.Text = "";

                        DataClassesDataContext myInfo = new DataClassesDataContext();
                        var objInfo = myInfo.spSelectInfoDistributed(Convert.ToInt32(Request.QueryString["id"]));
                        foreach (spSelectInfoDistributedResult recordInfo in objInfo)
                        {
                            lblActivityType.Text = "Info/Intel Distributed";
                            txtFaxes.Text = recordInfo.FCS_aid_items.ToString();
                            txtRecipients.Text = recordInfo.FCS_aid_recipients.ToString();
                        }

                        break;
                    default:

                        break;
                }
                break;
            }
        }
    }

    protected void ShowAgencyOfficers()
    {
        DataClassesDataContext myAgencyInfo = new DataClassesDataContext();
        var objAgencyInfo = myAgencyInfo.spSelectAgencyAddressPhone(intAgencyKey);
        foreach (spSelectAgencyAddressPhoneResult recordAgencyInfo in objAgencyInfo)
        {
            lblAgencyName.Text = recordAgencyInfo.ag_Name + " - " + recordAgencyInfo.ag_ID;
            lblAddress1.Text = recordAgencyInfo.aa_Line1;
            lblAddress2.Text = recordAgencyInfo.aa_Line2;
            lblAddress3.Text = recordAgencyInfo.aa_Line3;
            lblCity.Text = recordAgencyInfo.aa_City + ", " + recordAgencyInfo.aa_State + " " + recordAgencyInfo.aa_Zip;
            lblPhone.Text = "Phone: (" + recordAgencyInfo.ap_AreaCode + ") " + recordAgencyInfo.ap_Number;
            break;
        }

        DataClassesDataContext myAgencyFax = new DataClassesDataContext();
        var objAgencyFax = myAgencyFax.spSelectAgencyFax(intAgencyKey);
        foreach (spSelectAgencyFaxResult recordAgencyFax in objAgencyFax)
        {
            lblFax.Text = "Fax: (" + recordAgencyFax.ap_AreaCode + ") " + recordAgencyFax.ap_Number;
            break;
        }

        Boolean blnOfficerFirst = true;
        Boolean blnRemoteFirst = true;
        String strResult = "<table width='800px' cellpadding='2' cellspacing='0' border='0'>";

        DataClassesDataContext myNonRemote = new DataClassesDataContext();
        var objNonRemote = myNonRemote.spSelectAgencyOfficersWithoutRISSNET(intAgencyKey);
        foreach (spSelectAgencyOfficersWithoutRISSNETResult recordNonRemote in objNonRemote)
        {

            if (blnOfficerFirst)
            {
                strResult += "<tr><td class='tableheadings'>Officers</td><td class='tableheadings'>Information</td><td class='tableheadings'>Address</td><td class='tableheadings'>Edit</td></tr>";
                blnOfficerFirst = false;
            }

            strResult += "<tr><td class='text' valign='top'>" + recordNonRemote.temp_of_LastName + ", " + recordNonRemote.temp_of_FirstName + ", " + recordNonRemote.temp_of_Title + "<br />" + recordNonRemote.temp_of_eMail + "</td><td class='text'><a class='tablelink' href='#' onclick=NewWindow('officercode.aspx?oc=" + recordNonRemote.temp_of_Codes.Replace("P", "").Replace("S", "").Replace("B", "").Replace("X", "") + "','name','125','250','no');return false;>" + recordNonRemote.temp_of_Codes.Replace("P", "").Replace("S", "").Replace("B", "").Replace("X", "") + "</a>";
            if (recordNonRemote.temp_PhoneNumber != null)
            {
                strResult += "<br>" + recordNonRemote.temp_PhoneNumber;
            }
            else
            {
                strResult += "</td>";
            }
            if (recordNonRemote.temp_oa_Line1 != null & recordNonRemote.temp_oa_Line1 != "")
            {
                strResult += "<td class='text'>" + recordNonRemote.temp_oa_Line1;
                if (recordNonRemote.temp_oa_Line2 != null & recordNonRemote.temp_oa_Line2 != "")
                {
                    strResult += "<br />" + recordNonRemote.temp_oa_Line2;
                    if (recordNonRemote.temp_oa_Line3 != null & recordNonRemote.temp_oa_Line3 != "")
                    {
                        strResult += "<br />" + recordNonRemote.temp_oa_Line3;
                    }
                }
                strResult += "<br />" + recordNonRemote.temp_oa_City + ", " + recordNonRemote.temp_oa_State + " " + recordNonRemote.temp_oa_Zip + "</td>";
            }
            else
            {
                strResult += "<td></td>";
            }

            strResult += "<td class='text'><a href='#' onclick=NewWindow('officerupdate.aspx?ofkey=" + recordNonRemote.temp_of_Key + "','name','325','350','no');return false; title='Notify membership clerk that " + recordNonRemote.temp_of_Title + " " + recordNonRemote.temp_of_FirstName + " " + recordNonRemote.temp_of_LastName + " needs to be updated.'>Select</a></td>";
            strResult += "</tr><tr><td colspan='4'><img src='images/bar.jpg' height='3' width='800' /></td></tr>";
        }

        strResult += "<tr><td colspan='4'><img src='images/spacer.gif' height='20' /></td></tr>";


        DataClassesDataContext myRemote = new DataClassesDataContext();
        var objRemote = myRemote.spSelectAgencyOfficersWithRISSNET(intAgencyKey);
        foreach (spSelectAgencyOfficersWithRISSNETResult recordRemote in objRemote)
        {

            if (blnRemoteFirst)
            {
                strResult += "<tr><td class='tableheadings'>Remote User</td><td class='tableheadings'>Information</td><td class='tableheadings'>Address</td><td class='tableheadings'>Edit</td></tr>";
                blnRemoteFirst = false;
            }

            strResult += "<tr><td class='text' valign='top'>" + recordRemote.temp_of_LastName + ", " + recordRemote.temp_of_FirstName + ", " + recordRemote.temp_of_Title + "<br />" + recordRemote.temp_oi_UserID + "<br />" + recordRemote.temp_OTP + "</td><td class='text'><a href=mailto:" + recordRemote.temp_of_eMail + " title='" + recordRemote.temp_of_Title + " " + recordRemote.temp_of_FirstName + " " + recordRemote.temp_of_LastName + "'>" + recordRemote.temp_of_eMail + "</a><br /><a class='tablelink' href='#' onclick=NewWindow('officercode.aspx?oc=" + recordRemote.temp_of_Codes.Replace("P", "").Replace("S", "").Replace("B", "").Replace("X", "") + "','name','125','250','no');return false;>" + recordRemote.temp_of_Codes.Replace("P", "").Replace("S", "").Replace("B", "").Replace("X", "") + "</a>";
            if (recordRemote.temp_PhoneNumber != null)
            {
                strResult += "<br>" + recordRemote.temp_PhoneNumber;
            }
            else
            {
                strResult += "</td>";
            }
            if (recordRemote.temp_oa_Line1 != null & recordRemote.temp_oa_Line1 != "")
            {
                strResult += "<td class='text'>" + recordRemote.temp_oa_Line1;
                if (recordRemote.temp_oa_Line2 != null & recordRemote.temp_oa_Line2 != "")
                {
                    strResult += "<br />" + recordRemote.temp_oa_Line2;
                    if (recordRemote.temp_oa_Line3 != null & recordRemote.temp_oa_Line3 != "")
                    {
                        strResult += "<br />" + recordRemote.temp_oa_Line3;
                    }
                }
                strResult += "<br />" + recordRemote.temp_oa_City + ", " + recordRemote.temp_oa_State + " " + recordRemote.temp_oa_Zip + "</td>";
            }
            else
            {
                strResult += "<td></td>";
            }

            strResult += "<td class='text'><a href='#' onclick=NewWindow('officerupdate.aspx?ofkey=" + recordRemote.temp_of_Key + "','name','325','350','no');return false; title='Notify membership clerk that " + recordRemote.temp_of_Title + " " + recordRemote.temp_of_FirstName + " " + recordRemote.temp_of_LastName + " needs to be updated.'>Select</a></td>";
            strResult += "</tr><tr><td colspan='4'><img src='images/bar.jpg' height='3' width='800' /></td></tr>";


        }

        strResult += "</table>";

        divNonRemote.InnerHtml = strResult;
    }



    protected void rdoSponsored_OnClick(object sender, EventArgs e)
    {
        //if (rdoSponsored.SelectedItem.Value == "1")
        //{
        //    panSponsored.Visible = true;
        //}
        //else
        //{
        //    panSponsored.Visible = false;
        //}
    }

    protected void cmdCancel_Click(object sender, EventArgs e)
    {
        if (Request.QueryString["l"] == "y")
        {
            Response.Redirect("listactivity.aspx");
        }
        else
        {
            Response.Redirect("default.aspx");
        }
    }

    protected void dropAgency_SelectedIndexChanged(object sender, EventArgs e)
    {
        dropOfficer.DataBind();
    }

    protected void cmdAgencyCommentsSave_onClick(object sender, EventArgs e)
    {
        string strMessage = "";

        MailMessage objMM = new MailMessage();

        string strUserAddress = Session["UserName"] + "@mocic.riss.net";

        objMM.From = new MailAddress(strUserAddress);
        objMM.To.Add(new MailAddress("tlong@mocic.riss.net"));
        objMM.To.Add(new MailAddress("lterhune@mocic.riss.net"));
        //objMM.To.Add(new MailAddress("lglenn@mocic.riss.net"));
        objMM.CC.Add(new MailAddress(strUserAddress));
        objMM.IsBodyHtml = true;
        objMM.Priority = MailPriority.Normal;


        objMM.Subject = lblAgencyName.Text + " - OTHER UPDATE - Membership Update";
        strMessage = "---- OTHER UPDATE - Membership Update ----<br /><br />";

        DateTime now = DateTime.Now;
        strMessage += "Date: " + now.Month.ToString() + "/" + now.Day.ToString() + "/" + now.Year.ToString() + "<br /><br />Law Enforcement Coordinator: " + Session["UserName"] + "<br /><br />Agency: " + lblAgencyName.Text + "<br /><br />Other Updates:<br /><br />" + txtAgencyUpdateComments.Text;

        if (chkInterim.Checked)
        {
            strMessage += "<br /><br />Send Interim Agreement";
        }
        if (chkReapplication.Checked)
        {
            strMessage += "<br /><br />Send Reapplication Paperwork";
        }

        objMM.Body = strMessage;

        SmtpClient mSmtpClient = new SmtpClient();
        mSmtpClient.Host = "mail.mocic2003.net";
        mSmtpClient.Send(objMM);

        if (Request.QueryString["l"] == "y")
        {
            Response.Redirect("editactivity.aspx?l=y&id=" + Request.QueryString["id"] + "&au=y");
        }
        else
        {
            Response.Redirect("editactivity.aspx?id=" + Request.QueryString["id"] + "&au=y");
        }

    }

    protected void cmdSave_Click(object sender, EventArgs e)
    {
        if (chkRISSafe.Checked && txtRISSafe.Text == "0")
        {
            lblMessage.Text = "When checking the RISSafe box you must enter time.";
        }
        else if (txtRISSafe.Text != "0" && chkRISSafe.Checked == false)
        {
            lblMessage.Text = "Must check the RISSafe box when entering time for RISSafe.";
        }
        else if (lblActivityType.Text == "Meeting/Training" && txtNotes.Text == "")
        {
            lblMessage.Text = "Must enter notes about the meeting/training.";
        }
        //else if (chkNotOnSite.Checked == false && chkOnSite.Checked == false && chkPhone.Checked == false && chkAttempted.Checked == false)
        //{
        //    lblMessage.Text = "You must select either phone contact, on-site, attempted on-site, or not on-site.";
        //}
        else
        {
            if (lblActivityType.Text == "Info/Intel Distributed")
            {
                lblHours.Visible = true;
                txtHours.Text = "0";
            }
            DataClassesDataContext myDB = new DataClassesDataContext();
            myDB.spUpdateActivity(Convert.ToInt32(Request.QueryString["id"]), Convert.ToDateTime(txtDate.Text), Convert.ToDouble(txtHours.Text), Convert.ToInt32(Session["EmpID"]));

            switch (lblActivityType.Text)
            {
                case "Agency Visit":
                    if (chkNotOnSite.Checked == false && chkOnSite.Checked == false && chkPhone.Checked == false && chkAttempted.Checked == false)
                    {
                        lblMessage.Text = "You must select either phone contact, on-site, attempted on-site, or not on-site.";
                    }
                    else if ((chkRISSafe.Checked == true || chkPhone.Checked == true || chkCISOP.Checked == true || chkAtix.Checked == true || chkDemoed.Checked == true || chkBackground.Checked == true) && txtOther.Text == "")
                    {
                        lblMessage.Text = "Must enter notes in the Other field about your visit.";
                    }
                    else
                    {
                        DataClassesDataContext myAgency = new DataClassesDataContext();
                        myAgency.spUpdateActivityAgencyVisit(Convert.ToInt32(Request.QueryString["id"]), Convert.ToInt32(dropAgency.SelectedItem.Value), "", "", "", dropOfficer.SelectedItem.Value.ToString(), chkAttemptedContact.Checked, chkPhone.Checked, chkOnSite.Checked, chkAttempted.Checked, chkNotOnSite.Checked, chkAtix.Checked, chkCISOP.Checked, Convert.ToInt32(txtSSLSetup.Text), "", chkDemoed.Checked, chkBackground.Checked, txtOther.Text, Convert.ToInt32(Session["EmpID"]));
                        myAgency.spUpdateRISSafeHours(Convert.ToInt32(Request.QueryString["id"]), chkRISSafe.Checked, Convert.ToDouble(txtRISSafe.Text));
                    }
                    break;
                case "Non Member Agency Visit":
                    if (chkNotOnSite.Checked == false && chkOnSite.Checked == false && chkPhone.Checked == false && chkAttempted.Checked == false)
                    {
                        lblMessage.Text = "You must select either phone contact, on-site, attempted on-site, or not on-site.";
                    }
                    else if ((chkRISSafe.Checked == true || chkPhone.Checked == true || chkCISOP.Checked == true || chkAtix.Checked == true || chkDemoed.Checked == true || chkBackground.Checked == true) && txtOther.Text == "")
                    {
                        lblMessage.Text = "Must enter notes in the Other field about your visit.";
                    }
                    else
                    {
                        DataClassesDataContext myNonMember = new DataClassesDataContext();
                        myNonMember.spUpdateActivityAgencyVisit(Convert.ToInt32(Request.QueryString["id"]), 0, txtNonMemberName.Text, txtNonMemberCity.Text, txtNonMemberState.Text, txtPersonContacted.Text, chkAttemptedContact.Checked, chkPhone.Checked, chkOnSite.Checked, chkAttempted.Checked, chkNotOnSite.Checked, chkAtix.Checked, chkCISOP.Checked, Convert.ToInt32(txtSSLSetup.Text), "", chkDemoed.Checked, chkBackground.Checked, txtOther.Text, Convert.ToInt32(Session["EmpID"]));
                        myNonMember.spUpdateRISSafeHours(Convert.ToInt32(Request.QueryString["id"]), chkRISSafe.Checked, Convert.ToDouble(txtRISSafe.Text));
                    }
                    break;
                case "Meeting/Training":
                    DataClassesDataContext myTraining = new DataClassesDataContext();
                    if (lblMeetings.Text == "Information Sharing Meeting/Conference")
                    {
                        //if (rdoSponsored.SelectedItem.Value == "1")
                        //{
                        myTraining.spUpdateActivityTrainingNew(Convert.ToInt32(Request.QueryString["id"]), Convert.ToInt32(rdoSponsored.SelectedItem.Value), dropParticipated.SelectedItem.Value, txtMeetingName.Text, Convert.ToInt32(txtMeetingAgencies.Text), Convert.ToInt32(txtMeetingAttendees.Text), 0, Convert.ToInt32(dropValue.SelectedItem.Value), txtGain.Text, txtNotes.Text, txtMeetingState.Text, txtMeetingCity.Text, Convert.ToInt32(Session["EmpID"]));
                        //}
                        //else
                        //{
                        //    myTraining.spUpdateActivityTraining(Convert.ToInt32(Request.QueryString["id"]), Convert.ToInt32(rdoSponsored.SelectedItem.Value), chkPresenter.Checked, txtMeetingName.Text, 0, 0, 0, txtNotes.Text, txtMeetingState.Text, txtMeetingCity.Text);
                        //}
                    }
                    else
                    {
                        myTraining.spUpdateActivityTrainingNew(Convert.ToInt32(Request.QueryString["id"]), 0, "", txtTrainingAttended.Text, 0, 0, 0, 0, "", txtNotes.Text, txtTrainingState.Text, txtTrainingCity.Text, Convert.ToInt32(Session["EmpID"]));
                    }
                    myTraining.spUpdateRISSafeHours(Convert.ToInt32(Request.QueryString["id"]), chkRISSafe.Checked, Convert.ToDouble(txtRISSafe.Text));
                    break;
                case "Other":
                    DataClassesDataContext myOtherDB = new DataClassesDataContext();
                    myOtherDB.spUpdateActivityMisc(Convert.ToInt32(Convert.ToInt32(Request.QueryString["id"]).ToString()), Convert.ToInt32(dropMisc.SelectedItem.Value), txtType.Text, Convert.ToInt32(Session["EmpID"]));
                    break;
                case "Info/Intel Distributed":
                    DataClassesDataContext myInfoDB = new DataClassesDataContext();
                    myInfoDB.spUpdateActivityInfoDist(Convert.ToInt32(Convert.ToInt32(Request.QueryString["id"]).ToString()), Convert.ToInt32(txtFaxes.Text), Convert.ToInt32(txtRecipients.Text), Convert.ToInt32(Session["EmpID"]));
                    break;
                default:
                    break;
            }

            if (Request.QueryString["l"] == "y")
            {
                Response.Redirect("listactivity.aspx");
            }
            else
            {
                Response.Redirect("default.aspx");
            }
        }
    }

    protected void cmdAddTrainingContactMember_Click(object sender, EventArgs e)
    {
        DataClassesDataContext myMember = new DataClassesDataContext();
        myMember.spInsertTrainingContact(Convert.ToInt32(Request.QueryString["id"]), Convert.ToInt32(dropTrainingContactAgency.SelectedItem.Value), txtMemberName.Text);
        txtMemberName.Text = "";
        GridTrainingContacts.DataBind();
    }

    protected void cmdAddNonMemberContact_Click(object sender, EventArgs e)
    {
        DataClassesDataContext myNonMember = new DataClassesDataContext();
        myNonMember.spInsertTrainingContactNonMember(Convert.ToInt32(Request.QueryString["id"]), txtNonMemberAgencyName.Text, txtNonMemberAgencyState.Text, txtNonMemberOfficerName.Text);
        txtNonMemberOfficerName.Text = "";
        txtNonMemberAgencyState.Text = "";
        txtNonMemberAgencyName.Text = "";
        GridView1.DataBind();
    }

    protected void GridTrainingContacts_SelectedIndexChanged(object sender, EventArgs e)
    {
        //do this
        string url = "addactivity.aspx?mid=" + GridTrainingContacts.SelectedDataKey.Value.ToString() + "&date=" + txtDate.Text;
        string s = "window.open('" + url + "', 'popup_window', 'width=1000,height=800,left=50,top=50,resizable=yes,scrollbars=1');";
        ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);

        //Response.Redirect("addactivity.aspx?mid=" + GridTrainingContacts.SelectedDataKey.Value.ToString() + "&date=" + txtDate.Text);
    }

    protected void GridTrainingMaterials_SelectedIndexChanged(object sender, EventArgs e)
    {
        //do this
        Response.Redirect("addactivity.aspx?mid=" + GridTrainingMaterials.SelectedDataKey.Value.ToString() + "&date=" + txtDate.Text);
    }


    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        //do this
        Response.Redirect("addactivity.aspx?nmid=y&name=" + GridView1.Rows[GridView1.SelectedIndex].Cells[0].Text + "&date=" + txtDate.Text + "&state=" + GridView1.Rows[GridView1.SelectedIndex].Cells[1].Text + "&pc=" + GridView1.Rows[GridView1.SelectedIndex].Cells[2].Text);
    }

    protected void dropMisc_SelectedIndexChanged(object sender, EventArgs e)
    {
        switch (dropMisc.SelectedItem.ToString())
        {
            case "Office Time":
                panOtherType.Visible = true;
                break;
            default:
                panOtherType.Visible = false;
                break;
        }
    }

    protected void cmdAddHandout_Click(object sender, EventArgs e)
    {
        lblMaterial.Visible = false;
        lblQuantity.Visible = false;
        if (txtMaterial.Text == "")
        {
            lblMaterial.Visible = true;
        }
        else if (txtQuantity.Text == "")
        {
            lblQuantity.Visible = true;
        }
        else
        {
            DataClassesDataContext myDB = new DataClassesDataContext();
            myDB.spInsertTrainingMaterial(Convert.ToInt32(Request.QueryString["id"]), txtMaterial.Text, Convert.ToInt32(txtQuantity.Text));
            txtMaterial.Text = "";
            txtQuantity.Text = "";
            GridTrainingMaterials.DataBind();
        }
    }

    protected void chkPhone_CheckedChanged(object sender, EventArgs e)
    {
        chkOnSite.Checked = false;
        chkNotOnSite.Checked = false;
        chkAttempted.Checked = false;
    }

    protected void chkOnSite_CheckedChanged(object sender, EventArgs e)
    {
        chkPhone.Checked = false;
        chkNotOnSite.Checked = false;
        chkAttempted.Checked = false;
    }

    protected void chkAttempted_CheckedChanged(object sender, EventArgs e)
    {
        chkOnSite.Checked = false;
        chkNotOnSite.Checked = false;
        chkPhone.Checked = false;
    }

    protected void chkNotOnSite_CheckedChanged(object sender, EventArgs e)
    {
        chkOnSite.Checked = false;
        chkPhone.Checked = false;
        chkAttempted.Checked = false;
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1>Edit Activity Event</h1>
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
                <td>Activity Type:
                    <font size="4"><i><u>
                        <asp:Label ID="lblActivityType" runat="server"></asp:Label></u></i></font>
                    <%--<asp:DropDownList ID="dropActivityType" runat="server" DataSourceID="SqlDataSource1"
                        DataTextField="FCS_atype_Type" DataValueField="FCS_atype_ID" AutoPostBack="true"
                        OnSelectedIndexChanged="dropActivityType_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>"
                        SelectCommand="spSelectActivityType" SelectCommandType="StoredProcedure"></asp:SqlDataSource>--%>
                </td>
            </tr>
            <tr>
                <td>Date:
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
            <asp:Panel ID="lblHours" runat="server">
                <tr>
                    <td>Hours:
                    <asp:TextBox ID="txtHours" Columns="5" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ControlToValidate="txtHours"
                            CssClass="validation" Text="*" runat="Server" /><asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                ErrorMessage="*" CssClass="validation" ValidationExpression="(^\d*\.?\d*[1-9]+\d*$)|(^[1-9]+\d*\.\d*$)"
                                ControlToValidate="txtHours" />
                    </td>
                </tr>
            </asp:Panel>
        </table>
        <asp:Panel ID="panInfoDist" runat="server">
            <table cellpadding="5" cellspacing="0" border="0">
                <tr>
                    <td># E-mails/Faxes/Etc.:
                        <asp:TextBox ID="txtFaxes" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td># Recipients:
                        <asp:TextBox ID="txtRecipients" runat="server"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="panAgency" runat="server">
            <table cellpadding="5" cellspacing="0" border="0">
                <tr>
                    <td>Agency:
                        <asp:DropDownList ID="dropAgency" runat="server" DataSourceID="SqlDataSource2" DataTextField="AgencyName"
                            DataValueField="ag_Key" AutoPostBack="true"
                            OnSelectedIndexChanged="dropAgency_SelectedIndexChanged">
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
                    <td>Person Contacted:
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
                            DataTextField="FullName" DataValueField="FullName">
                        </asp:DropDownList>
                        <img src="images/spacer.gif" height="0" width="20" />
                        <asp:CheckBox ID="chkAttemptedContact" Text="Attempted" runat="server" />
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
            </table>
        </asp:Panel>
        <asp:Panel ID="panNonMember" runat="server">
            <table cellpadding="5" cellspacing="0" border="0">
                <tr>
                    <td>Non-Member Agency Name:
                        <asp:TextBox ID="txtNonMemberName" Columns="50" MaxLength="100" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtNonMemberName"
                            CssClass="validation" Text="*" runat="Server" />
                    </td>
                </tr>
                <tr>
                    <td>Non-Member Agency City:
                        <asp:TextBox ID="txtNonMemberCity" Columns="50" MaxLength="50" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ControlToValidate="txtNonMemberCity"
                            CssClass="validation" Text="*" runat="Server" />
                    </td>
                </tr>
                <tr>
                    <td>Non-Member Agency State:
                        <asp:TextBox ID="txtNonMemberState" Columns="2" MaxLength="2" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ControlToValidate="txtNonMemberState"
                            CssClass="validation" Text="*" runat="Server" />
                    </td>
                </tr>
                <tr>
                    <td>Person Contacted:
                        <asp:TextBox ID="txtPersonContacted" Columns="50" MaxLength="100" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator22" ControlToValidate="txtPersonContacted"
                            CssClass="validation" Text="*" runat="Server" />
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
            </table>
        </asp:Panel>
        <asp:Panel ID="panRISSafe" runat="server">
            <table cellpadding="5" cellspacing="0" border="0">
                <tr>
                    <td>
                        <asp:CheckBox ID="chkRISSafe" runat="server" Text="RISSafe" />
                    </td>
                    <td>
                        <img src="images/spacer.gif" height="0" width="100" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtRISSafe" Columns="5" Text="0" runat="server"></asp:TextBox># RISSafe Hours<asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server"
                            ErrorMessage="*" CssClass="validation" ValidationExpression="(^\d*\.?\d*[0-9]+\d*$)|(^[0-9]+\d*\.\d*$)"
                            ControlToValidate="txtRISSafe" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="panVisitInfo" runat="server">
            <asp:UpdatePanel ID="upVisitInfo" runat="server">
                <ContentTemplate>
                    <table cellpadding="5" cellspacing="0" border="0">
                        <tr>
                            <td>
                                <asp:CheckBox ID="chkPhone" runat="server" Text="Phone Contact" AutoPostBack="true" OnCheckedChanged="chkPhone_CheckedChanged" />
                            </td>
                            <td>
                                <img src="images/spacer.gif" height="0" width="100" />
                            </td>
                            <td>
                                <asp:CheckBox ID="chkOnSite" runat="server" Text="On-Site" AutoPostBack="true" OnCheckedChanged="chkOnSite_CheckedChanged" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="chkAttempted" runat="server" Text="Attempted On-Site" AutoPostBack="true" OnCheckedChanged="chkAttempted_CheckedChanged" />
                            </td>
                            <td>
                                <img src="images/spacer.gif" height="0" width="100" />
                            </td>
                            <td>
                                <asp:CheckBox ID="chkNotOnSite" runat="server" AutoPostBack="true" Text="Not On-Site (agency contact during intel meeting, etc.)" OnCheckedChanged="chkNotOnSite_CheckedChanged" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="chkCISOP" runat="server" Text="CISOP Completed" />
                            </td>
                            <td>
                                <img src="images/spacer.gif" height="0" width="100" />
                            </td>
                            <td>
                                <asp:TextBox ID="txtSSLSetup" Columns="5" runat="server"></asp:TextBox>
                                # of SSL Accounts set this Visit<asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                                    ErrorMessage="*" CssClass="validation" ValidationExpression="(^\d*\.?\d*[0-9]+\d*$)|(^[0-9]+\d*\.\d*$)"
                                    ControlToValidate="txtSSLSetup" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="chkAtix" runat="server" Text="ATIX" />
                            </td>
                        </tr>
                    </table>
                    <table cellpadding="5" cellspacing="0" border="0">
                        <%--<tr>
                            <td>
                                Remote Connection&nbsp;<asp:DropDownList ID="dropRemote" runat="server">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                    <asp:ListItem Value="Working Properly" Text="Working Properly"></asp:ListItem>
                                    <asp:ListItem Value="Working Partially" Text="Working Partially"></asp:ListItem>
                                    <asp:ListItem Value="Not Working" Text="Not Working"></asp:ListItem>
                                    <asp:ListItem Value="Not Verified" Text="Not Verified"></asp:ListItem>
                                    <asp:ListItem Value="Not Connected" Text="Not Connected"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>--%>
                        <tr>
                            <td>
                                <asp:CheckBox ID="chkDemoed" runat="server" Text="Demoed/Discussed MOCIC/RISS Services (orientations/reorientations)" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="chkBackground" runat="server" Text="LEC Report, app/reapp process" />
                            </td>
                        </tr>
                        <tr>
                            <td>Other<br />
                                <asp:TextBox TextMode="MultiLine" Rows="4" Columns="50" ID="txtOther" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <img src="images/spacer.gif" height="7" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <img src="images/bar.jpg" height="3" width="800" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <img src="images/spacer.gif" height="7" />
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>
        <asp:Panel ID="panMisc" runat="server">
            <table cellpadding="5" cellspacing="0" border="0">
                <tr>
                    <td>
                        <asp:SqlDataSource ID="sqlMisc" runat="server" ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>"
                            SelectCommand="spSelectActivityMiscTypes" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        Other Type:
                        <asp:DropDownList ID="dropMisc" runat="server" DataSourceID="sqlMisc" DataTextField="FCS_amt_Type" AutoPostBack="true"
                            OnSelectedIndexChanged="dropMisc_SelectedIndexChanged" DataValueField="FCS_amt_ID">
                        </asp:DropDownList>
                    </td>
                </tr>
                <asp:Panel ID="panOtherType" runat="server">
                    <tr>
                        <td>Type:
                            <asp:TextBox ID="txtType" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </asp:Panel>
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
            </table>
        </asp:Panel>
        <asp:Panel ID="panTraining" runat="server">
            <table cellpadding="5" cellspacing="0" border="0">
                <tr>
                    <td>
                        <%--<asp:SqlDataSource ID="sqlTrainingType" runat="server" ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>"
                            SelectCommandType="StoredProcedure" SelectCommand="spSelectActivityTrainingTypes">
                        </asp:SqlDataSource>--%>
                        Meetings/Conferences/Trainings Type:
                        <font size="4"><i><u>
                            <asp:Label ID="lblMeetings" runat="server"></asp:Label></u></i></font>
                        <%--<asp:DropDownList ID="dropTrainingType" DataSourceID="sqlTrainingType" DataTextField="FCS_att_Type"
                            DataValueField="FCS_att_ID" runat="server" AutoPostBack="true" OnSelectedIndexChanged="dropTrainingType_SelectedIndexChanged">
                        </asp:DropDownList>--%>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="panAttendedMeeting" runat="server">
                <table cellpadding="5" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <img src="images/spacer.gif" height="0" width="20" />
                        </td>
                        <td>
                            <asp:RadioButtonList ID="rdoSponsored" runat="server">
                                <asp:ListItem Value="0" Text="NOT sponsored or co-sponsored by MOCIC/RISS (i.e. USAO LECC meeting, NSA, IACP, IALEA, etc.)"></asp:ListItem>
                                <asp:ListItem Value="1" Text="Sponsored or co-sponsored by MOCIC/RISS(i.e. SLATT, NW3C, etc. - check with Training Dept. if unsure)"></asp:ListItem>
                            </asp:RadioButtonList><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator13" CssClass="validation" ControlToValidate="rdoSponsored" Text="*"
                                runat="Server" />
                        </td>
                    </tr>
                    <%--<tr>
                        <td>
                            <img src="images/spacer.gif" height="0" width="20" />
                        </td>
                        <td>
                            <asp:CheckBox ID="chkPresenter" Text="I was a Presenter" runat="server" />
                        </td>
                    </tr>--%>
                    <tr>
                        <td colspan="2">Participated as
                            <asp:DropDownList ID="dropParticipated" runat="server">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                                <asp:ListItem Text="Presenter" Value="Presenter"></asp:ListItem>
                                <asp:ListItem Text="Vendor" Value="Vendor"></asp:ListItem>
                                <asp:ListItem Text="Attendee" Value="Attendee"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">Name of Meeting
                            <asp:TextBox ID="txtMeetingName" Columns="75" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator14" CssClass="validation" ControlToValidate="txtMeetingName" Text="*"
                                runat="Server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">Meeting City
                            <asp:TextBox ID="txtMeetingCity" Columns="50" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator15" CssClass="validation" ControlToValidate="txtMeetingCity" Text="*"
                                runat="Server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">Meeting State
                            <asp:TextBox ID="txtMeetingState" Columns="2" MaxLength="2" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator16" CssClass="validation" ControlToValidate="txtMeetingState" Text="*"
                                runat="Server" />
                        </td>
                    </tr>
                </table>
                <asp:Panel ID="panSponsored" runat="server">
                    <table cellpadding="5" cellspacing="0" border="0">
                        <tr>
                            <td># of agencies in attendance
                                <asp:TextBox ID="txtMeetingAgencies" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                    ID="RequiredFieldValidator17" CssClass="validation" ControlToValidate="txtMeetingAgencies" Text="*"
                                    runat="Server" /><asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server"
                                        ErrorMessage="*" CssClass="validation" ValidationExpression="(^\d*\.?\d*[1-9]+\d*$)|(^[1-9]+\d*\.\d*$)"
                                        ControlToValidate="txtMeetingAgencies" />
                            </td>
                        </tr>
                        <tr>
                            <td># of attendees
                                <asp:TextBox ID="txtMeetingAttendees" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                    ID="RequiredFieldValidator18" CssClass="validation" ControlToValidate="txtMeetingAttendees" Text="*"
                                    runat="Server" /><asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server"
                                        ErrorMessage="*" CssClass="validation" ValidationExpression="(^\d*\.?\d*[1-9]+\d*$)|(^[1-9]+\d*\.\d*$)"
                                        ControlToValidate="txtMeetingAttendees" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td><u>Material handed out during meeting/training</u></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:SqlDataSource ID="SqlTrainingMaterials" runat="server"
                                                ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>"
                                                UpdateCommand="spUpdateTrainingMaterial" UpdateCommandType="StoredProcedure"
                                                DeleteCommand="spDeleteTrainingMaterial" DeleteCommandType="StoredProcedure"
                                                SelectCommand="spSelectTrainingMaterials" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int32" />
                                                </SelectParameters>
                                                <UpdateParameters>
                                                    <asp:Parameter Type="Int32" Name="FCS_am_ID" />
                                                    <asp:Parameter Type="String" Name="FCS_am_material" />
                                                    <asp:Parameter Type="Int32" Name="FCS_am_quantity" />
                                                </UpdateParameters>
                                                <DeleteParameters>
                                                    <asp:Parameter Type="Int32" Name="FCS_am_ID" />
                                                </DeleteParameters>
                                            </asp:SqlDataSource>
                                            <asp:GridView ID="GridTrainingMaterials" runat="server"
                                                EmptyDataText="No Materials Handed Out" AllowSorting="True"
                                                AutoGenerateColumns="False" CellPadding="4"
                                                DataSourceID="SqlTrainingMaterials" HorizontalAlign="Left"
                                                ForeColor="#333333" GridLines="None" DataKeyNames="FCS_am_ID"
                                                OnSelectedIndexChanged="GridTrainingMaterials_SelectedIndexChanged">
                                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                <Columns>
                                                    <%--<asp:BoundField DataField="FCS_am_material" HeaderText="Material" 
                                                        SortExpression="FCS_am_material" />
                                                    <asp:BoundField DataField="FCS_am_quantity" HeaderText="Quantity" 
                                                        SortExpression="FCS_am_quantity" />--%>
                                                    <asp:BoundField DataField="FCS_am_ID" Visible="false" />
                                                    <asp:TemplateField HeaderText="Material" SortExpression="FCS_am_material">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtGridMaterial" Text='<%# Bind("FCS_am_material") %>' runat="server"></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblGridMaterial" Text='<%# Bind("FCS_am_material") %>' runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Quantity" SortExpression="FCS_am_quantity">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtGridQuantity" Text='<%# Bind("FCS_am_quantity") %>' runat="server"></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblGridQuantity" Text='<%# Bind("FCS_am_quantity") %>' runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:CommandField ShowDeleteButton="True" />
                                                    <asp:CommandField ShowEditButton="True" />
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
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Material
                                            <asp:TextBox ID="txtMaterial" runat="server"></asp:TextBox><asp:Label ID="lblMaterial" Text="*" ForeColor="Red" Visible="false" runat="server"></asp:Label>&nbsp;&nbsp;Quantity
                                            <asp:TextBox ID="txtQuantity" Columns="3" runat="server"></asp:TextBox><asp:Label ID="lblQuantity" Text="*" ForeColor="Red" Visible="false" runat="server"></asp:Label>
                                            <asp:Button ID="cmdAddHandout" Text="Add Handout" runat="server" OnClick="cmdAddHandout_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>How do you rate the value of your attendance at this event? (1=no value - 10=very significant value) 
                                <asp:DropDownList ID="dropValue" runat="server">
                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                    <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                    <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                    <asp:ListItem Text="9" Value="9"></asp:ListItem>
                                    <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>In your opinion what will RISS/MOCIC gain from you participation?<br />
                                <asp:TextBox ID="txtGain" runat="server" Columns="50" Rows="4"
                                    TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>

                        <%--<tr>
                            <td>
                                # of hours
                                <asp:TextBox ID="txtMeetingHours" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator19" CssClass="validation" ControlToValidate="txtMeetingHours" Text="*"
                                runat="Server" /><asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server"
                                    ErrorMessage="*" CssClass="validation" ValidationExpression="(^\d*\.?\d*[1-9]+\d*$)|(^[1-9]+\d*\.\d*$)"
                                    ControlToValidate="txtMeetingHours" />
                            </td>
                        </tr>--%>
                    </table>
                </asp:Panel>
            </asp:Panel>
            <asp:Panel ID="panAttendedTraining" runat="server">
                <table cellpadding="5" cellspacing="0" border="0">
                    <tr>
                        <td>Training name:
                            <asp:TextBox ID="txtTrainingAttended" MaxLength="50" runat="server" /><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator3" CssClass="validation" ControlToValidate="txtTrainingAttended" Text="*"
                                runat="Server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">City:
                            <asp:TextBox ID="txtTrainingCity" Columns="50" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator20" CssClass="validation" ControlToValidate="txtTrainingCity" Text="*" runat="Server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">State:
                            <asp:TextBox ID="txtTrainingState" Columns="2" MaxLength="2" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator21" CssClass="validation" ControlToValidate="txtTrainingState" Text="*" runat="Server" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <table cellpadding="5" cellspacing="0" border="0">
                <tr>
                    <td>Notes<br />
                        <asp:TextBox ID="txtNotes" TextMode="MultiLine" Columns="75" Rows="5" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="images/spacer.gif" height="7" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <img src="images/bar.jpg" height="3" width="800" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="images/spacer.gif" height="7" />
                    </td>
                </tr>
            </table>
        </asp:Panel>

        <asp:Panel ID="panButtons" runat="server">
            <table cellpadding="5" cellspacing="0" border="0" width="800px">
                <tr class="center">
                    <td class="center">
                        <asp:Button ID="cmdSave" runat="server" Text="Save" OnClick="cmdSave_Click" /><img
                            src="images/spacer.gif" height="0" width="50" />
                        <asp:Button ID="cmdCancel" runat="server" CausesValidation="false" Text="Cancel" OnClick="cmdCancel_Click" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="images/spacer.gif" height="7" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <img src="images/bar.jpg" height="3" width="800" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="images/spacer.gif" height="7" />
                    </td>
                </tr>
            </table>
        </asp:Panel>

        <asp:Panel ID="panUserUpdate" runat="server">
            <table cellpadding="2" cellspacing="0" border="0" width="800px">
                <tr>
                    <td class="center">
                        <asp:Label ID="lblAgencyName" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="center">
                        <asp:Label ID="lblAddress1" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="center">
                        <asp:Label ID="lblAddress2" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="center">
                        <asp:Label ID="lblAddress3" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="center">
                        <asp:Label ID="lblCity" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="center">
                        <asp:Label ID="lblPhone" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="center">
                        <asp:Label ID="lblFax" runat="server"></asp:Label></td>
                </tr>
            </table>
            <br />
            <%--<table cellpadding="2" cellspacing="0" border="0" width="800px">
                <tr>
                    <td>Officers</td>
                    <td>Information</td>
                    <td>Address</td>
                    <td>Remove</td>
                </tr>
                

            </table>--%>
            <div id="divNonRemote" runat="server"></div>

            <br />

            <table cellpadding="2" cellspacing="0" border="0" width="800px">
                <tr>
                    <td valign="top">
                        <br />
                        <asp:CheckBox ID="chkInterim" Text="Send Interim Agreement" runat="server" /><br />
                        <asp:CheckBox ID="chkReapplication" Text="Send Reapplication Paperwork" runat="server" />
                    </td>
                    <td>&nbsp;</td>
                    <td class="center">Other Updates:<br />
                        <asp:TextBox ID="txtAgencyUpdateComments" TextMode="MultiLine" Rows="8" Columns="35"
                            runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" class="center">
                        <asp:Button ID="cmdAgencyCommentsSave" Text="Submit" runat="server" OnClick="cmdAgencyCommentsSave_onClick" /><br />
                        <br />
                    </td>
                </tr>
            </table>

        </asp:Panel>

        <asp:Panel ID="panTrainingAgencyContacts" runat="server">

            <table cellpadding="7" cellspacing="0" border="0" width="800px">
                <tr>
                    <td class="center"><font class="tableheadings">Members Contacted at Training</font></td>
                </tr>
                <tr>
                    <td class="center">
                        <asp:SqlDataSource ID="SqlTrainingContacts" runat="server"
                            ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>"
                            SelectCommand="spSelectTrainingContacts" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:GridView ID="GridTrainingContacts" runat="server"
                            EmptyDataText="No Members Contacted" AllowSorting="True"
                            AutoGenerateColumns="False" CellPadding="4"
                            DataSourceID="SqlTrainingContacts" HorizontalAlign="Center"
                            ForeColor="#333333" GridLines="None" DataKeyNames="FCS_tc_ag_Key"
                            OnSelectedIndexChanged="GridTrainingContacts_SelectedIndexChanged">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:BoundField DataField="ag_Name" HeaderText="Agency Name"
                                    SortExpression="ag_Name" />
                                <asp:BoundField DataField="ag_State" HeaderText="State"
                                    SortExpression="ag_State" />
                                <asp:BoundField DataField="FCS_tc_Member_Name" HeaderText="Member Name"
                                    SortExpression="FCS_tc_Member_Name" />
                                <asp:BoundField DataField="FCS_tc_ag_Key" HeaderText="FCS_tc_ag_Key"
                                    SortExpression="FCS_tc_ag_Key" Visible="False" />
                                <asp:CommandField ShowSelectButton="True" />
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
                        <br />
                    </td>
                </tr>
            </table>

            <table cellpadding="7" cellspacing="0" border="0" width="800px">
                <tr>
                    <td class="center">
                        <asp:DropDownList ID="dropTrainingContactAgency" runat="server" DataSourceID="SqlDataSource2" DataTextField="AgencyName"
                            DataValueField="ag_Key">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="center">Member Name:
                        <asp:TextBox ID="txtMemberName" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="center">
                        <asp:Button ID="cmdAddTrainingContactMember" Text="Add Member"
                            runat="server" OnClick="cmdAddTrainingContactMember_Click" /></td>
                </tr>
            </table>

            <table cellpadding="7" cellspacing="0" border="0" width="800px">
                <tr>
                    <td class="center"><font class="tableheadings">Non-Members Contacted at Training</font></td>
                </tr>
                <tr>
                    <td class="center">
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                            ConnectionString="<%$ ConnectionStrings:FieldCoorSuiteConnectionString %>"
                            SelectCommand="spSelectTrainingContactsNonMember" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:GridView ID="GridView1" runat="server"
                            EmptyDataText="No Non-Members Contacted" AllowSorting="True"
                            AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" HorizontalAlign="Center"
                            ForeColor="#333333" GridLines="None"
                            OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:BoundField DataField="FCS_tcnm_Agency_Name" HeaderText="Agency Name"
                                    SortExpression="FCS_tcnm_Agency_Name" />
                                <asp:BoundField DataField="FCS_tcnm_State" HeaderText="State"
                                    SortExpression="ag_State" />
                                <asp:BoundField DataField="FCS_tcnm_Officer" HeaderText="Officer Name"
                                    SortExpression="FCS_tcnm_Officer" />
                                <asp:BoundField DataField="FCS_tc_ag_Key" HeaderText="FCS_tc_ag_Key"
                                    SortExpression="FCS_tc_ag_Key" Visible="False" />
                                <asp:CommandField ShowSelectButton="True" />
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
                        <br />
                    </td>
                </tr>
            </table>
            <table cellpadding="7" cellspacing="0" border="0" width="800px">
                <tr>
                    <td class="center">Agency Name:
                        <asp:TextBox ID="txtNonMemberAgencyName" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="center">Agency State:
                        <asp:TextBox ID="txtNonMemberAgencyState" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="center">Officer Name:
                        <asp:TextBox ID="txtNonMemberOfficerName" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="center">
                        <asp:Button ID="cmdAddNonMemberContact"
                            Text="Add Non-Member Contact" runat="server"
                            OnClick="cmdAddNonMemberContact_Click" /></td>
                </tr>
            </table>
        </asp:Panel>

    </asp:Panel>
</asp:Content>

