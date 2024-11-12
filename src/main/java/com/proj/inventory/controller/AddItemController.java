package com.proj.inventory.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.proj.inventory.model.Item;
import com.proj.inventory.repository.ItemRepository;

@Controller
public class AddItemController {

    @Autowired
    private ItemRepository itemRepository;

    @GetMapping("/add-item")
    public String showAddItemForm(Model model) {
        model.addAttribute("title", "Tambah Barang - Inventory Management System");
        model.addAttribute("content", "add-item.jsp");
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

        // Membuat objek item baru dan menyimpannya ke database
        Item item = new Item();
        item.setMaterialCode(materialCode);
        item.setDescription(description);
        item.setPortNumber(portNumber);
        item.setUnit(unit);
        item.setRackLocation(rackLocation);

        itemRepository.save(item);

        // Menambahkan notifikasi ke model
        model.addAttribute("successMessage", "Barang berhasil ditambahkan!");
        model.addAttribute("title", "Tambah Barang - Inventory Management System");
        model.addAttribute("content", "add-item.jsp");
        return "layout";
    }
}
