/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sg.shcbblog.dao.mappers;

import com.sg.shcbblog.model.Category;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author jared
 */
public class CategoryMapper implements RowMapper<Category> {

    @Override
    public Category mapRow(ResultSet rs, int i) throws SQLException {
        Category cat = new Category();
        cat.setId(rs.getInt("cat_id"));
        cat.setName(rs.getString("cat_name"));
        return cat;
    }
    
}
