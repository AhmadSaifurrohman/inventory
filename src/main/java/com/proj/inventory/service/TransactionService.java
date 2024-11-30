package com.proj.inventory.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proj.inventory.model.Stock;
import com.proj.inventory.model.Transaction;
import com.proj.inventory.repository.StockRepository;
import com.proj.inventory.repository.TransactionRepository;

@Service
public class TransactionService {

    @Autowired
    private TransactionRepository transactionRepository;

    @Autowired
    private StockRepository stockRepository;

    public List<Transaction> getAllTransactions() {
        return transactionRepository.findAll();
    }

    // Menemukan transaksi berdasarkan itemCode dan transDate
    public List<Transaction> findTransactionsByItemCodeAndDate(String itemCode, String transDate) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // Format tanggal
            Date date = dateFormat.parse(transDate);
            return transactionRepository.findByItemCodeAndTransDate(itemCode, date);
        } catch (Exception e) {
            e.printStackTrace();
            return List.of(); // Mengembalikan list kosong jika ada kesalahan parsing
        }
    }

    // Menemukan transaksi berdasarkan itemCode
    public List<Transaction> findTransactionsByItemCode(String itemCode) {
        return transactionRepository.findByItemCode(itemCode);
    }

    // Menemukan transaksi berdasarkan transDate
    public List<Transaction> findTransactionsByDate(String transDate) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // Format tanggal
            Date date = dateFormat.parse(transDate);
            return transactionRepository.findByTransDate(date);
        } catch (Exception e) {
            e.printStackTrace();
            return List.of(); // Mengembalikan list kosong jika ada kesalahan parsing
        }
    }

    public Transaction recordInboundTransaction(Transaction transaction) {
        transaction.setTransactionType("inbound");
        updateStock(transaction.getItemCode(), transaction.getTransQty(), true);
        transaction.setTransDate(new Date());
        return transactionRepository.save(transaction);
    }

    public Transaction recordOutboundTransaction(Transaction transaction) {
        transaction.setTransactionType("outbound");
        updateStock(transaction.getItemCode(), transaction.getTransQty(), false);
        transaction.setTransDate(new Date());
        return transactionRepository.save(transaction);
    }

    private void updateStock(String itemCode, int quantity, boolean isInbound) {
        Stock stock = stockRepository.findById(itemCode).orElse(new Stock());
        int updatedQuantity = isInbound ? stock.getQuantity() + quantity : stock.getQuantity() - quantity;
        stock.setQuantity(updatedQuantity);
        stock.setItemCode(itemCode);
        stock.setUpdateDate(new Date());
        stockRepository.save(stock);
    }
}
