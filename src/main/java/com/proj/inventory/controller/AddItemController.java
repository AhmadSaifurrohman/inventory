package com.proj.inventory.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AddItemController {

    @GetMapping("/add-item")
    public String showAddItemForm(Model model) {
        // Setel judul halaman
        model.addAttribute("title", "Tambah Barang - Inventory Management System");

        // Tentukan konten untuk halaman tambah barang
        model.addAttribute("content", "add-item.jsp");

        // Kembalikan layout.jsp sebagai template utama
        return "layout";
    }

    @PostMapping("/add-item")
    public String addItem(
            @RequestParam("materialCode") String materialCode,
            @RequestParam("description") String description,
            @RequestParam("portNumber") String portNumber,
            @RequestParam("unit") String unit,
            @RequestParam("rackLocation") String rackLocation,
            Model model) {

        // Proses untuk menyimpan data barang baru ke database dapat ditambahkan di sini

        // Redirect ke halaman stok setelah penambahan data berhasil
        return "redirect:/stock";
    }
}
