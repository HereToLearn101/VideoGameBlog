<%-- 
    Document   : users
    Created on : Nov 8, 2017, 3:04:45 PM
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
        <title>Users</title>

        <script src="https://use.fontawesome.com/29e07f4330.js"></script>
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/home.css">
    </head>
    <body>
        <%@include file="navigation.jsp" %>
        <div id="users_container" class="container" style="padding-bottom: 15%;">
            <div id="blogBanner" class="col-md-12 col-sm-12">
                <a href="home.html">
                    <img src="blogBanner.png" width="100%">
                </a>
            </div>
            <h1 class="green-text">Users</h1>
            <hr>
            <div class="well well-sm">
                <table class="table">
                    <thead>
                        <tr>
                            <th> User Name</th>
                            <th> Status</th>
                            <th> Confirm?</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="currentUser" items="${listOfUsers}">
                        <form action="${pageContext.request.contextPath}/editUser" method="POST">
                            <tr>
                            <input type="hidden" name="id" value="${currentUser.id}"/>
                            <td>${currentUser.userName}</td>
                            <td>
                                <label>Enable: </label>
                                <c:choose>
                                    <c:when test="${currentUser.isEnabled}">
                                        <input name="enable" type="radio" value="true" checked/> Yes
                                        <input name="enable" type="radio" value="false"/> No
                                    </c:when>
                                    <c:when test="${currentUser.isEnabled == false}">
                                        <input name="enable" type="radio" value="true"/> Yes
                                        <input name="enable" type="radio" value="false" checked/> No
                                    </c:when>
                                    <c:otherwise>
                                        <input name="enable" type="radio" value="true"/> Yes
                                        <input name="enable" type="radio" value="false"/> No
                                    </c:otherwise>
                                </c:choose>
                                <br>
                                <c:set var="user" value="false"/>
                                <c:set var="contributor" value="false"/>
                                <c:set var="admin" value="false"/>
                                <c:forEach var="currentAuthority" items="${currentUser.authorities}">
                                    <c:if test="${currentAuthority == 'ROLE_USER'}">
                                        <c:set var="user" value="true"/>
                                    </c:if>
                                    <c:if test="${currentAuthority == 'ROLE_CONTRIBUTOR'}">
                                        <c:set var="contributor" value="true"/>
                                    </c:if>
                                    <c:if test="${currentAuthority == 'ROLE_ADMIN'}">
                                        <c:set var="admin" value="true"/>
                                    </c:if>
                                </c:forEach>

                                <c:choose>
                                    <c:when test="${user == true}">
                                        <label>
                                            <input name="authorization" type="checkbox" value="ROLE_USER" checked> User
                                        </label>
                                    </c:when>
                                    <c:otherwise>
                                        <label>
                                            <input name="authorization" type="checkbox" value="ROLE_USER"> User
                                        </label>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${contributor == true}">
                                        <label>
                                            <input name="authorization" type="checkbox" value="ROLE_CONTRIBUTOR" checked> Contributor
                                        </label>
                                    </c:when>
                                    <c:otherwise>
                                        <label>
                                            <input name="authorization" type="checkbox" value="ROLE_CONTRIBUTOR"> Contributor
                                        </label>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${admin == true}">
                                        <label>
                                            <input name="authorization" type="checkbox" value="ROLE_ADMIN" checked> Admin
                                        </label>
                                    </c:when>
                                    <c:otherwise>
                                        <label>
                                            <input name="authorization" type="checkbox" value="ROLE_ADMIN"> Admin
                                        </label>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <button class="btn btn-success" type="submit">Make Changes</button>
                            </td>
                            <td>
                                <span onclick="addDeleteButton(${currentUser.id})">
                                <a href="#myModal" data-toggle="modal" data-target="#myModal">
                                    <i class="fa fa-times" aria-hidden="true"></i>
                                </a>
                                </span>
                            </td>
                            </tr>
                        </form>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h3 id="myModalLabel" class="green-text">Delete Confirmation</h3>
                    </div>
                    <div class="modal-body">
                        <p class="error-text green-text">Are you sure you want to delete the user?</p>
                    </div>
                    <div class="modal-footer">
                        <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
                        <span id="deleteButtonDiv">
                            <!-- This is a spot for the delete button created from users.js specified for the user -->
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-2.1.4.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/users.js"></script>
    </body>
    <script src="https://code.jquery.com/jquery-2.1.4.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</html>
