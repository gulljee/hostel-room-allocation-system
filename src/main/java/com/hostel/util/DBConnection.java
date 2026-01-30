package com.hostel.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static Connection connection = null;

    public static Connection getConnection() {
        if (connection != null) {
            return connection;
        } else {
            try {
                Class.forName("org.postgresql.Driver");
                // Database aur user details
                String url = "jdbc:postgresql://localhost:5432/hostel_db";
                String user = "postgres";
                String password = "myPostgres";

                connection = DriverManager.getConnection(url, user, password);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return connection;
        }
    }

    public static void main(String[] args) {
        if(getConnection() != null) {
            System.out.println("Connection Success!");
        } else {
            System.out.println("Connection Failed!");
        }
    }

}