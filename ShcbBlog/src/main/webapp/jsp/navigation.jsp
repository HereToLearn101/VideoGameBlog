<%-- 
    Document   : navigation
    Created on : Nov 8, 2017, 4:18:48 PM
    Author     : jared
--%>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="collapse navbar-collapse" id="bs-nav-demo">
            <ul class="nav navbar-nav">
                <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                <c:forEach var="currentCat" items="${listOfCats}">
                    <li class="dropdown"><a href="${pageContext.request.contextPath}/displayPostsByCategory?id=${currentCat.id}">${currentCat.name}</a></li>
                </c:forEach>
                <li><a href="${pageContext.request.contextPath}/timeLine">Timeline</a></li>
                <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_CONTRIBUTOR')">
                    <li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                </sec:authorize>
            </ul>
            <form class="navbar-form navbar-right" action="${pageContext.request.contextPath}/search" method="GET">
                <div class="form-group">
                    <input type="text" class="form-control" name="search" placeholder="Search By Title"/>
                </div>
                <button type="submit" class="btn btn-default">Search</button>
            </form>

            <!-- These two tags are display to ANONYMOUS USERS -->
            <sec:authorize access="isAnonymous()">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="${pageContext.request.contextPath}/signUp">Sign Up</a></li>
                    <li><a href="${pageContext.request.contextPath}/login">Login</a></li>
                </ul>
            </sec:authorize>

            <!-- Tags at the button are to be displayed only with, ADMINISTRATOR, CONTRIBUTOR, and USER AUTHORIZED -->
            <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_CONTRIBUTOR', 'ROLE_USER')">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#" style="pointer-events: none;"><sec:authentication property="principal.username"/></a></li>
                    <a href="#" class="navbar-brand" style="pointer-events: none;">
                        <span class="glyphicon glyphicon-user"></span>
                    </a>
                    <li><a href="${pageContext.request.contextPath}/j_spring_security_logout">Logout</a></li>
                </ul>
            </sec:authorize>          
        </div>
    </div>
</nav>
