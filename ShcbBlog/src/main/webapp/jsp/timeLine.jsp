<%-- 
    Document   : timeLine
    Created on : Nov 14, 2017, 11:12:34 AM
    Author     : tedis
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Time Line</title>

        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/home.css">
    </head>
    <body>
        <%@include file="navigation.jsp" %>
        <div id="id-container" class="container" style="padding-bottom: 15%;">
            <div id="blogBanner">
                <a href="${pageContext.request.contextPath}/">
                    <img src="${pageContext.request.contextPath}/img/blogBanner.png" width="100%">
                </a>
            </div>

            <div>
                <h1 class="green-text">Video Game Timeline</h1>
                <hr>
                <section class="timeline col-md-12 col-sm-12">
                    <ul>
                        <c:forEach var="currentYear" items="${years}">
                            <li>
                                <div>
                                    <h2 class="green-text">${currentYear.year}</h2>
                                    
                                    <c:forEach var="currentGame" items="${currentYear.games}">
                                        <span><h4 class="green-text">- ${currentGame.name}</h4></span>
                                    </c:forEach>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </section>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-2.1.4.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/timeLine.js"></script>
    </body>
    <script src="https://code.jquery.com/jquery-2.1.4.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</html>
