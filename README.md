# 🏨 Hostel Room Allocation System

A web-based **Hostel Room Allocation System** built using **Java (JSP/Servlet)** and **PostgreSQL**. This application streamlines the process of booking rooms for students and allows administrators to manage room allocations efficiently.

## 🚀 Features

### 👤 User (Student)
- **User Registration & Login:** Secure account creation and authentication.
- **Room Booking:** View available rooms and submit booking requests.
- **Application Status:** Track the status of room allocation requests (Pending/Approved/Rejected).
- **Dashboard:** Personalized dashboard to view profile and booking details.

### 🛠 Administrator
- **Manage Rooms:** Add, update, or delete hostel rooms.
- **View Applications:** See all booking requests submitted by students.
- **Allocate Rooms:** Approve or reject room requests based on availability.
- **System Monitoring:** Overview of total rooms and occupancy.

## 💻 Tech Stack

- **Backend:** Java 21, Jakarta Servlets, JSP (JavaServer Pages)
- **Database:** PostgreSQL (v42.7.2)
- **Build Tool:** Apache Maven
- **Server:** Apache Tomcat 10.1+ (Required for Jakarta EE 10 support)
- **Frontend:** HTML, CSS, Bootstrap (presumed), JSP Standard Tag Library (JSTL)

## ⚙️ Prerequisites

Before running the project, ensure you have the following installed:
1.  **Java Development Kit (JDK) 21**
2.  **Apache Maven**
3.  **PostgreSQL Database**
4.  **Apache Tomcat 10.1** (or any Jakarta EE 10 compatible server)
5.  **IntelliJ IDEA / Eclipse** (Optional, for development)

## 🗄️ Database Setup

1.  Open your PostgreSQL tool (pgAdmin or psql).
2.  Create a database named `hostel_db`.
3.  Execute the following SQL script to create the necessary tables (Modify columns based on your specific model logic if needed):

```sql
-- Create Database
CREATE DATABASE hostel_db;

-- Connect to hostel_db
\c hostel_db;

-- Users Table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL, -- 'ADMIN' or 'STUDENT'
    email VARCHAR(100)
);

-- Rooms Table
CREATE TABLE rooms (
    id SERIAL PRIMARY KEY,
    room_number VARCHAR(20) UNIQUE NOT NULL,
    capacity INT NOT NULL,
    status VARCHAR(20) DEFAULT 'Available'
);

-- Allocations/Bookings Table
CREATE TABLE allocations (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    room_id INT REFERENCES rooms(id),
    status VARCHAR(20) DEFAULT 'Pending',
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);