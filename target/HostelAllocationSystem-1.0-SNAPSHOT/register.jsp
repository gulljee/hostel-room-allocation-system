<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <title>Roomeo - Join Us</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            function validateEmail() {
                const emailInput = document.getElementById('emailInput');
                const emailError = document.getElementById('emailError');
                const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

                if (emailInput.value && !emailRegex.test(emailInput.value)) {
                    emailError.classList.remove('hidden');
                    emailInput.classList.add('border-red-500', 'focus:border-red-500', 'focus:ring-red-500/10');
                    emailInput.classList.remove('border-gray-300', 'focus:border-slate-800', 'focus:ring-slate-800/10');
                    return false;
                } else {
                    emailError.classList.add('hidden');
                    emailInput.classList.remove('border-red-500', 'focus:border-red-500', 'focus:ring-red-500/10');
                    emailInput.classList.add('border-gray-300', 'focus:border-slate-800', 'focus:ring-slate-800/10');
                    return true;
                }
            }

            function validatePhone() {
                const phoneInput = document.getElementById('phoneInput');
                const phoneError = document.getElementById('phoneError');
                // Remove spaces and hyphens for validation
                const cleanPhone = phoneInput.value.replace(/[\s-]/g, '');

                // Pakistani phone number formats:
                // +923061005084 (13 chars) - with country code
                // 03061005084 (11 chars) - with leading 0
                // 3061005084 (10 chars) - without prefix
                const phoneRegex = /^(\+92[0-9]{10}|0[0-9]{10}|[0-9]{10})$/;

                if (phoneInput.value && !phoneRegex.test(cleanPhone)) {
                    phoneError.classList.remove('hidden');
                    phoneInput.classList.add('border-red-500', 'focus:border-red-500', 'focus:ring-red-500/10');
                    phoneInput.classList.remove('border-gray-300', 'focus:border-slate-800', 'focus:ring-slate-800/10');
                    return false;
                } else {
                    phoneError.classList.add('hidden');
                    phoneInput.classList.remove('border-red-500', 'focus:border-red-500', 'focus:ring-red-500/10');
                    phoneInput.classList.add('border-gray-300', 'focus:border-slate-800', 'focus:ring-slate-800/10');
                    return true;
                }
            }

            function validateUsername() {
                const usernameInput = document.getElementById('usernameInput');
                const usernameError = document.getElementById('usernameError');
                const usernameRegex = /^[a-zA-Z0-9_]{3,20}$/;

                if (usernameInput.value && !usernameRegex.test(usernameInput.value)) {
                    usernameError.classList.remove('hidden');
                    usernameInput.classList.add('border-red-500', 'focus:border-red-500', 'focus:ring-red-500/10');
                    usernameInput.classList.remove('border-gray-300', 'focus:border-slate-800', 'focus:ring-slate-800/10');
                    return false;
                } else {
                    usernameError.classList.add('hidden');
                    usernameInput.classList.remove('border-red-500', 'focus:border-red-500', 'focus:ring-red-500/10');
                    usernameInput.classList.add('border-gray-300', 'focus:border-slate-800', 'focus:ring-slate-800/10');
                    return true;
                }
            }

            function validateForm(event) {
                const isEmailValid = validateEmail();
                const isPhoneValid = validatePhone();
                const isUsernameValid = validateUsername();

                if (!isEmailValid || !isPhoneValid || !isUsernameValid) {
                    event.preventDefault();
                    return false;
                }
                return true;
            }
        </script>
    </head>

    <body
        class="bg-gradient-to-br from-slate-50 to-gray-100 text-slate-800 font-sans min-h-screen flex items-center justify-center py-10">

        <div class="w-full max-w-md p-8 bg-white border border-gray-200 rounded-xl shadow-lg">
            <div class="text-center mb-8">
                <h2 class="text-3xl font-bold text-slate-900 tracking-tight">Join Roomeo.</h2>
                <p class="text-gray-500 text-sm mt-1">Find your perfect space today.</p>
            </div>

            <% String error=request.getParameter("error"); if (error !=null && error.equals("username_exists")) { %>
                <div
                    class="mb-4 text-sm text-red-700 bg-red-50 p-3 rounded-lg border border-red-200 flex items-center gap-2">
                    <svg class="w-4 h-4 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd"
                            d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z"
                            clip-rule="evenodd" />
                    </svg>
                    <span>This username is already taken. Please choose a different one.</span>
                </div>
                <% } else if (error !=null && error.equals("email_exists")) { %>
                    <div
                        class="mb-4 text-sm text-red-700 bg-red-50 p-3 rounded-lg border border-red-200 flex items-center gap-2">
                        <svg class="w-4 h-4 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd"
                                d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z"
                                clip-rule="evenodd" />
                        </svg>
                        <span>This email is already registered. Please use a different email or login.</span>
                    </div>
                    <% } else if (error !=null && error.equals("failed")) { %>
                        <div
                            class="mb-4 text-sm text-red-700 bg-red-50 p-3 rounded-lg border border-red-200 flex items-center gap-2">
                            <svg class="w-4 h-4 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd"
                                    d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z"
                                    clip-rule="evenodd" />
                            </svg>
                            <span>Registration failed. Please try again.</span>
                        </div>
                        <% } %>

                            <form action="register" method="post" class="space-y-4"
                                onsubmit="return validateForm(event)">
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-1.5">Full Name</label>
                                    <input type="text" name="fullName" required placeholder="e.g. Ali Khan"
                                        class="w-full border border-gray-300 rounded-lg px-3 py-2.5 focus:border-slate-800 focus:ring-2 focus:ring-slate-800/10 outline-none transition">
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-1.5">Email Address</label>
                                    <input type="email" name="email" id="emailInput" required
                                        placeholder="student@example.com"
                                        pattern="[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" oninput="validateEmail()"
                                        class="w-full border border-gray-300 rounded-lg px-3 py-2.5 focus:border-slate-800 focus:ring-2 focus:ring-slate-800/10 outline-none transition">
                                    <p id="emailError"
                                        class="hidden text-xs text-red-600 mt-1.5 flex items-center gap-1">
                                        <svg class="w-3.5 h-3.5" fill="currentColor" viewBox="0 0 20 20">
                                            <path fill-rule="evenodd"
                                                d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z"
                                                clip-rule="evenodd" />
                                        </svg>
                                        Please enter a valid email address (e.g., user@example.com)
                                    </p>
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-1.5">Phone Number</label>
                                    <input type="tel" name="phoneNumber" id="phoneInput" required
                                        placeholder="+92 300 1234567" oninput="validatePhone()"
                                        class="w-full border border-gray-300 rounded-lg px-3 py-2.5 focus:border-slate-800 focus:ring-2 focus:ring-slate-800/10 outline-none transition">
                                    <p id="phoneError"
                                        class="hidden text-xs text-red-600 mt-1.5 flex items-center gap-1">
                                        <svg class="w-3.5 h-3.5" fill="currentColor" viewBox="0 0 20 20">
                                            <path fill-rule="evenodd"
                                                d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z"
                                                clip-rule="evenodd" />
                                        </svg>
                                        Please enter a valid Pakistani phone number (10 digits)
                                    </p>
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-1.5">Username</label>
                                    <input type="text" name="username" id="usernameInput" required
                                        placeholder="Choose a username" pattern="[a-zA-Z0-9_]{3,20}"
                                        oninput="validateUsername()"
                                        class="w-full border border-gray-300 rounded-lg px-3 py-2.5 focus:border-slate-800 focus:ring-2 focus:ring-slate-800/10 outline-none transition">
                                    <p id="usernameError"
                                        class="hidden text-xs text-red-600 mt-1.5 flex items-center gap-1">
                                        <svg class="w-3.5 h-3.5" fill="currentColor" viewBox="0 0 20 20">
                                            <path fill-rule="evenodd"
                                                d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z"
                                                clip-rule="evenodd" />
                                        </svg>
                                        Username must be 3-20 characters (letters, numbers, underscore only)
                                    </p>
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-1.5">Password</label>
                                    <div class="relative">
                                        <input type="password" name="password" id="registerPassword" required
                                            placeholder="Create a strong password" minlength="6"
                                            class="w-full border border-gray-300 rounded-lg px-3 py-2.5 pr-10 focus:border-slate-800 focus:ring-2 focus:ring-slate-800/10 outline-none transition">
                                        <button type="button" onclick="toggleRegisterPassword()"
                                            class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-700 focus:outline-none">
                                            <svg id="registerEyeIcon" class="w-5 h-5" fill="none" stroke="currentColor"
                                                viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                            </svg>
                                        </button>
                                    </div>
                                    <p class="text-xs text-gray-500 mt-1.5">Minimum 6 characters</p>
                                </div>

                                <script>
                                    function toggleRegisterPassword() {
                                        const passwordInput = document.getElementById('registerPassword');
                                        const eyeIcon = document.getElementById('registerEyeIcon');

                                        if (passwordInput.type === 'password') {
                                            passwordInput.type = 'text';
                                            eyeIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21"/>';
                                        } else {
                                            passwordInput.type = 'password';
                                            eyeIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>';
                                        }
                                    }
                                </script>

                                <button type="submit"
                                    class="w-full bg-slate-900 text-white font-medium py-3 rounded-lg hover:bg-slate-800 transition shadow-sm hover:shadow-md mt-6">
                                    Create Account
                                </button>
                            </form>

                            <div class="mt-6 text-center text-sm">
                                <span class="text-gray-500">Already have an account?</span>
                                <a href="login.jsp"
                                    class="text-emerald-600 hover:text-emerald-700 font-medium ml-1 hover:underline underline-offset-2">Log
                                    in</a>
                            </div>
        </div>

    </body>

    </html>