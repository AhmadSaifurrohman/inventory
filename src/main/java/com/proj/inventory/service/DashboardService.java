package com.proj.inventory.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proj.inventory.repository.ItemRepository;
import com.proj.inventory.repository.StockRepository;
import com.proj.inventory.repository.TransactionRepository;

@Service
public class DashboardService {

    @Autowired
    private StockRepository stockRepository;

    @Autowired
    private TransactionRepository transactionRepository;

    @Autowired
    private ItemRepository itemRepository;

    public long getTotalStock() {
        return stockRepository.count();
    }

    public long getTotalItem() {
        return itemRepository.count();
    }

    public long getTotalStockQuantity() {
        Long totalStock = stockRepository.findTotalStockQuantity();
        return totalStock != null ? totalStock : 0L; // Menggunakan Long dan memastikan nilainya 0 jika null
    }        

    public long getTotalInboundTransactions() {
        return transactionRepository.countByTransactionType("inbound");
    }

    public long getTotalOutboundTransactions() {
        return transactionRepository.countByTransactionType("outbound");
    }
}
