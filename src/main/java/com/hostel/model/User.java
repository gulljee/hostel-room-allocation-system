package com.hostel.model;

public class User {
    private int id;
    private String fullName;
    private String username;
    private String password;
    private String role;
    private String email;
    private String phoneNumber;
    private String department;
    private String semester;
    private String city;
    private String studentRemarks;

    public User() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    public String getSemester() { return semester; }
    public void setSemester(String semester) { this.semester = semester; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getStudentRemarks() { return studentRemarks; }
    public void setStudentRemarks(String studentRemarks) { this.studentRemarks = studentRemarks; }
}