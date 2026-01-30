<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <title>Roomeo - Login</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>

    <body
        class="bg-gradient-to-br from-slate-50 to-gray-100 text-slate-800 font-sans h-screen flex items-center justify-center">

        <div class="w-full max-w-sm p-8 bg-white border border-gray-200 rounded-xl shadow-lg">
            <div class="text-center mb-8">
                <h1 class="text-3xl font-bold tracking-tight text-slate-900">Roomeo.</h1>
                <p class="text-gray-500 text-sm mt-1">Your Space, Your Place.</p>
            </div>

            <% String error=request.getParameter("error"); if(error !=null) { %>
                <div class="mb-4 text-sm text-red-700 bg-red-50 p-3 rounded-lg border border-red-200 text-center">
                    Username or Password Invalid!
                </div>
                <% } %>

                    <% String msg=request.getParameter("msg"); if(msg !=null && msg.equals("registered")) { %>
                        <div id="successMsg"
                            class="mb-4 text-sm text-emerald-700 bg-emerald-50 p-3 rounded-lg border border-emerald-200 text-center transition-opacity duration-500">
                            Registration successful! Please login to continue.
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

                            <form action="login" method="post" class="space-y-4">
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-1.5">Username or
                                        Email</label>
                                    <input type="text" name="username" required placeholder="Enter username or email"
                                        class="w-full border border-gray-300 rounded-lg px-3 py-2.5 focus:outline-none focus:border-slate-800 focus:ring-2 focus:ring-slate-800/10 transition">
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-1.5">Password</label>
                                    <div class="relative">
                                        <input type="password" name="password" id="loginPassword" required
                                            class="w-full border border-gray-300 rounded-lg px-3 py-2.5 pr-10 focus:outline-none focus:border-slate-800 focus:ring-2 focus:ring-slate-800/10 transition">
                                        <button type="button" onclick="toggleLoginPassword()"
                                            class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-700 focus:outline-none">
                                            <svg id="loginEyeIcon" class="w-5 h-5" fill="none" stroke="currentColor"
                                                viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                            </svg>
                                        </button>
                                    </div>
                                </div>

                                <script>
                                    function toggleLoginPassword() {
                                        const passwordInput = document.getElementById('loginPassword');
                                        const eyeIcon = document.getElementById('loginEyeIcon');

                                        if (passwordInput.type === 'password') {
                                            passwordInput.type = 'text';
                                            eyeIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21"/>';
                                        } else {
                                            passwordInput.type = 'password';
                                            eyeIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>';
                                        }
                                    }
                                </script>

                                <input type="submit" value="Sign In"
                                    class="w-full bg-slate-900 text-white font-medium py-2.5 rounded-lg hover:bg-slate-800 cursor-pointer transition shadow-sm hover:shadow-md">
                            </form>

                            <div class="mt-6 text-center text-sm">
                                <span class="text-gray-500">New to Roomeo?</span>
                                <a href="register.jsp"
                                    class="text-emerald-600 hover:text-emerald-700 font-medium ml-1 hover:underline underline-offset-2">Create
                                    account</a>
                            </div>
        </div>

    </body>

    </html>