package com.proj.inventory.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/stock/adjustment")
public class AdjustmentController {

    // Endpoint untuk menampilkan halaman Stock
    @GetMapping
    public String showStockPage(Model model, HttpServletRequest request) {
        // Setel judul halaman
        model.addAttribute("title", "Stock");
        model.addAttribute("currentUrl", request.getRequestURI());
        // Tentukan konten untuk halaman stok
        model.addAttribute("content", "stock-adjustment.jsp");

        // Kembalikan layout.jsp sebagai template utama
        return "layout";
    }
}