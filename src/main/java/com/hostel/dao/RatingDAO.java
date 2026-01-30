package com.hostel.dao;

import com.hostel.util.DBConnection;
import java.sql.*;

public class RatingDAO {

    /**
     * Save or update a rating
     * Uses ON CONFLICT to update if rating already exists
     */
    public boolean saveRating(int ratedStudentId, int raterStudentId, int rating) {
        boolean isSuccess = false;
        try {
            Connection conn = DBConnection.getConnection();
            
            // PostgreSQL syntax for INSERT ... ON CONFLICT UPDATE
            String sql = "INSERT INTO student_ratings (rated_student_id, rater_student_id, rating) " +
                        "VALUES (?, ?, ?) " +
                        "ON CONFLICT (rated_student_id, rater_student_id) " +
                        "DO UPDATE SET rating = EXCLUDED.rating";
            
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, ratedStudentId);
            pst.setInt(2, raterStudentId);
            pst.setInt(3, rating);

            int rowCount = pst.executeUpdate();
            if (rowCount > 0) {
                isSuccess = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    /**
     * Get rating given by specific rater to specific student
     * Returns null if no rating exists
     */
    public Integer getRatingByRater(int ratedStudentId, int raterStudentId) {
        Integer rating = null;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT rating FROM student_ratings " +
                        "WHERE rated_student_id = ? AND rater_student_id = ?";
            
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, ratedStudentId);
            pst.setInt(2, raterStudentId);

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                rating = rs.getInt("rating");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rating;
    }

    /**
     * Get average rating for a student
     * Returns 0.0 if no ratings exist
     */
    public double getAverageRating(int studentId) {
        double average = 0.0;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT AVG(rating) as avg_rating FROM student_ratings " +
                        "WHERE rated_student_id = ?";
            
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, studentId);

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                average = rs.getDouble("avg_rating");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return average;
    }

    /**
     * Get total number of ratings received by a student
     */
    public int getRatingCount(int studentId) {
        int count = 0;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT COUNT(*) as rating_count FROM student_ratings " +
                        "WHERE rated_student_id = ?";
            
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, studentId);

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                count = rs.getInt("rating_count");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    /**
     * Update average rating cache in users table
     */
    public boolean updateAverageCache(int studentId) {
        boolean isSuccess = false;
        try {
            double avgRating = getAverageRating(studentId);
            
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE users SET average_rating = ? WHERE user_id = ?";
            
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setDouble(1, avgRating);
            pst.setInt(2, studentId);

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
