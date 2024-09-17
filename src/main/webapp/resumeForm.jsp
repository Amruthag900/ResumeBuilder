<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Resume Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100vh;
            text-align: center;
        }
        .header {
           /* margin-top: 5px; /* Decreased space at the top of the page */
            margin-bottom: 10px; /* Space between title and form */
        }
        .form-container {
            width: 595px; /* Width similar to A4 paper */
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: left; /* Align form content to the left */
        }
        .form-container form {
            display: flex;
            flex-direction: column;
        }
        .form-container label {
            margin-top: 10px;
            font-weight: bold;
        }
        .form-container input[type="text"],
        .form-container input[type="email"],
        .form-container textarea {
            margin-top: 5px;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
            box-sizing: border-box;
           
        }
        .form-container input[type="submit"] {
            margin-top: 20px;
            padding: 12px;
            font-size: 16px;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .form-container input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .form-container a {
            text-align: center;
            display: block;
            margin-top: 20px;
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }
        .form-container a:hover {
            color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Resume Form</h1>
    </div>
    <div class="form-container">
        <form action="ResumeServlet" method="post">
            <label>Full Name:</label>
            <input type="text" name="fullName" required>
            
            <label>Email:</label>
            <input type="email" name="email" required>
            
            <label>Phone:</label>
            <input type="text" name="phone" required>
            
            <label>Address:</label>
            <input type="text" name="address" required>
            
            <label>Education:</label>
            <textarea name="education" required></textarea>
            
            <label>Experience:</label>
            <textarea name="experience" required></textarea>
            
            <label>Skills:</label>
            <textarea name="skills" required></textarea>
            
            <label>Certifications:</label>
            <textarea name="certifications" required></textarea>
            
            <label>Projects:</label>
            <textarea name="projects" required></textarea>
            
            <input type="submit" value="Submit">
            
            <a href="dashboard.jsp">Back</a>
        </form>
    </div>
</body>
</html>
