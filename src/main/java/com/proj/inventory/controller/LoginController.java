package com.proj.inventory.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginController {
    
    @GetMapping("/login")
    public String login() {
        return "login"; // Mengarahkan ke login.jsp
    }

    @GetMapping("/admin")
    public String admin() {
        return "admin"; // Mengarahkan ke halaman admin.jsp
    }
}
