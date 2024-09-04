<%@ include file="javabean.jsp"%>
<%@ include file="Annex_1_Form_Header.jsp" %>
<%

    String appno = "FG/2024/3";
    session.setAttribute("appno", appno);
  
    String phase_plan = request.getParameter("phase_plan");
    String mile_stone = request.getParameter("mile_stone");
   

    if (mile_stone != null && phase_plan != null) {
       
    	out.println("values during the parameters:");
        out.println("phase_plan: " + phase_plan + "<br>");
        out.println("mile_stone: " + mile_stone + "<br>");
       
    }else{
    	 out.println("Error: fill the required fileds");
    }
    
 
    if (request.getParameter("sub") != null) {  
        String updateQuery = "UPDATE facultygrants.projectdetails SET w_phaseplan = ?, w_milestone = ?  WHERE appno = ?";
        PreparedStatement psUpdate = conn.prepareStatement(updateQuery);
        psUpdate.setString(1, phase_plan);
        psUpdate.setString(2, mile_stone);
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
            
            out.println("----------------------Background:-----------------------"+"<br>");
            out.println("Background Review: " + rs.getBlob("b_review") + "<br>");
            out.println("Background Rational: " + rs.getBlob("b_rational") + "<br>");
             
            out.println("----------------------Description:-----------------------"+"<br>");
            out.println("Description Objectives: " + rs.getBlob("d_objectives").toString() + "<br>");
            out.println("Description Preliminary: " + rs.getBlob("d_preliminv").toString() + "<br>");
            out.println("Description Innovative: " + rs.getBlob("d_inncomp").toString() + "<br>");
            out.println("Description Methodology: " + rs.getBlob("d_methodology").toString() + "<br>");

            out.println("----------------------WorkPhase:-----------------------"+"<br>");
            out.println("Description Objectives: " + rs.getBlob("w_phaseplan").toString() + "<br>");
            out.println("Description Preliminary: " + rs.getBlob("w_milestone").toString() + "<br>");

            out.println("----------------------Output&Deliverables:-----------------------"+"<br>");
            out.println("Output&Deliverables Objectives: " + rs.getBlob("del_impact").toString() + "<br>");
            out.println("Output&Deliverables Preliminary: " + rs.getBlob("del_exp_pub").toString() + "<br>");
            out.println("Output&Deliverables Innovative: " + rs.getBlob("del_mon_effective").toString() + "<br>");
            out.println("Output&Deliverables Methodology: " + rs.getBlob("del_suit_gov_schemes").toString() + "<br>");
            out.println("Output&Deliverables Methodology: " + rs.getBlob("del_post_proj_act").toString() + "<br>");
            
        } 

    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Collapsible Section</title>
    <style>
        /* Styles for the page */
        .container {
            max-width: 600px;
            margin: 20px auto;
            font-family: Arial, sans-serif;
        }
        .card-container {
            background-color: #333;
            color: #fff;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 5px;
            cursor: pointer;
            position: relative;
        }
        .card-container h2 {
            margin: 0;
            font-size: 18px;
            display: inline;
        }
        .toggle-icon {
            float: right;
            font-size: 20px;
            font-weight: bold;
            line-height: 18px;
        }
        .content {
            background-color: #444;
            color: #ddd;
            padding: 10px;
            display: none;
        }
        .content-card {
            display: flex;
            flex-direction: column;
        }
        .card-container-card {
            display: flex;
            flex-direction: column;
            margin-bottom: 1rem;
        }
        .textarea {
            flex: 1;
            margin-right: 1rem;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            resize: vertical;
            background-color: #555;
            color: #fff;
        }
        .file {
            flex-shrink: 0;
            padding: 5px;
            background-color: #555;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        button {
            background-color: #333;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }
        button:hover {
            background-color: #444;
        }
        .textarea{
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="container">
        <form method="POST">
            <!-- Background of Proposal -->
        <div class="card-container-background">
            <div class="card-container">
                <h2>WorkPlan</h2>
                <span class="toggle-icon">+</span>
            </div>
            <div class="content">
                <div class="content-card">

                    <label for="PERT-GANTT-Phase-wiseFiled">Phase-wise plan of action upto post project activities detailing time schedule</label>
                    <div class="card-container-card">
                        <div class="card-iframe">
                            <textarea class="textarea" id="PERT-GANTT-Phase-wiseFiled" rows="10" name="phase_plan" placeholder="Phase-wise plan of action...."></textarea>
                        </div>
                    </div>

                    <label for="PERT-GANTT-MilestoneFiled">Milestone may clearly be indicated </label>
                    <div class="card-container-card">
                        <div class="card-iframe">
                            <textarea class="textarea" id="PERT-GANTT-MilestoneFiled" rows="10" name="mile_stone" placeholder="Expected Publications / Patents....."></textarea>
        
                        </div>
                         <div class="card-iframe">
                            
                        <iframe src="image_upload_file.jsp?ses=1" name="PERTGANTTMilestoneFiledFile" id="PERT-GANTT-Milestone-file" style="border: 0" width="800" frameborder="0" scrolling="no"></iframe>
                        </div>
                    </div>


                </div>
            </div>
        </div>
            
            <button type="submit" name="sub">Submit</button>
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
                } else {
                    content.style.display = 'none';
                    icon.textContent = '+';
                }
            });
        });
    </script>
</body>
</html>

<%@ include file="dbClose.jsp"%>