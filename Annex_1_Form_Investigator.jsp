<%@ page import="java.sql.*" %>
<%@ page import="javax.swing.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.management.InvalidApplicationException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="javabean.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Investigator</title>
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
        width: 100%;
        padding: 8px;
        box-sizing: border-box;
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
        background-color: #FF9800;
    }

    .mentor-btn {
        background-color: #FF9800;
    }

    input[type="submit"]:not(:disabled) {
        background-color: #4CAF50;
    }

    input[type="submit"]:disabled {
        background-color: #cccccc; /* Light gray background for disabled button */
        cursor: not-allowed; /* Show 'not-allowed' cursor */
        opacity: 0.6;
    }

    .sbmt {
        background-color: #4CAF50; /* Green color */
        color: white;
    }

    .note p {
        margin: 0;
        font-weight: bold;
    }

    .note ul {
        margin: 10px 0;
        padding-left: 20px;
    }

    .note ul li {
        margin: 5px 0;
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

    .tble2 td {
        justify-content: space-between;
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


    //String empID = (String) session.getAttribute("pi");
    String empID = "020806";   // get from session
    //int tenure = (Integer) session.getAttribute("tenure");

    
    //int role = (Integer) session.getAttribute("role");
    int role = 1;

    //int FS = (Integer) session.getAttribute("FS");
    int FS = 0;
    //int subStatus = (Integer) session.getAttribute("status");
    int subStatus = 0;

    String appli = "";
    // String appli = (String)session.getAttribute("appno");
    int mid = 1;
    int year = 0;
    String apq = "select max(id),year(curdate()) from facultygrants.projectdetails";
    Statement st12 = conn.createStatement();
    ResultSet rst12 = st12.executeQuery(apq);
    if(rst12.next())
    {
        mid = rst12.getInt(1)+1;
        year = rst12.getInt(2);
    }
    else
    {
        String apyq = "select year(curdate()) from dual";
        Statement st123 = conn.createStatement();
        ResultSet rst123 = st123.executeQuery(apyq);
        rst123.next();
        year = rst123.getInt(1);
        st123.close();
        rst123.close();
    }
    
    appli = "FG/"+year+"/"+mid;

%>
<!-- Navbar -->
<nav>
    <ul class="navbar">
         <li><a href="Annex_1_Form_Investigator.jsp" class="active">Investigators</a></li>
        <li><a href="Annex_1_Form_proposal.jsp" >Proposal</a></li>
        <li><a href="Annex_1_Form_workplan.jsp">Work Plan</a></li>
        <li><a href="Annex_1_Form_Strength.jsp">Strength</a></li>
        <li><a href="Annex_1_Form_deliverables.jsp">Deliverables</a></li>
        <li><a href="Annex_1_Form_Budget.jsp">Budget</a></li>
        <li><a href="Annex_1_Form_uploads.jsp">Uploads</a></li>
        <li><a href="Annex_1_Form_preview.jsp">Preview</a></li>
    </ul>
</nav>

<!-- Content Section -->
<section id="section1" class="content-section">
    <%
        try{
            preparedStatement  = conn.prepareStatement("select appno , funding , title , duration , copi , pi from facultygrants.projectdetails where appno = ?");
            preparedStatement.setString(1,appli);

            resultSet = preparedStatement.executeQuery();

            if(resultSet != null && resultSet.next()){

                %>
    <form method="post">
        <table>
            <tr>
                <td class="c1">Application No.</td>
                <td><%= appli%></td>
            </tr>
            <tr>
                <td class="c1">Funding Scheme</td>
                <td colspan="2"><select name="scheme" id="Scheme" onchange="checkSchemeAndDuration()" required>
                    <%
                        try{
                            preparedStatement = conn.prepareStatement("select id,scheme_name from facultygrants.scheme_master where id = ?");
                            preparedStatement.setInt(1,resultSet.getInt("funding"));

                            resultSet1 = preparedStatement.executeQuery();
                            if(resultSet1!=null && resultSet1.next()){
                    %>
                    <option value='<%= resultSet1.getInt("id")%>' selected><%= resultSet1.getString("scheme_name")%></option>
                    <%
                    }
                    else{
                    %>
                    <option value="">-- Select Funding Scheme --</option>
                    <%
                            }
                        } catch (Exception e) {
                            throw new RuntimeException(e);
                        }
                        finally {
                            if (resultSet1 != null) try { resultSet1.close(); } catch (SQLException e) { /* Handle error */ }
                            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { /* Handle error */ }
                        }

                        try{
                            preparedStatement = conn.prepareStatement("select * from facultygrants.scheme_master where id != ?");
                            preparedStatement.setInt(1,resultSet.getInt("funding"));
                            resultSet1 = preparedStatement.executeQuery();
                            while(resultSet1!=null && resultSet1.next()){
                    %>
                    <option value='<%= resultSet1.getString("id")%>'><%= resultSet1.getString("scheme_name")%></option>
                    <%
                            }
                        } catch (Exception e) {
                            throw new RuntimeException(e);
                        }
                        finally {
                            if (resultSet1 != null) try { resultSet1.close(); } catch (SQLException e) { /* Handle error */ }
                            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { /* Handle error */ }
                        }
                    %>
                </select></td>

            </tr>
            <tr>
                <td class="c1">Funding Agency</td>
                <td>VFSTR</td>
            </tr>
            <tr>
                <td class="c1">Title of proposed project</td>
                <td><input type="text" name="title" value="<%= resultSet.getString("title")%>"></td>
            </tr>
            <tr>
                <td class="c1">Budget (in lacs)</td>
                <td><input type="number" name="budget" value="<%= resultSet.getInt("amount")%>"></td>
            </tr>
            <tr>
                <td class="c1">Duration</td>
                <td colspan="2">
                    <select name="duration" required>
                        <%
                            if(resultSet.getInt("duration") == 1){
                        %>
                        <option value="1" selected>1</option>
                        <option value="2">2</option>
                        <%
                        }
                        else{
                        %>
                        <option value="1">1</option>
                        <option value="2" selected>2</option>
                        <%
                            }
                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="c1">Investigator</td>
                <%
                    try{
                        preparedStatement = conn.prepareStatement("select name, role from facultygrants.registration where empcode = ?");
                        preparedStatement.setString(1,empID);

                        resultSet1 = preparedStatement.executeQuery();

                        if(resultSet1!=null && resultSet1.next()){
                            int rol = resultSet1.getInt("role");
                            session.setAttribute("role",rol);
                %>
                <td colspan="2"><%= resultSet1.getString("name")%> [<%= empID%>]</td>
                <%
                }
                else{
                %>
                <td colspan="2">Not Specified</td>
                <%
                        }

                    } catch (Exception e) {
                        throw new RuntimeException(e);
                    }
                    finally {
                        if (resultSet1 != null) try { resultSet1.close(); } catch (SQLException e) {  }
                        if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) {  }

                    }
                %>
            </tr>
            <div id="newWorker" name="new"></div>
        </table>
        <input type="hidden" id="selectedValues" name="selectedValues">
        <div class="button-container">
            <!-- Add Co-Investigator Button -->
            <button type="button" class="btn co-investigator-btn" onclick="generateSelect()">Add Co-Investigator</button>

            <!-- Add Mentor Button (Initially Hidden) -->
            <button type="button" class="btn mentor-btn" id="mentorBtn" style="display: none;" onclick="addMentor()">Add Mentor</button>

            <!-- Save and Next Button (Initially Disabled) -->
            <input type="submit" class="btn sbmt" id="saveNextBtn" value="SAVE AND NEXT">
        </div>
    </form>

    <%
        //String applicationNumber = appli;
        if("POST".equalsIgnoreCase(request.getMethod())) {
            String applicationNumber = appli;
            if (applicationNumber == null) {
                applicationNumber = "FG/2024/1";
            }
            String funding = request.getParameter("scheme");
            if (funding == null) {
                funding = resultSet.getString("funding");
            }
            String agency = "VFSTR";
            String title = request.getParameter("title");
            if (title == null) {
                title = resultSet.getString("title");
            }
            String durationParam = request.getParameter("duration"); // Fetch duration as String
            if (durationParam == null) {
                durationParam = resultSet.getString("duration");
            }
            String invest = empID;
            if (invest == null) {
                invest = resultSet.getString("pi");
            }
            String CoEmp = request.getParameter("selectedValues");
            if (CoEmp == null) {
                CoEmp = resultSet.getString("copi");
            }

            String budget = request.getParameter("budget");
            if(budget == null){
                budget = resultSet.getString("amount");
            }

            int budget_int = 0;
            if(budget != null && !budget.isEmpty()){
                try{
                    budget_int = Integer.parseInt(budget);
                } catch (java.lang.Exception e) {
                    throw new RuntimeException(e);
                }
            }

            int dur = 0; // Default duration value
            if (durationParam != null && !durationParam.isEmpty()) {
                try {
                    dur = Integer.parseInt(durationParam); // Parse duration if not null or empty
                } catch (NumberFormatException e) {
                    out.println("<h3 style='color: red;'>Invalid duration value. Please enter a valid number.</h3>");
                }
            }
//        else {
//            out.println("<h3 style='color: red;'>Duration is required.</h3>"); // Handle empty duration
//        }
            int fund_id = 0;
            if (funding != null && !funding.isEmpty()) {
                try {
                    fund_id = Integer.parseInt(funding);
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
            }
            try {
                preparedStatement = conn.prepareStatement("update facultygrants.projectdetails set funding = ? , duration = ? , copi = ? , pi=?,title=? , amount = ? where appno = ?");
                preparedStatement.setInt(1, fund_id);
                preparedStatement.setInt(2, dur);
                preparedStatement.setString(3, CoEmp);
                preparedStatement.setString(4, invest);
                preparedStatement.setString(5, title);
                preparedStatement.setInt(6,budget_int);
                preparedStatement.setString(7, applicationNumber);

                int rowAffected =  preparedStatement.executeUpdate();
                if(rowAffected > 0){
                    response.sendRedirect("Annex_1_Form_proposal.jsp");
                }


            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
//        finally {
//            if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { /* Handle error */ }
//            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { /* Handle error */ }
//        }
    %>


    <table class="tble2">
        <h3>Selected Co-Investigator</h3>
        <%
            try {
                String resultant = "";
                String emp[] = new String[20];
                preparedStatement = conn.prepareStatement("select copi from facultygrants.projectdetails where appno = ?");
                preparedStatement.setString(1,appli);
                resultSet1 = preparedStatement.executeQuery();
                if (resultSet1 != null && resultSet1.next())
                    resultant = resultSet1.getString("copi");
                if(resultant != null) {
                    emp = resultant.split(";");
                }
                //String[] emp = resultSet.getString("copi").split(";");
                int count = 1;
                for (String empCode : emp) {
                    preparedStatement = conn.prepareStatement("select name from facultygrants.registration where empcode = ?");
                    preparedStatement.setString(1, empCode);
                    resultSet2 = preparedStatement.executeQuery();
                    if (resultSet2 != null && resultSet2.next()) {
        %>
        <tr>
            <td>Co-Investigator  <%= count%></td>
            <td><%= resultSet2.getString("name")%> [<%= empCode%>]</td>
        </tr>
        <%
                        count+=1;
                    }
                }
            } catch (Exception e) {
                throw new RuntimeException(e);
            } finally {
                if (resultSet1 != null) try { resultSet1.close(); } catch (SQLException e) { /* Handle error */ }
                if (resultSet2 != null) try { resultSet2.close(); } catch (SQLException e) { /* Handle error */ }
                if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { /* Handle error */ }
            }
        %>
    </table>
    <%

            }


            else{
                %>

    <form method="post">
        <table>
            <tr>
                <td class="c1">Application No.</td>
                <td><%= appli%></td>
            </tr>
            <tr>
                <td class="c1">Funding Scheme</td>
                <td colspan="2"><select name="scheme" id="Scheme" onchange="checkSchemeAndDuration()" required>
                    <option value="">-- Select Funding Scheme --</option>
                    <%
                        try{
                            preparedStatement = conn.prepareStatement("select * from facultygrants.scheme_master");
                            resultSet1 = preparedStatement.executeQuery();
                            while(resultSet1!=null && resultSet1.next()){
                    %>
                    <option value='<%= resultSet1.getString("id")%>'><%= resultSet1.getString("scheme_name")%></option>
                    <%
                            }
                        } catch (Exception e) {
                            throw new RuntimeException(e);
                        }
                        finally {
                            if (resultSet1 != null) try { resultSet1.close(); } catch (SQLException e) { /* Handle error */ }
                            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { /* Handle error */ }
                        }
                    %>
                </select></td>

            </tr>
            <tr>
                <td class="c1">Funding Agency</td>
                <td>VFSTR</td>
            </tr>
            <tr>
                <td class="c1">Title of proposed project</td>
                <td><input type="text" name="title"></td>
            </tr>
            <tr>
                <td class="c1">Budget (in lacs)</td>
                <td><input type="number" name="budget"></td>
            </tr>
            <tr>
                <td class="c1">Duration</td>
                <td colspan="2">
                    <select name="duration" required>
                        <option value="">-- Select Duration --</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="c1">Investigator</td>
                <%
                    try{
                        preparedStatement = conn.prepareStatement("select name from facultygrants.registration where empcode = ?");
                        preparedStatement.setString(1,empID);

                        resultSet1 = preparedStatement.executeQuery();

                        if(resultSet1!=null && resultSet1.next()){
                %>
                <td colspan="2"><%= resultSet1.getString("name")%> [<%= empID%>]</td>
                <%
                }
                else{
                %>
                <td colspan="2">Not Specified</td>
                <%
                        }

                    } catch (Exception e) {
                        throw new RuntimeException(e);
                    }
                    finally {
                        if (resultSet1 != null) try { resultSet1.close(); } catch (SQLException e) {  }
                        if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) {  }

                    }
                %>
            </tr>
            <div id="newWorker" name="new"></div>
        </table>
        <input type="hidden" id="selectedValues" name="selectedValues">
        <div class="button-container">
            <!-- Add Co-Investigator Button -->
            <button type="button" class="btn co-investigator-btn" onclick="generateSelect()">Add Co-Investigator</button>

            <!-- Add Mentor Button (Initially Hidden) -->
            <button type="button" class="btn mentor-btn" id="mentorBtn" style="display: none;" onclick="addMentor()">Add Mentor</button>

            <!-- Save and Next Button (Initially Disabled) -->
            <input type="submit" class="btn sbmt" id="saveNextBtn" value="SAVE AND NEXT">
        </div>
    </form>
    <%

                if("POST".equalsIgnoreCase(request.getMethod())) {
                    String applicationNumber = appli;
                    if (applicationNumber == null) {
                        applicationNumber = "FG/2024/1";
                    }
                    String budget = request.getParameter("budget");
                    String funding = request.getParameter("scheme");
                    String agency = "VFSTR";
                    String title = request.getParameter("title");
                    String durationParam = request.getParameter("duration"); // Fetch duration as String
                    String invest = empID;
                    String CoEmp = request.getParameter("selectedValues");

                    int dur = 0; // Default duration value
                    if (durationParam != null && !durationParam.isEmpty()) {
                        try {
                            dur = Integer.parseInt(durationParam); // Parse duration if not null or empty
                        } catch (NumberFormatException e) {
                            out.println("<h3 style='color: red;'>Invalid duration value. Please enter a valid number.</h3>");
                        }
                    }
//        else {
//            out.println("<h3 style='color: red;'>Duration is required.</h3>"); // Handle empty duration
//        }

                    int budget_int = 0;
                    if(budget != null && !budget.isEmpty()){
                        try{
                            budget_int = Integer.parseInt(budget);
                        } catch (java.lang.Exception e) {
                            throw new RuntimeException(e);
                        }
                    }


                    int fund_id = 0;
                    if (funding != null && !funding.isEmpty()) {
                        try {
                            fund_id = Integer.parseInt(funding);
                        } catch (Exception e) {
                            throw new RuntimeException(e);
                        }
                    }

                    try {

                        preparedStatement = conn.prepareStatement("insert into facultygrants.projectdetails (appno , funding , title , duration,pi,amount,copi) values(?,?,?,?,?,?,?)");
                        preparedStatement.setString(1, applicationNumber);
                        preparedStatement.setInt(2, fund_id);
                        preparedStatement.setString(3, title);
                        preparedStatement.setInt(4, dur);
                        preparedStatement.setString(5, invest);
                        preparedStatement.setInt(6,budget_int);
                        preparedStatement.setString(7, CoEmp);


                        int rowAffected =  preparedStatement.executeUpdate();
                        if(rowAffected > 0){
        
                            session.setAttribute("pi",empID);
                            session.setAttribute("tenure",dur);
                            session.setAttribute("appno", appli);

                            response.sendRedirect("Annex_1_Form_proposal.jsp");
                        }


                    } catch (Exception e) {
                        throw new RuntimeException(e);
                    }
                }


            }

    %>



    <%

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        finally {
            if(resultSet != null) try{ resultSet.close(); } catch (SQLException e) {  }
            if(preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) {  }
        }
    %>



</section>
</body>
<script>

    function addMentor(){
        alert("Mentor will addded later!!");
    }

    function checkSchemeAndDuration() {
        console.log("Function called"); // Debugging statement
        const schemeElement = document.getElementById('Scheme');
        if (!schemeElement) {
            console.error("Element not found in DOM.");
            return;
        }

        const scheme = schemeElement.value;
        console.log("Selected scheme:", scheme); // Debugging statement

        const mentorBtn = document.getElementById('mentorBtn');
        if (scheme==1 || scheme == 2) {
            mentorBtn.style.display = 'inline-block';
        } else {
            mentorBtn.style.display = 'none';
        }
    }




    document.querySelectorAll('.navbar a').forEach(link => {
        link.addEventListener('click', function(event) {
            // Remove 'active' class from all links
            document.querySelectorAll('.navbar a').forEach(nav => nav.classList.remove('active'));

            // Add 'active' class to the clicked link
            this.classList.add('active');
        });
    });


    let investigatorCount = 0;

    // This function will store selected values in a hidden input field
    function updateSelectedValues() {
        // Get all select elements with the specific class
        const selects = document.querySelectorAll('.co-investigator-select');
        let selectedValues = [];

        // Loop through all relevant selects and get their values
        selects.forEach(select => {
            if (select.value) {  // Check if a value is selected
                selectedValues.push(select.value);
            }
        });

        // Join selected values into a string separated by semicolons
        const selectedString = selectedValues.join(';');

        // Set the value of the hidden input field
        document.getElementById('selectedValues').value = selectedString;
    }



    function generateSelect() {
        // Increment the investigator count
        investigatorCount++;

        // Get the table element
        const table = document.querySelector('.content-section table');

        // Create a new row
        const newRow = document.createElement('tr');

        // Create the first column and add text
        const firstColumn = document.createElement('td');
        firstColumn.textContent = "Co-Investigator - " + investigatorCount;
        newRow.appendChild(firstColumn);

        // Create the second column
        const secondColumn = document.createElement('td');
        const selectElement = document.createElement('select');

        // Add a specific class to target these elements
        selectElement.classList.add('co-investigator-select');

        // Populate the select options from server-side code
        <%
            preparedStatement = conn.prepareStatement("select * from facultygrants.registration");
            resultSet = preparedStatement.executeQuery();
            while(resultSet.next()) {
        %>
        const option<%= resultSet.getString("empcode") %> = document.createElement('option');
        option<%= resultSet.getString("empcode") %>.value = "<%= resultSet.getString("empcode") %>";
        option<%= resultSet.getString("empcode") %>.text = "<%= resultSet.getString("name") %>";
        selectElement.appendChild(option<%= resultSet.getString("empcode") %>);
        <%
            }
        %>

        // Add event listener to update the selected values string when an option is selected
        selectElement.addEventListener('change', updateSelectedValues);

        secondColumn.appendChild(selectElement);
        newRow.appendChild(secondColumn);

        // Append the new row to the table
        table.appendChild(newRow);

        // Update selected values after adding new dropdown
        updateSelectedValues();
    }



</script>
</html>

