/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sg.shcbblog.service;

/**
 *
 * @author tedis
 */
public class UserNameExistsException extends Exception {
    
    public UserNameExistsException(String message) {
        super(message);
    }
    
    public UserNameExistsException(String message, Throwable cause) {
        super(message, cause);
    }
    
}
