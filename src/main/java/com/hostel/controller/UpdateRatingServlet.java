package com.hostel.controller;

import com.hostel.dao.RatingDAO;
import com.hostel.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/update-rating")
public class UpdateRatingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        // Check if user is logged in
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String ratedStudentIdParam = request.getParameter("ratedStudentId");
        String ratingParam = request.getParameter("rating");
        String roomIdParam = request.getParameter("roomId");

        if (ratedStudentIdParam != null && ratingParam != null) {
            try {
                int ratedStudentId = Integer.parseInt(ratedStudentIdParam);
                int rating = Integer.parseInt(ratingParam);
                int raterStudentId = currentUser.getId();

                // Validate rating is between 1-5
                if (rating < 1 || rating > 5) {
                    response.sendRedirect("room-details?roomId=" + roomIdParam + "&error=invalid_rating");
                    return;
                }

                // Prevent self-rating
                if (ratedStudentId == raterStudentId) {
                    response.sendRedirect("room-details?roomId=" + roomIdParam + "&error=self_rating");
                    return;
                }

                // Save rating
                RatingDAO ratingDAO = new RatingDAO();
                boolean success = ratingDAO.saveRating(ratedStudentId, raterStudentId, rating);

                if (success) {
                    // Update average rating cache
                    ratingDAO.updateAverageCache(ratedStudentId);
                    
                    if (roomIdParam != null) {
                        response.sendRedirect("room-details?roomId=" + roomIdParam + "&msg=rating_success");
                    } else {
                        response.sendRedirect("dashboard.jsp");
                    }
                } else {
                    if (roomIdParam != null) {
                        response.sendRedirect("room-details?roomId=" + roomIdParam + "&error=rating_failed");
                    } else {
                        response.sendRedirect("dashboard.jsp");
                    }
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("room-details?roomId=" + roomIdParam + "&error=invalid_input");
            }
        } else {
            response.sendRedirect("dashboard.jsp");
        }
    }
}
