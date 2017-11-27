/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sg.shcbblog.model;

import java.util.List;
import java.util.Objects;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 *
 * @author jared
 */
@ToString
@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
public class User {
    
    private Integer id;
    private String userName;
    private String userPassword;
    private Boolean isEnabled;
    private List<Authority> authorities;

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 41 * hash + Objects.hashCode(this.id);
        hash = 41 * hash + Objects.hashCode(this.userName);
        hash = 41 * hash + Objects.hashCode(this.userPassword);
        hash = 41 * hash + Objects.hashCode(this.isEnabled);
        hash = 41 * hash + Objects.hashCode(this.authorities);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final User other = (User) obj;
        if (!Objects.equals(this.userName, other.userName)) {
            return false;
        }
        if (!Objects.equals(this.userPassword, other.userPassword)) {
            return false;
        }
        if (!Objects.equals(this.id, other.id)) {
            return false;
        }
        if (!Objects.equals(this.isEnabled, other.isEnabled)) {
            return false;
        }
        if (!Objects.equals(this.authorities, other.authorities)) {
            return false;
        }
        return true;
    }

    
    
}
