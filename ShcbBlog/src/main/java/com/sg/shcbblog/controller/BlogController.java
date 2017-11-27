/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sg.shcbblog.controller;

import com.sg.shcbblog.model.Authority;
import com.sg.shcbblog.model.Category;
import com.sg.shcbblog.model.Comment;
import com.sg.shcbblog.model.Game;
import com.sg.shcbblog.model.Post;
import com.sg.shcbblog.model.PostStatus;
import com.sg.shcbblog.model.Tag;
import com.sg.shcbblog.model.User;
import com.sg.shcbblog.model.Year;
import com.sg.shcbblog.service.BlogService;
import com.sg.shcbblog.service.MisMatchPasswordException;
import com.sg.shcbblog.service.UserNameExistsException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author tedis
 */
@Controller
public class BlogController {

    private BlogService service;

    @Inject
    public BlogController(BlogService service) {
        this.service = service;
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String displayHomePage(Model model) {
        // list of posts
        List<Post> listOfPosts = service.acquireAllPostsApproved();
        // list of categories
        List<Category> listOfCats = service.acquireAllCategories();

        model.addAttribute("listOfPosts", listOfPosts);
        model.addAttribute("listOfCats", listOfCats);

        return "home";
    }

    // part of handler mapping
    @RequestMapping(value = "/timeLine", method = RequestMethod.GET)
    public String displayTimeLinePage(Model model) {
        List<Game> allGames = service.acquireAllGames();
        List<Year> years = new ArrayList<>();
        for (Game game : allGames) {
            boolean notExists = false;
            for (Year year : years) {
                if (year.getYear() == game.getReleaseDate().getYear()) {
                    notExists = true;
                }
            }

            if (!notExists) {
                Year newYear = new Year();
                newYear.setYear(game.getReleaseDate().getYear());
                years.add(newYear);
            }
        }

        for (Year year : years) {
            List<Game> gamesOfYear = new ArrayList<>();
            for (Game game : allGames) {
                if (game.getReleaseDate().getYear() == year.getYear()) {
                    gamesOfYear.add(game);
                }
            }
            year.setGames(gamesOfYear);
        }

        List<Category> listOfCats = service.acquireAllCategories();

        Collections.sort(years, Collections.reverseOrder(new CustomComparator()));

        model.addAttribute("years", years);
        model.addAttribute("listOfCats", listOfCats);

        return "timeLine";
    }

    @RequestMapping(value = "/signUp", method = RequestMethod.GET)
    public String displaySignUpPage(Model model) {
        List<Category> listOfCats = service.acquireAllCategories();

        model.addAttribute("listOfCats", listOfCats);

        return "signUp";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String displayLoginPage(Model model) {
        List<Category> listOfCats = service.acquireAllCategories();

        model.addAttribute("listOfCats", listOfCats);

        return "login";
    }

    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
    public String displayAdminPage(Model model) {
        List<Category> listOfCats = service.acquireAllCategories();

        model.addAttribute("listOfCats", listOfCats);

        return "dashboard";
    }

    @RequestMapping(value = "/admin/manage", method = RequestMethod.GET)
    public String displayManagePostPage(Model model) {
        List<Category> listOfCats = service.acquireAllCategories();
        List<Post> posts = service.acquireAllPostsByPending();

        model.addAttribute("listOfCats", listOfCats);
        model.addAttribute("cat", "Pending Posts");
        model.addAttribute("posts", posts);

        return "managePost";
    }

    @RequestMapping(value = "/editPostApproval", method = RequestMethod.POST)
    public String editPostApproval(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        String approve = request.getParameter("approve");
        Post currentPost = service.acquirePostById(id);

        if (approve == null) {
            currentPost.setStatus(PostStatus.UNAPPROVED);
        } else if (approve.equals("true")) {        
            currentPost.setStatus(PostStatus.APPROVED);
        } else {
            return "redirect:/admin/manage";
        }
        
        service.editPost(currentPost);

        return "redirect:/admin/manage";
    }

    @RequestMapping(value = "/admin/manage/status", method = RequestMethod.GET)
    public String acquirePendingPostsByStatus(HttpServletRequest request, Model model) {
        String status = request.getParameter("status");
        List<Category> listOfCats = service.acquireAllCategories();
        
        List<Post> posts = new ArrayList<>();
        if (status.equals("approved")) {
            posts = service.acquireAllPostsApproved();
            model.addAttribute("cat", "Approved Posts");
        } else {
            posts = service.acquireAllPostsDisapproved();
            model.addAttribute("cat", "UnApproved Posts");
        }

        model.addAttribute("listOfCats", listOfCats);
        model.addAttribute("posts", posts);

        return "managePost";
    }

    @RequestMapping(value = "/displayPostsByCategory", method = RequestMethod.GET)
    public String displayPostsByCategory(HttpServletRequest request, Model model) {
        int id = Integer.parseInt(request.getParameter("id"));

        Category cat = service.acquireCategoryById(id);
        List<Post> listOfPosts = service.acquireAllPostsByCategoryApproved(id);
        List<Category> listOfCats = service.acquireAllCategories();

        model.addAttribute("listOfPosts", listOfPosts);
        model.addAttribute("listOfCats", listOfCats);
        model.addAttribute("typeOfPosts", cat.getName());

        return "home";
    }

    @RequestMapping(value = "/displayPostsByTag", method = RequestMethod.GET)
    public String displayPostsByTag(HttpServletRequest request, Model model) {
        int id = Integer.parseInt(request.getParameter("id"));

        Tag tag = service.acquireTagById(id);
        List<Post> listOfPosts = service.acquireAllPostsByTag(id);
        List<Category> listOfCats = service.acquireAllCategories();

        model.addAttribute("listOfPosts", listOfPosts);
        model.addAttribute("listOfCats", listOfCats);
        model.addAttribute("typeOfPosts", tag.getName());

        return "home";
    }

    @RequestMapping(value = "/blog", method = RequestMethod.GET)
    public String displayBlogPage(HttpServletRequest request, Model model) {
        int id = Integer.parseInt(request.getParameter("id"));
        Post post = service.acquirePostById(id);
        LocalDateTime date = post.getPublishDate();
        List<Category> listOfCats = service.acquireAllCategories();

        model.addAttribute("post", post);
        model.addAttribute("listOfCats", listOfCats);
        model.addAttribute("date", date);

        return "blog";
    }

    @RequestMapping(value = "/create/post", method = RequestMethod.GET)
    public String displayCreatePostPage(Model model) {
        List<Category> listOfCats = service.acquireAllCategories();
        List<User> listOfAuthors = service.acquireAllUsers();

        model.addAttribute("listOfCats", listOfCats);
        model.addAttribute("listOfAuthors", listOfAuthors);

        return "post";
    }

    @RequestMapping(value = "/editPostPage", method = RequestMethod.GET)
    public String displayEditPostPage(HttpServletRequest request, Model model) {
        int id = Integer.parseInt(request.getParameter("id"));
        List<Category> listOfCats = service.acquireAllCategories();
        List<User> listOfAuthors = service.acquireAllUsers();

        model.addAttribute("listOfCats", listOfCats);
        model.addAttribute("listOfAuthors", listOfAuthors);

        Post post = service.acquirePostById(id);

        model.addAttribute("id", id);
        model.addAttribute("title", post.getTitle());
        model.addAttribute("content", post.getHtmlString());
        model.addAttribute("image", post.getHeaderImg());

        String tagsStr = "";
        int i = 0;
        for (Tag tag : post.getTags()) {
            i++;
            if (i != post.getTags().size()) {
                tagsStr += tag.getName() + ",";
            } else {
                tagsStr += tag.getName();
            }
        }

        model.addAttribute("tags", tagsStr);
        model.addAttribute("cats", post.getCategories());

        return "editPost";
    }

    @RequestMapping(value = "/edit/posts", method = RequestMethod.GET)
    public String displayEditPostsListPage(HttpServletRequest request, Model model) {
        String userName = request.getUserPrincipal().getName();
        List<Category> listOfCats = service.acquireAllCategories();

        User user = service.acquireUserByUsername(userName);
        List<Post> listOfPosts = service.acquireAllPostsByUser(user);

        model.addAttribute("listOfCats", listOfCats);
        model.addAttribute("listOfPosts", listOfPosts);
        model.addAttribute("cat", "All");

        return "editPosts";
    }

    @RequestMapping(value = "/edit/posts/cat", method = RequestMethod.GET)
    public String displayPostsToEditByCat(HttpServletRequest request, Model model) {
        String userName = request.getUserPrincipal().getName();
        int catId = Integer.parseInt(request.getParameter("id"));

        Category cat = service.acquireCategoryById(catId);
        User user = service.acquireUserByUsername(userName);
        List<Post> posts = service.acquireAllPostsByUser(user);
        List<Category> listOfCats = service.acquireAllCategories();

        List<Post> listOfPosts = new ArrayList<>();
        for (Post post : posts) {
            if (post.getCategories().contains(cat)) {
                listOfPosts.add(post);
            }
        }

        model.addAttribute("listOfCats", listOfCats);
        model.addAttribute("listOfPosts", listOfPosts);
        model.addAttribute("cat", cat.getName());

        return "editPosts";
    }

    @RequestMapping(value = "/createPost", method = RequestMethod.POST)
    public String createPost(HttpServletRequest request, Model model) {

        List<Category> listOfCats = service.acquireAllCategories();

        Boolean isApprove = false;
        String userName = "";
        String title = "";
        String imageURL = "";
        String post = "";
        List<Category> catList = new ArrayList<>();
        String tags = request.getParameter("tags").trim();

        try {
            isApprove = Boolean.parseBoolean(request.getParameter("approve"));
            String[] catIds = request.getParameterValues("categories");
            for (String catIdString : catIds) {
                int catId = Integer.parseInt(catIdString);
                catList.add(service.acquireCategoryById(catId));
            }
            userName = request.getUserPrincipal().getName();
            title = request.getParameter("title");
            imageURL = request.getParameter("image");
            post = request.getParameter("post");
            if (userName.isEmpty() || title.isEmpty() || imageURL.isEmpty()
                    || post.isEmpty() || catList.isEmpty()) {
                if (!post.isEmpty()) {
                    model.addAttribute("post", post);
                }
                if (!title.isEmpty()) {
                    model.addAttribute("title", title);
                }
                if (!imageURL.isEmpty()) {
                    model.addAttribute("imageURL", imageURL);
                }
                if (!tags.isEmpty()) {
                    model.addAttribute("tags", tags);
                }
                model.addAttribute("listOfCats", listOfCats);
                model.addAttribute("catList", catList);
                model.addAttribute("error", "Fields cannot be empty.");
                return "post";
            }
        } catch (NullPointerException ex) {
            model.addAttribute("listOfCats", listOfCats);
            model.addAttribute("error", "Fields cannot be null.");
            return "post";
        }
        List<String> tagStringList = Arrays.asList(tags.split(","));
        List<Tag> tagList = new ArrayList<>();

        for (String tagString : tagStringList) {
            Tag tag = new Tag();
            tag.setName(tagString);
            tagList.add(tag);
        }

        List<User> userList = new ArrayList<>();
        User user = service.acquireUserByUsername(userName);
        userList.add(user);

        LocalDateTime publishDate = LocalDateTime.now();
        Post newPost = new Post();
        newPost.setHtmlString(post);
        newPost.setTitle(title);
        newPost.setHeaderImg(imageURL);
        newPost.setPublishDate(publishDate);
        
        if (isApprove) {
            newPost.setStatus(PostStatus.APPROVED);
        } else {
            newPost.setStatus(PostStatus.PENDING);
        }
        
        newPost.setTags(tagList);
        newPost.setCategories(catList);
        newPost.setAuthors(userList);

        service.createPost(newPost);

        return "redirect:/create/post";
    }

    @RequestMapping(value = "/editPost", method = RequestMethod.POST)
    public String editPost(HttpServletRequest request, Model model) {

        List<Category> listOfCats = service.acquireAllCategories();
        String title = "";
        String imageURL = "";
        String post = "";
        String tags = request.getParameter("tags").trim();
        List<Category> catList = new ArrayList<>();

        Boolean isApprove = Boolean.parseBoolean(request.getParameter("approve"));

        int id = -1;

        try {
            String stringId = request.getParameter("id");
            id = Integer.parseInt(stringId);

            isApprove = Boolean.parseBoolean(request.getParameter("approve"));
            String[] catIds = request.getParameterValues("categories");
            for (String catIdString : catIds) {
                int catId = Integer.parseInt(catIdString);
                catList.add(service.acquireCategoryById(catId));
            }
            title = request.getParameter("title");
            imageURL = request.getParameter("image");
            post = request.getParameter("post");
            if (title.isEmpty() || imageURL.isEmpty()
                    || post.isEmpty() || catList.isEmpty()) {
                if (!post.isEmpty()) {
                    model.addAttribute("content", post);
                }
                if (!title.isEmpty()) {
                    model.addAttribute("title", title);
                }
                if (!imageURL.isEmpty()) {
                    model.addAttribute("image", imageURL);
                }
                if (!tags.isEmpty()) {
                    model.addAttribute("tags", tags);
                }
                model.addAttribute("listOfCats", listOfCats);
                model.addAttribute("cats", catList);
                model.addAttribute("error", "Fields cannot be empty.");
                return "editPost";
            }
        } catch (NullPointerException ex) {
            model.addAttribute("listOfCats", listOfCats);
            model.addAttribute("error", "Fields cannot be null.");
            return "editPost";
        } catch (NumberFormatException ex) {
            model.addAttribute("listOfCats", listOfCats);
            model.addAttribute("error", "Unable to edit post.");
            return "editPost";
        }

        List<String> tagStringList = Arrays.asList(tags.split(","));
        List<Tag> tagList = new ArrayList<>();

        for (String tagString : tagStringList) {
            Tag tag = new Tag();
            tag.setName(tagString);
            tagList.add(tag);
        }

        Post editPost = service.acquirePostById(id);
        editPost.setTitle(title);
        editPost.setHeaderImg(imageURL);
        editPost.setHtmlString(post);
        editPost.setCategories(catList);
        
        if (isApprove) {
            editPost.setStatus(PostStatus.APPROVED);
        } else {
            editPost.setStatus(PostStatus.PENDING);
        }
        
        editPost.setTags(tagList);

        service.editPost(editPost);

        return "redirect:/edit/posts";
    }

    @RequestMapping(value = "/createComment", method = RequestMethod.POST)
    public String createComment(HttpServletRequest request, Model model) {
        int id = Integer.parseInt(request.getParameter("id"));
        String comment = request.getParameter("comment");
        String userName = request.getUserPrincipal().getName();
        User user = service.acquireUserByUsername(userName);
        //User user = service.acquireUserById();
        LocalDateTime date = LocalDateTime.now();

        Comment newComment = new Comment();
        newComment.setBody(comment);
        newComment.setUser(user);
        newComment.setTime(date);

        service.createComment(newComment, id);

        Post post = service.acquirePostById(id);
        List<Category> listOfCats = service.acquireAllCategories();

        model.addAttribute("post", post);
        model.addAttribute("listOfCats", listOfCats);

        return "blog";
    }

    //**************************FOR USERS AND USERS PAGE*****************************************
    @RequestMapping(value = "/users", method = RequestMethod.GET)
    public String displayUsersPage(Model model) {
        List<Category> listOfCats = service.acquireAllCategories();
        List<User> listOfUsers = service.acquireAllUsers();

        model.addAttribute("listOfCats", listOfCats);
        model.addAttribute("listOfUsers", listOfUsers);

        return "users";
    }

    @RequestMapping(value = "/createUser", method = RequestMethod.POST)
    public String createUser(HttpServletRequest request, Model model) {
        String userName = request.getParameter("newUsername");
        String pass = request.getParameter("newPass");
        String reTypedPass = request.getParameter("reTypedNewPass");

        // if given null values then resend user back to the same where they were
        // on, which in this case is the sign up page.
        if ((userName == null) || (pass == null) || (reTypedPass == null)) {

            return "signUp";
        }

        try {
            service.checkForMisMatchPasswords(pass, reTypedPass);
        } catch (MisMatchPasswordException e) {
            model.addAttribute("userName", userName);
            model.addAttribute("pass", pass);
            model.addAttribute("reTypedPass", reTypedPass);
            model.addAttribute("passError", e.getMessage());

            return "signUp";
        }

        User newUser = new User();
        newUser.setUserName(userName);
        newUser.setUserPassword(pass);
        newUser.setIsEnabled(true);
        newUser.setAuthorities(new ArrayList<Authority>(Arrays.asList(Authority.ROLE_USER)));

        try {
            service.createUser(newUser);
        } catch (UserNameExistsException e) {
            model.addAttribute("userName", userName);
            model.addAttribute("pass", pass);
            model.addAttribute("reTypedPass", reTypedPass);
            model.addAttribute("error", e.getMessage());

            return "signUp";
        }

        return "redirect:/login";
    }

    @RequestMapping(value = "/editUser", method = RequestMethod.POST)
    public String editUser(HttpServletRequest request, Model model) {
        int id = Integer.parseInt(request.getParameter("id"));
        Boolean isEnabled = Boolean.parseBoolean(request.getParameter("enable"));
        String[] authorities = request.getParameterValues("authorization");

        List<Authority> newAuthorities = new ArrayList<>();

        if (authorities != null) {
            if (Arrays.asList(authorities).contains("ROLE_USER")) {
                newAuthorities.add(Authority.ROLE_USER);
            }

            if (Arrays.asList(authorities).contains("ROLE_CONTRIBUTOR")) {
                newAuthorities.add(Authority.ROLE_CONTRIBUTOR);
            }

            if (Arrays.asList(authorities).contains("ROLE_ADMIN")) {
                newAuthorities.add(Authority.ROLE_ADMIN);
            }
        }

        User currentUser = service.acquireUserById(id);
        currentUser.setIsEnabled(isEnabled);
        currentUser.setAuthorities(newAuthorities);

        service.editUser(currentUser);

        return "redirect:/users";
    }

    @RequestMapping(value = "/deleteUser", method = RequestMethod.GET)
    public String deleteUser(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        service.deleteUser(id);

        return "redirect:/users";
    }
    //*****************************************************************************************

    //*******************************FOR GAMES AND GAMES PAGE***********************************
    @RequestMapping(value = "/game", method = RequestMethod.GET)
    public String displayCreateGamePage(Model model) {
        List<Category> listOfCats = service.acquireAllCategories();

        model.addAttribute("listOfCats", listOfCats);

        return "game";
    }

    @RequestMapping(value = "/createGame", method = RequestMethod.POST)
    public String createGame(HttpServletRequest request, Model model) {
        String gameName = request.getParameter("gameName");
        String relDate = request.getParameter("releaseDate");

        if (gameName.isEmpty() || relDate.isEmpty()) {

            if (gameName.isEmpty()) {
                model.addAttribute("name", "error");
            } else {
                model.addAttribute("name", gameName);
            }

            if (relDate.isEmpty()) {
                model.addAttribute("date", "error");
            } else {
                model.addAttribute("date", relDate);
            }

            model.addAttribute("error", "Fields cannot be empty!");

            return "game";
        }

        LocalDate date;

        try {
            date = LocalDate.parse(relDate);
        } catch (DateTimeParseException e) {
            model.addAttribute("name", gameName);
            model.addAttribute("date", relDate);
            model.addAttribute("dateError", "Date wrong format!");

            return "game";
        }

        Game newGame = new Game();
        newGame.setName(gameName);
        newGame.setReleaseDate(date);

        service.createGame(newGame);

        return "redirect:/dashboard";
    }

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public String searchByTitleOrKeyword(HttpServletRequest request, Model model) {
        String titleOrKeyword = request.getParameter("search");

        List<Post> listOfPosts = service.acquirePostsByTitleOrKeyword(titleOrKeyword);
        List<Category> listOfCats = service.acquireAllCategories();

        if (listOfPosts.size() == 0) {
            model.addAttribute("error", "Checking");
            model.addAttribute("listOfCats", listOfCats);

            return "home";
        }

        model.addAttribute("listOfPosts", listOfPosts);
        model.addAttribute("listOfCats", listOfCats);

        return "home";
    }

//    @RequestMapping(value = "/login", method = RequestMethod.POST)
//    public String loginUser(HttpServletRequest request) {
//        String userName = request.getParameter("newUsername");
//        String pass = request.getParameter("newPass");
//
//        return "redirect:/";
//    }
    public class CustomComparator implements Comparator<Year> {

        @Override
        public int compare(Year o1, Year o2) {
            return o1.getYear().compareTo(o2.getYear());
        }
    }
}
