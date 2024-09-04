<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.SQLException" %>

<%
catch (Exception e) {
  e.printStackTrace();
} 
    // Get the connection from application scope
   // Connection conn = (Connection) application.getAttribute("DBConnection");

    if (conn != null) {
        try {
            conn.close(); // Close the database connection
            application.removeAttribute("DBConnection"); // Remove connection from application scope
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to close the database connection!", e);
        }
    }
%>
