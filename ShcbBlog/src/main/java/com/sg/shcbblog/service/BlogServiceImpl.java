/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sg.shcbblog.service;

import com.sg.shcbblog.dao.BlogDao;
import com.sg.shcbblog.model.Category;
import com.sg.shcbblog.model.Comment;
import com.sg.shcbblog.model.Game;
import com.sg.shcbblog.model.Post;
import com.sg.shcbblog.model.PostStatus;
import com.sg.shcbblog.model.Tag;
import com.sg.shcbblog.model.User;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author tedis
 */
public class BlogServiceImpl implements BlogService{
    
    private BlogDao dao;
    
    public BlogServiceImpl(BlogDao dao) {
        this.dao = dao;
    }

    @Override
    public List<Post> acquireAllPostsApproved() {
        return dao.getAllPosts(PostStatus.APPROVED);
    }
    
    @Override
    public List<Post> acquireAllPostsDisapproved() {
        return dao.getAllPosts(PostStatus.UNAPPROVED);
    }
    
    @Override
    public Post acquirePostById(int id) {
        return dao.getPostById(id);
    }
    
    @Override
    public List<Post> acquireAllPostsByCategoryApproved(int id) {
        Category cat = dao.getCategoryById(id);
        return dao.getPostsByCategory(cat, PostStatus.APPROVED);
    }
    
    @Override
    public List<Post> acquireAllPostsByCategoryDisapproved(int id) {
        Category cat = dao.getCategoryById(id);
        return dao.getPostsByCategory(cat, PostStatus.UNAPPROVED);
    }
    
    @Override
    public List<Post> acquireAllPostsByPending() {
        return dao.getAllPosts(PostStatus.PENDING);
    }
    
    @Override
    public List<Post> acquireAllPostsByTag(int id) {
        Tag tag = dao.getTagById(id);
        return dao.getPostsByTag(tag, PostStatus.APPROVED);
    }
    
    @Override
    public List<Post> acquireAllPostsByUser(User user) {
        return dao.getPostsByAuthor(user);
    }
    
    @Override
    public List<Category> acquireAllCategories() {
        return dao.getAllCategories();
    }
    
    @Override
    public Category acquireCategoryById(int id) {
        return dao.getCategoryById(id);
    }
    
    @Override
    public void createPost(Post post) {
        dao.createPost(post);
    }
    
    @Override
    public void editPost(Post post) {
        dao.updatePost(post);
    }
    
    @Override
    public void createTag(Tag tag) {
        dao.createTag(tag);
    }
    
    @Override
    public Tag acquireTagById(int id) {
        return dao.getTagById(id);      
    }
    
    @Override
    public void createComment(Comment comment, int postId) {
        dao.createComment(comment, postId);
    }
    
    @Override
    public List<User> acquireAllUsers() {
        return dao.getAllUsers();
    }
    
    @Override
    public User acquireUserById(int id) {
        return dao.getUserById(id);
    }
    
    @Override
    public User acquireUserByUsername(String userName) {
        return dao.getUserByUsername(userName);
    }
    
    @Override
    public void createUser(User user) throws UserNameExistsException {
        dao.createUser(user);
    }
    
    @Override
    public void editUser(User user) {
        dao.updateUser(user);
    }
    
    @Override
    public void deleteUser(int id) {
        User user = dao.getUserById(id);
        dao.removeUser(user);
    }
    
    @Override
    public List<Game> acquireAllGames() {
        return dao.getAllGames();
    }
    
    @Override
    public void createGame(Game game) {
        dao.createGame(game);
    }
    
    @Override
    public List<Post> acquirePostsByTitleOrKeyword(String title) {
        List<Post> postsFound = new ArrayList<>();
        
        List<Post> posts = dao.getAllPosts();
        
        for (Post post : posts) {
            if (post.getTitle().toLowerCase().contains(title.toLowerCase())) {
                postsFound.add(post);
            }
        }
        
        return postsFound;
    }
    
    @Override
    public void checkForMisMatchPasswords(String pass, String reTypedPass) throws MisMatchPasswordException {
        validatePasswords(pass, reTypedPass);
    }
    
//    private void validateUserExists(User user) throws UserNameExistsException {
//        User userExists = dao.getUserByUsername(user.getUserName());
//        if (userExists != null) {
//            throw new UserNameExistsException("* that username already exists...");
//        }
//    }
    
    private void validatePasswords(String pass, String reTypedPass) throws MisMatchPasswordException {
        if (!pass.equals(reTypedPass)) {
            throw new MisMatchPasswordException("Passwords don't match!");
        }
    }
}
