package com.proj.inventory.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class OutItemController {

    @GetMapping("/out-item")
    public String showOutItemPage(Model model) {
        // Setel judul halaman
        model.addAttribute("title", "Barang Out - Inventory Management System");

        // Tentukan konten yang akan dimuat di layout.jsp
        model.addAttribute("content", "out-item.jsp");

        // Kembalikan layout.jsp sebagai template utama
        return "layout";
    }

    @PostMapping("/add-out-item")
    public String addOutItem(
            @RequestParam("materialCode") String materialCode,
            @RequestParam("quantity") int quantity,
            @RequestParam("unit") String unit,
            @RequestParam("recipient") String recipient,
            @RequestParam("dateOut") String dateOut,
            @RequestParam(value = "reason", required = false) String reason,
            Model model) {

        // Proses untuk menyimpan data barang keluar ke database bisa ditambahkan di sini

        // Redirect ke halaman Barang Out setelah penambahan data berhasil
        return "redirect:/out-item";
    }
}
