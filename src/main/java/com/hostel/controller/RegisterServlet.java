package com.hostel.controller;

import com.hostel.dao.UserDAO;
import com.hostel.model.User;
// Agar Tomcat 10 hai to 'jakarta', agar 9 hai to 'javax'
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String pass = request.getParameter("password");
        String phoneNumber = request.getParameter("phoneNumber");

        User newUser = new User();
        newUser.setFullName(fullName);
        newUser.setEmail(email);
        newUser.setUsername(username);
        newUser.setPassword(pass);
        newUser.setPhoneNumber(phoneNumber);

        UserDAO dao = new UserDAO();
        
        // Check if username already exists
        if (dao.isUsernameExists(username)) {
            response.sendRedirect("register.jsp?error=username_exists");
            return;
        }
        
        // Check if email already exists
        if (dao.isEmailExists(email)) {
            response.sendRedirect("register.jsp?error=email_exists");
            return;
        }
        
        boolean success = dao.registerUser(newUser);

        if (success) {
            response.sendRedirect("login.jsp?msg=registered");
        } else {
            response.sendRedirect("register.jsp?error=failed");
        }
    }
}