/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sg.shcbblog.service;

import com.sg.shcbblog.model.Category;
import com.sg.shcbblog.model.Comment;
import com.sg.shcbblog.model.Game;
import com.sg.shcbblog.model.Post;
import com.sg.shcbblog.model.Tag;
import com.sg.shcbblog.model.User;
import java.util.List;

/**
 *
 * @author tedis
 */
public interface BlogService {
    
    List<Post> acquireAllPostsApproved();
    
    List<Post> acquireAllPostsDisapproved();
    
    Post acquirePostById(int id);
    
    List<Post> acquireAllPostsByCategoryApproved(int id);
    
    List<Post> acquireAllPostsByCategoryDisapproved(int id);
    
    List<Post> acquireAllPostsByPending();
    
    List<Post> acquireAllPostsByTag(int id);
    
    List<Post> acquireAllPostsByUser(User user);
    
    List<Category> acquireAllCategories();
    
    Category acquireCategoryById(int id);
    
    void createPost(Post post);
    
    void editPost(Post post);
    
    void createTag(Tag tag);
    
    Tag acquireTagById(int id);
    
    void createComment(Comment comment, int postId);
    
    List<User> acquireAllUsers();
    
    User acquireUserById(int id);
    
    User acquireUserByUsername(String userName);
    
    void createUser(User user) throws UserNameExistsException;
    
    void editUser(User user);
    
    void deleteUser(int id);
    
    void checkForMisMatchPasswords(String pass, String reTypedPass) throws MisMatchPasswordException;
    
    List<Game> acquireAllGames();
    
    void createGame(Game game);
    
    List<Post> acquirePostsByTitleOrKeyword(String title);
}
