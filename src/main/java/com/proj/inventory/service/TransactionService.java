package com.proj.inventory.service;

import com.proj.inventory.model.Transaction;
import com.proj.inventory.repository.TransactionRepository;
import com.proj.inventory.model.Stock;
import com.proj.inventory.repository.StockRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class TransactionService {

    @Autowired
    private TransactionRepository transactionRepository;

    @Autowired
    private StockRepository stockRepository;

    public List<Transaction> getAllTransactions() {
        return transactionRepository.findAll();
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
