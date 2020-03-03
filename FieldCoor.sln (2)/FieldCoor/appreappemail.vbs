Option Explicit

dim objConn
dim objCmd
dim objCmd2
dim objRS
dim msg
dim thebody

Set objConn = CreateObject("ADODB.Connection")
objConn.Open "Driver=SQL Server;Server=SRV-DBS1;Database=FieldCoorSuite;UID=MOCIC_IT;PWD=!it_MOCIC!"

Set objCmd = CreateObject("ADODB.Command")
Set objRS = CreateObject("ADODB.Recordset")
objCmd.ActiveConnection = objConn
objCmd.CommandType = 4
objCmd.CommandText = "spSelect30DayAppReappNotificationEmail"
set objRS = objCmd.Execute

Do until objRS.eof
  
  thebody = "<html>"
  thebody = thebody & "<head>"
  thebody = thebody & "<title>App/Reapp needing updated</title>"
  thebody = thebody & "</head>"
  thebody = thebody & "<body>"
  thebody = thebody & "<p>Currently there is an open app/reapp that needs to be updated.</p>"
  thebody = thebody & "<p>The agency name is " & objRS("AgencyName") & ".  The last time the case was updated was " & objRS("UpdateDate") & ".</p>"
  thebody = thebody & "</body>"
  thebody = thebody & "</html>"
  
  set msg = CreateObject( "JMail.Message" )
  msg.ContentType = "text/html"
  msg.Logging = true
  msg.silent = true
  msg.From = "tlong@mocic.riss.net"
  msg.FromName = "App/Reapp Notification"
  If objRS("Type") = "Requested Application" then
    msg.AddRecipient "tlong@mocic.riss.net"
    msg.AddRecipient "lterhune@mocic.riss.net"
  else
    msg.AddRecipient objRS("UserName") & "@mocic.riss.net"
  End If
  'msg.AddRecipient "bblades@mocic.riss.net"
  msg.AddRecipientCC "tlong@mocic.riss.net"
  msg.AddRecipientCC "lterhune@mocic.riss.net"
  
  'msg.AddRecipientBCC "bblades@mocic.riss.net"
  msg.Subject = "App/Reapp Needing Updated Notification"
  msg.Body = thebody
  msg.Send( "10.12.1.2" )
  
  objRS.movenext
Loop

objRS.Close
objConn.Close
Set objRS = nothing
Set objCmd = nothing
Set objConn = nothing

CompletedMail()

sub CompletedMail()

	thebody = "<html>"
	thebody = thebody & "<head>"
	thebody = thebody & "<title>App/Reapp reminder routine completed</title>"
	thebody = thebody & "</head>"
	thebody = thebody & "<body>"
	thebody = thebody & "<p>The app/reapp reminder daily routine completed successfully.</p>"
	thebody = thebody & "</body>"
	thebody = thebody & "</html>"
	
	set msg = CreateObject( "JMail.Message" )
	msg.ContentType = "text/html"
	msg.Logging = true
	msg.silent = true
	msg.From = "bblades@mocic.riss.net"
	msg.FromName = "App/Reapp Reminder Routine"
	msg.AddRecipient "bblades@mocic.riss.net"
	msg.Subject = "App/Reapp Reminder Routine Completed"
	msg.Body = thebody
	msg.Send( "10.12.1.2" )
	
end sub
