package com.hostel.controller;

import com.hostel.dao.AllocationDAO;
import com.hostel.dao.RoomDAO;
import com.hostel.model.Room;
import com.hostel.model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/book-room")
public class BookingServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RoomDAO dao = new RoomDAO();
        List<Room> roomList = dao.getAllRooms();

        request.setAttribute("rooms", roomList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("book_room.jsp");
        dispatcher.forward(request, response);
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");

        if(user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int roomId = Integer.parseInt(request.getParameter("roomId"));
        int userId = user.getId();

        AllocationDAO dao = new AllocationDAO();

        if(dao.isAlreadyInRoom(userId, roomId)) {
            response.sendRedirect("book-room?msg=same_room_error");
        }
        else if(dao.hasPendingRequest(userId)) {
            response.sendRedirect("book-room?msg=already_pending");
        }
        else {
            boolean success = dao.bookRoom(userId, roomId);
            if(success) {
                response.sendRedirect("dashboard.jsp?msg=booking_success");
            } else {
                response.sendRedirect("book-room?msg=error");
            }
        }
    }
}