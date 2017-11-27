/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sg.shcbblog.dao;

import com.sg.shcbblog.model.Authority;
import com.sg.shcbblog.model.Category;
import com.sg.shcbblog.model.Comment;
import com.sg.shcbblog.model.Game;
import com.sg.shcbblog.model.Post;
import com.sg.shcbblog.model.PostStatus;
import com.sg.shcbblog.model.Tag;
import com.sg.shcbblog.model.User;
import com.sg.shcbblog.service.UserNameExistsException;
import java.util.List;

/**
 *
 * @author jared
 */
public interface BlogDao {
    
    //QUERIES
    List<Tag> getMostUsedTags(int numTags);
    Post getPostByTitle(String title);
    List<Post> getPostsByTag(Tag tag);
    List<Post> getPostsByTag(Tag tag, PostStatus status);
    List<Post> getPostsByCategory(Category cat);
    List<Post> getPostsByCategory(Category cat, PostStatus status);
    List<Post> getPostsByAuthor(User author);
    List<Post> getPostsByAuthor(User author, PostStatus status);
    List<Comment> getCommentsByPost(Post post);
    User getUserByUsername(String username);
    List<User> getUsersByAuthority(Authority auth);
    
    // POSTS
    Post getPostById(int postId);
    List<Post> getAllPosts();
    List<Post> getAllPosts(PostStatus status);
    Post createPost(Post post);
    Post updatePost(Post post);
    Post removePost(Post post);
    
    // TAGS
    Tag getTagById(int tagId);
    List<Tag> getAllTags();
    Tag createTag(Tag tag);
    Tag updateTag(Tag tag);
    Tag removeTag(Tag tag);
            
    // CATEGORIES
    Category getCategoryById(int catId);
    List<Category> getAllCategories();
    Category createCategory(Category cat);
    Category updateCategory(Category cat);
    Category removeCategory(Category cat);
            
    // COMMENTS
    Comment getCommentById(int commentId);
    List<Comment> getAllComments();
    Comment createComment(Comment comment, int postId);
    Comment removeComment(Comment comment);
            
    // USERS
    User getUserById(int userId);
    List<User> getAllUsers();
    User createUser(User user) throws UserNameExistsException;
    User updateUser(User user);
    User removeUser(User user);
    
    // GAMES
    Game getGameById(int gameId);
    List<Game> getAllGames();
    Game createGame(Game game);
    Game updateGame(Game game);
    Game removeGame(Game game);
}
