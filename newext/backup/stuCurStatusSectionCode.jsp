<%@ page import="java.sql.*,model.DataManager,java.text.*" %>
<% DataManager database=(DataManager)pageContext.getAttribute("db",PageContext.APPLICATION_SCOPE); Connection con=database.getConnection(); %>
<%

Statement st,st1,st2,st3,st4;
ResultSet rs,rs1,rs2,rs3,rs4;
PreparedStatement ps1,ps2,ps3;
String[] subcode = new String[1000];
int subcount=0;
int internalmax=0,externalmax=0;
String subjecttypeid="";

String regno= "";
String course="",branch="",year="",semester="",subject="",sln="",exam="",sql="",date="",date1="",reg="",ext="",cc="",bc="",name="",status="",monthYear="";
cc = request.getParameter("course");
bc = request.getParameter("branch");
String batch= request.getParameter("batch");
String section= request.getParameter("section");
java.util.Date now = new java.util.Date();
date = now.getDate()+"."+(now.getMonth()+1)+"."+(now.getYear()+1900);
int marks=0,internal=0,external=0;
int sl=0,pages=0,count=0,total=0,cyear=0,sem=0,i=0,sm=0,score=0,tscore=0,ttotal=0;
double percent=0;
NumberFormat nf=new DecimalFormat("0.00");
%>
<head>
<title>Vignan University :: Vadlamudi</title>
<style type="text/css">
table			{border-collapse:collapse;}
th,td			{font-family:Verdana;font-size:9pt;line-height:15px;}
legend							{font-style:Verdana;font-size:7pt; font-weight:bold;text-align:center;}
#fieldset td,#fieldset th		{font-family:Verdana;font-size:7pt;line-height:10px;text-overflow:ellipsis;white-space:nowrap;padding-top:2px;padding-bottom:2px;}
.right	{border-right:solid 1px;}
.left	{border-left:solid 1px;}
.top	{border-top:solid 1px;}
.bottom	{border-bottom:solid 1px;}
@media print
{
	p			{page-break-after:always;}
	body		{margin:0;}
}
</style>
</head>
<body>
<%
st4=con.createStatement();
rs4=st4.executeQuery("Select * from administrator.course where coursecode='"+cc+"'");
if(rs4.next())
{
	course = rs4.getString("coursename");
}
rs4.close();
st4=con.createStatement();
rs4=st4.executeQuery("Select * from administrator.branch where coursecode='"+cc+"' and branchcode='"+bc+"'");
if(rs4.next())
{
	branch = rs4.getString("branchname");
}
rs4.close();

