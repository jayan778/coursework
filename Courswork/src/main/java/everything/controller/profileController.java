package everything.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.*;

import com.college.config.DbConfig;
import util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/profile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class profileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String IMAGE_UPLOAD_DIR = "uploads";

    public profileController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check session for userId
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp"); // Adjust path as needed
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        try (Connection dbConn = DbConfig.getDbConnection()) {
            if (dbConn == null) {
                request.setAttribute("error", "Unable to connect to database.");
                request.getRequestDispatcher("/WEB-INF/Pages/profile.jsp").forward(request, response);
                return;
            }

            String selectQuery = "SELECT * FROM student WHERE student_id = ?";
            try (PreparedStatement selectStmt = dbConn.prepareStatement(selectQuery)) {
                selectStmt.setInt(1, userId);
                ResultSet rs = selectStmt.executeQuery();

                if (rs.next()) {
                    request.setAttribute("firstName", rs.getString("first_name"));
                    request.setAttribute("lastName", rs.getString("last_name"));
                    request.setAttribute("username", rs.getString("username"));
                    request.setAttribute("dob", rs.getDate("dob"));
                    request.setAttribute("gender", rs.getString("gender"));
                    request.setAttribute("email", rs.getString("email"));
                    request.setAttribute("phoneNumber", rs.getString("number"));
                    request.setAttribute("imagePath", rs.getString("image_path"));
                } else {
                    request.setAttribute("error", "User not found.");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error retrieving user data.");
        }

        request.getRequestDispatcher("/WEB-INF/Pages/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Check session for userId
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp"); // Adjust path as needed
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("username");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String password = request.getParameter("password");

        // Handle file upload
        Part imagePart = request.getPart("image");
        String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("") + File.separator + IMAGE_UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String imagePath = "";
        if (fileName != null && !fileName.isEmpty()) {
            imagePath = IMAGE_UPLOAD_DIR + File.separator + fileName;
            imagePart.write(uploadPath + File.separator + fileName);
        }

        // Retrieve current password and image path if not provided
        String currentPassword = null;
        String currentImagePath = null;
        try (Connection dbConn = DbConfig.getDbConnection()) {
            String fetchQuery = "SELECT password, image_path FROM student WHERE student_id = ?";
            try (PreparedStatement fetchStmt = dbConn.prepareStatement(fetchQuery)) {
                fetchStmt.setInt(1, userId);
                ResultSet rs = fetchStmt.executeQuery();
                if (rs.next()) {
                    currentPassword = rs.getString("password");
                    currentImagePath = rs.getString("image_path");
                } else {
                    request.setAttribute("error", "User not found.");
                    request.getRequestDispatcher("/WEB-INF/Pages/profile.jsp").forward(request, response);
                    return;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error retrieving user data.");
            request.getRequestDispatcher("/WEB-INF/Pages/profile.jsp").forward(request, response);
            return;
        }

        // Encrypt password if provided, otherwise keep old one
        if (password != null && !password.trim().isEmpty()) {
            password = PasswordUtil.encrypt(username, password);
        } else {
            password = currentPassword;
        }

        // Use existing image if a new one was not uploaded
        if (imagePath == null || imagePath.isEmpty()) {
            imagePath = currentImagePath;
        }

        try (Connection dbConn = DbConfig.getDbConnection()) {
            if (dbConn == null) {
                request.setAttribute("error", "Unable to connect to database.");
                request.getRequestDispatcher("/WEB-INF/Pages/profile.jsp").forward(request, response);
                return;
            }

            String updateQuery = """
                UPDATE student
                SET first_name=?, last_name=?, username=?, dob=?, gender=?, 
                    email=?, number=?, password=?, image_path=? 
                WHERE student_id=?
            """;

            try (PreparedStatement updateStmt = dbConn.prepareStatement(updateQuery)) {
                updateStmt.setString(1, firstName);
                updateStmt.setString(2, lastName);
                updateStmt.setString(3, username);
                updateStmt.setString(4, dob);
                updateStmt.setString(5, gender);
                updateStmt.setString(6, email);
                updateStmt.setString(7, phoneNumber);
                updateStmt.setString(8, password);
                updateStmt.setString(9, imagePath);
                updateStmt.setInt(10, userId);

                int rowsAffected = updateStmt.executeUpdate();
                if (rowsAffected > 0) {
                    request.setAttribute("message", "Profile updated successfully.");
                } else {
                    request.setAttribute("error", "Failed to update profile.");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error updating user data.");
        }

        // Reload profile after update
        doGet(request, response);
    }

}
