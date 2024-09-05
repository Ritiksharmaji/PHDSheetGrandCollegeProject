<%@ include file="javabean.jsp"%>
<%-- <%@ include file="Annex_1_Form_Header.jsp" %> --%>
<%

    String appno = (String) session.getAttribute("appno");

    String od_Likely = request.getParameter("od_Likely");
    String od_Expected = request.getParameter("od_Expected");
    String od_Parameters = request.getParameter("od_Parameters");
    String od_Suitable = request.getParameter("od_Suitable");
    String od_Suggested = request.getParameter("od_Suggested");

    // for display the data on web we are writting the below code

    // if (od_Likely != null && od_Expected != null &&
    // 	od_Parameters != null && od_Suitable != null &&
    // 	od_Suggested != null) {
       
    // 	out.println("values during the parameters:");
    //     out.println("od_Likely: " + od_Likely + "<br>");
    //     out.println("od_Expected: " + od_Expected + "<br>");
    //     out.println("od_Parameters: " + od_Parameters+ "<br>");
    //     out.println("od_Suitable: " + od_Suitable + "<br>");
    //     out.println("od_Suggested: " + od_Suggested + "<br>");
    // }else{
    // 	 out.println("Error: fill the required fileds");
    // }
    
    if (request.getParameter("sub") != null) {  
        String updateQuery = "UPDATE facultygrants.projectdetails SET del_impact = ?, del_exp_pub = ?,del_mon_effective= ?, del_suit_gov_schemes= ?,del_post_proj_act=? WHERE appno = ?";
        PreparedStatement psUpdate = conn.prepareStatement(updateQuery);
        psUpdate.setString(1, od_Likely);
        psUpdate.setString(2, od_Expected);
        psUpdate.setString(3, od_Parameters);
        psUpdate.setString(4, od_Suitable);
        psUpdate.setString(5, od_Suggested);
        psUpdate.setString(6, appno);
        psUpdate.executeUpdate();

        // Fetch updated data
        String selectQuery = "SELECT * FROM facultygrants.projectdetails WHERE appno = ?";
        PreparedStatement psSelect = conn.prepareStatement(selectQuery);
        psSelect.setString(1, appno);
        ResultSet rs = psSelect.executeQuery();
                RequestDispatcher dispatcher = request.getRequestDispatcher("Annex_1_Form_Budget.jsp"); // Replace with your target URL
                dispatcher.forward(request, response);
 
        
        // Display the result
       // if (rs.next()) {
            // out.println("ID: " + rs.getInt("id") + "<br>");
            // out.println("Application Number: " + rs.getString("appno") + "<br>");
            // out.println("Funding: " + rs.getInt("funding") + "<br>");
            // out.println("Title: " + rs.getBlob("title") + "<br>");
            // out.println("Duration: " + rs.getInt("duration") + "<br>");
            // out.println("Amount: " + rs.getInt("amount") + "<br>");
            // out.println("COPI: " + rs.getString("copi") + "<br>");
            
            // out.println("----------------------Background:-----------------------"+"<br>");
            
            // Blob blob = rs.getBlob("b_description");
            // String blobContent = BlobHelper.blobToString(blob);
           // out.println("Background Review: " + blobContent + "<br>");
            //out.println("Background Description: " + BlobHelper.blobToString(blob)(rs.getBlob("b_description")) + "<br>");
            // out.println("Background Review: " + rs.getString("b_review") + "<br>");
            // out.println("Background Rational: " + rs.getString("b_rational") + "<br>");
             
            // out.println("----------------------Description:-----------------------"+"<br>");
            // out.println("Description Objectives: " + rs.getBlob("d_objectives").toString() + "<br>");
            // out.println("Description Preliminary: " + rs.getBlob("d_preliminv").toString() + "<br>");
            // out.println("Description Innovative: " + rs.getBlob("d_inncomp").toString() + "<br>");
            // out.println("Description Methodology: " + rs.getBlob("d_methodology").toString() + "<br>");

            // out.println("----------------------Output&Deliverables:-----------------------"+"<br>");
            // out.println("Output&Deliverables Objectives: " + rs.getBlob("del_impact").toString() + "<br>");
            // out.println("Output&Deliverables Preliminary: " + rs.getBlob("del_exp_pub").toString() + "<br>");
            // out.println("Output&Deliverables Innovative: " + rs.getBlob("del_mon_effective").toString() + "<br>");
            // out.println("Output&Deliverables Methodology: " + rs.getBlob("del_suit_gov_schemes").toString() + "<br>");
            // out.println("Output&Deliverables Methodology: " + rs.getBlob("del_post_proj_act").toString() + "<br>");
            
       // } 

    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Deliverables</title>
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 80%;
            margin: 0 auto;
            padding: 20px;
        }

        /* Navbar Styles */
        nav {
            background-color: #333;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
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
            border-radius: 4px;
        }

        .navbar li a.active {
            background-color: #149f19;
        }

        /* Card Styles */
       .container {
            width: 80%;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
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
            margin-top: 20px;
            display: block;
            width: 100%;
        }

        button:hover {
            background-color: #218838;
        }

        .card-container:hover {
            background-color: #0056b3;
        }

        .card-container.active .toggle-icon {
            transform: rotate(45deg);
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
    margin-top: 20px;
    width: 200px; /* Set a fixed width */
    display: block;
    margin-left: auto;
    margin-right: auto;
}

