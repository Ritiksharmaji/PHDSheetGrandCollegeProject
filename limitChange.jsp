<%@ include file="javabean.jsp" %>
<%
    String head = request.getParameter("head");
    Statement s1 = conn.createStatement();
    String qu = "SELECT `limit`/100 FROM facultygrants.budget_master WHERE head_name = '"+head+"'";
    ResultSet rs1 = s1.executeQuery(qu);
    float lim = 0;
    if(rs1.next())
    {
        rs1.beforeFirst();
        rs1.next();
        lim = rs1.getFloat(1);
    }
    out.println(lim);
    rs1.close();
    s1.close();
%>
<%@ include file="dbClose.jsp" %>