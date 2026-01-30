package com.hostel.controller;

import com.hostel.dao.RoomDAO;
import com.hostel.model.Room;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.util.List;

@WebServlet("/manage-rooms")
public class RoomServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RoomDAO dao = new RoomDAO();
        List<Room> rooms = dao.getAllRooms();

        request.setAttribute("roomList", rooms);

        RequestDispatcher dispatcher = request.getRequestDispatcher("manage_rooms.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String roomNumber = request.getParameter("roomNumber");
        int capacity = Integer.parseInt(request.getParameter("capacity"));

        Room newRoom = new Room();
        newRoom.setRoomNumber(roomNumber);
        newRoom.setCapacity(capacity);

        RoomDAO dao = new RoomDAO();
        boolean success = dao.addRoom(newRoom);

        response.sendRedirect("manage-rooms");
    }
}