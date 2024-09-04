<%@ include file="javabean.jsp"%>
<%
String appno = "FG/2024/1";
session.setAttribute("appno",appno);

String phase_plan ="";
String mile_stone ="";

if(request.getParameter("phase_plan")!=null)
{
  phase_plan = request.getParameter("phase_plan");
}
if(request.getParameter("mile_stone")!=null)
{
  mile_stone = request.getParameter("mile_stone");
}
if(request.getParameter("sub")!=null)
{
  String sdf = "update facultygrants.projectdetails set w_phaseplan ='"+phase_plan+"', w_milestone ='"+mile_stone+"' where appno ='"+appno+"'";
  Statement st = conn.createStatement();
  st.executeUpdate(sdf);
}
%>
<%
%>
<form>
  <textarea name="phase_plan"></textarea>
  <textarea name="mile_stone"></textarea>
  <input type="submit" name="sub">
</form>
<iframe src="image_upload_file.jsp?ses=1" style="border: 0" width="800" height="600" frameborder="0" scrolling="no"></iframe>
<br>
<iframe src="image_upload_file.jsp?ses=4" style="border: 0" width="800" height="600" frameborder="0" scrolling="no"></iframe>

<%@ include file="dbClose.jsp"%>