rs4=st4.executeQuery("Select * from attendance.student where registerno like '"+batch+"%' and coursecode='"+cc+"' and branchcode='"+bc+"' and sectioncode='"+section+"' order by registerno");
//out.println("Select * from attendance.student where registerno like '"+batch+"%' and coursecode='"+cc+"' and branchcode='"+bc+"' order by registerno");
while(rs4.next())
{
	total=0;score=0;tscore=0;ttotal=0;
	out.println("<table width='100%' cellspacing=0 cellpadding=10 border=0>");
	out.println("<tr><th colspan='2'>Vignan University :: Vadlamudi<br>Department of "+branch+"</tr>");
	out.println("<tr><td width='50%'>To,<td width='50%' align='right'>Date: "+date+"</tr>");
	out.println("<tr><td colspan='2'>Mr./Mrs. "+rs4.getString("father")+"");
	out.println("<br>F/O "+rs4.getString("name")+" ("+rs4.getString("registerno")+")");
	out.println("<br>"+rs4.getString("houseno")+"");
	out.println("<br>"+rs4.getString("street")+"");
	out.println("<br>"+rs4.getString("city")+"");
	out.println("<br>"+rs4.getString("state")+"-"+rs4.getString("pincode")+"");
	out.println("<br><br>Sir/Madam, <br><br><b  style='padding-left:30px;'>The performance of your ward in "+course+", Examinations conducted upto July 2012 is given below. If you need any more information you can contact the councellor.");
	%>
	</table>
	<table width='100%' cellspacing=0 cellpadding=1 border=0>
	<tr>
	<%
	ps1 = con.prepareStatement("select subjectname from subjects where subjectcode=?");
	ps2 = con.prepareStatement("select internal, external,maxmarks, monthYear,status from marksmaster where cc='"+cc+"' and cyear=? and semester=? and registerno='"+rs4.getString("registerno")+"' and subjectcode=? order by STATUS desc,id desc");
	st=con.createStatement();
	rs=st.executeQuery("Select DISTINCT subjectcode,subjectname, cyear, semester from marksmaster where registerno='"+rs4.getString("registerno")+"' order by cyear,semester,subjecttypeid,subjectcode");
	i=0;sm=0;
	count=0;
	total=0;score=0;percent=0.0D;
	while(rs.next())
	{
		
		switch(rs.getInt("cyear"))
		{
			case	1	:	year="I";break;
			case	2	:	year="II";break;
			case	3	:	year="III";break;
			case	4	:	year="IV";break;
		}

		switch(rs.getInt("semester"))
		{
			case	1	:	semester="I";break;
			case	2	:	semester="II";break;
			case	3	:	semester="I";break;
			case	4	:	semester="II";break;
			case	5	:	semester="I";break;
			case	6	:	semester="II";break;
			case	7	:	semester="I";break;
			case	8	:	semester="II";break;
		}
		if(sm!=rs.getInt("semester"))
		{
			if(sm!=0)
			{
				if(total>0)
					percent = (double)score*100/total;
				out.println("<tr><td colspan='2' class='top' align='right'><b>Semester Aggregate % </td><td colspan='4'  class='top'><b>"+nf.format(percent)+"("+score+"/"+total+")</tr>");
				out.println("</table></fieldset></td>");
				
				ttotal+=total;
				tscore+=score;
				total=0;score=0;
			}
			if(i%2==0)
				out.println("</tr><tr>");
			sm=rs.getInt("semester");	
		
			out.println("<td width='50%' valign='top'><fieldset id='fieldset'><legend>"+year+" YEAR - "+semester+" SEMESTER</legend><table width='100%' cellspacing=0 cellpadding=0 border=0>");
			out.println("<tr style='border-bottom: 1px solid;'><th align='center' width='1%' class='top left'>S.NO.<th align='center'  width='40%' class='top left'>SUBJECT NAME<th align='center'  width='2%' class='top left'>INT<th align='center'  class='top left' width='2%'>EXT<th align='center'  class='top left' width='2%'>TOTAL<th align='center'  class='top left right' width='2%'>RESULT</tr>");
			i++;
			count=0;
		}
		count++;
		
		subject = rs.getString("subjectname").toUpperCase();
		subject = subject.replace("MINUS","-");
		
		ps2.setInt(1,rs.getInt("cyear"));
		ps2.setInt(2,rs.getInt("semester"));
		ps2.setString(3,rs.getString("subjectcode"));
		rs1 = ps2.executeQuery();
		monthYear="";
		internal=0;
		external=0;
		status="";
		if(rs1.next())
		{
			internal = rs1.getInt("internal");
			external = rs1.getInt("external");
			status = rs1.getString("status");
			total+=rs1.getInt("maxmarks");
		}
		rs1.close();
		out.println("<tr><td align='center' class='left'>"+count+"</td><td class='left'>"+subject+"</td>");
		if(external==-1)
		{
			external=0;
		}
		score+=internal+external;
		out.println("<td align='center' class='left'>"+internal+"</td><td align='center' class='left'>"+external+"</td><td align='center' class='left'>"+(internal+external)+"</td><td align='center' class='left right'>"+status+"</td></tr>");

		
	}
	ttotal+=total;
	tscore+=score;
	if(total>0)
		percent = (double)score*100/total;
					out.println("<tr><td colspan='2' class='top' align='right'><b>Semester Aggregate % </td><td colspan='4'  class='top'><b>"+nf.format(percent)+"("+score+"/"+total+")</tr>");
	out.println("</table></fieldset></td>");
	if(ttotal>0)
		percent = (double)tscore*100/ttotal;
	out.println("</tr><tr><td><br><b>Total Aggregate % of marks : "+nf.format(percent)+"("+tscore+"/"+ttotal+")</td><td><br><b>The attendance in the present semester:___________</tr>");
	out.println("<tr><td align='left' colspan='2'><br><br><b style='padding-left:50px;'>Thanking You,</tr>");
	out.println("<tr><td align='left' >&nbsp;<td align='center'><br><br><b>Head of the Department</td></tr>");
	out.println("<tr><td  colspan='2' ><br><b style='padding-left:50px;'>Councellor Name : <br><br> <b style='padding-left:50px;'>Phone No : <br><br> <b style='padding-left:50px;'>Signature: </td></table><p></p>");
	rs.close();
	st.close();
}
rs4.close();
st4.close();



%>