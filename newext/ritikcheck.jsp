<%@ include file="javabean.jsp"%>
<%

    String appno = "FG/2024/2";
    session.setAttribute("appno", appno);

    String b_review = "";
    String b_description = "";

    if (request.getParameter("b_description") != null) {
        b_description = request.getParameter("b_description");
        out.println("b_description: " + b_description + "<br>");
    }
    if (request.getParameter("b_review") != null) {
        b_review = request.getParameter("b_review");
        out.println("b_review: " + b_review + "<br>");
    }

    if (request.getParameter("sub") != null) {
        String updateQuery = "UPDATE facultygrants.projectdetails SET b_description = ?, b_review = ? WHERE appno = ?";
        PreparedStatement psUpdate = conn.prepareStatement(updateQuery);
        psUpdate.setString(1, b_description);
        psUpdate.setString(2, b_review);
        psUpdate.setString(3, appno);
        psUpdate.executeUpdate();

        // Fetch updated data
        String selectQuery = "SELECT * FROM facultygrants.projectdetails WHERE appno = ?";
        PreparedStatement psSelect = conn.prepareStatement(selectQuery);
        psSelect.setString(1, appno);
        ResultSet rs = psSelect.executeQuery();

        // Display the result
        if (rs.next()) {
            out.println("ID: " + rs.getInt("id") + "<br>");
            out.println("Application Number: " + rs.getString("appno") + "<br>");
            out.println("Funding: " + rs.getInt("funding") + "<br>");
            out.println("Title: " + rs.getBlob("title") + "<br>");
            out.println("Duration: " + rs.getInt("duration") + "<br>");
            out.println("Amount: " + rs.getInt("amount") + "<br>");
            out.println("COPI: " + rs.getString("copi") + "<br>");
            out.println("Background Description: " + rs.getBlob("b_description") + "<br>");
            out.println("Background Review: " + rs.getBlob("b_review") + "<br>");
            out.println("Work Phase Plan: " + rs.getBlob("w_phaseplan") + "<br>");
            out.println("Work Milestone: " + rs.getBlob("w_milestone") + "<br>");
        } else {
            out.println("No records found for the given application number.");
        }

    }

    out.println();
    out.println("after b_description: " + b_description + "<br>");
    out.println("after b_review: " + b_review + "<br>");
%>
<form method="post">
  <textarea name="b_description"></textarea>
  <textarea name="b_review"></textarea>
  <input type="submit" name="sub">
</form>

<iframe src="image_upload_file.jsp?ses=3" style="border: 0" width="800" height="600" frameborder="0" scrolling="no"></iframe>
<br>
<iframe src="image_upload_file.jsp?ses=4" style="border: 0" width="800" height="600" frameborder="0" scrolling="no"></iframe>
// Close resources
       // rs.close();
       // psSelect.close();
       // psUpdate.close();
<%@ include file="dbClose.jsp"%>
