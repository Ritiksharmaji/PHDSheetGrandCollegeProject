<%@ include file="javabean.jsp" %>
<%@ page import="java.io.*" %>
<%

int ses = Integer.parseInt(request.getParameter("ses"));
String appno = "FG/2024/3"; // Replace with session attribute if needed
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

    if (ses == 5) {
        chkquery = "select b_rational_img_file from facultygrants.projectdetails p where appno ='" + appno + "'";
        st = conn.createStatement();
        rchk = st.executeQuery(chkquery);

        if (rchk != null && rchk.next()) {
          
            if (rchk.getString(1) != null) {
                chkstatus = 1;
                chknm += rchk.getString(1);
            }
        }
    }

    if (ses == 6) {
        chkquery = "select d_obj_img_file from facultygrants.projectdetails p where appno ='" + appno + "'";
        st = conn.createStatement();
        rchk = st.executeQuery(chkquery);

        if (rchk != null && rchk.next()) {
          
            if (rchk.getString(1) != null) {
                chkstatus = 1;
                chknm += rchk.getString(1);
            }
        }
    }

    if (ses == 7) {
        chkquery = "select d_prelim_img_file from facultygrants.projectdetails p where appno ='" + appno + "'";
        st = conn.createStatement();
        rchk = st.executeQuery(chkquery);

        if (rchk != null && rchk.next()) {
          
            if (rchk.getString(1) != null) {
                chkstatus = 1;
                chknm += rchk.getString(1);
            }
        }
    }


    if (ses == 8) {
        chkquery = "select d_inn_comp_img_file from facultygrants.projectdetails p where appno ='" + appno + "'";
        st = conn.createStatement();
        rchk = st.executeQuery(chkquery);

        if (rchk != null && rchk.next()) {
          
            if (rchk.getString(1) != null) {
                chkstatus = 1;
                chknm += rchk.getString(1);
            }
        }
    }


    if (ses == 9) {
        chkquery = "select d_method_img_file from facultygrants.projectdetails p where appno ='" + appno + "'";
        st = conn.createStatement();
        rchk = st.executeQuery(chkquery);

        if (rchk != null && rchk.next()) {
          
            if (rchk.getString(1) != null) {
                chkstatus = 1;
                chknm += rchk.getString(1);
            }
        }
    }

    if (ses == 10) {
        chkquery = "select del_impact_img_file from facultygrants.projectdetails p where appno ='" + appno + "'";
        st = conn.createStatement();
        rchk = st.executeQuery(chkquery);

        if (rchk != null && rchk.next()) {
          
            if (rchk.getString(1) != null) {
                chkstatus = 1;
                chknm += rchk.getString(1);
            }
        }
    }

    if (ses == 11) {
        chkquery = "select del_Expected_Publications_img_file from facultygrants.projectdetails p where appno ='" + appno + "'";
        st = conn.createStatement();
        rchk = st.executeQuery(chkquery);

        if (rchk != null && rchk.next()) {
          
            if (rchk.getString(1) != null) {
                chkstatus = 1;
                chknm += rchk.getString(1);
            }
        }
    }

    if (ses == 12) {
        chkquery = "select del_mon_effective_img_file from facultygrants.projectdetails p where appno ='" + appno + "'";
        st = conn.createStatement();
        rchk = st.executeQuery(chkquery);

        if (rchk != null && rchk.next()) {
          
            if (rchk.getString(1) != null) {
                chkstatus = 1;
                chknm += rchk.getString(1);
            }
        }
    }

    if (ses == 13) {
        chkquery = "select del_suit_gov_scheme_img_file from facultygrants.projectdetails p where appno ='" + appno + "'";
        st = conn.createStatement();
        rchk = st.executeQuery(chkquery);

        if (rchk != null && rchk.next()) {
          
            if (rchk.getString(1) != null) {
                chkstatus = 1;
                chknm += rchk.getString(1);
            }
        }
    }

    if (ses == 14) {
        chkquery = "select del_post_proj_act_img_file from facultygrants.projectdetails p where appno ='" + appno + "'";
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

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" 
     integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #f7f7f7, #e0e0e0);
            background-size: cover;
            background-attachment: fixed;
        }
        .container {
            background: #ffffff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .form-control, .btn {
            border-radius: 0.375rem;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004089;
        }
        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #545b62;
        }
        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
        }
        .btn-success:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }
    </style>
</head>
<body>
<div class="container mt-2 " style=backround-color:red>
    <form method="post" action="image_upload_next.jsp" name="f" enctype="multipart/form-data">
        <div class="mb-3">
            <input type="file" class="form-control" id="uploadfile" name="uploadfile" required="required">
        </div>
        <div class="mb-3 d-flex flex-direction-row justify-content-between">
            <button type="submit" id="<%= ses %>" name="Submit" class="btn btn-primary" onclick="fun(this.id)">Submit</button>
            <button type="reset" class="btn btn-secondary">Reset</button>

            <%
            if (chkstatus == 1) {
            %>
                <a href="<%= chknm %>" class="btn btn-success" target="_blank">View Uploaded File</a>
            <%
            }
            %>
            </div>
    </form>
</div>

<script>
    // Ajax call function
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
</body>
</html>