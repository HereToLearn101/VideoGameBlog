<%-- 
    Document   : login
    Created on : Nov 7, 2017, 1:25:45 PM
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
        <title>Sign Up</title>  
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
                <form class="form-signin" action="${pageContext.request.contextPath}/createUser" method="POST">
                    <h2 class="form-signin-heading">Sign Up</h2>
                    <label for="inputUsername" class="input-block-level green-text">New Username: </label>
                    <input type="text" id="inputUsername" name="newUsername" class="form-control" value="${userName}" required autofocus/>  
                    <div><span style="color: red;">${error}</span></div>
                    <label for="inputPassword" class="input-block-level green-text">New Password:</label>
                    <input type="password" id="inputPassword" name="newPass" class="form-control" value="${pass}" required/>
                    <!--<div><span style="color: red;">${passError}</span></div>-->
                    <label for="reTypePass" class="input-block-level green-text">Re-Type Password:</label>
                    <input type="password" id="reTypePass" name="reTypedNewPass" class="form-control" value="${reTypedPass}" required/>
                    <div><span style="color: red;">${passError}</span></div>
                    <button class="btn btn-large btn-success" type="submit">Create</button>
                </form>
            </div>
        </div>
        
        <script src="https://code.jquery.com/jquery-2.1.4.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    </body>
    <script src="https://code.jquery.com/jquery-2.1.4.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</html>