<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Registration Form</title>
    <link rel="stylesheet" href="Ritik.css">
</head>
<body>

<div class="container">
    <div class="header-container">
        <h2>Application</h2>
    </div>
    <div class="body-container-registation">
        <div class="form-container">
            <form>
            <!-- <form action="/submit_registration" method="post"></form> -->
               <div class="form-card-container">
                    <div class="form-group">
                        <label for="name">Employee Name</label>
                        <input type="text" id="name" name="name" placeholder="Enter your name" required>
                    </div>
                    <div class="form-group">
                        <label for="id">Employee ID</label>
                        <input type="text" id="id" name="id" placeholder="Enter your employee ID" required>
                    </div>
                    <div class="form-group">
                        <label for="designation">Designation</label>
                        <input type="text" id="designation" name="designation" placeholder="Enter your designation" required>
                    </div>
                    <div class="form-group">
                        <label for="school">School Name</label>
                        <input type="text" id="school" name="school" placeholder="Enter your school name" required>
                    </div>
                    <div class="form-group">
                        <label for="department">Department Name</label>
                        <input type="text" id="department" name="department" placeholder="Enter your department name" required>
                    </div>
                    <div class="form-group">
                        <label for="qualification">Highest Qualification</label>
                        <input type="text" id="qualification" name="qualification" placeholder="Enter your highest qualification" required>
                    </div>
                    <div class="form-group">
                        <label for="contact_number">Contact Number</label>
                        <input type="number" id="contact_number" name="contact_number" placeholder="Enter your contact number" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Contact Email</label>
                        <input type="email" id="email" name="email" placeholder="Enter your contact email" required>
                    </div>
                    <div class="form-submit-button">
                        <!-- <input type="submit" value="SUBMIT"> -->
                         <button type="submit" class="submit-button">Submit</button>
                    </div>
               </div>
            </form>
        </div>
        <div class="image-container">
            <img src="/resources/registationImage.jpg" alt="RegistationImage" class="registaionImage">
        </div>
    </div>
</div>

<script src="Ritik.js"></script>
</body>
</html>
