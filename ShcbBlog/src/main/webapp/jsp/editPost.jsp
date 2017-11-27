<%-- 
    Document   : editPost
    Created on : Nov 8, 2017, 1:25:57 PM
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
        <title>Edit Post</title>
        <script src="${pageContext.request.contextPath}/js/tinymce/tinymce.min.js"></script>
        <script type="text/javascript">
            tinymce.init({
                selector: 'textarea',
                language: 'en_GB',
                plugins: 'image',
                directionality: 'ltr'
            });
        </script>      
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
                <h1 class="green-text">Edit Post</h1>
                <hr>
                <c:if test="${not empty error}">
                    <div class="alert alert-warning">
                        ${error}
                    </div>
                </c:if>
                <form action="${pageContext.request.contextPath}/editPost" method="POST">
                    <div id="categories">
                        <h4 class="green-text">Categories</h4>

                        <select id="cat_select" name="categories" multiple required>
                            <c:forEach var="currentCat" items="${listOfCats}">
                                <c:choose>
                                    <c:when test="${cats.contains(currentCat)}">
                                        <option value="${currentCat.id}"
                                                selected="selected">${currentCat.name}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${currentCat.id}">${currentCat.name}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select>
                    </div>
                    <h4 class="green-text">Title</h4>
                    <input id="title-input" name="title" type="text" 
                           class="form-control" placeholder="Title" value="${title}" required/>

                    <h4 class="green-text">Image</h4>
                    <input id="image-input" name="image" type="text" 
                           class="form-control" placeholder="Image URL" 
                           value="${image}"/>
                    <textarea id="ti-tensity" name="post" class="form-control" 
                              rows="12" placeholder="Type content here...">
                        ${content}
                    </textarea>
                    <h4 class="green-text">Tags</h4>
                    <input id="tags-input" name="tags" type="text" 
                           class="form-control" value="${tags}" 
                           placeholder="For Multiple tags add a ',' between each tag (e.g. supermario1,sonic)">
                    
                    <sec:authorize access="hasRole('ROLE_ADMIN')">
                        <label class="green-text"><h4>Approve: </h4></label>
                        <select id="approve-select" name="approve">
                            <option value="true">True</option>
                            <option value="false" selected>False</option>
                        </select> <br>
                    </sec:authorize>
                    <input type="hidden" name="id" value="${id}"/>
                    <div>
                        <button id="submit_post" type="submit" class="btn btn-success">Submit</button>
                        <a href="${pageContext.request.contextPath}/edit/posts">
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
