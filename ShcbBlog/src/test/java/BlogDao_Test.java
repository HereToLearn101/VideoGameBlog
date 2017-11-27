/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import com.sg.shcbblog.dao.BlogDao;
import com.sg.shcbblog.model.Authority;
import com.sg.shcbblog.model.Tag;
import com.sg.shcbblog.model.Category;
import com.sg.shcbblog.model.Comment;
import com.sg.shcbblog.model.Game;
import com.sg.shcbblog.model.Post;
import com.sg.shcbblog.model.PostStatus;
import com.sg.shcbblog.model.User;
import com.sg.shcbblog.service.UserNameExistsException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Assert;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 *
 * @author jared
 */
public class BlogDao_Test {

    private BlogDao dao;
    private Tag tag1 = new Tag();
    private Tag tag2 = new Tag();
    private Tag tag3 = new Tag();
    private Category cat1 = new Category();
    private Category cat2 = new Category();
    private Category cat3 = new Category();
    private Post post1 = new Post();
    private Post post2 = new Post();
    private Game game1 = new Game();
    private Game game2 = new Game();
    private User user1 = new User();
    private User user2 = new User();
    private Comment com1 = new Comment();
    private Comment com2 = new Comment();
    private Comment com3 = new Comment();
    private Authority authUser = Authority.ROLE_USER;
    private Authority authCont = Authority.ROLE_CONTRIBUTOR;
    private Authority authAdmin = Authority.ROLE_ADMIN;
    private PostStatus pending = PostStatus.PENDING;
    private PostStatus approved = PostStatus.APPROVED;
    private PostStatus unapproved = PostStatus.UNAPPROVED;

    public BlogDao_Test() {
        ApplicationContext ctx = new ClassPathXmlApplicationContext(
                "test-applicationContext.xml");
        dao = ctx.getBean("dao", BlogDao.class);
    }

    @BeforeClass
    public static void setUpClass() {
    }

    @AfterClass
    public static void tearDownClass() {
    }

