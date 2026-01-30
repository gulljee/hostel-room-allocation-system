package com.hostel.dao;

import com.hostel.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AllocationDAO {


    public void approveAllocation(int allocationId) {
        try {
            Connection conn = DBConnection.getConnection();

            String getDetailsSql = "SELECT user_id, room_id FROM allocations WHERE allocation_id = ?";
            PreparedStatement pstDetails = conn.prepareStatement(getDetailsSql);
            pstDetails.setInt(1, allocationId);
            ResultSet rsDetails = pstDetails.executeQuery();

            if(rsDetails.next()) {
                int userId = rsDetails.getInt("user_id");
                int newRoomId = rsDetails.getInt("room_id");


                String findOldSql = "SELECT allocation_id, room_id FROM allocations WHERE user_id = ? AND status = 'Approved'";
                PreparedStatement pstOld = conn.prepareStatement(findOldSql);
                pstOld.setInt(1, userId);
                ResultSet rsOld = pstOld.executeQuery();

                if(rsOld.next()) {
                    int oldAllocId = rsOld.getInt("allocation_id");
                    int oldRoomId = rsOld.getInt("room_id");

                    if(oldRoomId != newRoomId) {
                        String incCapacitySql = "UPDATE rooms SET capacity = capacity + 1, status = 'Available' WHERE room_id = ?";
                        PreparedStatement pstInc = conn.prepareStatement(incCapacitySql);
                        pstInc.setInt(1, oldRoomId);
                        pstInc.executeUpdate();

                        String closeOldAllocSql = "UPDATE allocations SET status = 'Completed' WHERE allocation_id = ?";
                        PreparedStatement pstClose = conn.prepareStatement(closeOldAllocSql);
                        pstClose.setInt(1, oldAllocId);
                        pstClose.executeUpdate();
                    }
                }


                String updateAllocSql = "UPDATE allocations SET status = 'Approved' WHERE allocation_id = ?";
                PreparedStatement pst2 = conn.prepareStatement(updateAllocSql);
                pst2.setInt(1, allocationId);
                pst2.executeUpdate();

                String updateRoomSql = "UPDATE rooms SET capacity = capacity - 1 WHERE room_id = ?";
                PreparedStatement pst3 = conn.prepareStatement(updateRoomSql);
                pst3.setInt(1, newRoomId);
                pst3.executeUpdate();

                String checkFullSql = "UPDATE rooms SET status = 'Full' WHERE room_id = ? AND capacity <= 0";
                PreparedStatement pst4 = conn.prepareStatement(checkFullSql);
                pst4.setInt(1, newRoomId);
                pst4.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public boolean hasPendingRequest(int userId) {
        boolean hasPending = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM allocations WHERE user_id = ? AND status = 'Pending'";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, userId);
            ResultSet rs = pst.executeQuery();
            if(rs.next()) hasPending = true;
        } catch (Exception e) { e.printStackTrace(); }
        return hasPending;
    }

    public boolean bookRoom(int userId, int roomId) {
        boolean isSuccess = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO allocations (user_id, room_id, status) VALUES (?, ?, 'Pending')";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, userId);
            pst.setInt(2, roomId);
            if(pst.executeUpdate() > 0) isSuccess = true;
        } catch (Exception e) { e.printStackTrace(); }
        return isSuccess;
    }

    public java.util.List<com.hostel.model.Allocation> getAllAllocations() {
        java.util.List<com.hostel.model.Allocation> list = new java.util.ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT a.allocation_id, a.status, a.application_date, u.full_name, r.room_number " +
                    "FROM allocations a JOIN users u ON a.user_id = u.user_id " +
                    "JOIN rooms r ON a.room_id = r.room_id " +
                    "ORDER BY CASE WHEN a.status = 'Pending' THEN 1 ELSE 2 END, a.application_date DESC";
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            while(rs.next()) {
                com.hostel.model.Allocation alloc = new com.hostel.model.Allocation();
                alloc.setId(rs.getInt("allocation_id"));
                alloc.setStatus(rs.getString("status"));
                alloc.setStudentName(rs.getString("full_name"));
                alloc.setRoomNumber(rs.getString("room_number"));
                list.add(alloc);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public void updateStatus(int allocationId, String newStatus) {
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE allocations SET status = ? WHERE allocation_id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, newStatus);
            pst.setInt(2, allocationId);
            pst.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void rejectAllocation(int allocationId) {
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE allocations SET status = 'Rejected' WHERE allocation_id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, allocationId);
            pst.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public boolean isAlreadyInRoom(int userId, int roomId) {
        boolean isInSameRoom = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM allocations WHERE user_id = ? AND room_id = ? AND status = 'Approved'";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, userId);
            pst.setInt(2, roomId);
            ResultSet rs = pst.executeQuery();
            if(rs.next()) isInSameRoom = true;
        } catch (Exception e) { e.printStackTrace(); }
        return isInSameRoom;
    }

    public com.hostel.model.Allocation getAllocationByUserId(int userId) {
        com.hostel.model.Allocation alloc = null;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT a.status, r.room_number, u.full_name FROM allocations a " +
                    "JOIN rooms r ON a.room_id = r.room_id JOIN users u ON a.user_id = u.user_id " +
                    "WHERE a.user_id = ? ORDER BY a.allocation_id DESC LIMIT 1";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, userId);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                alloc = new com.hostel.model.Allocation();
                alloc.setStatus(rs.getString("status"));
                alloc.setRoomNumber(rs.getString("room_number"));
                alloc.setStudentName(rs.getString("full_name"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return alloc;
    }

    public java.util.List<com.hostel.model.User> getStudentsByRoom(int roomId) {
        java.util.List<com.hostel.model.User> students = new java.util.ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT u.* FROM users u " +
                    "JOIN allocations a ON u.user_id = a.user_id " +
                    "WHERE a.room_id = ? AND a.status = 'Approved' " +
                    "ORDER BY u.full_name";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, roomId);
            ResultSet rs = pst.executeQuery();
            
            while (rs.next()) {
                com.hostel.model.User student = new com.hostel.model.User();
                student.setId(rs.getInt("user_id"));
                student.setFullName(rs.getString("full_name"));
                student.setEmail(rs.getString("email"));
                student.setUsername(rs.getString("username"));
                student.setPhoneNumber(rs.getString("phone_number"));
                student.setDepartment(rs.getString("department"));
                student.setSemester(rs.getString("semester"));
                student.setCity(rs.getString("city"));
                student.setStudentRemarks(rs.getString("student_remarks"));
                students.add(student);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return students;
    }
}