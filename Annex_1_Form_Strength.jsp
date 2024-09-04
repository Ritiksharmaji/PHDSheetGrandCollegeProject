<%@ page import="java.sql.*" %>
<%@ page import="javax.swing.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.management.InvalidApplicationException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="javabean.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Strength</title>
</head>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f4f4;
        width: 80%;
    }

    nav {
        background-color: #fbfcfc;
        padding: 10px;
        margin-left: 20%;
        margin-top: 10%;
        margin-bottom: 10px;
    }

    .navbar {
        list-style-type: none;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: space-around;
    }

    .navbar li {
        display: inline;
    }

    .navbar li a {
        text-decoration: none;
        color: white;
        padding: 10px 20px;
        display: inline-block;
        background-color: #93989d;
    }

    .navbar li a.active {
        background-color: #149f19;
    }

    .content-section {
        background-color: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        margin-left: 20%;
        width: 77%; /* Ensure consistent width for both sections */
    }
    .content-section h2 {
        text-align: center;
        color: #333;
    }

    table {
        width: 100%;
        margin: 20px 0;
        border-collapse: collapse;
    }

    table, th, td {
        border: 1px solid #ddd;
        background: lightblue;
    }

    td {
        padding: 10px;
        vertical-align: top;
    }

    td select, textarea, input {
        width: 95%;
        padding: 8px;

        background: lightblue;
    }

    .button-container {
        display: flex;
        gap: 10px; /* Add spacing between buttons */
        justify-content: space-between; /* Align buttons to the start */
        margin-top: 20px;
    }

    .btn {
        padding: 10px 15px;
        border: none;
        color: white;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
        text-align: center; /* Centers text in the button */
        width: auto; /* Adjusts width according to text */
    }

    .co-investigator-btn {
        background-color: #4CAF50;
    }


    .sbmt {
        background-color: #4CAF50; /* Green color */
        color: white;
    }


    a {
        text-decoration: none;
        color: #f4f4f4;
    }

    .c1 {
        background: royalblue;
        color: white;
        font-weight: bolder;
        width: 25%; /* Ensure a consistent width for label columns */
    }

    h4 {
        color: red;
    }

    h3 {
        text-align: center;
    }
    .r1{
        color: white;
        background: #0054E3;
    }

</style>
<body>
    <%
    //Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet ,resultSet1 , resultSet2;
    resultSet = null;
    resultSet1 = null;
    resultSet2 = null;

//    DatabaseConnection con = new DatabaseConnection();
//    connection = con.getConnection();


    String empID = (String) session.getAttribute("pi");
    int tenure = (Integer) session.getAttribute("tenure");
    int role = (Integer) session.getAttribute("role");
    int FS = (Integer) session.getAttribute("FS");
    int subStatus = (Integer) session.getAttribute("status");
    String appli = (String)session.getAttribute("appno");
%>
<!-- Navbar -->
<nav>
    <ul class="navbar">
        <li><a href="Annex_1_Form_Investigator.jsp" >Investigators</a></li>
        <li><a href="Annex_1_Form_proposal.jsp" >Proposal</a></li>
        <li><a href="Annex_1_Form_workplan.jsp">Work Plan</a></li>
        <li><a href="Annex_1_Form_Strength.jsp" class="active">Strength</a></li>
        <li><a href="Annex_1_Form_deliverables.jsp">Deliverables</a></li>
        <li><a href="Annex_1_Form_Budget.jsp">Budget</a></li>
        <li><a href="Annex_1_Form_uploads.jsp">Uploads</a></li>
        <li><a href="Annex_1_Form_preview.jsp">Preview</a></li>
    </ul>
</nav>

<!-- Content Section -->
<section id="section1" class="content-section">
    <form method="post" action="Annex_1_Form_Strength.jsp">
    <table>
        <tr>
            <td colspan="4" class="r1"><b>Top publications of investigator-Supporting the proposal (last five year)</b></td>
        </tr>
        <tr>
            <td></td>
            <td>Details</td>
            <td>SCI/SCI-E</td>
            <td>Impact factor</td>
        </tr>
            <tr>
                <td>1</td>
                <td><input name="d1"></td>
                <td><input name="s1"></td>
                <td><input name="i1"></td>
            </tr>
            <tr>
                <td>2</td>
                <td><input name="d2"></td>
                <td><input name="s2"></td>
                <td><input name="i3"></td>
            </tr>
            <tr>
                <td>3</td>
                <td><input name="d3"></td>
                <td><input name="s3"></td>
                <td><input name="i3"></td>
            </tr>
            <tr>
                <td>4</td>
                <td><input name="d4"></td>
                <td><input name="s4"></td>
                <td><input name="i4"></td>
            </tr>
            <tr>
                <td>5</td>
                <td><input name="d5"></td>
                <td><input name="s5"></td>
                <td><input name="i5"></td>
            </tr>
        </table>
            <div class="button-container">
                <button type="button" class="btn co-investigator-btn">Previous Page</button>
                <input type="submit" class="btn sbmt" id="saveNextBtn" value="SAVE AND NEXT">
            </div>

    </form>
    <%
        if("POST".equalsIgnoreCase(request.getMethod())){
            String dt1 = request.getParameter("d1");
            String sc1 = request.getParameter("s1");
            String imp1 = request.getParameter("i1");
            String dt2 = request.getParameter("d2");
            String sc2 = request.getParameter("s2");
            String imp2 = request.getParameter("i2");
            String dt3 = request.getParameter("d3");
            String sc3 = request.getParameter("s3");
            String imp3 = request.getParameter("i3");
            String dt4 = request.getParameter("d4");
            String sc4 = request.getParameter("s4");
            String imp4 = request.getParameter("i4");
            String dt5 = request.getParameter("d5");
            String sc5 = request.getParameter("s5");
            String imp5 = request.getParameter("i5");

            preparedStatement = conn.prepareStatement("update facultygrants.projectdetails set s_d1 = ? , s_sc1 = ? , s_impact1 = ? , s_d2 = ? , s_sc2 = ? , s_impact2 = ? , s_d3 = ? , s_sc3 = ? , s_impact3 = ? , s_d4 = ? , s_sc4 = ? , s_impact4 = ? , s_d5 = ? , s_sc5 = ? , s_impact5 = ? where appno = ?");
            preparedStatement.setString(1,dt1);
            preparedStatement.setString(2,sc1);
            preparedStatement.setString(3,imp1);
            preparedStatement.setString(4,dt2);
            preparedStatement.setString(5,sc2);
            preparedStatement.setString(6,imp2);
            preparedStatement.setString(7,dt3);
            preparedStatement.setString(8,sc3);
            preparedStatement.setString(9,imp3);
            preparedStatement.setString(10,dt4);
            preparedStatement.setString(11,sc4);
            preparedStatement.setString(12,imp4);
            preparedStatement.setString(13,dt5);
            preparedStatement.setString(14,sc5);
            preparedStatement.setString(15,imp5);
            preparedStatement.setString(16,appli);

            int rowAffected = preparedStatement.executeUpdate();
            if(rowAffected > 0){ 
            response.sendRedirect("Annex_1_Form_deliverables.jsp");
  
        }
        }
               
            %>

</section>
</body>
</html>