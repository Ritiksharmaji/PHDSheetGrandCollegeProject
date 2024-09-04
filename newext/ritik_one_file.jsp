<%@ include file="javabean.jsp"%>
<%

    String appno = "FG/2024/3";
    session.setAttribute("appno", appno);

    String b_description = request.getParameter("b_description");
    String b_review = request.getParameter("b_review");
    String b_Rational = request.getParameter("b_Rational");
    String d_Objectives = request.getParameter("d_Objectives");
    String d_Preliminary = request.getParameter("d_Preliminary");
    String d_Innovative = request.getParameter("d_Innovative");
    String d_Methodology = request.getParameter("d_Methodology");

    if (request.getParameter("b_description") != null && request.getParameter("b_review") != null &&
    	request.getParameter("b_Rational") != null && request.getParameter("d_Objectives") != null &&
    	request.getParameter("d_Preliminary") != null && request.getParameter("d_Innovative") != null &&
    	request.getParameter("d_Methodology") != null) {
       
    	out.println("values during the parameters:");
        out.println("b_description: " + request.getParameter("b_description") + "<br>");
        out.println("b_review: " + request.getParameter("b_review") + "<br>");
        out.println("b_Rational: " + request.getParameter("b_Rational") + "<br>");
        out.println("d_Objectives: " + request.getParameter("d_Objectives") + "<br>");
        out.println("d_Preliminary: " + request.getParameter("d_Preliminary") + "<br>");
        out.println("d_Innovative: " + request.getParameter("d_Innovative") + "<br>");
        out.println("d_Methodology: " + request.getParameter("d_Methodology") + "<br>");
    }else{
    	 out.println("Error: fill the required fileds");
    }
    

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
            out.println("Background Rational: " + rs.getBlob("b_rational") + "<br>");
            
            out.println("Description Objectives: " + rs.getBlob("d_objectives") + "<br>");
            out.println("Description Preliminary: " + rs.getBlob("d_preliminv") + "<br>");
            out.println("Description Innovative: " + rs.getBlob("d_inncomp") + "<br>");
            out.println("Description Methodology: " + rs.getBlob("d_methodology") + "<br>");
            
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
                <h2>Background</h2>
                <span class="toggle-icon">+</span>
            </div>
            <div class="content">
                <div class="content-card">
                    <label for="Background-DescriptionFiled">Description of problem</label>
                    <div class="card-container-card">
                        <div class="card-iframe">
                            <textarea class="textarea" id="Background-DescriptionFiled" rows="10" name="b_description" placeholder="Description of problem"></textarea>
                            <iframe src="image_upload_file.jsp?ses=3" name="backgroundDescriptionFile" id="Background-Description-file" style="border: 0" width="800" frameborder="0" scrolling="no"></iframe>
                        </div>
                    </div>
                    <label for="Background-DescriptionFiled">Review of problem</label>
                    <div class="card-container-card">a
                        <div class="card-iframe">
                            <textarea class="textarea" id="Background-ReviewFiled" rows="10" name="b_review" placeholder="Description of problem"></textarea>
                        <iframe src="image_upload_file.jsp?ses=4" name="backgroundReviewFile" id="Background-Review-file" style="border: 0" width="800" frameborder="0" scrolling="no"></iframe>
                        </div>
                    </div>
                    
                     <label for="Background-RationalFiled">Rational for taking up the project</label>
                        <div class="card-container-card">
                            <div class="card-iframe">
                                <textarea class="textarea" id="Background-RationalFiled" rows="10" name="b_Rational" placeholder="Rational for taking up the project"></textarea>
                            <iframe src="image_upload_file.jsp?ses=5" name="BackgroundRationalFile" id="Background-Rational-file" style="border: 0" width="800" frameborder="0" scrolling="no"></iframe>
                            </div>
                        </div>
                </div>
            </div>
            </div>
            
<!------------------------------------------ descript of proposal---------------------------------------- -->
            <div class="card-container-background">
            <div class="card-container">
                <h2>Description of Proposal</h2>
                <span class="toggle-icon">+</span>
            </div>
            <div class="content">
                <div class="content-card">
                     <label for="Description-ObjectivesFiled">Objectives of the project (3 or 4 bullets)</label>
                        <div class="card-container-card">
                            <div class="card-iframe">
                                <textarea class="textarea" id="Description-ObjectivesFiled" rows="10" name="d_Objectives" placeholder="Objectives of the project (3 or 4 bullets)"></textarea>
                                <iframe src="image_upload_file.jsp?ses=6" name="DescriptionObjectivesFiled" id="Description-Objectives-file" style="border: 0" width="800" frameborder="0" scrolling="no"></iframe>
                            </div>
                        </div>

                        <label for="Description-PreliminaryFiled">Preliminary Investigations done (if any)</label>
                        <div class="card-container-card">
                            <div class="card-iframe">
                                <textarea class="textarea" id="Description-PreliminaryFiled" rows="10" name="d_Preliminary" placeholder="Preliminary Investigations done (if any)"></textarea>
                            <iframe src="image_upload_file.jsp?ses=7" name="DescriptionPreliminaryFile" id="Description-Preliminary-file" style="border: 0" width="800" frameborder="0" scrolling="no"></iframe>
                            </div>
                        </div>

                        <label for="Description-InnovativeFiled">Innovative component of the project</label>
                        <div class="card-container-card">
                            <div class="card-iframe">
                                <textarea class="textarea" id="Description-InnovativeFiled" rows="10" name="d_Innovative" placeholder="Innovative component of the project"></textarea>
                                <iframe src="image_upload_file.jsp?ses=8" name="DescriptionInnovativeFiled" id="Description-Innovative-file" style="border: 0" width="800" frameborder="0" scrolling="no"></iframe>
                            </div>
                        </div>
                        <label for="Description-MethodologyFiled">Methodology detailing stepwise activities and sub-activities</label>
                        <div class="card-container-card">
                            <div class="card-iframe">
                                <textarea class="textarea" id="Description-MethodologyFiled" rows="10" name="d_Methodology" placeholder="Methodology detailing stepwise activities and sub-activities"></textarea>
                            <iframe src="image_upload_file.jsp?ses=9" name="DescriptionMethodologyFile" id="Description-Methodology-file" style="border: 0" width="800" frameborder="0" scrolling="no"></iframe>
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