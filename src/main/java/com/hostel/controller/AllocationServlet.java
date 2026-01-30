package com.hostel.controller;

import com.hostel.dao.AllocationDAO;
import com.hostel.model.Allocation;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/view-applications")
public class AllocationServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AllocationDAO dao = new AllocationDAO();
        List<Allocation> list = dao.getAllAllocations();

        request.setAttribute("applicationList", list);
        RequestDispatcher dispatcher = request.getRequestDispatcher("view_applications.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String action = request.getParameter("action");

        AllocationDAO dao = new AllocationDAO();

        if ("approve".equals(action)) {
            dao.approveAllocation(id);
        } else if ("reject".equals(action)) {
            dao.rejectAllocation(id);
        }

        response.sendRedirect("view-applications");
    }
}