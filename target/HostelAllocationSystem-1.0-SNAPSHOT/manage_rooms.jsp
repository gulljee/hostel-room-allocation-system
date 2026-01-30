<%@ page import="java.util.List" %>
    <%@ page import="com.hostel.model.Room" %>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <title>Roomeo Admin - Rooms</title>
                <script src="https://cdn.tailwindcss.com"></script>
            </head>

            <body class="bg-gradient-to-br from-slate-50 to-gray-100 text-slate-800 font-sans p-8 min-h-screen">

                <div class="max-w-5xl mx-auto">
                    <div class="flex justify-between items-center mb-10">
                        <div>
                            <h2 class="text-3xl font-bold text-slate-900 tracking-tight">Manage Rooms</h2>
                            <p class="text-gray-500 text-sm mt-1">Roomeo Admin Panel</p>
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

                    <div class="bg-white border border-gray-200 rounded-xl p-6 mb-10 shadow-lg">
                        <h3 class="text-sm uppercase font-bold text-gray-500 mb-4 tracking-wider">Add New Room</h3>
                        <form action="manage-rooms" method="post" class="flex flex-col sm:flex-row gap-4">
                            <div class="flex-1">
                                <input type="text" name="roomNumber" placeholder="Room Number (e.g. 101)" required
                                    class="w-full border border-gray-300 rounded-lg px-3 py-3 focus:border-slate-800 focus:ring-2 focus:ring-slate-800/10 outline-none transition">
                            </div>

                            <div class="w-full sm:w-48">
                                <input type="number" name="capacity" placeholder="Capacity" required
                                    class="w-full border border-gray-300 rounded-lg px-3 py-3 focus:border-slate-800 focus:ring-2 focus:ring-slate-800/10 outline-none transition">
                            </div>

                            <button type="submit"
                                class="bg-slate-900 text-white px-8 py-3 rounded-lg hover:bg-slate-800 transition font-medium shadow-sm hover:shadow-md">
                                Add Room
                            </button>
                        </form>
                    </div>

                    <h3 class="text-lg font-bold text-slate-900 mb-4">All Rooms</h3>
                    <div class="overflow-hidden bg-white border border-gray-200 rounded-xl shadow-lg">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th
                                        class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                                        ID</th>
                                    <th
                                        class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                                        Room Number</th>
                                    <th
                                        class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                                        Capacity</th>
                                    <th
                                        class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                                        Status</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <% List<Room> rooms = (List<Room>) request.getAttribute("roomList");
                                        if (rooms != null) {
                                        for (Room r : rooms) {
                                        %>
                                        <tr class="hover:bg-gray-50 transition cursor-pointer"
                                            onclick="window.location.href='room-details?roomId=<%= r.getId() %>'">
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-400">#<%= r.getId()
                                                    %>
                                            </td>
                                            <td
                                                class="px-6 py-4 whitespace-nowrap text-sm font-semibold text-slate-900">
                                                <%= r.getRoomNumber() %>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">
                                                <%= r.getCapacity() %> Students
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm">
                                                <% if("Available".equals(r.getStatus())) { %>
                                                    <span
                                                        class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-emerald-100 text-emerald-800">
                                                        Available
                                                    </span>
                                                    <% } else { %>
                                                        <span
                                                            class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">
                                                            Full
                                                        </span>
                                                        <% } %>
                                            </td>
                                        </tr>
                                        <% } } else { %>
                                            <tr>
                                                <td colspan="4" class="px-6 py-8 text-center text-gray-500">No rooms
                                                    added yet.</td>
                                            </tr>
                                            <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </body>

            </html>