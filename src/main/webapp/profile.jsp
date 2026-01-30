<%@ page import="com.hostel.model.User" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <% User user=(User) request.getAttribute("user"); if(user==null) { response.sendRedirect("login.jsp"); return; }
            String successMsg=request.getParameter("msg"); String errorMsg=request.getParameter("error"); %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <title>Roomeo - My Profile</title>
                <script src="https://cdn.tailwindcss.com"></script>
                <script>
                    function togglePassword() {
                        const passwordField = document.getElementById('passwordField');
                        const eyeIcon = document.getElementById('eyeIcon');
                        const eyeOffIcon = document.getElementById('eyeOffIcon');

                        if (passwordField.type === 'password') {
                            passwordField.type = 'text';
                            eyeIcon.classList.add('hidden');
                            eyeOffIcon.classList.remove('hidden');
                        } else {
                            passwordField.type = 'password';
                            eyeIcon.classList.remove('hidden');
                            eyeOffIcon.classList.add('hidden');
                        }
                    }
                </script>
            </head>

            <body class="bg-gradient-to-br from-slate-50 to-gray-100 text-slate-800 font-sans min-h-screen p-8">

                <div class="max-w-3xl mx-auto">
                    <div class="flex justify-between items-center mb-8">
                        <div>
                            <h2 class="text-3xl font-bold text-slate-900 tracking-tight">My Profile</h2>
                            <p class="text-gray-500 mt-1">Manage your personal information</p>
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

                    <!-- Success/Error Messages -->
                    <% if (successMsg !=null && successMsg.equals("success")) { %>
                        <div id="successMsg"
                            class="mb-6 bg-emerald-50 border border-emerald-200 text-emerald-800 px-5 py-4 rounded-xl flex items-start gap-3 transition-opacity duration-500">
                            <svg class="w-5 h-5 text-emerald-600 mt-0.5 flex-shrink-0" fill="currentColor"
                                viewBox="0 0 20 20">
                                <path fill-rule="evenodd"
                                    d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                                    clip-rule="evenodd" />
                            </svg>
                            <span class="text-sm font-medium">Profile updated successfully!</span>
                        </div>
                        <script>
                            setTimeout(function () {
                                var successMsg = document.getElementById('successMsg');
                                successMsg.style.opacity = '0';
                                setTimeout(function () {
                                    successMsg.remove();
                                }, 500);
                            }, 3000);
                        </script>
                        <% } %>

                            <% if (errorMsg !=null && errorMsg.equals("failed")) { %>
                                <div
                                    class="mb-6 bg-red-50 border border-red-200 text-red-800 px-5 py-4 rounded-xl flex items-start gap-3">
                                    <svg class="w-5 h-5 text-red-600 mt-0.5 flex-shrink-0" fill="currentColor"
                                        viewBox="0 0 20 20">
                                        <path fill-rule="evenodd"
                                            d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z"
                                            clip-rule="evenodd" />
                                    </svg>
                                    <span class="text-sm font-medium">Failed to update profile. Please try again.</span>
                                </div>
                                <% } %>

                                    <!-- Profile Form -->
                                    <div class="bg-white border border-gray-200 rounded-xl p-8 shadow-lg">
                                        <form action="profile" method="post" class="space-y-5">

                                            <!-- Personal Information Section -->
                                            <div class="pb-4 border-b border-gray-100">
                                                <h3 class="text-lg font-bold text-slate-900 mb-4">Personal Information
                                                </h3>

                                                <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                                                    <div>
                                                        <label
                                                            class="block text-sm font-medium text-gray-700 mb-1.5">Full
                                                            Name</label>
                                                        <input type="text" name="fullName"
                                                            value="<%= user.getFullName() != null ? user.getFullName() : "" %>"
                                                            required
                                                            class="w-full border border-gray-300 rounded-lg px-3 py-2.5 focus:border-slate-800 focus:ring-2 focus:ring-slate-800/10 outline-none transition">
                                                    </div>

                                                    <div>
                                                        <label
                                                            class="block text-sm font-medium text-gray-700 mb-1.5">Email
                                                            Address</label>
                                                        <input type="email"
                                                            value="<%= user.getEmail() != null ? user.getEmail() : "" %>"
                                                            disabled
                                                            class="w-full border border-gray-200 rounded-lg px-3 py-2.5 bg-gray-50 text-gray-500 cursor-not-allowed">
                                                        <p class="text-xs text-gray-500 mt-1">Email cannot be changed
                                                        </p>
                                                    </div>

                                                    <div>
                                                        <label
                                                            class="block text-sm font-medium text-gray-700 mb-1.5">Phone
                                                            Number</label>
                                                        <input type="tel" name="phoneNumber"
                                                            value="<%= user.getPhoneNumber() != null ? user.getPhoneNumber() : "" %>"
                                                            required
                                                            class="w-full border border-gray-300 rounded-lg px-3 py-2.5 focus:border-slate-800 focus:ring-2 focus:ring-slate-800/10 outline-none transition">
                                                    </div>

                                                    <div>
                                                        <label
                                                            class="block text-sm font-medium text-gray-700 mb-1.5">City</label>
                                                        <input type="text" name="city"
                                                            value="<%= user.getCity() != null ? user.getCity() : "" %>"
                                                            placeholder="e.g. Lahore"
                                                            class="w-full border border-gray-300 rounded-lg px-3 py-2.5 focus:border-slate-800 focus:ring-2 focus:ring-slate-800/10 outline-none transition">
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Academic Information Section -->
                                            <div class="pb-4 border-b border-gray-100">
                                                <h3 class="text-lg font-bold text-slate-900 mb-4">Academic Information
                                                </h3>

                                                <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                                                    <div>
                                                        <label
                                                            class="block text-sm font-medium text-gray-700 mb-1.5">Department</label>
                                                        <input type="text" name="department"
                                                            value="<%= user.getDepartment() != null ? user.getDepartment() : "" %>"
                                                            placeholder="e.g. Computer Science"
                                                            class="w-full border border-gray-300 rounded-lg px-3 py-2.5 focus:border-slate-800 focus:ring-2 focus:ring-slate-800/10 outline-none transition">
                                                    </div>

                                                    <div>
                                                        <label
                                                            class="block text-sm font-medium text-gray-700 mb-1.5">Semester</label>
                                                        <input type="text" name="semester"
                                                            value="<%= user.getSemester() != null ? user.getSemester() : "" %>"
                                                            placeholder="e.g. 6th"
                                                            class="w-full border border-gray-300 rounded-lg px-3 py-2.5 focus:border-slate-800 focus:ring-2 focus:ring-slate-800/10 outline-none transition">
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Account Security Section -->
                                            <div class="pb-4 border-b border-gray-100">
                                                <h3 class="text-lg font-bold text-slate-900 mb-4">Account Security</h3>

                                                <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                                                    <div>
                                                        <label
                                                            class="block text-sm font-medium text-gray-700 mb-1.5">Username</label>
                                                        <input type="text" name="username"
                                                            value="<%= user.getUsername() != null ? user.getUsername() : "" %>"
                                                            required
                                                            class="w-full border border-gray-300 rounded-lg px-3 py-2.5 focus:border-slate-800 focus:ring-2 focus:ring-slate-800/10 outline-none transition">
                                                    </div>

                                                    <div>
                                                        <label
                                                            class="block text-sm font-medium text-gray-700 mb-1.5">Password</label>
                                                        <div class="relative">
                                                            <input type="password" name="password" id="passwordField"
                                                                value="<%= user.getPassword() != null ? user.getPassword() : "" %>"
                                                                required
                                                                class="w-full border border-gray-300 rounded-lg px-3 py-2.5 pr-10 focus:border-slate-800 focus:ring-2 focus:ring-slate-800/10 outline-none transition">
                                                            <button type="button" onclick="togglePassword()"
                                                                class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-700 focus:outline-none">
                                                                <svg id="eyeIcon" class="w-5 h-5" fill="none"
                                                                    stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                                        stroke-width="2"
                                                                        d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                                        stroke-width="2"
                                                                        d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                                                </svg>
                                                                <svg id="eyeOffIcon" class="w-5 h-5 hidden" fill="none"
                                                                    stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                                        stroke-width="2"
                                                                        d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21" />
                                                                </svg>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Submit Button -->
                                            <div class="pt-4">
                                                <button type="submit"
                                                    class="w-full bg-slate-900 text-white font-medium py-3 rounded-lg hover:bg-slate-800 transition shadow-sm hover:shadow-md">
                                                    Save Changes
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                </div>

            </body>

            </html>