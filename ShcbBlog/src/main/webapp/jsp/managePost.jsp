<%-- 
    Document   : pendingPost
    Created on : Nov 11, 2017, 11:17:44 AM
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
        <div id="id-container" class="container">
            <div id="blogBanner">
                <a href="${pageContext.request.contextPath}/">
                    <img src="${pageContext.request.contextPath}/img/blogBanner.png" width="100%">
                </a>
            </div>

            <h1 class="green-text">Manage Posts</h1>
            <div class="col-md-12 green-text" id="pendingPosts">
                <ul class="nav nav-tabs">
                    <li><a href="${pageContext.request.contextPath}/admin/manage" class="green-text">Pending</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/manage/status?status=approved" class="green-text">Approved</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/manage/status?status=unapproved'" class="green-text">Unapproved</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade in active">
                        <h3>${cat}</h3>
                        <table class="table table-dark table-bordered">
                            <thead>
                                <tr border="0">
                                    <th width="20%">Title</th>
                                    <th width="10%">Author</th>
                                    <th width="45%">Description</th>
                                    <th width="10%">Approve?</th>
                                    <th width="15%">Commit?</th>
                                </tr>
                            </thead>
                            <c:forEach var="currentPost" items="${posts}">
                                <form action="${pageContext.request.contextPath}/editPostApproval" method="POST">
                                    <tbody>
                                    <td>${currentPost.title}</td>
                                    <td>
                                        <input type="hidden" name="id" value="${currentPost.id}"/>
                                        <c:forEach var="currentAuthor" items="${currentPost.authors}">
                                            <c:out value="${currentAuthor.userName}"/>
                                        </c:forEach>
                                    </td>
                                    <td>
                                        <div class="cnt block-with-text">${currentPost.htmlString}</div>
                                    </td>
                                    <td>
                                        <div class="form-check form-check-inline text-center">
                                            <c:choose>
                                                <c:when test="${currentPost.status == 'APPROVED'}">
                                                    <input type="checkbox" name="approve" value="true" checked/>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="checkbox" name="approve" value="true"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                    <td>
                                        <input type="submit" class="btn btn-success" value="Make Change"/>
                                    </td>
                                    </tbody>
                                </form>
                            </c:forEach>
                        </table>
                    </div>
                </div>
            </div>    
        </div>
        <script src="https://code.jquery.com/jquery-2.1.4.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    </body>
    <script src="https://code.jquery.com/jquery-2.1.4.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</html>
