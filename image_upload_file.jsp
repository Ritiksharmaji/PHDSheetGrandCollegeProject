<%@ include file="javabean.jsp" %>
<%@ page import="java.io.*" %>
<%

int ses = Integer.parseInt(request.getParameter("ses"));
String appno = "FG/2024/1"; // Replace with session attribute if needed
String neww = "";

String chkquery = "";
int chkstatus = 0;
String chknm = "D:/package/newext/RSGRANTS/";

ResultSet rchk = null;
Statement st = null;


try {
    // fetching file names if present from respective db_tables
    if (ses == 1) {
        chkquery = "select b_description_img_file from facultygrants.projectdetails p where appno ='" + appno + "'";
        st = conn.createStatement();
        rchk = st.executeQuery(chkquery);

        if (rchk != null && rchk.next()) {
          
            if (rchk.getString(1) != null) {
                chkstatus = 1;
                chknm += rchk.getString(1);
            }
        }
    }

    if (ses == 2) {
        chkquery = "select b_review_img_file from facultygrants.projectdetails p where appno ='" + appno + "'";
        st = conn.createStatement();
        rchk = st.executeQuery(chkquery);

        if (rchk != null && rchk.next()) {
          
            if (rchk.getString(1) != null) {
                chkstatus = 1;
                chknm += rchk.getString(1);
            }
        }
    }

    if (ses == 3) {
        chkquery = "select b_description_img_file from facultygrants.projectdetails p where appno ='" + appno + "'";
        st = conn.createStatement();
        rchk = st.executeQuery(chkquery);

        if (rchk != null && rchk.next()) {
          
            if (rchk.getString(1) != null) {
                chkstatus = 1;
                chknm += rchk.getString(1);
            }
        }
    }


    if (ses == 4) {
        chkquery = "select b_review_img_file from facultygrants.projectdetails p where appno ='" + appno + "'";
        st = conn.createStatement();
        rchk = st.executeQuery(chkquery);

        if (rchk != null && rchk.next()) {
          
            if (rchk.getString(1) != null) {
                chkstatus = 1;
                chknm += rchk.getString(1);
            }
        }
    }


} catch (SQLException e) {
    // Handle SQL Exception
    e.printStackTrace();
} finally {
    // Close the ResultSet and Statement to prevent resource leaks
    if (rchk != null) {
        try {
            rchk.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    if (st != null) {
        try {
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
%>

<form method="post" action="image_upload_next.jsp" name="f" enctype='multipart/form-data'>
    <input type="file" name="uploadfile" required="required">
    <input type="submit" id="<%= ses %>" name="Submit" value="Submit" onclick="fun(this.id)">
    <input type="reset" name="Reset" value="Reset">
</form>

<br>

<%
if (chkstatus == 1) {
%>
    <a target="_blank" href="<%= chknm %>">Click</a>
<%
}
%>

<script>
    //ajax call function
    function fun(d) {
        var xhr = new XMLHttpRequest();
        var url = "sessChange.jsp?a=" + d;
        xhr.open("GET", url, true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                document.getElementById("response").innerHTML = xhr.responseText;
            }
        };
        xhr.send();
    }
</script>

<%@ include file="dbClose.jsp" %>
