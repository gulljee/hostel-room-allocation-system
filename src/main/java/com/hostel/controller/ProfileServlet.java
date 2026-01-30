package com.hostel.controller;

import com.hostel.dao.UserDAO;
import com.hostel.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("currentUser");
        UserDAO dao = new UserDAO();
        User fullUserData = dao.getUserById(currentUser.getId());

        request.setAttribute("user", fullUserData);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("currentUser");

        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phoneNumber");
        String department = request.getParameter("department");
        String semester = request.getParameter("semester");
        String city = request.getParameter("city");

        User updatedUser = new User();
        updatedUser.setId(currentUser.getId());
        updatedUser.setFullName(fullName);
        updatedUser.setUsername(username);
        updatedUser.setPassword(password);
        updatedUser.setPhoneNumber(phoneNumber);
        updatedUser.setDepartment(department);
        updatedUser.setSemester(semester);
        updatedUser.setCity(city);

        UserDAO dao = new UserDAO();
        boolean success = dao.updateUserProfile(updatedUser);

        if (success) {
            // Update session with new data
            User refreshedUser = dao.getUserById(currentUser.getId());
            session.setAttribute("currentUser", refreshedUser);
            response.sendRedirect("profile?msg=success");
        } else {
            response.sendRedirect("profile?error=failed");
        }
    }
}
