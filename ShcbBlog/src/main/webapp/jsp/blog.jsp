<%-- 
    Document   : blog
    Created on : Nov 6, 2017, 8:47:09 PM
    Author     : tedis
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Blog</title>
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/home.css">
    </head>
    <body>
        <%@include file="navigation.jsp" %>
        <div class="container" style="padding-bottom: 15%;">
            <div id="blogBanner">
                <img src="${pageContext.request.contextPath}/img/blogBanner.png" width="100%">
            </div>
            <div class="row">
                <div class="col-lg-2"></div>
                <div class="col-lg-8">
                    <h1 class="title display-4 green-text">
                        <span>${post.title}</span></h1>
                    <p class="lead green-text">by 
                        <c:forEach var="currentAuthor" items="${post.authors}">
                                <c:out value="${currentAuthor.userName}"/>
                        </c:forEach>
                    </p>
                    <!-- Date/Time -->
                    <!--<p class="green-text">Posted on January 1, 2017 at 12:00 PM</p>-->
                    <div>
                        <p class="green-text" style="text-align: left;">Posted on ${date} 
                            <span class="green-text" style="float: right;">Category: 
                                <c:forEach var="currentCat" items="${post.categories}" varStatus="loop">
                                    ${currentCat.name}
                                    <c:if test="${!loop.last}">,</c:if>
                                </c:forEach>
                            </span>
                        </p>   
                    </div>
                    <hr>
                    <img id="image" class="img-fluid rounded" src="${post.headerImg}" alt="">
                    <hr>
                    <!-- Post Content -->
                    <!--                    <p class="green-text">Haxx0r ipsum epoch bang wombat tunnel in protected ascii semaphore data suitably small values cookie. Pwned James T. Kirk race condition continue salt blob memory leak float January 1, 1970 injection packet sniffer fatal infinite loop. Tera eof crack loop Donald Knuth fail it's a feature void fopen class d00dz ifdef cache flush syn throw.
                                            Mountain dew wombat continue worm it's a feature over clock Starcraft cat char protocol hash fopen alloc. Mailbomb January 1, 1970 less piggyback sql protected. Eof Linus Torvalds access injection unix system gc int interpreter frack packet terminal fatal cd python I'm compiling epoch headers tcp nak.
                                            Then Dennis Ritchie spoof grep semaphore int /dev/null injection flush James T. Kirk ban function. Worm double giga infinite loop rm -rf segfault cd. Packet sniffer I'm sorry Dave, I'm afraid I can't do that gcc Trojan horse.</p>-->
                    <div class="green-text">${post.htmlString}</div>
                    <hr>
                    <!-- Tags -->
                    <c:forEach var="currentTag" items="${post.tags}">
                        <span class="label label-success"><a href="${pageContext.request.contextPath}/displayPostsByTag?id=${currentTag.id}" style="color: white;"><c:out value="${currentTag.name}"/></a></span>
                        </c:forEach>
                    <!--<span class="label label-default"><a href="#">Tag</a></span> <span class="label label-default"><a href="#">Tag</a></span> <span class="label label-default"><a href="#">Tag</a></span>-->
                    <hr>
                    <!-- Comments Form -->
                    <div class="card my-4">
                        <h5 class="card-header green-text">Leave a Comment:</h5>
                        <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_CONTRIBUTOR', 'ROLE_USER')">
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/createComment" method="POST">
                                    <input type="hidden" name="id" value="${post.id}">
                                    <div class="form-group">
                                        <textarea class="form-control" rows="5" name="comment"></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-success">Submit</button>
                                </form>
                            </div>
                        </sec:authorize>
                        <sec:authorize access="isAnonymous()">
                            <div class="green-text">
                                <a href="${pageContext.request.contextPath}/login"><b>Login</b></a>
                                or 
                                <a href="${pageContext.request.contextPath}/signUp"><b>Sign Up</b></a>
                            </div>
                        </sec:authorize>
                    </div>
                    <!-- Comment -->
                    <div class="media">
                        <!-- <div class="media-left">
                                <img id="avatar" src="http://kodeinfo.com/admin_assets/assets/img/avatars/default-avatar.jpg" class="media-object">
                        </div> -->
                        <div class="media-body">
                            <c:forEach var="currentComment" items="${post.comments}">
                                <h4 class="media-heading green-text"><c:out value="${currentComment.user.userName}"/></h4>
                                <p class="green-text"><c:out value="${currentComment.body}"/></p>
                            </c:forEach>
                        </div>
                    </div>
                    <hr>
                </div>
                <div class="col-lg-2"></div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-2.1.4.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    </body>
    <script src="https://code.jquery.com/jquery-2.1.4.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</html>