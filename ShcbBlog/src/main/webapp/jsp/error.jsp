<%-- 
    Document   : error
    Created on : Nov 9, 2017, 3:39:58 PM
    Author     : jared
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TI-Tensity Error</title>

        <title>Error Page</title>
        
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="home.css">
    </head>
    <body id="error" style="background: url(${pageContext.request.contextPath}/img/gameover.png) no-repeat center center fixed; background-size: cover;">
        <div class="text-center" style="position: relative; top: 15cm;">
            <h1 style="color: rgb(84, 185, 72);">Status: ${statusCode}</h1>
            <p style="color: rgb(84, 185, 72);">Request URI: ${requestUri}</p>
            <p style="color: rgb(84, 185, 72);">Exception message: ${exMessage}</p>
        </div>
    </body>
</html>
