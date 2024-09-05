<%@ include file="javabean.jsp"%>
<%-- <%@ include file="Annex_1_Form_Header.jsp" %> --%>
<%

    String appno = (String) session.getAttribute("appno");

    String b_description = request.getParameter("b_description");
    String b_review = request.getParameter("b_review");
    String b_Rational = request.getParameter("b_Rational");
    String d_Objectives = request.getParameter("d_Objectives");
    String d_Preliminary = request.getParameter("d_Preliminary");
    String d_Innovative = request.getParameter("d_Innovative");
    String d_Methodology = request.getParameter("d_Methodology");

    // if (request.getParameter("b_description") != null && request.getParameter("b_review") != null &&
    // 	request.getParameter("b_Rational") != null && request.getParameter("d_Objectives") != null &&
    // 	request.getParameter("d_Preliminary") != null && request.getParameter("d_Innovative") != null &&
    // 	request.getParameter("d_Methodology") != null) {
       
    // 	out.println("values during the parameters:");
    //     out.println("b_description: " + request.getParameter("b_description") + "<br>");
    //     out.println("b_review: " + request.getParameter("b_review") + "<br>");
    //     out.println("b_Rational: " + request.getParameter("b_Rational") + "<br>");
    //     out.println("d_Objectives: " + request.getParameter("d_Objectives") + "<br>");
    //     out.println("d_Preliminary: " + request.getParameter("d_Preliminary") + "<br>");
    //     out.println("d_Innovative: " + request.getParameter("d_Innovative") + "<br>");
    //     out.println("d_Methodology: " + request.getParameter("d_Methodology") + "<br>");
    // }else{
    // 	 out.println("Error: fill the required fileds");
    // }
    

    if (request.getParameter("sub") != null) {
        String updateQuery = "UPDATE facultygrants.projectdetails SET b_description = ?, b_review = ?,b_rational= ?, d_objectives= ?,d_preliminv=?,d_inncomp=?,d_methodology=? WHERE appno = ?";
        PreparedStatement psUpdate = conn.prepareStatement(updateQuery);
        psUpdate.setString(1, b_description);
        psUpdate.setString(2, b_review);
        psUpdate.setString(3, b_Rational);
        psUpdate.setString(4, d_Objectives);
        psUpdate.setString(5, d_Preliminary);
        psUpdate.setString(6, d_Innovative);
        psUpdate.setString(7, d_Methodology);
        psUpdate.setString(8, appno);
        int rowAffected = psUpdate.executeUpdate();
        if(rowAffected > 0){
            response.sendRedirect("Annex_1_Form_workplan.jsp");
        }

        // Fetch updated data
        // String selectQuery = "SELECT * FROM facultygrants.projectdetails WHERE appno = ?";
        // PreparedStatement psSelect = conn.prepareStatement(selectQuery);
        // psSelect.setString(1, appno);
        // ResultSet rs = psSelect.executeQuery();
    
         
        // // Display the result
        // if (rs.next()) {
        //     out.println("ID: " + rs.getInt("id") + "<br>");
        //     out.println("Application Number: " + rs.getString("appno") + "<br>");
        //     out.println("Funding: " + rs.getInt("funding") + "<br>");
        //     out.println("Title: " + rs.getBlob("title") + "<br>");
        //     out.println("Duration: " + rs.getInt("duration") + "<br>");
        //     out.println("Amount: " + rs.getInt("amount") + "<br>");
        //     out.println("COPI: " + rs.getString("copi") + "<br>");
        //     out.println("Background Description: " + rs.getBlob("b_description") + "<br>");
        //     out.println("Background Review: " + rs.getBlob("b_review") + "<br>");
        //     out.println("Background Rational: " + rs.getBlob("b_rational") + "<br>");
            
        //     out.println("Description Objectives: " + rs.getBlob("d_objectives") + "<br>");
        //     out.println("Description Preliminary: " + rs.getBlob("d_preliminv") + "<br>");
        //     out.println("Description Innovative: " + rs.getBlob("d_inncomp") + "<br>");
        //     out.println("Description Methodology: " + rs.getBlob("d_methodology") + "<br>");
            
        // } 

    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Proposal Form</title>
    <style>
        /* Basic reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            line-height: 1.6;
        }

        .container {
            width: 80%;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        nav {
            background-color: #007bff;
            border-radius: 8px;
            margin-bottom: 30px;
            padding: 15px;
        }

        .navbar {
            list-style: none;
            display: flex;
            justify-content: space-around;
            align-items: center;
        }

        .navbar li {
            flex: 1;
            text-align: center;
        }

        .navbar li a {
            text-decoration: none;
            color: #fff;
            padding: 10px 15px;
            font-weight: bold;
            display: block;
            transition: background-color 0.3s ease-in-out;
            border-radius: 5px;
        }

        .navbar li a:hover,
        .navbar li a.active {
            background-color: #0056b3;
        }

        .card-container-background {
            margin-bottom: 20px;
        }

        .card-container {
            background-color: #007bff;
            color: #fff;
            padding: 15px;
            border-radius: 8px;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: background-color 0.3s ease-in-out;
        }

        .card-container h2 {
            margin: 0;
            font-size: 20px;
        }

        .toggle-icon {
            font-size: 24px;
            line-height: 1;
            transition: transform 0.3s ease-in-out;
        }

        .content {
            background-color: #f9f9f9;
            color: #333;
            padding: 20px;
            margin-top: 10px;
            border-radius: 8px;
            display: none;
        }

        .content-card {
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            margin-bottom: 8px;
            display: block;
        }

        .textarea {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            resize: vertical;
            font-size: 16px;
        }

        iframe {
            width: 100%;
            height: 200px;
            border: none;
            margin-top: 10px;
            border-radius: 5px;
            background-color: #007bff;
        }

        button {
            background-color: #28a745;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease-in-out;
        }

        button:hover {
            background-color: #218838;
        }

        /* Additional Styles */
        .card-container:hover {
            background-color: #0056b3;
        }

        .card-container.active .toggle-icon {
            transform: rotate(45deg);
        }

    </style>
</head>

<body>

    <div class="container">
        <!-- Navbar -->
        <nav>
            <ul class="navbar">
                <li><a href="Annex_1_Form_Investigator.jsp">Investigators</a></li>
                <li><a href="Annex_1_Form_proposal.jsp" class="active">Proposal</a></li>
                <li><a href="Annex_1_Form_workplan.jsp">Work Plan</a></li>
                <li><a href="Annex_1_Form_Strength.jsp">Strength</a></li>
                <li><a href="Annex_1_Form_deliverables.jsp">Deliverables</a></li>
                <li><a href="Annex_1_Form_Budget.jsp">Budget</a></li>
                <li><a href="Annex_1_Form_uploads.jsp">Uploads</a></li>
                <li><a href="Annex_1_Form_preview.jsp">Preview</a></li>
            </ul>
        </nav>

        <!-- Background of Proposal -->
        <form method="POST">
            <div class="card-container-background">
                <div class="card-container">
                    <h2>Background</h2>
                    <span class="toggle-icon">+</span>
                </div>
                <div class="content">
                    <div class="content-card">
                        <label for="Background-DescriptionFiled">Description of problem</label>
                        <textarea class="textarea" id="Background-DescriptionFiled" rows="10" name="b_description"
                            placeholder="Description of problem"></textarea>
                        <iframe src="image_upload_file.jsp?ses=3" name="backgroundDescriptionFile"
                            id="Background-Description-file"></iframe>
                    </div>
                    <div class="content-card">
                        <label for="Background-ReviewFiled">Review of problem</label>
                        <textarea class="textarea" id="Background-ReviewFiled" rows="10" name="b_review"
                            placeholder="Review of problem"></textarea>
                        <iframe src="image_upload_file.jsp?ses=4" name="backgroundReviewFile" id="Background-Review-file"></iframe>
                    </div>
                    <div class="content-card">
                        <label for="Background-RationalFiled">Rationale for taking up the project</label>
                        <textarea class="textarea" id="Background-RationalFiled" rows="10" name="b_Rational"
                            placeholder="Rationale for taking up the project"></textarea>
                        <iframe src="image_upload_file.jsp?ses=5" name="BackgroundRationalFile" id="Background-Rational-file"></iframe>
                    </div>
                </div>
            </div>

            <!-- Description of Proposal -->
            <div class="card-container-background">
                <div class="card-container">
                    <h2>Description of Proposal</h2>
                    <span class="toggle-icon">+</span>
                </div>
                <div class="content">
                    <div class="content-card">
                        <label for="Description-ObjectivesFiled">Objectives of the project (3 or 4 bullets)</label>
                        <textarea class="textarea" id="Description-ObjectivesFiled" rows="10" name="d_Objectives"
                            placeholder="Objectives of the project"></textarea>
                        <iframe src="image_upload_file.jsp?ses=6" name="DescriptionObjectivesFiled"
                            id="Description-Objectives-file"></iframe>
                    </div>
                    <div class="content-card">
                        <label for="Description-PreliminaryFiled">Preliminary Investigations done (if any)</label>
                        <textarea class="textarea" id="Description-PreliminaryFiled" rows="10" name="d_Preliminary"
                            placeholder="Preliminary Investigations done"></textarea>
                        <iframe src="image_upload_file.jsp?ses=7" name="DescriptionPreliminaryFile"
                            id="Description-Preliminary-file"></iframe>
                    </div>
                    <div class="content-card">
                        <label for="Description-InnovativeFiled">Innovative component of the project</label>
                        <textarea class="textarea" id="Description-InnovativeFiled" rows="10" name="d_Innovative"
                            placeholder="Innovative component of the project"></textarea>
                        <iframe src="image_upload_file.jsp?ses=8" name="DescriptionInnovativeFiled"
                            id="Description-Innovative-file"></iframe>
                    </div>
                    <div class="content-card">
                        <label for="Description-MethodologyFiled">Methodology detailing stepwise activities and
                            sub-activities</label>
                        <textarea class="textarea" id="Description-MethodologyFiled" rows="10" name="d_Methodology"
                            placeholder="Methodology detailing stepwise activities"></textarea>
                        <iframe src="image_upload_file.jsp?ses=9" name="DescriptionMethodologyFile"
                            id="Description-Methodology-file"></iframe>
                    </div>
                </div>
            </div>

            <button type="submit" name="sub">Submit</button>
        </form>
    </div>

    <script>
        // Script to toggle content visibility
        document.querySelectorAll('.card-container').forEach(card => {
            card.addEventListener('click', function () {
                this.classList.toggle('active');
                const content = this.nextElementSibling;
                content.style.display = content.style.display === 'block' ? 'none' : 'block';
            });
        });
    </script>

</body>

</html>
<%@ include file="dbClose.jsp"%>