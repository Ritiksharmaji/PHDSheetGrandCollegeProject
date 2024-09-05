<%@ include file="javabean.jsp"%>
<%-- <%@ include file="Annex_1_Form_Header.jsp" %> --%>
<%

    String appno = (String) session.getAttribute("appno");
  
    String phase_plan = request.getParameter("phase_plan");
    String mile_stone = request.getParameter("mile_stone");
   

    // if (mile_stone != null && phase_plan != null) {
       
    // 	out.println("values during the parameters:");
    //     out.println("phase_plan: " + phase_plan + "<br>");
    //     out.println("mile_stone: " + mile_stone + "<br>");
       
    // }else{
    // 	 out.println("Error: fill the required fileds");
    // }
    
 
    if (request.getParameter("sub") != null) {  
        String updateQuery = "UPDATE facultygrants.projectdetails SET w_phaseplan = ?, w_milestone = ?  WHERE appno = ?";
        PreparedStatement psUpdate = conn.prepareStatement(updateQuery);
        psUpdate.setString(1, phase_plan);
        psUpdate.setString(2, mile_stone);
        psUpdate.setString(3, appno);
        int rowAffected = psUpdate.executeUpdate();

        if(rowAffected > 0){
            response.sendRedirect("Annex_1_Form_Strength.jsp");
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
            
        //     out.println("----------------------Background:-----------------------"+"<br>");
        //     out.println("Background Review: " + rs.getBlob("b_review") + "<br>");
        //     out.println("Background Rational: " + rs.getBlob("b_rational") + "<br>");
             
        //     out.println("----------------------Description:-----------------------"+"<br>");
        //     out.println("Description Objectives: " + rs.getBlob("d_objectives").toString() + "<br>");
        //     out.println("Description Preliminary: " + rs.getBlob("d_preliminv").toString() + "<br>");
        //     out.println("Description Innovative: " + rs.getBlob("d_inncomp").toString() + "<br>");
        //     out.println("Description Methodology: " + rs.getBlob("d_methodology").toString() + "<br>");

        //     out.println("----------------------WorkPhase:-----------------------"+"<br>");
        //     out.println("Description Objectives: " + rs.getBlob("w_phaseplan").toString() + "<br>");
        //     out.println("Description Preliminary: " + rs.getBlob("w_milestone").toString() + "<br>");

        //     out.println("----------------------Output&Deliverables:-----------------------"+"<br>");
        //     out.println("Output&Deliverables Objectives: " + rs.getBlob("del_impact").toString() + "<br>");
        //     out.println("Output&Deliverables Preliminary: " + rs.getBlob("del_exp_pub").toString() + "<br>");
        //     out.println("Output&Deliverables Innovative: " + rs.getBlob("del_mon_effective").toString() + "<br>");
        //     out.println("Output&Deliverables Methodology: " + rs.getBlob("del_suit_gov_schemes").toString() + "<br>");
        //     out.println("Output&Deliverables Methodology: " + rs.getBlob("del_post_proj_act").toString() + "<br>");
            
        // } 

    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Collapsible Section</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            width: 80%;
            margin: 0 auto;
            margin-top: 50px;
        }

        /* Navbar Styles */
        nav {
            background-color: #fbfcfc;
            padding: 15px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
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
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .navbar li a.active,
        .navbar li a:hover {
            background-color: #149f19;
        }

        /* Card Container Styles */
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
                <li><a href="Annex_1_Form_workplan.jsp" class="active">Work Plan</a></li>
                <li><a href="Annex_1_Form_Strength.jsp">Strength</a></li>
                <li><a href="Annex_1_Form_deliverables.jsp">Deliverables</a></li>
                <li><a href="Annex_1_Form_Budget.jsp">Budget</a></li>
                <li><a href="Annex_1_Form_uploads.jsp">Uploads</a></li>
                <li><a href="Annex_1_Form_preview.jsp">Preview</a></li>
            </ul>
        </nav>

        <form method="POST">
            <!-- Work Plan Section -->
            <div class="card-container">
                <h2>WorkPlan</h2>
                <span class="toggle-icon">+</span>
            </div>
            <div class="content">
                <div class="content-card">
                    <label for="PERT-GANTT-Phase-wiseFiled">Phase-wise plan of action up to post-project activities detailing time schedule</label>
                    <textarea class="textarea" id="PERT-GANTT-Phase-wiseFiled" rows="10" name="phase_plan" placeholder="Phase-wise plan of action...."></textarea>

                    <label for="PERT-GANTT-MilestoneFiled">Milestone may clearly be indicated</label>
                    <textarea class="textarea" id="PERT-GANTT-MilestoneFiled" rows="10" name="mile_stone" placeholder="Expected Publications / Patents....."></textarea>

                    <iframe src="image_upload_file.jsp?ses=1" name="PERTGANTTMilestoneFiledFile" id="PERT-GANTT-Milestone-file" width="800" frameborder="0" scrolling="no"></iframe>
                </div>
            </div>
            
            <div class="btn btn-buttton-contianer">
            <button type="submit" name="sub">Submit</button>
            </div>
        </form>

    </div>

    <script>
        // JavaScript for toggling sections
        const cards = document.querySelectorAll('.card-container');
        cards.forEach(card => {
            card.addEventListener('click', () => {
                const content = card.nextElementSibling;
                const icon = card.querySelector('.toggle-icon');
                if (content.style.display === 'none' || !content.style.display) {
                    content.style.display = 'block';
                    icon.textContent = '-';
                    icon.classList.add('active');
                } else {
                    content.style.display = 'none';
                    icon.textContent = '+';
                    icon.classList.remove('active');
                }
            });
        });
    </script>
</body>
</html>

<%@ include file="dbClose.jsp"%>