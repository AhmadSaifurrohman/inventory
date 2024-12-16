package com.proj.inventory.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.proj.inventory.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import jakarta.servlet.http.HttpServletRequest;


@Controller
@RequestMapping("/users12")
public class UserController {

    @Autowired
    private UserService userService;

    // Endpoint untuk menampilkan halaman Stock
    @GetMapping
    public String showUserPage(Model model, HttpServletRequest request) {
        // Setel judul halaman
        model.addAttribute("title", "Users List");
        model.addAttribute("currentUrl", request.getRequestURI());
        // Tentukan konten untuk halaman stok
        model.addAttribute("content", "users.jsp");

        // Kembalikan layout.jsp sebagai template utama
        return "layout";
    }

}