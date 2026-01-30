<%@ page import="com.hostel.model.Room" %>
    <%@ page import="com.hostel.model.User" %>
        <%@ page import="com.hostel.dao.RatingDAO" %>
            <%@ page import="java.util.List" %>
                <%@ page contentType="text/html;charset=UTF-8" language="java" %>
                    <% Room room=(Room) request.getAttribute("room"); List<User> students = (List<User>)
                            request.getAttribute("students");

                            if (room == null) {
                            response.sendRedirect("manage-rooms");
                            return;
                            }
                            %>
                            <!DOCTYPE html>
                            <html lang="en">

                            <head>
                                <title>Roomeo - Room <%= room.getRoomNumber() %> Details</title>
                                <script src="https://cdn.tailwindcss.com"></script>
                                <script>
                                    function updateRating(ratedStudentId, rating, roomId) {
                                        document.getElementById('ratingValue' + ratedStudentId).value = rating;
                                        document.getElementById('ratingForm' + ratedStudentId).submit();
                                    }
                                </script>
                            </head>

                            <body
                                class="bg-gradient-to-br from-slate-50 to-gray-100 text-slate-800 font-sans min-h-screen p-8">

                                <div class="max-w-6xl mx-auto">
                                    <!-- Header -->
                                    <div class="flex justify-between items-center mb-8">
                                        <div>
                                            <h2 class="text-3xl font-bold text-slate-900 tracking-tight">Room <%=
                                                    room.getRoomNumber() %>
                                            </h2>
                                            <p class="text-gray-500 mt-1">Students currently allocated to this room</p>
                                        </div>
                                        <% com.hostel.model.User currentUser=(com.hostel.model.User)
                                            session.getAttribute("currentUser"); String backUrl="dashboard.jsp" ; if
                                            (currentUser !=null) { if ("admin".equals(currentUser.getRole())) {
                                            backUrl="manage-rooms" ; } else { backUrl="book-room" ; } } %>
                                            <a href="<%= backUrl %>"
                                                class="flex items-center gap-2 text-sm font-medium text-slate-600 hover:text-slate-900 border border-gray-300 px-5 py-2.5 rounded-lg hover:bg-white transition hover:shadow-md">
                                                <svg class="w-5 h-5" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                                                </svg>
                                                Back to Rooms
                                            </a>
                                    </div>

                                    <!-- Success/Error Messages -->
                                    <% String msg=request.getParameter("msg"); String
                                        error=request.getParameter("error"); %>
                                        <% if (msg !=null && msg.equals("rating_success")) { %>
                                            <div class="bg-green-50 border border-green-200 text-green-800 px-4 py-3 rounded-lg mb-6 flex items-center justify-between"
                                                id="successMessage">
                                                <div class="flex items-center gap-2">
                                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                                        <path fill-rule="evenodd"
                                                            d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                                                            clip-rule="evenodd" />
                                                    </svg>
                                                    <span class="font-medium">Rating updated successfully!</span>
                                                </div>
                                                <button
                                                    onclick="document.getElementById('successMessage').style.display='none'"
                                                    class="text-green-600 hover:text-green-800">
                                                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                                                        <path fill-rule="evenodd"
                                                            d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                                                            clip-rule="evenodd" />
                                                    </svg>
                                                </button>
                                            </div>
                                            <script>
                                                setTimeout(function () {
                                                    var msg = document.getElementById('successMessage');
                                                    if (msg) msg.style.display = 'none';
                                                }, 3000);
                                            </script>
                                            <% } %>

                                                <% if (error !=null) { %>
                                                    <div class="bg-red-50 border border-red-200 text-red-800 px-4 py-3 rounded-lg mb-6 flex items-center justify-between"
                                                        id="errorMessage">
                                                        <div class="flex items-center gap-2">
                                                            <svg class="w-5 h-5" fill="currentColor"
                                                                viewBox="0 0 20 20">
                                                                <path fill-rule="evenodd"
                                                                    d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z"
                                                                    clip-rule="evenodd" />
                                                            </svg>
                                                            <span class="font-medium">
                                                                <% if (error.equals("self_rating")) { %>
                                                                    You cannot rate yourself!
                                                                    <% } else if (error.equals("invalid_rating")) { %>
                                                                        Invalid rating value!
                                                                        <% } else { %>
                                                                            Failed to update rating. Please try again.
                                                                            <% } %>
                                                            </span>
                                                        </div>
                                                        <button
                                                            onclick="document.getElementById('errorMessage').style.display='none'"
                                                            class="text-red-600 hover:text-red-800">
                                                            <svg class="w-4 h-4" fill="currentColor"
                                                                viewBox="0 0 20 20">
                                                                <path fill-rule="evenodd"
                                                                    d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                                                                    clip-rule="evenodd" />
                                                            </svg>
                                                        </button>
                                                    </div>
                                                    <script>
                                                        setTimeout(function () {
                                                            var msg = document.getElementById('errorMessage');
                                                            if (msg) msg.style.display = 'none';
                                                        }, 3000);
                                                    </script>
                                                    <% } %>

                                                        <!-- Room Info Card -->
                                                        <div
                                                            class="bg-white border border-gray-200 rounded-xl p-6 shadow-lg mb-8">
                                                            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                                                                <div>
                                                                    <p class="text-sm text-gray-500 mb-1">Room Number
                                                                    </p>
                                                                    <p class="text-2xl font-bold text-slate-900">
                                                                        <%= room.getRoomNumber() %>
                                                                    </p>
                                                                </div>
                                                                <div>
                                                                    <p class="text-sm text-gray-500 mb-1">Capacity</p>
                                                                    <p class="text-2xl font-bold text-slate-900">
                                                                        <%= room.getCapacity() %> Students
                                                                    </p>
                                                                </div>
                                                                <div>
                                                                    <p class="text-sm text-gray-500 mb-1">Status</p>
                                                                    <% if("Available".equals(room.getStatus())) { %>
                                                                        <span
                                                                            class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-emerald-100 text-emerald-800">
                                                                            Available
                                                                        </span>
                                                                        <% } else { %>
                                                                            <span
                                                                                class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-red-100 text-red-800">
                                                                                Full
                                                                            </span>
                                                                            <% } %>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <!-- Students Section -->
                                                        <div class="mb-4">
                                                            <h3 class="text-xl font-bold text-slate-900 mb-2">
                                                                Allocated Students
                                                                <span class="text-gray-500 font-normal text-base">(<%=
                                                                        students !=null ? students.size() : 0 %>)</span>
                                                            </h3>
                                                        </div>

                                                        <!-- Student Cards Grid -->
                                                        <% if (students !=null && !students.isEmpty()) { %>
                                                            <div
                                                                class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                                                                <% for (User student : students) { %>
                                                                    <div
                                                                        class="bg-white border border-gray-200 rounded-xl p-6 shadow-lg hover:shadow-xl transition duration-300">
                                                                        <!-- Student Header -->
                                                                        <div
                                                                            class="flex items-center gap-3 mb-4 pb-4 border-b border-gray-100">
                                                                            <div
                                                                                class="h-12 w-12 bg-emerald-100 rounded-full flex items-center justify-center">
                                                                                <svg class="w-6 h-6 text-emerald-600"
                                                                                    fill="none" stroke="currentColor"
                                                                                    viewBox="0 0 24 24">
                                                                                    <path stroke-linecap="round"
                                                                                        stroke-linejoin="round"
                                                                                        stroke-width="2"
                                                                                        d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                                                                                </svg>
                                                                            </div>
                                                                            <div class="flex-1 min-w-0">
                                                                                <h4
                                                                                    class="text-lg font-bold text-slate-900 truncate">
                                                                                    <%= student.getFullName() %>
                                                                                </h4>
                                                                                <p class="text-sm text-gray-500">ID: #
                                                                                    <%= student.getId() %>
                                                                                </p>
                                                                            </div>
                                                                        </div>

                                                                        <!-- Student Details -->
                                                                        <div class="space-y-3">
                                                                            <div>
                                                                                <p class="text-xs text-gray-500 mb-1">
                                                                                    Email</p>
                                                                                <p
                                                                                    class="text-sm text-slate-900 truncate">
                                                                                    <%= student.getEmail() !=null ?
                                                                                        student.getEmail() : "N/A" %>
                                                                                </p>
                                                                            </div>

                                                                            <div>
                                                                                <p class="text-xs text-gray-500 mb-1">
                                                                                    Phone Number</p>
                                                                                <p class="text-sm text-slate-900">
                                                                                    <%= student.getPhoneNumber() !=null
                                                                                        ? student.getPhoneNumber()
                                                                                        : "N/A" %>
                                                                                </p>
                                                                            </div>

                                                                            <div class="grid grid-cols-2 gap-3">
                                                                                <div>
                                                                                    <p
                                                                                        class="text-xs text-gray-500 mb-1">
                                                                                        Department</p>
                                                                                    <p
                                                                                        class="text-sm text-slate-900 font-medium">
                                                                                        <%= student.getDepartment()
                                                                                            !=null ?
                                                                                            student.getDepartment()
                                                                                            : "N/A" %>
                                                                                    </p>
                                                                                </div>
                                                                                <div>
                                                                                    <p
                                                                                        class="text-xs text-gray-500 mb-1">
                                                                                        Semester</p>
                                                                                    <p
                                                                                        class="text-sm text-slate-900 font-medium">
                                                                                        <%= student.getSemester() !=null
                                                                                            ? student.getSemester()
                                                                                            : "N/A" %>
                                                                                    </p>
                                                                                </div>
                                                                            </div>

                                                                            <div>
                                                                                <p class="text-xs text-gray-500 mb-1">
                                                                                    City</p>
                                                                                <p class="text-sm text-slate-900">
                                                                                    <%= student.getCity() !=null ?
                                                                                        student.getCity() : "N/A" %>
                                                                                </p>
                                                                            </div>

                                                                            <!-- Peer Rating Section -->
                                                                            <% RatingDAO ratingDAO=new RatingDAO();
                                                                                boolean canRate=(currentUser !=null &&
                                                                                currentUser.getId() !=student.getId());
                                                                                Integer myRating=null; double
                                                                                avgRating=ratingDAO.getAverageRating(student.getId());
                                                                                int
                                                                                ratingCount=ratingDAO.getRatingCount(student.getId());
                                                                                if (canRate) {
                                                                                myRating=ratingDAO.getRatingByRater(student.getId(),
                                                                                currentUser.getId()); } %>

                                                                                <div
                                                                                    class="pt-3 border-t border-gray-100 mt-3">
                                                                                    <% if (canRate) { %>
                                                                                        <!-- Clickable stars for rating roommates -->
                                                                                        <p
                                                                                            class="text-xs text-gray-500 mb-2">
                                                                                            Rate this
                                                                                            student</p>
                                                                                        <form action="update-rating"
                                                                                            method="post"
                                                                                            id="ratingForm<%= student.getId() %>">
                                                                                            <input type="hidden"
                                                                                                name="ratedStudentId"
                                                                                                value="<%= student.getId() %>">
                                                                                            <input type="hidden"
                                                                                                name="roomId"
                                                                                                value="<%= room.getId() %>">
                                                                                            <input type="hidden"
                                                                                                name="rating"
                                                                                                id="ratingValue<%= student.getId() %>"
                                                                                                value="0">

                                                                                            <div
                                                                                                class="flex items-center gap-1 mb-2">
                                                                                                <% int
                                                                                                    displayRating=(myRating
                                                                                                    !=null) ? myRating :
                                                                                                    0; for (int i=1; i
                                                                                                    <=5; i++) { String
                                                                                                    fillClass=(i
                                                                                                    <=displayRating)
                                                                                                    ? "text-amber-400"
                                                                                                    : "text-gray-300" ;
                                                                                                    %>
                                                                                                    <svg class="w-6 h-6 <%= fillClass %> fill-current cursor-pointer hover:text-amber-500 transition"
                                                                                                        viewBox="0 0 20 20"
                                                                                                        onclick="updateRating(<%= student.getId() %>, <%= i %>, <%= room.getId() %>)">
                                                                                                        <path
                                                                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                                                                                                    </svg>
                                                                                                    <% } %>
                                                                                                        <span
                                                                                                            class="text-xs text-gray-600 ml-2">
                                                                                                            <% if
                                                                                                                (myRating
                                                                                                                !=null)
                                                                                                                { %>
                                                                                                                You: <%=
                                                                                                                    myRating
                                                                                                                    %>/5
                                                                                                                    <% } else
                                                                                                                        {
                                                                                                                        %>
                                                                                                                        Click
                                                                                                                        to
                                                                                                                        rate
                                                                                                                        <% }
                                                                                                                            %>
                                                                                                        </span>
                                                                                            </div>
                                                                                        </form>

                                                                                        <!-- Average Rating Display -->
                                                                                        <% if (ratingCount> 0) { %>
                                                                                            <div
                                                                                                class="flex items-center gap-1">
                                                                                                <% int fullStars=(int)
                                                                                                    Math.floor(avgRating);
                                                                                                    for (int i=1; i <=5;
                                                                                                    i++) { String
                                                                                                    fillClass=(i
                                                                                                    <=fullStars)
                                                                                                    ? "text-amber-400"
                                                                                                    : "text-gray-300" ;
                                                                                                    %>
                                                                                                    <svg class="w-5 h-5 <%= fillClass %> fill-current"
                                                                                                        viewBox="0 0 20 20">
                                                                                                        <path
                                                                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                                                                                                    </svg>
                                                                                                    <% } %>
                                                                                                        <% String
                                                                                                            ratingColor="text-gray-500"
                                                                                                            ; if
                                                                                                            (avgRating>=
                                                                                                            4.0) {
                                                                                                            ratingColor
                                                                                                            =
                                                                                                            "text-green-600";
                                                                                                            } else if
                                                                                                            (avgRating
                                                                                                            >= 3.0) {
                                                                                                            ratingColor
                                                                                                            =
                                                                                                            "text-yellow-600";
                                                                                                            } else if
                                                                                                            (avgRating
                                                                                                            >= 2.0) {
                                                                                                            ratingColor
                                                                                                            =
                                                                                                            "text-orange-600";
                                                                                                            } else if
                                                                                                            (avgRating >
                                                                                                            0) {
                                                                                                            ratingColor
                                                                                                            =
                                                                                                            "text-red-600";
                                                                                                            }
                                                                                                            %>
                                                                                                            <span
                                                                                                                class="text-xs <%= ratingColor %> ml-2 font-medium">
                                                                                                                <%= String.format("%.1f",
                                                                                                                    avgRating)
                                                                                                                    %>/5
                                                                                                                    (<%= ratingCount
                                                                                                                        %>
                                                                                                                        <%= ratingCount==1
                                                                                                                            ? "rating"
                                                                                                                            : "ratings"
                                                                                                                            %>
                                                                                                                            )
                                                                                                            </span>
                                                                                            </div>
                                                                                            <% } else { %>
                                                                                                <p
                                                                                                    class="text-xs text-gray-400">
                                                                                                    No ratings
                                                                                                    yet</p>
                                                                                                <% } %>
                                                                                                    <% } else { %>
                                                                                                        <!-- Read-only display for own profile -->
                                                                                                        <p
                                                                                                            class="text-xs text-gray-500 mb-2">
                                                                                                            Your Rating
                                                                                                        </p>
                                                                                                        <% if
                                                                                                            (ratingCount>
                                                                                                            0) { %>
                                                                                                            <div
                                                                                                                class="flex items-center gap-1">
                                                                                                                <% int
                                                                                                                    fullStars=(int)
                                                                                                                    Math.floor(avgRating);
                                                                                                                    for
                                                                                                                    (int
                                                                                                                    i=1;
                                                                                                                    i
                                                                                                                    <=5;
                                                                                                                    i++)
                                                                                                                    {
                                                                                                                    String
                                                                                                                    fillClass=(i
                                                                                                                    <=fullStars)
                                                                                                                    ? "text-amber-400"
                                                                                                                    : "text-gray-300"
                                                                                                                    ; %>
                                                                                                                    <svg class="w-5 h-5 <%= fillClass %> fill-current"
                                                                                                                        viewBox="0 0 20 20">
                                                                                                                        <path
                                                                                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                                                                                                                    </svg>
                                                                                                                    <% }
                                                                                                                        %>
                                                                                                                        <span
                                                                                                                            class="text-xs text-gray-500 ml-2">
                                                                                                                            <%= String.format("%.1f",
                                                                                                                                avgRating)
                                                                                                                                %>
                                                                                                                                /5
                                                                                                                                (
                                                                                                                                <%= ratingCount
                                                                                                                                    %>
                                                                                                                                    <%= ratingCount==1
                                                                                                                                        ? "rating"
                                                                                                                                        : "ratings"
                                                                                                                                        %>
                                                                                                                                        )
                                                                                                                        </span>
                                                                                                            </div>
                                                                                                            <% } else {
                                                                                                                %>
                                                                                                                <div
                                                                                                                    class="flex items-center gap-1">
                                                                                                                    <% for
                                                                                                                        (int
                                                                                                                        i=1;
                                                                                                                        i
                                                                                                                        <=5;
                                                                                                                        i++)
                                                                                                                        {
                                                                                                                        %>
                                                                                                                        <svg class="w-5 h-5 text-gray-300 fill-current"
                                                                                                                            viewBox="0 0 20 20">
                                                                                                                            <path
                                                                                                                                d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                                                                                                                        </svg>
                                                                                                                        <% }
                                                                                                                            %>
                                                                                                                            <span
                                                                                                                                class="text-xs text-gray-400 ml-2">No
                                                                                                                                ratings
                                                                                                                                yet</span>
                                                                                                                </div>
                                                                                                                <% } %>
                                                                                                                    <% }
                                                                                                                        %>
                                                                                </div>
                                                                        </div>
                                                                    </div>
                                                                    <% } %>
                                                            </div>
                                                            <% } else { %>
                                                                <div
                                                                    class="bg-white border border-gray-200 rounded-xl p-12 text-center shadow-lg">
                                                                    <svg class="w-16 h-16 text-gray-300 mx-auto mb-4"
                                                                        fill="none" stroke="currentColor"
                                                                        viewBox="0 0 24 24">
                                                                        <path stroke-linecap="round"
                                                                            stroke-linejoin="round" stroke-width="2"
                                                                            d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                                                                    </svg>
                                                                    <h3 class="text-xl font-bold text-gray-700 mb-2">No
                                                                        Students Allocated
                                                                    </h3>
                                                                    <p class="text-gray-500">This room currently has no
                                                                        approved student
                                                                        allocations.</p>
                                                                </div>
                                                                <% } %>
                                </div>

                            </body>

                            </html>