package com.proj.inventory.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.proj.inventory.model.Transaction;
import com.proj.inventory.service.TransactionService;

@RestController
@RequestMapping("/api/transactions")
public class TransactionController {

    @Autowired
    private TransactionService transactionService;

    @GetMapping
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