    @Before
    public void setUp() {
        // REMOVE FROM EXISTING DATABASE
        List<Post> posts = dao.getAllPosts();
        for (Post post : posts) {
            dao.removePost(post);
        }

        List<Tag> tags = dao.getAllTags();
        for (Tag tag : tags) {
            dao.removeTag(tag);
        }

        List<Category> cats = dao.getAllCategories();
        for (Category cat : cats) {
            dao.removeCategory(cat);
        }

        List<Game> games = dao.getAllGames();
        for (Game game : games) {
            dao.removeGame(game);
        }

        List<User> users = dao.getAllUsers();
        for (User user : users) {
            dao.removeUser(user);
        }

        List<Comment> comments = dao.getAllComments();
        for (Comment com : comments) {
            dao.removeComment(com);
        }

        // ADD TO DATABASE
        tag1.setId(1);
        tag1.setName("Tag1");
        dao.createTag(tag1);
        tag2.setId(2);
        tag2.setName("Tag2");
        dao.createTag(tag2);
        tag3.setId(3);
        tag3.setName("Tag3");
        dao.createTag(tag3);

        cat1.setId(1);
        cat1.setName("Category 1");
        dao.createCategory(cat1);
        cat2.setId(2);
        cat2.setName("Category 2");
        dao.createCategory(cat2);
        cat3.setId(3);
        cat3.setName("Category 3");
        dao.createCategory(cat3);

        post1.setId(1);
        post1.setTitle("Post 1");
        post1.setHeaderImg("www.google.com/really-cool-image");
        post1.setHtmlString("<h1>Long String</h1><p>paragraph</p>");

        List<Tag> post1Tags = new ArrayList<>();
        post1Tags.add(tag2);
        post1.setTags(post1Tags);

        List<Category> post1Cats = new ArrayList<>();
        post1Cats.add(cat1);
        post1Cats.add(cat2);
        post1.setCategories(post1Cats);

        LocalDateTime time1 = LocalDateTime.parse("2017-08-07T11:20:00");
        post1.setPublishDate(time1);
        
        post1.setStatus(pending);

        user1.setId(1);
        user1.setUserName("testUser1");
        user1.setUserPassword("testUserPass1");
        user1.setIsEnabled(Boolean.TRUE);
        List<Authority> user1Auths = new ArrayList<>();
        user1Auths.add(authUser);
        user1.setAuthorities(user1Auths);
        

        user2.setId(2);
        user2.setUserName("testUser2");
        user2.setUserPassword("testUserPass2");
        user2.setIsEnabled(Boolean.FALSE);
        List<Authority> user2Auths = new ArrayList<>();
        user2Auths.add(authUser);
        user2Auths.add(authCont);
        user2Auths.add(authAdmin);
        user2.setAuthorities(user2Auths);
        
        try {
            dao.createUser(user1);
            dao.createUser(user2);
        } catch (UserNameExistsException ex) {
            System.out.println("Attempted to add Duplicate username.");
        }

        List<User> post1Authors = new ArrayList<>();
        post1Authors.add(user1);
        post1.setAuthors(post1Authors);

        dao.createPost(post1);

        post2.setId(2);
        post2.setTitle("Post 2");
        post2.setHeaderImg("www.google.com/post-2-image");
        post2.setHtmlString("<h1>Long String</h1><p>paragraph</p>");

        List<Tag> post2Tags = new ArrayList<>();
        post2Tags.add(tag2);
        post2Tags.add(tag3);
        post2.setTags(post2Tags);

        List<Category> post2Cats = new ArrayList<>();
        post2Cats.add(cat2);
        post2.setCategories(post2Cats);

        LocalDateTime time2 = LocalDateTime.parse("2017-05-21T16:20:00");
        post2.setPublishDate(time2);
        
        post2.setStatus(approved);

        List<User> post2Authors = new ArrayList<>();
        post2Authors.add(user2);
        post2.setAuthors(post2Authors);

        dao.createPost(post2);

        game1.setId(1);
        game1.setName("Test Game 1");
        game1.setReleaseDate(LocalDate.parse("1989-02-06"));
        dao.createGame(game1);
        game2.setId(2);
        game2.setName("Test Game 2");
        game2.setReleaseDate(LocalDate.parse("1990-04-21"));
        dao.createGame(game2);

        com1.setId(1);
        com1.setBody("This is great!");
        com1.setUser(user1);
        com1.setTime(LocalDateTime.parse("2017-09-19T11:11:11"));
        dao.createComment(com1, post1.getId());
        com2.setId(1);
        com2.setBody("This is awful!");
        com2.setUser(user2);
        com2.setTime(LocalDateTime.parse("2017-11-19T11:11:11"));
        dao.createComment(com2, post1.getId());
        com3.setId(1);
        com3.setBody("This is okay.");
        com3.setUser(user2);
        com3.setTime(LocalDateTime.parse("2017-08-21T09:00:00"));
        dao.createComment(com3, post2.getId());

        List<Comment> post1Comments = new ArrayList<>();
        post1Comments.add(com2);
        post1Comments.add(com1);
        post1.setComments(post1Comments);

        List<Comment> post2Comments = new ArrayList<>();
        post2Comments.add(com3);
        post2.setComments(post2Comments);

        
        
    }

    @After
    public void tearDown() {

    }

    /*
        QUERIES
     */
    @Test
    public void getMostUsedTags() {
        Assert.assertEquals(0, dao.getMostUsedTags(-3).size());
        Assert.assertEquals(0, dao.getMostUsedTags(0).size());
        Assert.assertEquals(1, dao.getMostUsedTags(1).size());
        Assert.assertEquals(2, dao.getMostUsedTags(2).size());
        Assert.assertEquals(2, dao.getMostUsedTags(5).size());
    }

    @Test
    public void getPostByTitle() {
        Assert.assertEquals(post1, dao.getPostByTitle("Post 1"));
        Assert.assertEquals(null, dao.getPostByTitle("Fake Post"));
    }

    @Test
    public void getPostsByTag() {
        List<Post> tag1Posts = dao.getPostsByTag(tag1);
        List<Post> tag2Posts = dao.getPostsByTag(tag2);
        List<Post> tag3Posts = dao.getPostsByTag(tag3);
        Assert.assertEquals(0, tag1Posts.size());
        Assert.assertEquals(2, tag2Posts.size());
        Assert.assertEquals(1, tag3Posts.size());
    }

