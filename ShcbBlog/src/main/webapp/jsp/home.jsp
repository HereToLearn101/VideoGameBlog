<%-- 
    Document   : home
    Created on : Nov 1, 2017, 11:04:54 PM
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
        <title>Home</title>

        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/home.css">
        <style>
            /* styles for '...' */
            /* .block-with-text CSS limits content to three lines only and adds '..' */
            .block-with-text {
                /* hide text if it more than N lines  */
                overflow: hidden;
                /* for set '...' in absolute position */
                position: relative;
                /* use this value to count block height */
                line-height: 1.2em;
                /* max-height = line-height (1.2) * lines max number (3) */
                max-height: 3.6em;
                /* fix problem when last visible word doesn't adjoin right side  */
                text-align: justify;

                /* */
                margin-right: -1em;
                padding-right: 1em;
            }

            .block-with-text:before {
                /* points in the end */
                content: '...';
                /* absolute position */
                position: absolute;
                /* set position to right bottom corner of block */
                right: 0;
                bottom: 0;
            }

            .block-with-text:after {
                /* points in the end */
                content: '';
                /* absolute position */
                position: absolute;
                /* set position to right bottom corner of text */
                right: 0;
                width: 1em;
                /* set width and height */
                height: 1em;
                margin-top: 0.2em;
                background: white;
            }

            .cnt h1 {
                display: none;
            }

            /*grabs the first paragraph tag*/
            .cnt p:not(:first-of-type) {
                display:none;
            }
        </style>

    </head>
    <body>
        <%@include file="navigation.jsp" %>
        <div id="id-container" class="container" style="padding-bottom: 15%;">
            <div id="blogBanner">
                <a href="${pageContext.request.contextPath}/">
                    <img src="${pageContext.request.contextPath}/img/blogBanner.png" width="100%">
                </a>
                <div class="text-center green-text"><h1>${typeOfPosts}</h1></div>
            </div>
            <!--<div class="text-center green-text"><h1>NO POSTS FOUND WITH THAT TITLE... TRY AGAIN</h1></div>-->
            <c:if test="${not empty error}">
                <div class="text-center green-text"><h1>NO POSTS FOUND... TRY AGAIN...</h1></div>
            </c:if>

            <c:forEach var="currentPost" items="${listOfPosts}">
                <a href="${pageContext.request.contextPath}/blog?id=${currentPost.id}">
                    <div class="col-md-6 col-sm-6">
                        <div class="thumbnail">
                            <img src="${currentPost.headerImg}" alt="..." style="height: 360px; width: auto;">
                            <div class="caption">
                                <h3>${currentPost.title}</h3>
                                <h4>Author:
                                    <c:forEach var="currentAuthor" items="${currentPost.authors}">
                                        <c:out value="${currentAuthor.userName}"/>
                                    </c:forEach>
                                </h4>
                                <div class="cnt block-with-text">${currentPost.htmlString}</div>
                            </div>
                        </div>
                    </div>
                </a>
            </c:forEach>

        </div>
        <script src="https://code.jquery.com/jquery-2.1.4.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    </body>
    <script src="https://code.jquery.com/jquery-2.1.4.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</html>
