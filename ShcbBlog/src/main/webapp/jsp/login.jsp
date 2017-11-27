<%-- 
    Document   : login
    Created on : Nov 8, 2017, 12:44:19 PM
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
        <title>Login</title>   
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/home.css">
    </head>
    <body>
        <%@include file="navigation.jsp" %>                    
        <div id="login_container" class="container" >
            <div id="blogBanner">
                <img src="${pageContext.request.contextPath}/img/blogBanner.png" width="100%">
            </div>
            <div id="login">
                <form class="form-signin" action="j_spring_security_check" method="POST">
                    <h2 class="form-signin-heading">Login</h2>
                    <label for="inputUsername" class="input-block-level green-text"></label>
                    <input type="text" id="inputUsername" name="j_username" class="form-control" placeholder="Username" required autofocus>
                    <label for="inputPassword" class="input-block-level green-text"></label>
                    <input type="password" id="inputPassword" name="j_password" class="form-control" placeholder="Password" required>
                    <button class="btn btn-large btn-success" type="submit">Login</button>
                </form>
            </div>
        </div>
        
        <script src="https://code.jquery.com/jquery-2.1.4.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    </body>
    <script src="https://code.jquery.com/jquery-2.1.4.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</html>
