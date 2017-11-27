/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sg.shcbblog.dao;

import com.sg.shcbblog.dao.mappers.AuthorityMapper;
import com.sg.shcbblog.dao.mappers.CategoryMapper;
import com.sg.shcbblog.dao.mappers.CommentMapper;
import com.sg.shcbblog.dao.mappers.GameMapper;
import com.sg.shcbblog.dao.mappers.PostMapper;
import com.sg.shcbblog.dao.mappers.TagMapper;
import com.sg.shcbblog.dao.mappers.UserMapper;
import com.sg.shcbblog.model.Authority;
import com.sg.shcbblog.model.Category;
import com.sg.shcbblog.model.Comment;
import com.sg.shcbblog.model.Game;
import com.sg.shcbblog.model.Post;
import com.sg.shcbblog.model.PostStatus;
import com.sg.shcbblog.model.Tag;
import com.sg.shcbblog.model.User;
import com.sg.shcbblog.service.UserNameExistsException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author jared
 */
public class BlogDaoJdbcImpl implements BlogDao {

    private JdbcTemplate jdbc;
    private static final String SQL_LAST_ID = "SELECT LAST_INSERT_ID()";
    private final User ANON_USER = new User(0, "anonymous", "anonymous", false,
            new ArrayList<Authority>(Arrays.asList(Authority.ROLE_USER)));

    public BlogDaoJdbcImpl(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }
    /*
         _______  __   __  _______  ______    ___   _______  _______ 
        |       ||  | |  ||       ||    _ |  |   | |       ||       |
        |   _   ||  | |  ||    ___||   | ||  |   | |    ___||  _____|
        |  | |  ||  |_|  ||   |___ |   |_||_ |   | |   |___ | |_____ 
        |  |_|  ||       ||    ___||    __  ||   | |    ___||_____  |
        |      | |       ||   |___ |   |  | ||   | |   |___  _____| |
        |____||_||_______||_______||___|  |_||___| |_______||_______|
     */

    private static final String SELECT_MOST_USED_TAGS
            = "SELECT Tags.* FROM Post_Tags "
            + "LEFT JOIN Tags ON Tags.tag_id = Post_Tags.tag_id "
            + "GROUP BY Post_Tags.tag_id "
            + "ORDER BY COUNT(*) DESC LIMIT ?";

    @Override
    public List<Tag> getMostUsedTags(int numTags) {
        if (numTags < 0) {
            numTags = 0;
        }
        return jdbc.query(SELECT_MOST_USED_TAGS, new TagMapper(), numTags);
    }

    private static final String SELECT_POSTS_BY_TAG
            = "SELECT Posts.* FROM Post_Tags "
            + "LEFT JOIN Posts ON Posts.post_id = Post_Tags.post_id "
            + "WHERE Post_Tags.tag_id = ? ORDER BY post_pub_date DESC";

    private static final String SELECT_POST_BY_TITLE
            = "SELECT * FROM Posts WHERE post_title = ?";

