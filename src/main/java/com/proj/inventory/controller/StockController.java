package com.proj.inventory.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class StockController {

    @GetMapping("/stock")
    public String showStock(Model model) {
        // Setel judul halaman
        model.addAttribute("title", "Stock - Inventory Management System");

        // Tentukan konten untuk halaman stok
        model.addAttribute("content", "stock.jsp");

        // Kembalikan layout.jsp sebagai template utama
        return "layout";
    }
}
