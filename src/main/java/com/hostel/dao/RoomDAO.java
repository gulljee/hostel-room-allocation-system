package com.hostel.dao;

import com.hostel.model.Room;
import com.hostel.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {

    public boolean addRoom(Room room) {
        boolean isSuccess = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO rooms (room_number, capacity, status) VALUES (?, ?, ?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, room.getRoomNumber());
            pst.setInt(2, room.getCapacity());
            pst.setString(3, "Available");

            int rowCount = pst.executeUpdate();
            if (rowCount > 0) {
                isSuccess = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    public List<Room> getAllRooms() {
        List<Room> list = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM rooms ORDER BY room_id ASC";
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Room r = new Room();
                r.setId(rs.getInt("room_id"));
                r.setRoomNumber(rs.getString("room_number"));
                r.setCapacity(rs.getInt("capacity"));
                r.setStatus(rs.getString("status"));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void deleteRoom(int id) {
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "DELETE FROM rooms WHERE room_id=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Room getRoomById(int roomId) {
        Room room = null;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM rooms WHERE room_id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, roomId);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                room = new Room();
                room.setId(rs.getInt("room_id"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setCapacity(rs.getInt("capacity"));
                room.setStatus(rs.getString("status"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return room;
    }
}