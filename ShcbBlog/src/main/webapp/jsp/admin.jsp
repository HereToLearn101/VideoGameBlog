<%-- 
    Document   : admin
    Created on : Nov 9, 2017, 9:15:17 AM
    Author     : tedis
--%>
<div class="container" id="admin_container">
    <div id="blogBanner" class="col-md-12 col-sm-12">
        <a href="home.html"><img src="blogBanner.png" width="100%"></a>
    </div>
    <h1 class="green-text">Admin</h1>
    <hr>
    <div class="row">
        <div class="col-md-4 col-offset-1">
            <a href="${pageContext.request.contextPath}/users" class="btn btn-sq-lg btn-success admin_button">
                <br>
                <i class="fa fa-users fa-5x" aria-hidden="true"></i><br/>
                Users
            </a>
        </div>
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
    </div>
    <div class="row">
        <div class="col-md-4 col-offset-1">
            <a href="${pageContext.request.contextPath}/game" class="btn btn-sq-lg btn-success admin_button">
                <br>
                <i class="fa fa-gamepad fa-5x" aria-hidden="true"></i><br/>
                Create Game
            </a>
        </div>
        <div class="col-md-4 col-offset-1">
            <a href="${pageContext.request.contextPath}/admin/manage" class="btn btn-sq-lg btn-success admin_button">
                <br>
                <i class="fa fa-exclamation fa-5x" aria-hidden="true"></i><br/>
                Manage Posts
            </a>
        </div>
        <div class="col-md-4 col-offset-1"></div>
    </div>
</div>