    public Post getPostByTitle(String title) {
        try {
            Post post = jdbc.queryForObject(SELECT_POST_BY_TITLE, new PostMapper(),
                    title);
            post.setTags(getTagsByPost(post));
            post.setCategories(getCategoriesByPost(post));
            post.setAuthors(getAuthorsByPost(post));
            post.setStatus(getStatusByPost(post));
            List<Comment> comments = getCommentsByPost(post);
            for (Comment com : comments) {
                this.setUserAuthorities(com.getUser());
            }
            post.setComments(comments);
            return post;
        } catch (EmptyResultDataAccessException ex) {
            return null;
        }
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public List<Post> getPostsByTag(Tag tag) {
        List<Post> posts = jdbc.query(SELECT_POSTS_BY_TAG, new PostMapper(),
                tag.getId());
        for (Post post : posts) {
            post.setTags(getTagsByPost(post));
            post.setCategories(getCategoriesByPost(post));
            post.setAuthors(getAuthorsByPost(post));
            post.setStatus(getStatusByPost(post));
            List<Comment> comments = getCommentsByPost(post);
            for (Comment com : comments) {
                this.setUserAuthorities(com.getUser());
            }
            post.setComments(comments);
        }
        return posts;
    }

    private static final String SELECT_POSTS_BY_TAG_BY_APPROVAL
            = "SELECT Posts.* FROM Post_Tags "
            + "LEFT JOIN Posts ON Posts.post_id = Post_Tags.post_id "
            + "WHERE Post_Tags.tag_id = ? AND Posts.post_status = ? "
            + "ORDER BY post_pub_date DESC";

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public List<Post> getPostsByTag(Tag tag, PostStatus status) {
        List<Post> posts = jdbc.query(SELECT_POSTS_BY_TAG_BY_APPROVAL,
                new PostMapper(), tag.getId(), this.getPostStatusCode(status));
        for (Post post : posts) {
            post.setTags(getTagsByPost(post));
            post.setCategories(getCategoriesByPost(post));
            post.setAuthors(getAuthorsByPost(post));
            post.setStatus(getStatusByPost(post));
            List<Comment> comments = getCommentsByPost(post);
            for (Comment com : comments) {
                this.setUserAuthorities(com.getUser());
            }
            post.setComments(comments);
        }
        return posts;
    }

    private static final String SELECT_POSTS_BY_CAT
            = "SELECT Posts.* FROM Post_Categories "
            + "LEFT JOIN Posts ON Posts.post_id = Post_Categories.post_id "
            + "WHERE Post_Categories.cat_id = ? ORDER BY post_pub_date DESC";

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public List<Post> getPostsByCategory(Category cat) {
        List<Post> posts = jdbc.query(SELECT_POSTS_BY_CAT, new PostMapper(),
                cat.getId());
        for (Post post : posts) {
            post.setTags(getTagsByPost(post));
            post.setCategories(getCategoriesByPost(post));
            post.setAuthors(getAuthorsByPost(post));
            post.setStatus(getStatusByPost(post));
            List<Comment> comments = getCommentsByPost(post);
            for (Comment com : comments) {
                this.setUserAuthorities(com.getUser());
            }
            post.setComments(comments);
        }
        return posts;
    }

    private static final String SELECT_POSTS_BY_CAT_BY_APPROVAL
            = "SELECT Posts.* FROM Post_Categories "
            + "LEFT JOIN Posts ON Posts.post_id = Post_Categories.post_id "
            + "WHERE Post_Categories.cat_id = ? AND Posts.post_status = ? "
            + " ORDER BY post_pub_date DESC";

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public List<Post> getPostsByCategory(Category cat, PostStatus status) {
        List<Post> posts = jdbc.query(SELECT_POSTS_BY_CAT_BY_APPROVAL,
                new PostMapper(), cat.getId(), this.getPostStatusCode(status));
        for (Post post : posts) {
            post.setTags(getTagsByPost(post));
            post.setCategories(getCategoriesByPost(post));
            post.setAuthors(getAuthorsByPost(post));
            post.setStatus(getStatusByPost(post));
            List<Comment> comments = getCommentsByPost(post);
            for (Comment com : comments) {
                this.setUserAuthorities(com.getUser());
            }
            post.setComments(comments);
        }
        return posts;
    }

    private static final String SELECT_COMMENTS_BY_POST
            = "SELECT * FROM Comments WHERE post_id = ? "
            + "ORDER BY comment_time DESC";

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public List<Comment> getCommentsByPost(Post post) {
        List<Comment> comments = jdbc.query(SELECT_COMMENTS_BY_POST, new CommentMapper(),
                post.getId());
        for (Comment com : comments) {
            try {
                User author = jdbc.queryForObject(SQL_SELECT_USER_BY_COMMENT,
                        new UserMapper(), com.getId());
                com.setUser(author);
                this.setUserAuthorities(author);
            } catch (EmptyResultDataAccessException exAuth) {
                com.setUser(ANON_USER);
            }
        }
        return comments;
    }

    private static final String SQL_SELECT_USERS_BY_AUTHORITY
            = "SELECT Users.* FROM Authorities "
            + "JOIN Users ON Authorities.user_name = Users.user_name "
            + "WHERE Authorities.authority = ?";

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public List<User> getUsersByAuthority(Authority auth) {
        List<User> users = jdbc.query(SQL_SELECT_USERS_BY_AUTHORITY,
                new UserMapper(), auth.toString());
        for (User user : users) {
            setUserAuthorities(user);
        }
        return users;
    }

    private static final String SQL_SELECT_POSTS_BY_AUTHOR
            = "SELECT Posts.* FROM Posts "
            + "JOIN Post_Authors ON Post_Authors.post_id = Posts.post_id "
            + "WHERE Post_Authors.user_id = ? ORDER BY post_pub_date DESC";

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public List<Post> getPostsByAuthor(User author) {
        List<Post> posts = jdbc.query(SQL_SELECT_POSTS_BY_AUTHOR, new PostMapper(),
                author.getId());
        for (Post post : posts) {
            post.setTags(getTagsByPost(post));
            post.setCategories(getCategoriesByPost(post));
            post.setAuthors(getAuthorsByPost(post));
            post.setStatus(getStatusByPost(post));
            List<Comment> comments = getCommentsByPost(post);
            for (Comment com : comments) {
                this.setUserAuthorities(com.getUser());
            }
            post.setComments(comments);
        }
        return posts;
    }

    private static final String SQL_SELECT_POSTS_BY_AUTHOR_BY_APPROVAL
            = "SELECT Posts.* FROM Posts "
            + "JOIN Post_Authors ON Post_Authors.post_id = Posts.post_id "
            + "WHERE Post_Authors.user_id = ? AND Posts.post_status = ? "
            + "ORDER BY post_pub_date DESC";

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public List<Post> getPostsByAuthor(User author, PostStatus status) {
        List<Post> posts = jdbc.query(SQL_SELECT_POSTS_BY_AUTHOR_BY_APPROVAL,
                new PostMapper(), author.getId(), this.getPostStatusCode(status));
        for (Post post : posts) {
            post.setTags(getTagsByPost(post));
            post.setCategories(getCategoriesByPost(post));
            post.setAuthors(getAuthorsByPost(post));
            post.setStatus(getStatusByPost(post));
            List<Comment> comments = getCommentsByPost(post);
            for (Comment com : comments) {
                this.setUserAuthorities(com.getUser());
            }
            post.setComments(comments);
        }
        return posts;
    }

    private static final String SQL_SELECT_USER_BY_USERNAME
            = "SELECT * FROM Users WHERE user_name = ?";

    @Override
    public User getUserByUsername(String username) {
        try {
            User user = jdbc.queryForObject(SQL_SELECT_USER_BY_USERNAME,
                    new UserMapper(), username);
            setUserAuthorities(user);
            return user;
        } catch (EmptyResultDataAccessException ex) {
            return null;
        }
    }

    /*
         _______  _______  _______  _______  _______ 
        |       ||       ||       ||       ||       |
        |    _  ||   _   ||  _____||_     _||  _____|
        |   |_| ||  | |  || |_____   |   |  | |_____ 
        |    ___||  |_|  ||_____  |  |   |  |_____  |
        |   |    |       | _____| |  |   |   _____| |
        |___|    |_______||_______|  |___|  |_______|
     */
    private static final String SQL_SELECT_POST_BY_ID
            = "SELECT * FROM Posts WHERE post_id = ?";

    @Override
    public Post getPostById(int postId) {
        try {
            Post post = jdbc.queryForObject(SQL_SELECT_POST_BY_ID, new PostMapper(),
                    postId);
            post.setTags(getTagsByPost(post));
            post.setCategories(getCategoriesByPost(post));
            post.setAuthors(getAuthorsByPost(post));
            post.setStatus(getStatusByPost(post));
            List<Comment> comments = getCommentsByPost(post);
            for (Comment com : comments) {
                this.setUserAuthorities(com.getUser());
            }
            post.setComments(comments);
            return post;
        } catch (EmptyResultDataAccessException ex) {
            return null;
        }
    }

    private static final String SQL_SELECT_POST_STATUS_BY_POST
            = "SELECT post_status FROM Posts WHERE post_id = ?";

    private PostStatus getStatusByPost(Post post) {
        int statusCode = jdbc.queryForObject(SQL_SELECT_POST_STATUS_BY_POST,
                Integer.class, post.getId());
        switch (statusCode) {
            case 1:
                return PostStatus.PENDING;
            case 2:
                return PostStatus.APPROVED;
            case 3:
                return PostStatus.UNAPPROVED;
            default:
                return null;
        }
    }

    private int getPostStatusCode(PostStatus status) {
        switch (status) {
            case PENDING:
                return 1;
            case APPROVED:
                return 2;
            case UNAPPROVED:
                return 3;
            default:
                return 1;
        }
    }

    private static final String SQL_SELECT_TAGS_BY_POST
            = "SELECT Tags.tag_id, Tags.tag_name FROM Tags "
            + "JOIN Post_Tags ON Tags.tag_id = Post_Tags.tag_id "
            + "WHERE Post_Tags.post_id = ?";

    private List<Tag> getTagsByPost(Post post) {
        return jdbc.query(SQL_SELECT_TAGS_BY_POST, new TagMapper(),
                post.getId());
    }
    private static final String SQL_SELECT_CATS_BY_POST
            = "SELECT Categories.cat_id, Categories.cat_name "
            + "FROM Categories JOIN Post_Categories "
            + "ON Categories.cat_id = Post_Categories.cat_id "
            + "WHERE Post_Categories.post_id = ?";

    private List<Category> getCategoriesByPost(Post post) {
        return jdbc.query(SQL_SELECT_CATS_BY_POST, new CategoryMapper(),
                post.getId());
    }

    private static final String SQL_SELECT_AUTHORS_BY_POST
            = "SELECT Users.* FROM Users "
            + "JOIN Post_Authors ON Users.user_id = Post_Authors.user_id "
            + "WHERE Post_Authors.post_id = ?";

    private List<User> getAuthorsByPost(Post post) {
        List<User> authors = jdbc.query(SQL_SELECT_AUTHORS_BY_POST, new UserMapper(),
                post.getId());
        for (User auth : authors) {
            setUserAuthorities(auth);
        }
        return authors;
    }

    private static final String SQL_SELECT_ALL_POSTS
            = "SELECT * FROM Posts ORDER BY post_pub_date DESC";

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public List<Post> getAllPosts() {
        List<Post> posts = jdbc.query(SQL_SELECT_ALL_POSTS, new PostMapper());

        for (Post post : posts) {
            post.setTags(getTagsByPost(post));
            post.setCategories(getCategoriesByPost(post));
            post.setAuthors(getAuthorsByPost(post));
            post.setStatus(getStatusByPost(post));
            List<Comment> comments = getCommentsByPost(post);
            for (Comment com : comments) {
                this.setUserAuthorities(com.getUser());
            }
            post.setComments(comments);
        }

        return posts;
    }

    private static final String SQL_SELECT_POSTS_BY_STATUS
            = "SELECT * FROM Posts WHERE post_status = ? ORDER BY post_pub_date DESC";

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public List<Post> getAllPosts(PostStatus status) {
        List<Post> posts = jdbc.query(SQL_SELECT_POSTS_BY_STATUS,
                new PostMapper(), this.getPostStatusCode(status));
        for (Post post : posts) {
            post.setTags(getTagsByPost(post));
            post.setCategories(getCategoriesByPost(post));
            post.setAuthors(getAuthorsByPost(post));
            post.setStatus(getStatusByPost(post));
            List<Comment> comments = getCommentsByPost(post);
            for (Comment com : comments) {
                this.setUserAuthorities(com.getUser());
            }
            post.setComments(comments);
        }
        return posts;
    }

    private static final String SQL_INSERT_POST
            = "INSERT INTO Posts (post_status,post_title,post_html,post_header_img,post_pub_date) "
            + "VALUES (?, ?, ?, ?, ?)";
    private static final String SQL_INSERT_POST_TAGS_BY_POST
            = "INSERT INTO Post_Tags (post_id, tag_id) VALUES (?, ?)";
    private static final String SQL_CHECK_IF_TAG_EXISTS
            = "SELECT * FROM Tags WHERE tag_name = ?";

    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    private void createPostTagsByPost(Post post) {
        List<Tag> tags = post.getTags();
        final int postId = post.getId();
        for (Tag tag : tags) {
            // this checks if tag exists. If not, then create a new one
            try {
                tag = jdbc.queryForObject(SQL_CHECK_IF_TAG_EXISTS, new TagMapper(),
                        tag.getName());
            } catch (EmptyResultDataAccessException ex) {
                tag = this.createTag(tag);
            }

            jdbc.update(SQL_INSERT_POST_TAGS_BY_POST, postId, tag.getId());
        }
    }
    private static final String SQL_INSERT_POST_CATS_BY_POST
            = "INSERT INTO Post_Categories (post_id, cat_id) VALUES (?, ?)";

    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    private void createPostCategoriesByPost(Post post) {
        List<Category> cats = post.getCategories();
        final int postId = post.getId();
        for (Category cat : cats) {
            // check if category exists HERE
            jdbc.update(SQL_INSERT_POST_CATS_BY_POST, postId, cat.getId());
        }
    }
    private static final String SQL_INSERT_POST_AUTHORS_BY_POST
            = "INSERT INTO Post_Authors (post_id, user_id) VALUES (?,?)";

    private void createPostAuthorsByPost(Post post) {
        List<User> authors = post.getAuthors();
        final int postId = post.getId();
        for (User author : authors) {
            jdbc.update(SQL_INSERT_POST_AUTHORS_BY_POST, postId, author.getId());
        }
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public Post createPost(Post post) {
//        jdbc.update(SQL_INSERT_POST, post.getIsApproved(), post.getTitle(), post.getHtmlString(),
//                post.getHeaderImg(), post.getPublishDate().toString());
        jdbc.update(SQL_INSERT_POST, this.getPostStatusCode(post.getStatus()), post.getTitle(), 
                post.getHtmlString(), post.getHeaderImg(), post.getPublishDate().toString());
        post.setId(jdbc.queryForObject(SQL_LAST_ID, Integer.class));
        createPostTagsByPost(post);
        createPostCategoriesByPost(post);
        createPostAuthorsByPost(post);
        return post;
    }

    private static final String SQL_UPDATE_POST
            = "UPDATE Posts SET post_status = ?, post_html = ?, post_title = ?, post_header_img = ?, "
            + "post_pub_date = ? WHERE post_id = ?";

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public Post updatePost(Post post) {
        jdbc.update(SQL_DELETE_POST_TAGS_BY_POST, post.getId());
        jdbc.update(SQL_DELETE_POST_CATS_BY_POST, post.getId());
        jdbc.update(SQL_DELETE_POST_AUTHORS_BY_POST, post.getId());
//        jdbc.update(SQL_UPDATE_POST, post.getIsApproved(), post.getHtmlString(), post.getTitle(),
//                post.getHeaderImg(), post.getPublishDate().toString(), post.getId());
        jdbc.update(SQL_UPDATE_POST, this.getPostStatusCode(post.getStatus()), post.getHtmlString(), post.getTitle(),
                post.getHeaderImg(), post.getPublishDate().toString(), post.getId());
        createPostTagsByPost(post);
        createPostCategoriesByPost(post);
        createPostAuthorsByPost(post);
        return post;
    }

    private static final String SQL_DELETE_POST_TAGS_BY_POST
            = "DELETE FROM Post_Tags WHERE post_id = ?";
    private static final String SQL_DELETE_POST_CATS_BY_POST
            = "DELETE FROM Post_Categories WHERE post_id = ?";
    private static final String SQL_DELETE_POST_AUTHORS_BY_POST
            = "DELETE FROM Post_Authors WHERE post_id = ?";
    private static final String SQL_DELETE_POST_COMMENTS_BY_POST
            = "DELETE FROM Comments WHERE post_id = ?";
    private static final String SQL_DELETE_POST
            = "DELETE FROM Posts WHERE post_id = ?";

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public Post removePost(Post post) {
        jdbc.update(SQL_DELETE_POST_TAGS_BY_POST, post.getId());
        jdbc.update(SQL_DELETE_POST_CATS_BY_POST, post.getId());
        jdbc.update(SQL_DELETE_POST_AUTHORS_BY_POST, post.getId());
        jdbc.update(SQL_DELETE_POST_COMMENTS_BY_POST, post.getId());
        jdbc.update(SQL_DELETE_POST, post.getId());
        return post;
    }

    /*
         _______  _______  _______  _______ 
        |       ||   _   ||       ||       |
        |_     _||  |_|  ||    ___||  _____|
          |   |  |       ||   | __ | |_____ 
          |   |  |       ||   ||  ||_____  |
          |   |  |   _   ||   |_| | _____| |
          |___|  |__| |__||_______||_______|
     */
    private static final String SQL_SELECT_TAG_BY_ID
            = "SELECT * FROM Tags WHERE tag_id = ?";

    @Override
    public Tag getTagById(int tagId) {
        try {
            return jdbc.queryForObject(SQL_SELECT_TAG_BY_ID, new TagMapper(),
                    tagId);
        } catch (EmptyResultDataAccessException ex) {
            return null;
        }
    }

    private static final String SQL_SELECT_ALL_TAGS
            = "SELECT * FROM Tags";

    @Override
    public List<Tag> getAllTags() {
        return jdbc.query(SQL_SELECT_ALL_TAGS, new TagMapper());
    }

    private static final String SQL_INSERT_TAG
            = "INSERT INTO Tags (tag_name) VALUES (?)";

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public Tag createTag(Tag tag) {
        jdbc.update(SQL_INSERT_TAG, tag.getName());
        tag.setId(jdbc.queryForObject(SQL_LAST_ID, Integer.class));
        return tag;
    }

    private static final String SQL_UPDATE_TAG
            = "UPDATE Tags SET tag_name = ? WHERE tag_id = ?";

    @Override
    public Tag updateTag(Tag tag) {
        jdbc.update(SQL_UPDATE_TAG, tag.getName(), tag.getId());
        return tag;
    }

    private static final String SQL_DELETE_POST_TAGS_BY_TAG
            = "DELETE FROM Post_Tags WHERE tag_id = ?";
    private static final String SQL_DELETE_TAG
            = "DELETE FROM Tags WHERE tag_id = ?";

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public Tag removeTag(Tag tag) {
        jdbc.update(SQL_DELETE_POST_TAGS_BY_TAG, tag.getId());
        jdbc.update(SQL_DELETE_TAG, tag.getId());
        return tag;
    }

    /*
         _______  _______  _______  _______ 
        |       ||   _   ||       ||       |
        |       ||  |_|  ||_     _||  _____|
        |       ||       |  |   |  | |_____ 
        |      _||       |  |   |  |_____  |
        |     |_ |   _   |  |   |   _____| |
        |_______||__| |__|  |___|  |_______|
     */
    private static final String SQL_SELECT_CAT_BY_ID
            = "SELECT * FROM Categories WHERE cat_id = ?";

    @Override
    public Category getCategoryById(int catId) {
        try {
            return jdbc.queryForObject(SQL_SELECT_CAT_BY_ID, new CategoryMapper(),
                    catId);
        } catch (EmptyResultDataAccessException ex) {
            return null;
        }
    }

    private static final String SQL_SELECT_ALL_CATS
            = "SELECT * FROM Categories";

    @Override
    public List<Category> getAllCategories() {
        return jdbc.query(SQL_SELECT_ALL_CATS, new CategoryMapper());
    }

    private static final String SQL_INSERT_CAT
            = "INSERT INTO Categories (cat_name) VALUES (?)";

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public Category createCategory(Category cat) {
        jdbc.update(SQL_INSERT_CAT, cat.getName());
        cat.setId(jdbc.queryForObject(SQL_LAST_ID, Integer.class));
        return cat;
    }

    private static final String SQL_UPDATE_CAT
            = "UPDATE Categories SET cat_name = ? WHERE cat_id = ?";

    @Override
    public Category updateCategory(Category cat) {
        jdbc.update(SQL_UPDATE_CAT, cat.getName(), cat.getId());
        return cat;
    }

    private static final String SQL_DELETE_POST_CATS_BY_CAT
            = "DELETE FROM Post_Categories WHERE cat_id = ?";
    private static final String SQL_DELETE_CAT
            = "DELETE FROM Categories WHERE cat_id = ?";

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public Category removeCategory(Category cat) {
        jdbc.update(SQL_DELETE_POST_CATS_BY_CAT, cat.getId());
        jdbc.update(SQL_DELETE_CAT, cat.getId());
        return cat;
    }

    /*
         _______  _______  __   __  __   __  _______  __    _  _______  _______ 
        |       ||       ||  |_|  ||  |_|  ||       ||  |  | ||       ||       |
        |       ||   _   ||       ||       ||    ___||   |_| ||_     _||  _____|
        |       ||  | |  ||       ||       ||   |___ |       |  |   |  | |_____ 
        |      _||  |_|  ||       ||       ||    ___||  _    |  |   |  |_____  |
        |     |_ |       || ||_|| || ||_|| ||   |___ | | |   |  |   |   _____| |
        |_______||_______||_|   |_||_|   |_||_______||_|  |__|  |___|  |_______|
     */
    private static final String SQL_SELECT_COMMENT_BY_ID
            = "SELECT * FROM Comments WHERE comment_id = ?";
    private static final String SQL_SELECT_USER_BY_COMMENT
            = "SELECT Users.* FROM Comments "
            + "JOIN Users ON Comments.user_id = Users.user_id "
            + "WHERE comment_id = ?";

    @Override
    public Comment getCommentById(int commentId) {
        try {
            Comment com = jdbc.queryForObject(SQL_SELECT_COMMENT_BY_ID,
                    new CommentMapper(), commentId);
            try {
                User author = jdbc.queryForObject(SQL_SELECT_USER_BY_COMMENT,
                        new UserMapper(), commentId);
                setUserAuthorities(author);
                com.setUser(author);
            } catch (EmptyResultDataAccessException exAuth) {
                com.setUser(ANON_USER);
            } finally {
                return com;
            }
        } catch (EmptyResultDataAccessException ex) {
            return null;
        }
    }

    private static final String SQL_SELECT_ALL_COMMENTS
            = "SELECT * FROM Comments ORDER BY comment_time DESC";

    @Override
    public List<Comment> getAllComments() {
        List<Comment> comments = jdbc.query(SQL_SELECT_ALL_COMMENTS,
                new CommentMapper());
        for (Comment com : comments) {
            try {
                User author = jdbc.queryForObject(SQL_SELECT_USER_BY_COMMENT,
                        new UserMapper(), com.getId());
                setUserAuthorities(author);
                com.setUser(author);
            } catch (EmptyResultDataAccessException exAuth) {
                com.setUser(ANON_USER);
            }
        }
        return comments;
    }

    private static final String SQL_INSERT_COMMENT
            = "INSERT INTO Comments (post_id, user_id, comment_body, comment_time) "
            + "VALUES (?, ?, ?, ?)";

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public Comment createComment(Comment comment, int postId) {
        jdbc.update(SQL_INSERT_COMMENT, postId, comment.getUser().getId(),
                comment.getBody(), comment.getTime().toString());
        comment.setId(jdbc.queryForObject(SQL_LAST_ID, Integer.class));
        return comment;
    }

    private static final String SQL_DELETE_COMMENT
            = "DELETE FROM Comments WHERE comment_id = ?";

    @Override
    public Comment removeComment(Comment comment) {
        jdbc.update(SQL_DELETE_COMMENT, comment.getId());
        return comment;
    }

    /*
         __   __  _______  _______  ______    _______ 
        |  | |  ||       ||       ||    _ |  |       |
        |  | |  ||  _____||    ___||   | ||  |  _____|
        |  |_|  || |_____ |   |___ |   |_||_ | |_____ 
        |       ||_____  ||    ___||    __  ||_____  |
        |       | _____| ||   |___ |   |  | | _____| |
        |_______||_______||_______||___|  |_||_______|
     */
    private static final String SQL_SELECT_AUTHORITIES_BY_USER
            = "SELECT * FROM Authorities WHERE user_name = ?";

    private void setUserAuthorities(User user) {
        List<Authority> auths = jdbc.query(SQL_SELECT_AUTHORITIES_BY_USER,
                new AuthorityMapper(), user.getUserName());
        user.setAuthorities(auths);
    }

    private static final String SQL_SELECT_USER_BY_ID
            = "SELECT * FROM Users WHERE user_id = ?";

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public User getUserById(int userId) {
        try {
            User user = jdbc.queryForObject(SQL_SELECT_USER_BY_ID, new UserMapper(),
                    userId);
            setUserAuthorities(user);
            return user;
        } catch (EmptyResultDataAccessException ex) {
            return null;
        }
    }

    private static final String SQL_SELECT_ALL_USERS
            = "SELECT * FROM Users";

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public List<User> getAllUsers() {
        List<User> users = jdbc.query(SQL_SELECT_ALL_USERS, new UserMapper());
        for (User user : users) {
            setUserAuthorities(user);
        }
        return users;
    }

    private static final String SQL_INSERT_USER
            = "INSERT INTO Users (user_name, user_password, user_enabled) "
            + "VALUES (?,?,?)";
    private static final String SQL_INSERT_USER_AUTHORITIES
            = "INSERT INTO Authorities (user_name, authority) "
            + "VALUES (?,?)";

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public User createUser(User user) throws UserNameExistsException {
        try {
            jdbc.update(SQL_INSERT_USER, user.getUserName(), user.getUserPassword(),
                    user.getIsEnabled());
            List<Authority> auths = user.getAuthorities();
            for (Authority auth : auths) {
                jdbc.update(SQL_INSERT_USER_AUTHORITIES, user.getUserName(),
                        auth.toString());
            }
            user.setId(jdbc.queryForObject(SQL_LAST_ID, Integer.class));
            return user;
        } catch (DuplicateKeyException ex) {
            throw new UserNameExistsException("Username already exists.");
        }
    }

    private static final String SQL_UPDATE_USER
            = "UPDATE Users SET user_password = ?, "
            + "user_enabled = ? WHERE user_id = ?";
    private static final String SQL_DELETE_AUTHORITIES_BY_USER
            = "DELETE FROM Authorities WHERE user_name = ?";

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public User updateUser(User user) {
        jdbc.update(SQL_DELETE_AUTHORITIES_BY_USER, user.getUserName());
        jdbc.update(SQL_UPDATE_USER, user.getUserPassword(),
                user.getIsEnabled(), user.getId());
        List<Authority> auths = user.getAuthorities();
        for (Authority auth : auths) {
            jdbc.update(SQL_INSERT_USER_AUTHORITIES, user.getUserName(),
                    auth.toString());
        }
        return user;
    }

    private static final String SQL_DELETE_POST_AUTHORS_BY_USER
            = "DELETE FROM Post_Authors WHERE user_id = ?";
    private static final String SQL_DELETE_COMMENTS_BY_USER
            = "DELETE FROM Comments WHERE user_id = ?";
    private static final String SQL_DELETE_USER_AUTHORITIES
            = "DELETE FROM Authorities WHERE user_name = ?";
    private static final String SQL_DELETE_USER
            = "DELETE FROM Users WHERE user_id = ?";

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public User removeUser(User user) {
        jdbc.update(SQL_DELETE_POST_AUTHORS_BY_USER, user.getId());
        jdbc.update(SQL_DELETE_COMMENTS_BY_USER, user.getId());
        jdbc.update(SQL_DELETE_USER_AUTHORITIES, user.getUserName());
        jdbc.update(SQL_DELETE_USER, user.getId());
        return user;
    }

    /*
         _______  _______  __   __  _______  _______ 
        |       ||   _   ||  |_|  ||       ||       |
        |    ___||  |_|  ||       ||    ___||  _____|
        |   | __ |       ||       ||   |___ | |_____ 
        |   ||  ||       ||       ||    ___||_____  |
        |   |_| ||   _   || ||_|| ||   |___  _____| |
        |_______||__| |__||_|   |_||_______||_______|
     */
    private static final String SQL_SELECT_GAME_BY_ID
            = "SELECT * FROM Games WHERE game_id = ?";

    @Override
    public Game getGameById(int gameId) {
        try {
            return jdbc.queryForObject(SQL_SELECT_GAME_BY_ID, new GameMapper(),
                    gameId);
        } catch (EmptyResultDataAccessException ex) {
            return null;
        }
    }

    private static final String SQL_SELECT_ALL_GAMES
            = "SELECT * FROM Games ORDER BY game_release_date DESC";

    @Override
    public List<Game> getAllGames() {
        return jdbc.query(SQL_SELECT_ALL_GAMES, new GameMapper());
    }

    private static final String SQL_INSERT_GAME
            = "INSERT INTO Games (game_name, game_release_date) VALUES (?,?)";

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public Game createGame(Game game) {
        jdbc.update(SQL_INSERT_GAME, game.getName(),
                game.getReleaseDate().toString());
        game.setId(jdbc.queryForObject(SQL_LAST_ID, Integer.class));
        return game;
    }

    private static final String SQL_UPDATE_GAME
            = "UPDATE Games SET game_name = ?, game_release_date = ? "
            + "WHERE game_id = ?";

    @Override
    public Game updateGame(Game game) {
        jdbc.update(SQL_UPDATE_GAME, game.getName(),
                game.getReleaseDate().toString(), game.getId());
        return game;
    }

    private static final String SQL_DELETE_GAME
            = "DELETE FROM Games WHERE game_id = ?";

    @Override
    public Game removeGame(Game game) {
        jdbc.update(SQL_DELETE_GAME, game.getId());
        return game;
    }

}
