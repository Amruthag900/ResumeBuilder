<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<html>
<head>
    <title>Edit Resume Form</title>
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
        .form-container textarea {
            height: 75px; /* Adjust height for better usability */
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
        <h1>Edit Resume Form</h1>
    </div>
    <div class="form-container">
        <%
            HttpSession session1 = request.getSession(false);
            if (session1 == null || session1.getAttribute("userId") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int userId = (int) session1.getAttribute("userId");

            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            String url = "jdbc:mysql://localhost:3306/resume_builder";
            String user = "root";  
            String password = "root";  

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);

                String sql = "SELECT * FROM resumes WHERE user_id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, userId);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    int resumeId = rs.getInt("resume_id");
                    String fullName = rs.getString("full_name");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String address = rs.getString("address");
                    String education = rs.getString("education");
                    String experience = rs.getString("experience");
                    String skills = rs.getString("skills");
                    String certifications = rs.getString("certifications");
                    String projects = rs.getString("projects");
        %>
        <form action="EditResumeServlet" method="post">
            <input type="hidden" name="resumeId" value="<%= resumeId %>">
            <label>Full Name:</label>
            <input type="text" name="fullName" value="<%= fullName %>" required>
            
            <label>Email:</label>
            <input type="email" name="email" value="<%= email %>" required>
            
            <label>Phone:</label>
            <input type="text" name="phone" value="<%= phone %>" required>
            
            <label>Address:</label>
            <input type="text" name="address" value="<%= address %>" required>
            
            <label>Education:</label>
            <textarea name="education" required><%= education %></textarea>
            
            <label>Experience:</label>
            <textarea name="experience" required><%= experience %></textarea>
            
            <label>Skills:</label>
            <textarea name="skills" required><%= skills %></textarea>
            
            <label>Certifications:</label>
            <textarea name="certifications" required><%= certifications %></textarea>
            
            <label>Projects:</label>
            <textarea name="projects" required><%= projects %></textarea>
            
            <input type="submit" value="Update">
            
            <a href="dashboard.jsp">Back</a>
        </form>
        <%
                } else {
                    out.println("No resume found for this user.");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </div>
</body>
</html>
