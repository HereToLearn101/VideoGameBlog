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
public class MisMatchPasswordException extends Exception {
    
    public MisMatchPasswordException(String message) {
        super(message);
    }
    
    public MisMatchPasswordException(String message, Throwable cause) {
        super(message, cause);
    }
}