button:hover {
    background-color: #218838;
}

    </style>
</head>
<body>
    <div class="container">

        <!-- Navbar -->
        <nav>
            <ul class="navbar">
                <li><a href="Annex_1_Form_Investigator.jsp">Investigators</a></li>
                <li><a href="Annex_1_Form_proposal.jsp">Proposal</a></li>
                <li><a href="Annex_1_Form_workplan.jsp">Work Plan</a></li>
                <li><a href="Annex_1_Form_Strength.jsp">Strength</a></li>
                <li><a href="Annex_1_Form_deliverables.jsp" class="active">Deliverables</a></li>
                <li><a href="Annex_1_Form_Budget.jsp">Budget</a></li>
                <li><a href="Annex_1_Form_uploads.jsp">Uploads</a></li>
                <li><a href="Annex_1_Form_preview.jsp">Preview</a></li>
            </ul>
        </nav>

        <!-- Form -->
        <form method="POST">
            <!-- Deliverables Section -->
            <div class="card-container">
                <h2>Deliverables</h2>
                <span class="toggle-icon">+</span>
            </div>
            <div class="content">
                <div class="card-container-card">
                    <label for="Deliverables-LikelyFiled">Likely Impact</label>
                    <textarea class="textarea" id="Deliverables-LikelyFiled" rows="10" name="od_Likely" placeholder="Likely Impact"></textarea>
                    <iframe src="image_upload_file.jsp?ses=10" name="DeliverablesLikelyFile" id="Deliverables-Likely-file"></iframe>
                </div>

                <div class="card-container-card">
                    <label for="Deliverables-ExpectedFiled">Expected Publications / Patents / Models / Technology Transfers</label>
                    <textarea class="textarea" id="Deliverables-ExpectedFiled" rows="10" name="od_Expected" placeholder="Expected Publications / Patents..."></textarea>
                    <iframe src="image_upload_file.jsp?ses=11" name="DeliverablesExpectedFile" id="Deliverables-Expected-file"  class="iframe-class"></iframe>
                </div>

                <div class="card-container-card">
                    <label for="Deliverables-ParametersFiled">Parameters for Monitoring Effectiveness of Project</label>
                    <textarea class="textarea" id="Deliverables-ParametersFiled" rows="10" name="od_Parameters" placeholder="Parameters for Monitoring Effectiveness of Project"></textarea>
                    <iframe src="image_upload_file.jsp?ses=12" name="DeliverablesParametersFile" id="Deliverables-Parameters-file"></iframe>
                </div>

                <div class="card-container-card">
                    <label for="Deliverables-SuitableFiled">Suitable Scheme for Govt. Funded Project</label>
                    <textarea class="textarea" id="Deliverables-SuitableFiled" rows="10" name="od_Suitable" placeholder="Suitable Scheme for Govt. Funded Project"></textarea>
                    <iframe src="image_upload_file.jsp?ses=13" name="DeliverablesSuitableFile" id="Deliverables-Suitable-file"></iframe>
                </div>

                <div class="card-container-card">
                    <label for="Deliverables-SuggestedFiled">Suggested Post Project Activities</label>
                    <textarea class="textarea" id="Deliverables-SuggestedFiled" rows="10" name="od_Suggested" placeholder="Suggested Post Project Activities"></textarea>
                    <iframe src="image_upload_file.jsp?ses=14" name="DeliverablesSuggestedFile" id="Deliverables-Suggested-file"></iframe>
                </div>
            </div>
            
            <!-- Submit Button -->
            <button type="submit" name="sub">Submit</button>
        </form>
    </div>

    <script>
        // JavaScript for toggling sections
        document.querySelectorAll('.card-container').forEach(card => {
            card.addEventListener('click', function() {
                const content = this.nextElementSibling;
                const icon = this.querySelector('.toggle-icon');
                content.style.display = (content.style.display === 'none' || !content.style.display) ? 'block' : 'none';
                icon.textContent = (content.style.display === 'block') ? '-' : '+';
            });
        });
    </script>
</body>
</html>


<%@ include file="dbClose.jsp"%>