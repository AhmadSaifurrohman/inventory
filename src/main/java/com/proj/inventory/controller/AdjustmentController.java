package com.proj.inventory.controller;

import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.proj.inventory.dto.StockDTO;
import com.proj.inventory.model.Stock;
import com.proj.inventory.model.Transaction;
import com.proj.inventory.service.StockService;
import com.proj.inventory.service.TransactionService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/stock/adjustment")
public class AdjustmentController {

    @Autowired
    private StockService stockService;

    @Autowired
    private TransactionService transactionService;

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