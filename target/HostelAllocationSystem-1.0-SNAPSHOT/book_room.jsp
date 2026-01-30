<%@ page import="java.util.List" %>
    <%@ page import="com.hostel.model.Room" %>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <title>Roomeo - Book Room</title>
                <script src="https://cdn.tailwindcss.com"></script>
            </head>

            <body class="bg-gradient-to-br from-slate-50 to-gray-100 text-slate-800 font-sans p-8 min-h-screen">

                <div class="max-w-6xl mx-auto">
                    <div class="flex justify-between items-end mb-10 pb-6">
                        <div>
                            <h2 class="text-3xl font-bold text-slate-900 tracking-tight">Select Your Room</h2>
                            <p class="text-gray-500 mt-1.5">Available spaces in Roomeo</p>
                        </div>
                        <a href="dashboard.jsp"
                            class="flex items-center gap-2 text-sm font-medium text-slate-600 hover:text-slate-900 border border-gray-300 px-5 py-2.5 rounded-lg hover:bg-white transition hover:shadow-md">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                            </svg>
                            Back to Dashboard
                        </a>
                    </div>

                    <%-- Alerts --%>
                        <% if("same_room_error".equals(request.getParameter("msg"))) { %>
                            <script>alert("Error: You are already in this room!");</script>
                            <% } %>

                                <% if("already_pending".equals(request.getParameter("msg"))) { %>
                                    <div
                                        class="mb-8 bg-amber-50 border border-amber-200 text-amber-800 px-5 py-4 rounded-xl flex items-start gap-3">
                                        <svg class="w-5 h-5 text-amber-600 mt-0.5 flex-shrink-0" fill="currentColor"
                                            viewBox="0 0 20 20">
                                            <path fill-rule="evenodd"
                                                d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z"
                                                clip-rule="evenodd" />
                                        </svg>
                                        <span class="text-sm">You already have a <b>pending request</b>. Please wait for
                                            approval.</span>
                                    </div>
                                    <% } %>

                                        <div
                                            class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                                            <% List<Room> rooms = (List<Room>) request.getAttribute("rooms");
                                                    if(rooms != null) {
                                                    for(Room r : rooms) {
                                                    boolean isAvailable = "Available".equals(r.getStatus());
                                                    %>
                                                    <div class="bg-white border border-gray-200 rounded-xl p-6 shadow-lg hover:shadow-xl transition duration-300 cursor-pointer"
                                                        onclick="window.location.href='room-details?roomId=<%= r.getId() %>'">
                                                        <div class="flex justify-between items-start mb-4">
                                                            <div>
                                                                <h3 class="text-2xl font-bold text-slate-900">Room <%=
                                                                        r.getRoomNumber() %>
                                                                </h3>
                                                                <p class="text-sm text-gray-500 mt-1">Click to view
                                                                    roommates</p>
                                                            </div>
                                                            <% if("Available".equals(r.getStatus())) { %>
                                                                <span
                                                                    class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-emerald-100 text-emerald-800">
                                                                    Available
                                                                </span>
                                                                <% } else { %>
                                                                    <span
                                                                        class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-red-100 text-red-800">
                                                                        Full
                                                                    </span>
                                                                    <% } %>
                                                        </div>

                                                        <div class="space-y-3 mb-4">
                                                            <div class="flex items-center gap-2 text-gray-600">
                                                                <svg class="w-5 h-5" fill="none" stroke="currentColor"
                                                                    viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                                        stroke-width="2"
                                                                        d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                                                                </svg>
                                                                <span class="text-sm font-medium">Capacity: <%=
                                                                        r.getCapacity() %> Students</span>
                                                            </div>
                                                        </div>

                                                        <form action="book-room" method="post"
                                                            onclick="event.stopPropagation();" class="mt-4">
                                                            <input type="hidden" name="roomId" value="<%= r.getId() %>">
                                                            <button type="submit"
                                                                class="w-full bg-slate-900 text-white font-medium py-2.5 rounded-lg hover:bg-slate-800 transition shadow-sm hover:shadow-md"
                                                                <% if("Full".equals(r.getStatus())) { %>disabled<% } %>>
                                                                    <% if("Full".equals(r.getStatus())) { %>
                                                                        Room Full
                                                                        <% } else { %>
                                                                            Book This Room
                                                                            <% } %>
                                                            </button>
                                                        </form>
                                                    </div>
                                                    <% } } else { %>
                                                        <p class="text-gray-500 col-span-full text-center py-10">No
                                                            rooms found in the system.</p>
                                                        <% } %>
                                        </div>
                </div>
            </body>

            </html>