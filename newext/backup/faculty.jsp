<%@ page import="java.sql.*,model.DataManager,java.text.*" %>
<% DataManager db=(DataManager)pageContext.getAttribute("db",PageContext.APPLICATION_SCOPE); Connection con=db.getConnection(); %>
<%
String lid=(String)session.getAttribute("who");
String dt[]=new String[100];
out.println(lid);
Statement st,st1,st2,st3,st4;
ResultSet rs,rs1,rs2,rs3,rs4,rr,rr1,rr2;
PreparedStatement ps1,ps2,ps3;
String[] subcode = new String[1000];
int subcount=0;
int internalmax=0,externalmax=0;
String subjecttypeid="";
String fromDate=request.getParameter("date1");
String date1=fromDate;
String toDate=request.getParameter("date2");
String date2=toDate;
dt=fromDate.split("-");
fromDate=dt[2]+"-"+dt[1]+"-"+dt[0];
dt=toDate.split("-");
toDate=dt[2]+"-"+dt[1]+"-"+dt[0];
String subject1[]=new String[100];
int subid[]=new int[100];
String regno= "",registerno="";
String course="",branch="",year="",semester="",subject="",sln="",section="",exam="",sql="",date="",reg="",ext="",cc="",bc="",name="",status="",monthYear="",doj="";
String[] sub=new String[1000];
int subcnt=0,subc=0,datediff=0;
String attendance_and_examcell_1="";
//cc = request.getParameter("course");
//bc = request.getParameter("branch");
///String batch= request.getParameter("batch");
//String section= request.getParameter("section");
java.util.Date now = new java.util.Date();
date = now.getDate()+"."+(now.getMonth()+1)+"."+(now.getYear()+1900);
int marks=0,internal=0,external=0;
int sl=0,pages=0,count=0,total=0,cyear=0,sem=0,i=0,sm=0,score=0,tscore=0,ttotal=0;
double percent=0;
int all_a=0,all_c=0;


//int batch1=Integer.parseInt(batch);
//out.println(batch1);

//out.println(sem);
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



