/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sg.shcbblog.dao.mappers;

import com.sg.shcbblog.model.Comment;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author jared
 */
public class CommentMapper implements RowMapper<Comment> {

    @Override
    public Comment mapRow(ResultSet rs, int i) throws SQLException {
        Comment comm = new Comment();
        comm.setId(rs.getInt("comment_id"));
        comm.setBody(rs.getString("comment_body"));
        comm.setTime(rs.getTimestamp("comment_time").toLocalDateTime());
        return comm;
        
    }
    
}
