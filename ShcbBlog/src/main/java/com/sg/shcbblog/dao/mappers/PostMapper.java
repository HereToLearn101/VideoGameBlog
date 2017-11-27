/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sg.shcbblog.dao.mappers;

import com.sg.shcbblog.model.Post;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author jared
 */
public class PostMapper implements RowMapper<Post> {

    @Override
    public Post mapRow(ResultSet rs, int i) throws SQLException {
        Post post = new Post();
        post.setId(rs.getInt("post_id"));
        post.setTitle(rs.getString("post_title"));
        post.setHtmlString(rs.getString("post_html"));
        post.setHeaderImg(rs.getString("post_header_img"));
        post.setPublishDate(rs.getTimestamp("post_pub_date").toLocalDateTime());
        return post;
    }
    
}