//out.println("select * from student_master.student_faculty1 where empcode='"+lid+"'");
if(db.operation("select * from student_master.student_faculty1 where empcode='"+lid+"'","select"))
{
  rr=db.getResultSet();
  rr.beforeFirst();
  while(rr.next())
	{
    
      registerno=rr.getString("registerno");
      // out.println("Select * from student_master.financestudent where registerno='"+register+"'");
    if(db.operation("Select * from student_master.financestudent where registerno='"+registerno+"'","select"))
		{
			rs4=db.getResultSet();
			rs4.beforeFirst();
		//out.println("Select * from attendance.student where registerno like '"+batch+"%' and coursecode='"+cc+"' and branchcode='"+bc+"' order by registerno");
			if(rs4.next())
			{
				 cc=rs4.getString("coursecode");
			  bc=rs4.getString("branchcode");
			   cyear=rs4.getInt("cyear");
			   sem=rs4.getInt("semester");
			  section=rs4.getString("sectioncode");
              doj=rs4.getString("doj");

				db.operation("Select * from administrator.course where coursecode='"+cc+"'","select");
				rr1=db.getResultSet();
				rr1.beforeFirst();
				if(rr1.next())
				{
					course = rr1.getString("coursename");
				}
				rr1.close();
				db.operation("Select * from administrator.branch where coursecode='"+cc+"' and branchcode='"+bc+"'","select");
				rr2=db.getResultSet();
				rr2.beforeFirst();
				if(rr2.next())
				{
					branch = rr2.getString("branchname");
				}
				rr2.close();
				if(db.operation("select * from student_master.alldatabases1 where coursecode='"+cc+"' and status='1'","select"))
				{
				rr2=db.getResultSet();
				rr2.beforeFirst();
				if(rr2.next())
				{	
					attendance_and_examcell_1=rr2.getString("database");
					//out.println(attendance_and_examcell_1);
					//out.println(rs.getString("database"));
				}
				rr2=null;
				}
				//registerno=rs4.getString("registerno");
				//doj=rs4.getString("doj");
				total=0;score=0;tscore=0;ttotal=0;
				out.println("<table width='100%' cellspacing=0 cellpadding=10 border=0>");
				out.println("<tr><th colspan='2'>Vignan University :: Vadlamudi<br>Department of "+branch+"</tr>");
				out.println("<tr><td width='50%'>To,<td width='50%' align='right'>Date: "+date+"</tr>");
				out.println("<tr><td colspan='2'>Mr./Mrs. "+rs4.getString("fathername")+"");
				out.println("<br>F/O "+rs4.getString("name")+" ("+rs4.getString("registerno")+")");
				out.println("<br>"+rs4.getString("houseno")+"");
				out.println("<br>"+rs4.getString("street")+"");
				out.println("<br>"+rs4.getString("town")+"");
				out.println("<br>"+rs4.getString("state")+"-"+rs4.getString("pincode")+"");
				out.println("<br><br>Sir/Madam, <br><br><b  style='padding-left:30px;'>The performance of your ward in "+course+", Examinations conducted upto July 2012 is given below. If you need any more information you can contact the councellor.");
				%>
				</table>
				<table width='100%' cellspacing=0 cellpadding=1 border=0>
				<tr>
				<%
				ps1 = con.prepareStatement("select subjectname from subjects where subjectcode=?");
				ps2 = con.prepareStatement("select internal, external,maxmarks, monthYear,status from marksmaster where cc='"+cc+"' and cyear=? and semester=? and registerno='"+registerno+"' and subjectcode=? order by STATUS desc,id desc");
				//st=con.createStatement();
				db.operation("Select DISTINCT subjectcode,subjectname, cyear, semester from university.marksmaster where registerno='"+registerno+"' order by cyear,semester,subjecttypeid,subjectcode","select");
				rs=db.getResultSet();
			rs.beforeFirst();
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
					out.println("</tr><tr><td><br><b>Total Aggregate % of marks : "+nf.format(percent)+"("+tscore+"/"+ttotal+")</td>");

					rs.close();
                    

					if(db.operation("select distinct(t1.subjectcode),t1.subjecttypeid,t2.shortname from `"+attendance_and_examcell_1+"`.studentsubject t1 left join vignan.subjects t2 on (t1.subjectcode=t2.subjectcode) where t1.coursecode='"+cc+"' and t1.branchcode='"+bc+"' and t1.cyear="+cyear+" and t1.semester="+sem+" and t1.sectioncode='"+section+"' order by t1.subjecttypeid,t1.subjectcode","select"))
						{
							rs = db.getResultSet();
							rs.beforeFirst();
							while(rs.next())
							{
								//out.println("<th>"+rs.getString("shortname")+"</th>");
								sub[subcnt++]=rs.getString("subjectcode");
							}
							rs=null;
						}


						//out.println("select t1.subjecttypeid,t1.subjectcode,count(t3.date) as tot from (select * from `"+attendance_and_examcell_1+"`.semestersubject where coursecode='"+cc+"' and branchcode='"+bc+"' and cyear="+cyear+" and semester="+sem+") t1 left join (select distinct coursecode,branchcode,cyear,semestercode,sectioncode,subjectcode,period,date,subjecttypeid,batchno from `"+attendance_and_examcell_1+"`.subjecthours where coursecode='"+cc+"' and branchcode='"+bc+"' and cyear="+cyear+" and semestercode="+sem+" and sectioncode='"+section+"' and date>='"+fromDate+"' and date<='"+toDate+"') t3 on (t3.coursecode=t1.coursecode and t3.branchcode=t1.branchcode and t3.cyear=t1.cyear and t3.semestercode=t1.semester and t3.subjectcode=t1.subjectcode and t3.subjecttypeid=t1.subjecttypeid) where t3.date is not null and t3.period is not null  GROUP by t1.subjectcode,t1.subjecttypeid order by t1.subjecttypeid,t1.subjectcode");
						if(db.operation("select t1.subjecttypeid,t1.subjectcode,count(t3.date) as tot from (select * from `"+attendance_and_examcell_1+"`.semestersubject where coursecode='"+cc+"' and branchcode='"+bc+"' and cyear="+cyear+" and semester="+sem+") t1 left join (select distinct coursecode,branchcode,cyear,semestercode,sectioncode,subjectcode,period,date,subjecttypeid,batchno from `"+attendance_and_examcell_1+"`.subjecthours where coursecode='"+cc+"' and branchcode='"+bc+"' and cyear="+cyear+" and semestercode="+sem+" and sectioncode='"+section+"' and date>='"+fromDate+"' and date<='"+toDate+"') t3 on (t3.coursecode=t1.coursecode and t3.branchcode=t1.branchcode and t3.cyear=t1.cyear and t3.semestercode=t1.semester and t3.subjectcode=t1.subjectcode and t3.subjecttypeid=t1.subjecttypeid) where t3.date is not null and t3.period is not null  GROUP by t1.subjectcode,t1.subjecttypeid order by t1.subjecttypeid,t1.subjectcode","select"))
						{
							//
							rs = db.getResultSet();
							rs.beforeFirst();
							while(rs.next())
							{
								if(sub[subc].equalsIgnoreCase(rs.getString("subjectcode")))
								{
									while(subc<subcnt && !sub[subc].equalsIgnoreCase(rs.getString("subjectcode")))
									{
										subc++;
										//out.println("<th>-</th>");
									}
								}
								if(subc<subcnt && sub[subc].equalsIgnoreCase(rs.getString("subjectcode")))
								{
									if(rs.getInt("subjecttypeid")!=2)
									{
									//out.println("<td align='center'>"+rs.getInt("tot")+"</td>");
									}
									else
									{
									//out.println("<td align='center'>&nbsp;</td>");
									}
									subc++;
								}
							}
							while(subc<subcnt)
							{
								subc++;
								out.println("<th>-</th>");
							}

							rs=null;
						}



						datediff=0;
       //registerno=rs2.getString("registerno");
	 //  doj=rs2.getString("doj");
	   //out.println(doj);
	   //out.println("SELECT DATEDIFF('"+fromDate+"','"+doj+"') AS DiffDate");
	    if(db.operation("SELECT DATEDIFF('"+fromDate+"','"+doj+"') AS DiffDate","select"))
		{
           rs1=db.getResultSet();
		   rs1.beforeFirst();
		   while(rs1.next())
			{
                datediff=rs1.getInt("DiffDate");
			}
			rs1=null;
             
		}
		if(datediff>=0)
		{
          //out.println("take fromDate");

		}
      else
		{
           //out.println("take doj");
		}

		if(datediff>=0)
		{

if(db.operation("select t1.registerno,t1.name,t1.doj,t2.subjectcode,t2.subjecttypeid,t2.batchno,t3.date,t3.period,ifnull(t4.registerno,'P') as present from (select registerno,name,coursecode,branchcode,cyear,semester,sectioncode,doj from student_master.financestudent where coursecode='"+cc+"' and branchcode='"+bc+"' and cyear="+cyear+" and semester="+sem+" and sectioncode='"+section+"' and registerno='"+registerno+"' ) t1 left join (select * from `"+attendance_and_examcell_1+"`.studentsubject where coursecode='"+cc+"' and branchcode='"+bc+"' and cyear="+cyear+" and semester="+sem+" and sectioncode='"+section+"' and registerno='"+registerno+"') t2 on (t2.registerno=t1.registerno) left join (select distinct coursecode,branchcode,cyear,semestercode,sectioncode,subjectcode,period,date,subjecttypeid,batchno from `"+attendance_and_examcell_1+"`.subjecthours where coursecode='"+cc+"' and branchcode='"+bc+"' and cyear="+cyear+" and semestercode="+sem+" and sectioncode='"+section+"' and date between '"+fromDate+"' and '"+toDate+"') t3 on (t3.coursecode=t1.coursecode and t3.branchcode=t1.branchcode and t3.cyear=t1.cyear and t3.semestercode=t1.semester and t3.sectioncode=t1.sectioncode and t3.batchno=t2.batchno and t3.subjectcode=t2.subjectcode and t3.subjecttypeid=t2.subjecttypeid) left join (select distinct coursecode,branchcode,cyear,semestercode,sectioncode,subjectcode,period,date,subjecttypeid,batchno,registerno from `"+attendance_and_examcell_1+"`.attendance where coursecode='"+cc+"' and branchcode='"+bc+"' and cyear="+cyear+" and semestercode="+sem+"  and sectioncode='"+section+"' and registerno='"+registerno+"' and date between '"+fromDate+"' and '"+toDate+"') t4 on (t4.coursecode=t1.coursecode and t4.branchcode=t1.branchcode and t4.cyear=t1.cyear and t4.semestercode=t1.semester and t4.sectioncode=t1.sectioncode and t4.batchno=t2.batchno and t4.subjectcode=t2.subjectcode and t4.subjecttypeid=t2.subjecttypeid and t4.registerno=t1.registerno and t4.date=t3.date and t4.period=t3.period and t3.date between '"+fromDate+"' and '"+toDate+"') where t3.date is not null and t3.period is not null order by t1.registerno,t2.subjecttypeid,t2.subjectcode","select"))
{
	rs = db.getResultSet();
	rs.beforeFirst();
	int sub_c=0,sub_a=0;
	all_c=0;
	all_a=0;
	 reg="";
	 String sc="";
	subc=0;
	while(rs.next())
	{
		//t.println(rs.getString("doj"));
		
		//out.println(rs.getInt("subjecttypeid"));
		if(!reg.equalsIgnoreCase(rs.getString("registerno")))
		{
			if(reg.length()>0)
			{
//out.println(rs.getInt("subjecttypeid"));
				if(sc.length()>0)
				{
					if((sub[subc]!=null && !sub[subc].equalsIgnoreCase(sc)))
					{
						while(subc<subcnt && !sub[subc].equalsIgnoreCase(sc))
						{
							subc++;
							//out.println("<th>-</th>");
						}
					}
					if(subc<subcnt && sub[subc].equalsIgnoreCase(sc))
					{
						//out.println("<td align='center'>"+sub_a+"</td>");
						all_c+=sub_c;sub_c=0;
						all_a+=sub_a;sub_a=0;
						subc++;
					}
				}
				while(subc<subcnt)
				{
					subc++;
					//out.println("<th>-</th>");
				}
				if(all_c>0)
				{
				//out.println("<th>"+nf.format((double)all_a * 100 / all_c)+"</th>");
				}
				else
				{
              // out.println("<th>0</th>");
				}
				//out.println("</tr>");
			}
			sl=sl+1;
			//out.println("<tr><td align='center'>"+sl+"</td>");
			//out.println("<td align='center'>"+rs.getString("registerno")+"</td>");
			//out.println("<td align='left'>"+rs.getString("name")+"</td>");
			reg = rs.getString("registerno");
			sub_a=0;sub_c=0;all_a=0;all_c=0;
			subc=0;sc="";
		}
		//out.println(sc);
		if(!sc.equalsIgnoreCase(rs.getString("subjectcode")))
		{
			
			if(sc.length()>0)
			{
				//out.println(rs.getInt("subjecttypeid"));
				if(!(sub[subc]!=null && sub[subc].equalsIgnoreCase(sc)))
				{
					while(subc<subcnt && !sub[subc].equalsIgnoreCase(sc))
					{
						subc++;
						//out.println("<th>-</th>");
					}
				}
				if(subc<subcnt && sub[subc].equalsIgnoreCase(sc))
				{
					//out.println(rs.getInt("subjecttypeid"));
					if(rs.getInt("subjecttypeid")==2)
					{
					//out.println("<td align='center'>"+sub_a+"("+sub_c+")</td>");
					}
					else
					{
					//out.println("<td align='center'>"+sub_a+"("+sub_c+")</td>");
					}
					
					//out.println("<td align='center'>"+sub_a+"</td>");
					
					all_c+=sub_c;sub_c=0;
					all_a+=sub_a;sub_a=0;
					subc++;
				}
			}
			sub_c++;
			if(rs.getString("present").equalsIgnoreCase("P"))
			{
				sub_a++;
			}
			sc=rs.getString("subjectcode");
		}
		else
		{
			sub_c++;
			if(rs.getString("present").equalsIgnoreCase("P"))
			{
				sub_a++;
			}
		}


	}
	if(sc.length()>0)
	{
		if((sub[subc]!=null && !sub[subc].equalsIgnoreCase(sc)))
		{
			while(subc<subcnt && !sub[subc].equalsIgnoreCase(sc))
			{
				subc++;
				//out.println("<th>-</th>");
			}
		}
		if(subc<subcnt && sub[subc].equalsIgnoreCase(sc))
		{
			//out.println("<td align='center'>"+sub_a+"</td>");
			all_c+=sub_c;sub_c=0;
			all_a+=sub_a;sub_a=0;
			subc++;
		}
	}
	while(subc<subcnt)
	{
		subc++;
		//out.println("<th>-</th>");
	}
	if(all_c>0)
	{
	//out.println("<th>"+nf.format((double)all_a * 100 / all_c)+"</th>");
	//out.println(all_a);
	}
	else
	{
out.println("<td>0</td>");
	}
	//out.println("</tr>");
	rs=null;
}


		}

		else


		{
           if(db.operation("select t1.registerno,t1.name,t1.doj,t2.subjectcode,t2.subjecttypeid,t2.batchno,t3.date,t3.period,ifnull(t4.registerno,'P') as present from (select registerno,name,coursecode,branchcode,cyear,semester,sectioncode,doj from student_master.financestudent where coursecode='"+cc+"' and branchcode='"+bc+"' and cyear="+cyear+" and semester="+sem+" and sectioncode='"+section+"' and registerno='"+registerno+"' ) t1 left join (select * from `"+attendance_and_examcell_1+"`.studentsubject where coursecode='"+cc+"' and branchcode='"+bc+"' and cyear="+cyear+" and semester="+sem+" and sectioncode='"+section+"' and registerno='"+registerno+"') t2 on (t2.registerno=t1.registerno) left join (select distinct coursecode,branchcode,cyear,semestercode,sectioncode,subjectcode,period,date,subjecttypeid,batchno from `"+attendance_and_examcell_1+"`.subjecthours where coursecode='"+cc+"' and branchcode='"+bc+"' and cyear="+cyear+" and semestercode="+sem+" and sectioncode='"+section+"' and date between '"+doj+"' and '"+toDate+"') t3 on (t3.coursecode=t1.coursecode and t3.branchcode=t1.branchcode and t3.cyear=t1.cyear and t3.semestercode=t1.semester and t3.sectioncode=t1.sectioncode and t3.batchno=t2.batchno and t3.subjectcode=t2.subjectcode and t3.subjecttypeid=t2.subjecttypeid) left join (select distinct coursecode,branchcode,cyear,semestercode,sectioncode,subjectcode,period,date,subjecttypeid,batchno,registerno from `"+attendance_and_examcell_1+"`.attendance where coursecode='"+cc+"' and branchcode='"+bc+"' and cyear="+cyear+" and semestercode="+sem+"  and sectioncode='"+section+"'  and registerno='"+registerno+"' and date between '"+doj+"' and '"+toDate+"') t4 on (t4.coursecode=t1.coursecode and t4.branchcode=t1.branchcode and t4.cyear=t1.cyear and t4.semestercode=t1.semester and t4.sectioncode=t1.sectioncode and t4.batchno=t2.batchno and t4.subjectcode=t2.subjectcode and t4.subjecttypeid=t2.subjecttypeid and t4.registerno=t1.registerno and t4.date=t3.date and t4.period=t3.period and t3.date between '"+doj+"' and '"+toDate+"') where t3.date is not null and t3.period is not null order by t1.registerno,t2.subjecttypeid,t2.subjectcode","select"))


{
	rs = db.getResultSet();
	rs.beforeFirst();
	int sub_c=0,sub_a=0;
	all_c=0;
	all_a=0;
	 reg="";
	 String sc="";
	subc=0;
	while(rs.next())
	{
		//t.println(rs.getString("doj"));
		
		//out.println(rs.getInt("subjecttypeid"));
		if(!reg.equalsIgnoreCase(rs.getString("registerno")))
		{
			if(reg.length()>0)
			{
//out.println(rs.getInt("subjecttypeid"));
				if(sc.length()>0)
				{
					if((sub[subc]!=null && !sub[subc].equalsIgnoreCase(sc)))
					{
						while(subc<subcnt && !sub[subc].equalsIgnoreCase(sc))
						{
							subc++;
							//out.println("<th>-</th>");
						}
					}
					if(subc<subcnt && sub[subc].equalsIgnoreCase(sc))
					{
						//out.println("<td align='center'>"+sub_a+"</td>");
						all_c+=sub_c;sub_c=0;
						all_a+=sub_a;sub_a=0;
						subc++;
					}
				}
				while(subc<subcnt)
				{
					subc++;
					//out.println("<th>-</th>");
				}
				if(all_c>0)
				{
				//out.println("<th>"+nf.format((double)all_a * 100 / all_c)+"</th>");
				}
				else
				{
              // out.println("<th>0</th>");
				}
				//out.println("</tr>");
			}
			sl=sl+1;
			//out.println("<tr><td align='center'>"+sl+"</td>");
			//out.println("<td align='center'>"+rs.getString("registerno")+"</td>");
			//out.println("<td align='left'>"+rs.getString("name")+"</td>");
			reg = rs.getString("registerno");
			sub_a=0;sub_c=0;all_a=0;all_c=0;
			subc=0;sc="";
		}
		//out.println(sc);
		if(!sc.equalsIgnoreCase(rs.getString("subjectcode")))
		{
			
			if(sc.length()>0)
			{
				//out.println(rs.getInt("subjecttypeid"));
				if(!(sub[subc]!=null && sub[subc].equalsIgnoreCase(sc)))
				{
					while(subc<subcnt && !sub[subc].equalsIgnoreCase(sc))
					{
						subc++;
						//out.println("<th>-</th>");
					}
				}
				if(subc<subcnt && sub[subc].equalsIgnoreCase(sc))
				{
					//out.println(rs.getInt("subjecttypeid"));
					if(rs.getInt("subjecttypeid")==2)
					{
					//out.println("<td align='center'>"+sub_a+"("+sub_c+")</td>");
					}
					else
					{
					//out.println("<td align='center'>"+sub_a+"("+sub_c+")</td>");
					}
					
					//out.println("<td align='center'>"+sub_a+"</td>");
					
					all_c+=sub_c;sub_c=0;
					all_a+=sub_a;sub_a=0;
					subc++;
				}
			}
			sub_c++;
			if(rs.getString("present").equalsIgnoreCase("P"))
			{
				sub_a++;
			}
			sc=rs.getString("subjectcode");
		}
		else
		{
			sub_c++;
			if(rs.getString("present").equalsIgnoreCase("P"))
			{
				sub_a++;
			}
		}


	}
	if(sc.length()>0)
	{
		if((sub[subc]!=null && !sub[subc].equalsIgnoreCase(sc)))
		{
			while(subc<subcnt && !sub[subc].equalsIgnoreCase(sc))
			{
				subc++;
				//out.println("<th>-</th>");
			}
		}
		if(subc<subcnt && sub[subc].equalsIgnoreCase(sc))
		{
			//out.println("<td align='center'>"+sub_a+"</td>");
			all_c+=sub_c;sub_c=0;
			all_a+=sub_a;sub_a=0;
			subc++;
		}
	}
	while(subc<subcnt)
	{
		subc++;
		//out.println("<th>-</th>");
	}
	if(all_c>0)
	{
	//out.println("<th>"+nf.format((double)all_a * 100 / all_c)+"</th>");
	//out.println(all_a);
	}
	else
	{
out.println("<td>0</td>");
	}
	//out.println("</tr>");
	rs=null;
}


		}





			}
          rs4.close();
	     }
	}
rr.close();
}

%>

