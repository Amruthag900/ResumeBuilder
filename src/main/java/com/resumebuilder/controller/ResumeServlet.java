package com.resumebuilder.controller;

import com.resumebuilder.util.DatabaseConnection;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ResumeServlet extends HttpServlet {
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
       {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String education = request.getParameter("education");
        String experience = request.getParameter("experience");
        String skills = request.getParameter("skills");
        String certifications = request.getParameter("certifications");
        String projects = request.getParameter("projects");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO resumes (user_id, full_name, email, phone, address, education, experience, skills, certifications, projects) VALUES ((SELECT id FROM users WHERE username = ?), ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, fullName);
            stmt.setString(3, email);
            stmt.setString(4, phone);
            stmt.setString(5, address);
            stmt.setString(6, education);
            stmt.setString(7, experience);
            stmt.setString(8, skills);
            stmt.setString(9, certifications);
            stmt.setString(10, projects);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("viewResume.jsp");
            } else {
                response.sendRedirect("resumeForm.jsp?error=Resume+creation+failed");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("resumeForm.jsp?error=Database+error");
        }
    }
}
