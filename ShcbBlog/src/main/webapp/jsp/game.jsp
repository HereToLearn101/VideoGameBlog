<%-- 
    Document   : game
    Created on : Nov 14, 2017, 7:11:11 PM
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
        <title>Create Game</title>
        
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/home.css">
    </head>
    <body>
        <%@include file="navigation.jsp" %>
        <div id="post-container" class="container" style="padding-bottom: 15%;">
            <div id="blogBanner">
                <img src="${pageContext.request.contextPath}/img/blogBanner.png" width="100%">
            </div>
            <div id="post_page">
                <h1 class="green-text">Create Game</h1>
                <hr>
                <c:if test="${not empty error}">
                    <div class="alert alert-warning">
                        ${error}
                    </div>
                </c:if>
                <c:if test="${not empty dateError}">
                    <div class="alert alert-warning">
                        ${dateError}
                    </div>
                </c:if>
                <form action="${pageContext.request.contextPath}/createGame" method="POST">
                    
                    <h4 class="green-text">Game Name</h4>
                    <c:choose>
                        <c:when test="${name == 'error'}">
                            <input id="game-name" name="gameName" type="text" class="form-control" placeholder="Don't leave this blank!"/>
                        </c:when>
                        <c:otherwise>
                            <input id="game-name" name="gameName" type="text" class="form-control" value="${name}" placeholder="Game Name"/>
                        </c:otherwise>
                    </c:choose>
                    <h4 class="green-text">Release Date</h4>
                    <c:choose>
                        <c:when test="${date == 'error'}">
                            <input id="release-date" name="releaseDate" type="text" class="form-control" placeholder="Don't leave this blank!"/>
                        </c:when>
                        <c:otherwise>
                            <input id="release-date" name="releaseDate" type="text" class="form-control" value="${date}" placeholder="Date has to be in a LocalDate format, yyyy-mm-dd (e.g. 2017-01-21)"/>
                        </c:otherwise>
                    </c:choose>
                    <div>
                        <button id="submit_post" type="submit" class="btn btn-success">Submit</button>
                        <a href="${pageContext.request.contextPath}/dashboard">
                            <button id="backButton" type="button" class="btn btn-success" style="border-radius: 5px; margin-top: 15px;">Back</button>
                        </a>
                    </div>
                </form>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-2.1.4.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    </body>
    <script src="https://code.jquery.com/jquery-2.1.4.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</html>
