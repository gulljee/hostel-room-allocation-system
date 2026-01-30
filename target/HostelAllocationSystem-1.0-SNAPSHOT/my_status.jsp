<%@ page import="com.hostel.model.Allocation" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <title>Roomeo - My Status</title>
            <script src="https://cdn.tailwindcss.com"></script>
        </head>

        <body
            class="bg-gradient-to-br from-slate-50 to-gray-100 text-slate-800 font-sans h-screen flex items-center justify-center">

            <div class="w-full max-w-lg bg-white border border-gray-200 rounded-xl p-8 shadow-lg">
                <div class="flex justify-between items-center mb-8 pb-4 border-b border-gray-100">
                    <h2 class="text-xl font-bold text-slate-900">Application Status</h2>
                    <a href="dashboard.jsp"
                        class="flex items-center gap-2 text-sm font-medium text-slate-600 hover:text-slate-900 border border-gray-300 px-5 py-2.5 rounded-lg hover:bg-white transition hover:shadow-md">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                        </svg>
                        Back to Dashboard
                    </a>
                </div>

                <% Allocation alloc=(Allocation) request.getAttribute("myAllocation"); if (alloc !=null) { String
                    statusColor="text-gray-600 bg-gray-100" ; String message="" ;
                    if("Approved".equalsIgnoreCase(alloc.getStatus())) {
                    statusColor="text-emerald-700 bg-emerald-50 border border-emerald-200" ;
                    message="Congratulations! Your room allocation is confirmed." ; } else
                    if("Pending".equalsIgnoreCase(alloc.getStatus())) {
                    statusColor="text-amber-700 bg-amber-50 border border-amber-200" ;
                    message="Your application is under review. Please wait for approval." ; } else {
                    statusColor="text-red-700 bg-red-50 border border-red-200" ;
                    message="Your application was rejected. Please contact admin for details." ; } %>
                    <div class="space-y-6">
                        <div class="grid grid-cols-2 gap-4 text-sm">
                            <div>
                                <p class="text-gray-500 mb-1">Applicant Name</p>
                                <p class="font-semibold text-slate-900 text-lg">
                                    <%= alloc.getStudentName() %>
                                </p>
                            </div>
                            <div>
                                <p class="text-gray-500 mb-1">Requested Room</p>
                                <p class="font-semibold text-slate-900 text-lg">
                                    <%= alloc.getRoomNumber() %>
                                </p>
                            </div>
                        </div>

                        <div class="pt-4">
                            <p class="text-gray-500 mb-2 text-sm font-medium">Current Status</p>
                            <div class="p-4 rounded-lg flex items-center justify-center <%= statusColor %>">
                                <span class="font-bold text-base tracking-wide uppercase">
                                    <%= alloc.getStatus() %>
                                </span>
                            </div>
                            <p class="text-center mt-4 text-sm text-gray-600 leading-relaxed">
                                <%= message %>
                            </p>
                        </div>
                    </div>

                    <% } else { %>
                        <div class="text-center py-10">
                            <div
                                class="h-16 w-16 bg-slate-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                <svg class="w-8 h-8 text-slate-400" fill="none" stroke="currentColor"
                                    viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4" />
                                </svg>
                            </div>
                            <h3 class="text-lg font-semibold text-slate-900 mb-2">No Applications Yet</h3>
                            <p class="text-gray-500 mb-6 text-sm">You haven't applied for any room.</p>
                            <a href="book-room"
                                class="inline-block bg-slate-900 text-white px-6 py-2.5 rounded-lg hover:bg-slate-800 transition font-medium shadow-sm hover:shadow-md">
                                Book a Room
                            </a>
                        </div>
                        <% } %>
            </div>

        </body>

        </html>