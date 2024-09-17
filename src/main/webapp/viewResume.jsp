<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Your Resume</title>
    <style>
        body {
            font-family: 'Times New Roman', Times, serif;
            margin: 40px;
            line-height: 1.6;
            color: #333;
        }
        .resume-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            background-color: #f9f9f9;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1, h2 {
            font-weight: bold;
            margin-bottom: 10px;
        }
        h1 {
            text-align: center;
            text-transform: uppercase;
            font-size: 32px;
            margin-top: 0;
        }
        .resume-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .resume-header p {
            margin: 2px 0;
            font-size: 16px;
            color: #666;
        }
        .resume-section {
            margin-bottom: 30px;
        }
        .resume-section h2 {
            font-size: 20px;
            border-bottom: 2px solid #000;
            padding-bottom: 5px;
            margin-bottom: 15px;
            text-transform: uppercase;
            color: #000;
        }
        .resume-content {
            margin-left: 20px;
        }
        .resume-content p {
            margin: 5px 0;
            font-size: 16px;
            color: #333;
        }
        .resume-section ul {
            list-style-type: disc;
            margin-left: 40px;
        }
        .resume-section ul li {
            margin-bottom: 5px;
            color: #333;
        }
        .action-links {
            margin-top: 20px;
            text-align: center;
        }
        .action-links a {
            font-size: 16px;
            text-decoration: none;
            color: #000;
            margin: 0 10px;
            padding: 8px 15px;
            border: 1px solid #000;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        .action-links a:hover {
            background-color: #000;
            color: #fff;
        }
    </style>
</head>
<body>
<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = (Integer) session1.getAttribute("userId");
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    String fullName = "", email = "", phone = "", address = "", education = "", experience = "", skills = "", certifications = "", projects = "";
    int resumeId = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/resume_builder", "root", "root");

        // Retrieve the user's resume based on the userId
        String sql = "SELECT * FROM resumes WHERE user_id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, userId);
        rs = stmt.executeQuery();

        if (rs.next()) {
            resumeId = rs.getInt("resume_id");
            fullName = rs.getString("full_name");
            email = rs.getString("email");
            phone = rs.getString("phone");
            address = rs.getString("address");
            education = rs.getString("education");
            experience = rs.getString("experience");
            skills = rs.getString("skills");
            certifications = rs.getString("certifications");
            projects = rs.getString("projects");
        } else {
            out.println("No resume found for this user.");
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>

<div class="resume-container">
    <div class="resume-header">
        <h1><%= fullName %></h1>
        <p><strong>Email:</strong> <%= email %> | <strong>Phone:</strong> <%= phone %> | <strong>Address:</strong> <%= address %></p>
    </div>

    <div class="resume-section">
        <h2>Education</h2>
        <div class="resume-content">
            <p><%= education %></p>
        </div>
    </div>

    <div class="resume-section">
        <h2>Experience</h2>
        <div class="resume-content">
            <p><%= experience %></p>
        </div>
    </div>

    <div class="resume-section">
        <h2>Skills</h2>
        <div class="resume-content">
            <p><%= skills %></p>
        </div>
    </div>

    <div class="resume-section">
        <h2>Certifications</h2>
        <div class="resume-content">
            <p><%= certifications %></p>
        </div>
    </div>

    <div class="resume-section">
        <h2>Projects</h2>
        <div class="resume-content">
            <p><%= projects %></p>
        </div>
    </div>

    <% if (resumeId > 0) { %>
        <div class="action-links">
            <a href="DownloadPDFServlet?resumeId=<%= resumeId %>">Download as PDF</a>
            <a href="editResume.jsp?resumeId=<%= resumeId %>">Edit Resume</a>
            <a href="dashboard.jsp">Back</a>
        </div>
    <% } %>
</div>

</body>
</html>
