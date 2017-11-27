/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sg.shcbblog.dao.mappers;

import com.sg.shcbblog.model.Game;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author jared
 */
public class GameMapper implements RowMapper<Game> {

    @Override
    public Game mapRow(ResultSet rs, int i) throws SQLException {
        Game game = new Game();
        game.setId(rs.getInt("game_id"));
        game.setName(rs.getString("game_name"));
        game.setReleaseDate(rs.getDate("game_release_date").toLocalDate());
        return game;
    }
    
}
