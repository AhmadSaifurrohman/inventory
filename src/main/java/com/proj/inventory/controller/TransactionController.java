package com.proj.inventory.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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

    // Endpoint untuk mendapatkan semua transaksi
    // @GetMapping("/all")
    // @ResponseBody
    // public ResponseEntity<List<Transaction>> getAllTransactions() {
    //     List<Transaction> transactions = transactionService.getAllTransactions();
    //     return ResponseEntity.ok(transactions);
    // }

    @GetMapping("/all")
    @ResponseBody
    public ResponseEntity<List<Transaction>> getTransactions(
    @RequestParam(value = "startDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
    @RequestParam(value = "endDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDate,
    @RequestParam(value = "itemCode", required = false) String itemCode
    ) {
        List<Transaction> transactions;

        // Jika semua parameter diberikan
        if (startDate != null && endDate != null && itemCode != null) {
            transactions = transactionService.findTransactionsByDateAndItemCode(startDate, endDate, itemCode);
        } 
        // Jika hanya startDate dan endDate diberikan
        else if (startDate != null && endDate != null) {
            transactions = transactionService.findTransactionsByDate(startDate, endDate);
        } 
        // Jika hanya itemCode diberikan
        else if (itemCode != null) {
            transactions = transactionService.findTransactionsByItemCode(itemCode);
        } 
        // Jika tidak ada parameter
        else {
            transactions = transactionService.getAllTransactions();
        }

        return ResponseEntity.ok(transactions);
    }

    // Endpoint untuk mencatat transaksi inbound
    @PostMapping("/inbound")
    @ResponseBody
    public ResponseEntity<Transaction> recordInboundTransaction(@RequestBody Transaction transaction) {
        Transaction savedTransaction = transactionService.recordInboundTransaction(transaction);
        System.out.println("Data JSON yang diterima: " + transaction.toString());  // Debug semua properti
        System.out.println("Quantity yang diterima: " + transaction.getTransQty());
        return ResponseEntity.ok(savedTransaction);
    }

    @PostMapping("/outbound")
    @ResponseBody
    public Transaction recordOutboundTransaction(@RequestBody Transaction transaction) {
        return transactionService.recordOutboundTransaction(transaction);
    }

    // Endpoint untuk mendapatkan transaksi berdasarkan itemCode
    @GetMapping("/api/{itemCode}")
    public ResponseEntity<List<Transaction>> getTransactionsByItemCode(@PathVariable String itemCode) {
        List<Transaction> transactions = transactionService.findTransactionsByItemCode(itemCode);
        return ResponseEntity.ok(transactions);
    }

}