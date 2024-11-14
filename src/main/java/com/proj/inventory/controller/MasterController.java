package com.proj.inventory.controller;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MasterController {

    @GetMapping("/master")
    public String index(Model model) {
        // Setel judul halaman
        model.addAttribute("title", "Master Data - Inventory Management System");

        // Tentukan konten untuk halaman stok
        model.addAttribute("content", "master-data.jsp");

        // Kembalikan layout.jsp sebagai template utama
        return "layout";
    }
}
