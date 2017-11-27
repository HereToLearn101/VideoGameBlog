/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sg.shcbblog.controller;

import java.text.MessageFormat;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author jared
 */

@Controller
public class ErrorController {
    
    @RequestMapping(value="/error")
    public String blogError(HttpServletRequest request, 
            HttpServletResponse response, Model model) {
        
        Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
        
        HttpStatus httpStatus = HttpStatus.valueOf(statusCode);
        
        Throwable throwable = (Throwable) request.getAttribute("javax.servlet.error.exception");
        
        String exMessage = httpStatus.getReasonPhrase();
        
        String requestUri = (String) request.getAttribute("javax.servlet.error.request_uri");
        
        if (requestUri == null) {
            requestUri = "Unknown";
        }
        
        model.addAttribute("statusCode", statusCode);
        model.addAttribute("requestUri", requestUri);
        model.addAttribute("exMessage", exMessage);
        
        return "error";
    }
    
}
