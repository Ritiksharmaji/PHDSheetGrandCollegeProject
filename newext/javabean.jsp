<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String jdbcURL = "jdbc:mysql://localhost:3306/facultygrants"; // Change as per your DB settings
    String jdbcUsername = "root";
    String jdbcPassword = "Atten!@nce";

    // Load the JDBC driver (not always necessary for newer drivers)
    Class.forName("com.mysql.jdbc.Driver");

    // Establish the connection
    Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    
    

%>
