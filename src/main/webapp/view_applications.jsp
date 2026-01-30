<%@ page import="java.util.List" %>
    <%@ page import="com.hostel.model.Allocation" %>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <title>Roomeo Admin - Applications</title>
                <script src="https://cdn.tailwindcss.com"></script>
            </head>

            <body class="bg-gradient-to-br from-slate-50 to-gray-100 text-slate-800 font-sans p-8 min-h-screen">

                <div class="max-w-6xl mx-auto">
                    <div class="flex justify-between items-center mb-10">
                        <div>
                            <h2 class="text-3xl font-bold text-slate-900 tracking-tight">Student Applications</h2>
                            <p class="text-gray-500 text-sm mt-1">Review pending requests</p>
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

                    <div class="overflow-hidden bg-white border border-gray-200 rounded-xl shadow-lg">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase">App ID
                                    </th>
                                    <th class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase">Student
                                        Name</th>
                                    <th class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase">Room</th>
                                    <th class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase">Status
                                    </th>
                                    <th class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase">Actions
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <% List<Allocation> list = (List<Allocation>) request.getAttribute("applicationList");
                                        if (list != null && !list.isEmpty()) {
                                        for (Allocation a : list) {
                                        %>
                                        <tr class="hover:bg-gray-50 transition">
                                            <td class="px-6 py-4 text-sm text-gray-400">#<%= a.getId() %>
                                            </td>
                                            <td class="px-6 py-4 text-sm font-medium text-slate-900">
                                                <%= a.getStudentName() %>
                                            </td>
                                            <td class="px-6 py-4 text-sm text-gray-600 font-mono">Room <%=
                                                    a.getRoomNumber() %>
                                            </td>
                                            <td class="px-6 py-4 text-sm">
                                                <span class="px-3 py-1 text-xs font-bold rounded-full
                        <%= " Pending".equals(a.getStatus()) ? "bg-amber-100 text-amber-800" :
                                                    ("Approved".equals(a.getStatus())
                                                    ? "bg-emerald-100 text-emerald-800" : "bg-red-100 text-red-800" )
                                                    %>">
                                                    <%= a.getStatus() %>
                                                </span>
                                            </td>
                                            <td class="px-6 py-4 text-sm font-medium">
                                                <% if("Pending".equals(a.getStatus())) { %>
                                                    <div class="flex items-center gap-2">
                                                        <form action="view-applications" method="post">
                                                            <input type="hidden" name="id" value="<%= a.getId() %>">
                                                            <input type="hidden" name="action" value="approve">
                                                            <button
                                                                class="text-emerald-700 bg-emerald-50 hover:bg-emerald-100 border border-emerald-200 px-3 py-1.5 rounded-lg transition text-xs uppercase font-bold tracking-wide">
                                                                Approve
                                                            </button>
                                                        </form>

                                                        <form action="view-applications" method="post">
                                                            <input type="hidden" name="id" value="<%= a.getId() %>">
                                                            <input type="hidden" name="action" value="reject">
                                                            <button
                                                                class="text-red-700 bg-red-50 hover:bg-red-100 border border-red-200 px-3 py-1.5 rounded-lg transition text-xs uppercase font-bold tracking-wide">
                                                                Reject
                                                            </button>
                                                        </form>
                                                    </div>
                                                    <% } else { %>
                                                        <span class="text-gray-400 text-xs uppercase tracking-wide">No
                                                            Actions</span>
                                                        <% } %>
                                            </td>
                                        </tr>
                                        <% } } else { %>
                                            <tr>
                                                <td colspan="5" class="px-6 py-10 text-center text-gray-500">No
                                                    applications found.</td>
                                            </tr>
                                            <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </body>

            </html>