package com.proj.inventory.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.proj.inventory.model.Transaction;
import com.proj.inventory.service.TransactionService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/transactions")
public class TransactionController {

    @Autowired
    private TransactionService transactionService;

    // Endpoint untuk menampilkan halaman Stock Transactions
    @GetMapping
    public String showStockTransactionsPage(Model model, HttpServletRequest request) {
        model.addAttribute("title", "Stock Transactions");
        model.addAttribute("currentUrl", request.getRequestURI());
        model.addAttribute("content", "stock-trans.jsp");
        return "layout";
    }

    // Endpoint untuk mengambil semua transaksi
    @GetMapping("/all")
    public List<Transaction> getAllTransactions() {
        return transactionService.getAllTransactions();
    }

    @PostMapping("/inbound")
    public Transaction recordInboundTransaction(@RequestBody Transaction transaction) {
        return transactionService.recordInboundTransaction(transaction);
    }

    @PostMapping("/outbound")
    public Transaction recordOutboundTransaction(@RequestBody Transaction transaction) {
        return transactionService.recordOutboundTransaction(transaction);
    }
}
