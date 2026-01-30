package com.hostel.controller;

import com.hostel.dao.AllocationDAO;
import com.hostel.dao.RoomDAO;
import com.hostel.model.Room;
import com.hostel.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/room-details")
public class RoomDetailsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String roomIdParam = request.getParameter("roomId");
        
        if (roomIdParam == null || roomIdParam.isEmpty()) {
            response.sendRedirect("manage-rooms");
            return;
        }

        try {
            int roomId = Integer.parseInt(roomIdParam);
            
            // Get room details
            RoomDAO roomDAO = new RoomDAO();
            Room room = roomDAO.getRoomById(roomId);
            
            // Get students in this room
            AllocationDAO allocationDAO = new AllocationDAO();
            List<User> students = allocationDAO.getStudentsByRoom(roomId);
            
            request.setAttribute("room", room);
            request.setAttribute("students", students);
            request.getRequestDispatcher("room_details.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect("manage-rooms");
        }
    }
}
