<%@ include file="javabean.jsp" %>

<%
   int ds = Integer.parseInt(request.getParameter("a"));
//
    String emp = "020806"; // Replace with session attribute if needed
    String name = emp;
    String appno = "FG/2024/3"; // Replace with session attribute if needed


    // Set session attributes
    // type : in file_names table row's id value
   session.setAttribute("type", ds);
   session.setAttribute("appno", appno);
   session.setAttribute("emp", emp);

   // session.setAttribute("appno",emp);
    session.setAttribute("pi","30303");
    session.setAttribute("tenure",2);
    session.setAttribute("role",1);
    session.setAttribute("FS",0);
    session.setAttribute("status",0);

%>

<%@ include file="dbClose.jsp" %>