    @Test
    public void getPostsByCategory() {
        List<Post> postsCat1 = dao.getPostsByCategory(cat1);
        List<Post> postsCat2 = dao.getPostsByCategory(cat2);
        List<Post> postsCat3 = dao.getPostsByCategory(cat3);
        Assert.assertEquals(1, postsCat1.size());
        Assert.assertEquals(2, postsCat2.size());
        Assert.assertEquals(0, postsCat3.size());
    }
    
//    @Test
//    public void getPostsByCategoryAndStatus() {
////        List<Post> postsCat1 = dao.getPostsByCategory(cat1);
//        List<Post> postsCat2Appr = dao.getPostsByCategory(cat2, approved);
//        List<Post> postsCat2Pend = dao.getPostsByCategory(cat2, pending);
//        Assert.assertEquals(1, postsCat2Appr.size());
//        Assert.assertEquals(1, postsCat2Pend.size());
//    }

    @Test
    public void getPostsByAuthor() {
        List<Post> postsAuth1 = dao.getPostsByAuthor(user1);
        List<Post> postsAuth2 = dao.getPostsByAuthor(user2);
        Assert.assertEquals(1, postsAuth1.size());
        Assert.assertEquals(1, postsAuth2.size());
    }

    @Test
    public void getUsersByAuthority() {
        List<User> userUsers = dao.getUsersByAuthority(authUser);
        List<User> contUsers = dao.getUsersByAuthority(authCont);
        List<User> adminUsers = dao.getUsersByAuthority(authAdmin);
        Assert.assertEquals(2, userUsers.size());
        Assert.assertEquals(1, contUsers.size());
        Assert.assertEquals(1, adminUsers.size());
    }

    @Test
    public void getPostsByApproval() {
        List<Post> approvedPosts = dao.getAllPosts(approved);
        List<Post> notApprovedPosts = dao.getAllPosts(unapproved);
        List<Post> pendingPosts = dao.getAllPosts(pending);
        Post approvedPost = approvedPosts.get(0);
        Post notApprovedPost = approvedPosts.get(0);
        Assert.assertEquals(1, approvedPosts.size());
        Assert.assertEquals(post2, approvedPosts.get(0));
        Assert.assertEquals(0, notApprovedPosts.size());
        Assert.assertEquals(1, pendingPosts.size());
        Assert.assertEquals(post1, pendingPosts.get(0));
    }

    @Test
    public void getUserByUsername() {
        User user = dao.getUserByUsername("testUser1");
        Assert.assertEquals(user, user1);
    }

    @Test
    public void createUserDuplicate() {
        String dupName = "testUser1";
        try {
            User userDup = new User();
            userDup.setId(1);
            userDup.setUserName(dupName);
            userDup.setUserPassword("DuplicatePass");
            userDup.setIsEnabled(Boolean.TRUE);
            List<Authority> userDupAuths = new ArrayList<>();
            userDupAuths.add(authUser);
            userDup.setAuthorities(userDupAuths);
            dao.createUser(userDup);

            Assert.fail();

        } catch (UserNameExistsException ex) {
            Assert.assertNotNull(dao.getUserByUsername(dupName));
        }
    }

    /*
        TAGS
     */
    @Test
    public void getTagById() {
        Tag tag = dao.getTagById(tag1.getId());
        Assert.assertNotNull(tag);
    }

    @Test
    public void getTagById_Null() {
        Tag tag = dao.getTagById(0);
        Assert.assertNull(tag);
    }

    @Test
    public void getAllTags() {
        List<Tag> tags = dao.getAllTags();
        Assert.assertEquals("Thought I added 3 tags added to db...", 3,
                tags.size());
    }

    @Test
    public void createTag() {
        Tag tag = new Tag();
        tag.setName("New Tag");
        tag.setId(4);
        dao.createTag(tag);

        Assert.assertNotNull(dao.getTagById(tag.getId()));
    }

    @Test
    public void removeTag() {
        Assert.assertEquals(3, dao.getAllTags().size());
        dao.removeTag(tag1);
        Assert.assertNull(dao.getTagById(tag1.getId()));
        Assert.assertEquals(2, dao.getAllTags().size());
    }

    @Test
    public void updateTag() {
        tag1.setName("Changed Name");
        dao.updateTag(tag1);
        Tag fromDb = dao.getTagById(tag1.getId());
        Assert.assertEquals("Changed Name", fromDb.getName());
        Assert.assertEquals(tag1.getId(), fromDb.getId());
    }

