package com.resumebuilder.controller;

import com.lowagie.text.DocumentException;
import com.resumebuilder.util.DatabaseConnection;
import org.xhtmlrenderer.pdf.ITextRenderer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.*;

public class DownloadPDFServlet extends HttpServlet {
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int resumeId = Integer.parseInt(request.getParameter("resumeId"));

        String fullName = "", email = "", phone = "", address = "", education = "", experience = "", skills = "", certifications = "", projects = "";

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM resumes WHERE resume_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, resumeId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                fullName = rs.getString("full_name");
                email = rs.getString("email");
                phone = rs.getString("phone");
                address = rs.getString("address");
                education = rs.getString("education");
                experience = rs.getString("experience");
                skills = rs.getString("skills");
                certifications = rs.getString("certifications");
                projects = rs.getString("projects");
            }

            // Prepare the HTML content for PDF
            StringBuilder htmlContent = new StringBuilder();
            htmlContent.append("<html><head><style>")
                    .append("body { font-family: 'Times New Roman'; margin: 40px; }")
                    .append(".resume-header { text-align: center; margin-bottom: 20px; }")
                    .append("h1, h2 { font-weight: bold; }")
                    .append("</style></head><body>");
            htmlContent.append("<div class='resume-header'><h1>").append(fullName).append("</h1></div>");
            htmlContent.append("<p><b>Email:</b> ").append(email).append("</p>");
            htmlContent.append("<p><b>Phone:</b> ").append(phone).append("</p>");
            htmlContent.append("<p><b>Address:</b> ").append(address).append("</p>");
            htmlContent.append("<h2>Education</h2><p>").append(education).append("</p>");
            htmlContent.append("<h2>Experience</h2><p>").append(experience).append("</p>");
            htmlContent.append("<h2>Skills</h2><p>").append(skills).append("</p>");
            htmlContent.append("<h2>Certifications</h2><p>").append(certifications).append("</p>");
            htmlContent.append("<h2>Projects</h2><p>").append(projects).append("</p>");
            htmlContent.append("</body></html>");

            // Generate PDF using Flying Saucer (ITextRenderer)
            ITextRenderer renderer = new ITextRenderer();
            renderer.setDocumentFromString(htmlContent.toString());
            renderer.layout();

            // Set the response headers for PDF
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=" + fullName + "_resume.pdf");

            // Write PDF to output stream
            OutputStream os = response.getOutputStream();
            try {
				renderer.createPDF(os);
			} catch (DocumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            os.close();
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("viewResume.jsp?error=Database+error");
        }
    }
}
