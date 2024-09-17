package com.resumebuilder.controller;

import com.resumebuilder.util.DatabaseConnection;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class EditResumeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int resumeId = Integer.parseInt(request.getParameter("resumeId"));

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
            String sql = "UPDATE resumes SET full_name = ?, email = ?, phone = ?, address = ?, education = ?, experience = ?, skills = ?, certifications = ?, projects = ? WHERE resume_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, fullName);
            stmt.setString(2, email);
            stmt.setString(3, phone);
            stmt.setString(4, address);
            stmt.setString(5, education);
            stmt.setString(6, experience);
            stmt.setString(7, skills);
            stmt.setString(8, certifications);
            stmt.setString(9, projects);
            stmt.setInt(10, resumeId);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("viewResume.jsp");
            } else {
                response.sendRedirect("editResume.jsp?error=Resume+update+failed");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("editResume.jsp?error=Database+error");
        }
    }
}