    /*
        CATEGORIES
     */
    @Test
    public void getCategoryById() {
        Category cat = dao.getCategoryById(cat1.getId());
        Assert.assertNotNull(cat);
    }

    @Test
    public void getCategoryById_Null() {
        Category cat = dao.getCategoryById(0);
        Assert.assertNull(cat);
    }

    @Test
    public void createCategory() {
        Category cat = new Category();
        cat.setName("New Category");
        dao.createCategory(cat);
        Assert.assertNotNull(dao.getCategoryById(cat.getId()));
    }

    @Test
    public void removeCategory() {
        Assert.assertEquals(3, dao.getAllCategories().size());
        dao.removeCategory(cat1);
        Assert.assertNull(dao.getCategoryById(cat1.getId()));
        Assert.assertEquals(2, dao.getAllCategories().size());
    }

    @Test
    public void updateCategory() {
        cat1.setName("Changed Name");
        dao.updateCategory(cat1);
        Category fromDb = dao.getCategoryById(cat1.getId());
        Assert.assertEquals("Changed Name", fromDb.getName());
        Assert.assertEquals(cat1.getId(), fromDb.getId());
    }

    /*
        POSTS
     */
    @Test
    public void getPostById() {
        Post post = dao.getPostById(post1.getId());
        Assert.assertNotNull(post);
    }

    @Test
    public void getPostById_Null() {
        Post post = dao.getPostById(0);
        Assert.assertNull(post);
    }

    @Test
    public void getAllPosts() {
        List<Post> posts = dao.getAllPosts();
        Assert.assertEquals("Thought I added 2 posts added to db...", 2,
                posts.size());
    }

    @Test
    public void createPost() {
        Post post = new Post();
        post.setTitle("New Title");
        post.setHtmlString("<h1>Long String</h1><p>paragraph</p>");
        post.setHeaderImg("www.google.com/really-cool-image0-for-post-3");

        List<Tag> tags = new ArrayList<>();
        tags.add(tag2);
        post.setTags(tags);

        List<Category> cats = new ArrayList<>();
        cats.add(cat1);
        cats.add(cat2);
        post.setCategories(cats);

        LocalDateTime time = LocalDateTime.parse("2017-08-07T11:20:00");
        post.setPublishDate(time);

        List<User> authors = new ArrayList<>();
        authors.add(user1);
        post.setAuthors(authors);
        
        post.setStatus(unapproved);

        Assert.assertEquals(2, dao.getAllPosts().size());
        dao.createPost(post);
        Assert.assertNotNull(dao.getPostById(post.getId()));
        Assert.assertEquals(3, dao.getAllPosts().size());
    }

    @Test
    public void removePost() {
        Assert.assertEquals(2, dao.getAllPosts().size());
        dao.removePost(post1);
        Assert.assertNull(dao.getPostById(post1.getId()));
        Assert.assertEquals(1, dao.getAllPosts().size());
    }

    @Test
    public void updatePost() {
        post1.setTitle("New Title");
        post1.setHeaderImg("www.newImage.com/newImage");
        post1.setHtmlString("<p>New Html.</p>");
        List<Category> cats = new ArrayList<>(Arrays.asList(cat2, cat3));
        post1.setCategories(cats);
        List<Tag> tags = new ArrayList<>(Arrays.asList(tag1, tag3));
        post1.setTags(tags);
        post1.setStatus(unapproved);
        post1.setPublishDate(LocalDateTime.parse("1900-08-21T11:11:00"));
        dao.updatePost(post1);
        Post fromDb = dao.getPostById(post1.getId());
        Assert.assertEquals("New Title", fromDb.getTitle());
        Assert.assertEquals("www.newImage.com/newImage", fromDb.getHeaderImg());
        Assert.assertEquals("<p>New Html.</p>", fromDb.getHtmlString());
        Assert.assertEquals(cats, fromDb.getCategories());
        Assert.assertEquals(tags, fromDb.getTags());
        Assert.assertEquals(LocalDateTime.parse("1900-08-21T11:11:00"), fromDb.getPublishDate());
    }

    /*
        GAMES
     */
    @Test
    public void getGameById() {
        Game game = dao.getGameById(game1.getId());
        Assert.assertNotNull(dao.getGameById(game.getId()));
    }

