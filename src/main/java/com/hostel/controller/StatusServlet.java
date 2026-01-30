package com.hostel.controller;

import com.hostel.dao.AllocationDAO;
import com.hostel.model.Allocation;
import com.hostel.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/my-status")
public class StatusServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        AllocationDAO dao = new AllocationDAO();
        Allocation myAlloc = dao.getAllocationByUserId(user.getId());

        request.setAttribute("myAllocation", myAlloc);
        request.getRequestDispatcher("my_status.jsp").forward(request, response);
    }
}