<%-- 
    Document   : contributor
    Created on : Nov 9, 2017, 9:15:26 AM
    Author     : tedis
--%>
<div class="container" id="admin_container">
    <div id="blogBanner" class="col-md-12 col-sm-12">
        <a href="home.html"><img src="blogBanner.png" width="100%"></a>
    </div>
    <h1 class="green-text">Contributor</h1>
    <hr>
    <div class="row">
        <div class="col-md-4 col-offset-1">
            <a href="${pageContext.request.contextPath}/create/post" class="btn btn-sq-lg btn-success admin_button">
                <br>
                <i class="fa fa-plus fa-5x" aria-hidden="true"></i><br/>
                Create Post
            </a>
        </div>
        <div class="col-md-4 col-offset-1">
            <a href="${pageContext.request.contextPath}/edit/posts" class="btn btn-sq-lg btn-success admin_button">
                <br>
                <i class="fa fa-pencil fa-5x" aria-hidden="true"></i><br/>
                Edit Post
            </a>
        </div>
        <div class="col-md-4 col-offset-1"></div>
    </div>
</div>