    @Test
    public void getGameById_Null() {
        Game game = dao.getGameById(0);
        Assert.assertNull(game);
    }

    @Test
    public void getAllGames() {
        Assert.assertEquals(2, dao.getAllGames().size());
    }

    @Test
    public void createGame() {
        Assert.assertEquals(2, dao.getAllGames().size());
        Game game = new Game();
        game.setName("Test Game 3");
        LocalDate date = LocalDate.parse("1990-12-12");
        game.setReleaseDate(date);
        dao.createGame(game);
        Assert.assertEquals(3, dao.getAllGames().size());
        Assert.assertNotNull(game.getId());
    }

    @Test
    public void removeGame() {
        Assert.assertEquals(2, dao.getAllGames().size());
        dao.removeGame(game1);
        Assert.assertEquals(1, dao.getAllGames().size());
        Assert.assertNull(dao.getGameById(game1.getId()));
    }

    @Test
    public void updateGame() {
        game1.setName("Changed Name");
        game1.setReleaseDate(LocalDate.parse("2000-01-01"));
        dao.updateGame(game1);
        Game fromDb = dao.getGameById(game1.getId());

        Assert.assertEquals("Changed Name", fromDb.getName());
        Assert.assertEquals(LocalDate.parse("2000-01-01"), fromDb.getReleaseDate());
        Assert.assertEquals(game1.getId(), fromDb.getId());
    }

    /*
        Users
     */
    @Test
    public void getUserById() {
        User user = dao.getUserById(user1.getId());
        Assert.assertNotNull(user);
    }

    @Test
    public void getUserById_Null() {
        User user = dao.getUserById(0);
        Assert.assertNull(user);
    }

    @Test
    public void getAllUsers() {
        List<User> users = dao.getAllUsers();
        Assert.assertEquals(2, users.size());
    }

    @Test
    public void createUser() {
        Assert.assertEquals(2, dao.getAllUsers().size());
        User user = new User();
        user.setUserName("username4");
        user.setUserPassword("securePassword4");
        user.setIsEnabled(Boolean.TRUE);
        user.setId(4);
        List<Authority> auths = new ArrayList<>();
        auths.add(authUser);
        auths.add(authCont);
        user.setAuthorities(auths);
        try {
            dao.createUser(user);
        } catch (UserNameExistsException ex) {
            System.out.println("Attempted to add duplicate username.");
        }
        Assert.assertEquals(3, dao.getAllUsers().size());
    }

    @Test
    public void removeUser() {
        Assert.assertEquals(2, dao.getAllUsers().size());
        dao.removeUser(user1);
        Assert.assertEquals(1, dao.getAllUsers().size());
    }

    @Test
    public void updateUser() {
        user1.setUserPassword("ChngdMuhPsswrd");
        List<Authority> auths = new ArrayList<Authority>(Arrays.asList(
                Authority.ROLE_USER, Authority.ROLE_CONTRIBUTOR));
        user1.setAuthorities(auths);
        dao.updateUser(user1);
        User fromDb = dao.getUserById(user1.getId());
        Assert.assertEquals("ChngdMuhPsswrd", fromDb.getUserPassword());
        Assert.assertEquals(auths, fromDb.getAuthorities());
    }

    /*
        Comments
     */
    @Test
    public void getCommentById() {
        Assert.assertNotNull(dao.getCommentById(com1.getId()));
    }

    @Test
    public void getAllComments() {
        List<Comment> comments = dao.getAllComments();
        Assert.assertEquals(3, comments.size());
    }

    @Test
    public void createComment() {
        Assert.assertEquals(3, dao.getAllComments().size());

        Comment com = new Comment();
        com.setBody("This is the best blog I've ever seen!");
        com.setUser(user1);
        com.setTime(LocalDateTime.parse("2016-03-08T11:11:11"));
        dao.createComment(com, post2.getId());
        Assert.assertEquals(4, dao.getAllComments().size());
        Assert.assertNotNull(com.getId());
    }

    @Test
    public void removeComment() {
        Assert.assertEquals(3, dao.getAllComments().size());

        dao.removeComment(com1);

        Assert.assertEquals(2, dao.getAllComments().size());
        Assert.assertNull(dao.getCommentById(com1.getId()));
    }

}
