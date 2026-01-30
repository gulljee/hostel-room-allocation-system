package com.hostel.dao;

import com.hostel.model.User;
import com.hostel.util.DBConnection;
import java.sql.*;

public class UserDAO {

    public User authenticateUser(String usernameOrEmail, String password) {
        User user = null;
        try {
            Connection conn = DBConnection.getConnection();
            // Allow login with either username OR email
            String sql = "SELECT * FROM users WHERE (username = ? OR email = ?) AND password = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, usernameOrEmail);
            pst.setString(2, usernameOrEmail);
            pst.setString(3, password);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setUsername(rs.getString("username"));
                user.setRole(rs.getString("role"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNumber(rs.getString("phone_number"));
                user.setDepartment(rs.getString("department"));
                user.setSemester(rs.getString("semester"));
                user.setCity(rs.getString("city"));
                user.setStudentRemarks(rs.getString("student_remarks"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public static void main(String[] args) {
        UserDAO dao = new UserDAO();

        User user = dao.authenticateUser("admin", "admin123");

        if (user != null) {
            System.out.println("✅ Login Successful!");
            System.out.println("Welcome, " + user.getFullName());
            System.out.println("Role: " + user.getRole());
        } else {
            System.out.println("❌ Login Failed! Username/Password ghalat hai.");
        }
    }
    
    // Check if username already exists
    public boolean isUsernameExists(String username) {
        boolean exists = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, username);
            
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return exists;
    }
    
    // Check if email already exists
    public boolean isEmailExists(String email) {
        boolean exists = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, email);
            
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return exists;
    }
    
    public boolean registerUser(User user) {
        boolean isSuccess = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO users (full_name, username, password, role, email, phone_number) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = conn.prepareStatement(sql);

            pst.setString(1, user.getFullName());
            pst.setString(2, user.getUsername());
            pst.setString(3, user.getPassword());
            pst.setString(4, "STUDENT");
            pst.setString(5, user.getEmail());
            pst.setString(6, user.getPhoneNumber());

            int rowCount = pst.executeUpdate();
            if (rowCount > 0) {
                isSuccess = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    public User getUserById(int userId) {
        User user = null;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM users WHERE user_id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, userId);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNumber(rs.getString("phone_number"));
                user.setDepartment(rs.getString("department"));
                user.setSemester(rs.getString("semester"));
                user.setCity(rs.getString("city"));
                user.setStudentRemarks(rs.getString("student_remarks"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean updateUserProfile(User user) {
        boolean isSuccess = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE users SET full_name = ?, username = ?, password = ?, phone_number = ?, department = ?, semester = ?, city = ? WHERE user_id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);

            pst.setString(1, user.getFullName());
            pst.setString(2, user.getUsername());
            pst.setString(3, user.getPassword());
            pst.setString(4, user.getPhoneNumber());
            pst.setString(5, user.getDepartment());
            pst.setString(6, user.getSemester());
            pst.setString(7, user.getCity());
            pst.setInt(8, user.getId());

            int rowCount = pst.executeUpdate();
            if (rowCount > 0) {
                isSuccess = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess;
    }
}