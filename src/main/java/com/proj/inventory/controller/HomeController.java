package com.proj.inventory.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home(Model model) {
        // Setel judul halaman
        model.addAttribute("title", "Dashboard - Inventory Management System");

        // Tentukan konten yang akan dimuat ke dalam layout.jsp
        model.addAttribute("content", "dashboard.jsp");

        // Kembalikan layout.jsp sebagai view utama
        return "layout";
    }
}
