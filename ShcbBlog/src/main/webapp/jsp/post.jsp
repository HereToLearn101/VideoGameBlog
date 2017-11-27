<%-- 
    Document   : post
    Created on : Nov 5, 2017, 11:01:48 PM
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
        <title>Post</title>

        <script src="${pageContext.request.contextPath}/js/tinymce/tinymce.min.js"></script>
        <script type="text/javascript">
            tinymce.init({
                selector: 'textarea',
                language: 'en_GB',
                plugins: [ "placeholder" ,'image' ],
                directionality: 'ltr'
            });
        </script>
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/home.css">
    </head>
    <body>
        <%@include file="navigation.jsp" %>
        <div id="post-container" class="container" >
            <div id="blogBanner">
                <img src="${pageContext.request.contextPath}/img/blogBanner.png" width="100%">
            </div>
            <div id="post_page">
                <h1 class="green-text">New Post</h1>
                <hr>
                <c:if test="${not empty error}">
                    <div class="alert alert-warning">
                        ${error}
                    </div>
                </c:if>
                <form action="${pageContext.request.contextPath}/createPost" method="POST">
                    <div id="categories">
                        <h4 class="green-text">Categories</h4>
                        <select id="cat_select" name="categories" multiple required>
                            <c:forEach var="currentCat" items="${listOfCats}">
                                <c:choose>
                                    <c:when test="${catList.contains(currentCat)}">
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
                    <c:choose>
                        <c:when test="${not empty title}">
                            <input id="title-input" name="title" type="text" 
                                   class="form-control" placeholder="Title" 
                                   value="${title}" required>
                        </c:when>
                        <c:otherwise>
                            <input id="title-input" name="title" type="text" 
                                   class="form-control" placeholder="Title" required>
                        </c:otherwise>
                    </c:choose>
                    <h4 class="green-text">Image</h4>
                    <c:choose>
                        <c:when test="${not empty imageURL}">
                            <input id="image-input" name="image" type="text" 
                                   class="form-control" placeholder="Image URL" 
                                   value="${imageURL}" required>
                        </c:when>
                        <c:otherwise>
                            <input id="image-input" name="image" type="text" 
                                   class="form-control" placeholder="Image URL" required>
                        </c:otherwise>
                    </c:choose>
                    <textarea id="ti-tensity" name="post" class="form-control" rows="12" placeholder="Type content here...">
                        <c:if test="${not empty post}">
                            ${post}
                        </c:if>
                    </textarea>
                    <h4 class="green-text">Tags</h4>
                    
                    <c:choose>
                        <c:when test="${not empty tags}">
                            <input id="tags-input" name="tags" type="text" 
                                   class="form-control" 
                                   placeholder="For Multiple tags add a ',' between each tag (e.g. supermario1,sonic)"
                                   value="${tags}">
                        </c:when>
                        <c:otherwise>
                            <input id="tags-input" name="tags" type="text" 
                                   class="form-control" 
                                   placeholder="For Multiple tags add a ',' between each tag (e.g. supermario1,sonic)">
                        </c:otherwise>
                    </c:choose>
                    <sec:authorize access="hasRole('ROLE_ADMIN')">
                        <label class="green-text"><h4>Approve: </h4></label>
                        <select id="approve-select" name="approve">
                            <option value="true">True</option>
                            <option value="false" selected>False</option>
                        </select> <br>
                    </sec:authorize>
                    <button id="submit_post" type="submit" class="btn btn-success">Submit</button>
                </form>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-2.1.4.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    </body>
    <script src="https://code.jquery.com/jquery-2.1.4.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</html>
