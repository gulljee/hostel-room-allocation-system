<%@ page import="com.hostel.model.User" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <% User user=(User) session.getAttribute("currentUser"); if(user==null) { response.sendRedirect("login.jsp");
            return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <title>Roomeo - Dashboard</title>
                <script src="https://cdn.tailwindcss.com"></script>
            </head>

            <body class="bg-gradient-to-br from-slate-50 to-gray-100 text-slate-800 font-sans min-h-screen">

                <nav
                    class="border-b border-gray-200 px-8 py-4 flex justify-between items-center bg-white/80 backdrop-blur-sm sticky top-0 z-10 shadow-sm">
                    <div class="flex items-center gap-3">
                        <span class="text-2xl font-bold text-slate-900 tracking-tight">Roomeo.</span>
                        <span
                            class="bg-slate-100 text-slate-700 text-xs px-2.5 py-1 rounded-md font-semibold uppercase">
                            <%= user.getRole() %>
                        </span>
                    </div>
                    <div class="flex items-center gap-4">
                        <span class="text-sm text-gray-600">Welcome, <b>
                                <%= user.getFullName() %>
                            </b></span>
                        <a href="logout"
                            class="text-sm text-red-600 hover:text-red-700 font-medium border border-red-200 px-4 py-2 rounded-lg hover:bg-red-50 transition">Logout</a>
                    </div>
                </nav>

                <div class="max-w-5xl mx-auto p-8 mt-6">
                    <h1 class="text-3xl font-bold text-slate-900 mb-2">Dashboard</h1>
                    <p class="text-gray-500 mb-10">Manage your hostel activities efficiently.</p>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                        <%-- ADMIN PANEL --%>
                            <% if(user.getRole().equalsIgnoreCase("ADMIN")) { %>
                                <a href="manage-rooms"
                                    class="group block p-8 bg-white border border-gray-200 rounded-xl hover:border-slate-300 hover:shadow-xl transition duration-300">
                                    <div
                                        class="h-12 w-12 bg-slate-100 rounded-lg flex items-center justify-center mb-4 group-hover:bg-slate-900 transition">
                                        <svg class="w-6 h-6 text-slate-600 group-hover:text-white transition"
                                            fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
                                        </svg>
                                    </div>
                                    <h3 class="text-xl font-bold text-slate-900 mb-2">Manage Rooms</h3>
                                    <p class="text-gray-500 text-sm">Add new rooms, update capacity, and monitor
                                        occupancy.</p>
                                </a>

                                <a href="view-applications"
                                    class="group block p-8 bg-white border border-gray-200 rounded-xl hover:border-slate-300 hover:shadow-xl transition duration-300">
                                    <div
                                        class="h-12 w-12 bg-slate-100 rounded-lg flex items-center justify-center mb-4 group-hover:bg-slate-900 transition">
                                        <svg class="w-6 h-6 text-slate-600 group-hover:text-white transition"
                                            fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                        </svg>
                                    </div>
                                    <h3 class="text-xl font-bold text-slate-900 mb-2">View Applications</h3>
                                    <p class="text-gray-500 text-sm">Review student requests and approve or reject
                                        allocations.</p>
                                </a>
                                <% } %>

                                    <%-- STUDENT PANEL --%>
                                        <% if(user.getRole().equals("STUDENT")) { %>
                                            <a href="book-room"
                                                class="group block p-8 bg-white border border-gray-200 rounded-xl hover:border-emerald-300 hover:shadow-xl transition duration-300">
                                                <div
                                                    class="h-12 w-12 bg-emerald-50 rounded-lg flex items-center justify-center mb-4 group-hover:bg-emerald-600 transition">
                                                    <svg class="w-6 h-6 text-emerald-600 group-hover:text-white transition"
                                                        fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round"
                                                            stroke-width="2"
                                                            d="M8 14v3m4-3v3m4-3v3M3 21h18M3 10h18M3 7l9-4 9 4M4 10h16v11H4V10z" />
                                                    </svg>
                                                </div>
                                                <h3 class="text-xl font-bold text-slate-900 mb-2">Book a Room</h3>
                                                <p class="text-gray-500 text-sm">Browse available rooms and submit your
                                                    booking request.</p>
                                            </a>

                                            <a href="my-status"
                                                class="group block p-8 bg-white border border-gray-200 rounded-xl hover:border-emerald-300 hover:shadow-xl transition duration-300">
                                                <div
                                                    class="h-12 w-12 bg-emerald-50 rounded-lg flex items-center justify-center mb-4 group-hover:bg-emerald-600 transition">
                                                    <svg class="w-6 h-6 text-emerald-600 group-hover:text-white transition"
                                                        fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round"
                                                            stroke-width="2"
                                                            d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4" />
                                                    </svg>
                                                </div>
                                                <h3 class="text-xl font-bold text-slate-900 mb-2">My Status</h3>
                                                <p class="text-gray-500 text-sm">Check the status of your current room
                                                    application.</p>
                                            </a>

                                            <a href="profile"
                                                class="group block p-8 bg-white border border-gray-200 rounded-xl hover:border-emerald-300 hover:shadow-xl transition duration-300">
                                                <div
                                                    class="h-12 w-12 bg-emerald-50 rounded-lg flex items-center justify-center mb-4 group-hover:bg-emerald-600 transition">
                                                    <svg class="w-6 h-6 text-emerald-600 group-hover:text-white transition"
                                                        fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round"
                                                            stroke-width="2"
                                                            d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                                                    </svg>
                                                </div>
                                                <h3 class="text-xl font-bold text-slate-900 mb-2">My Profile</h3>
                                                <p class="text-gray-500 text-sm">View and update your personal
                                                    information.</p>
                                            </a>
                                            <% } %>

                    </div>
                </div>

            </body>

            </html>