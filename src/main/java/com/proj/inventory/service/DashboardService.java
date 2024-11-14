package com.proj.inventory.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.proj.inventory.repository.StockRepository;
import com.proj.inventory.repository.TransactionRepository;

@Service
public class DashboardService {

    @Autowired
    private StockRepository stockRepository;

    @Autowired
    private TransactionRepository transactionRepository;

    public long getTotalStock() {
        return stockRepository.count();
    }

    public long getTotalInboundTransactions() {
        return transactionRepository.countByTransactionType("inbound");
    }

    public long getTotalOutboundTransactions() {
        return transactionRepository.countByTransactionType("outbound");
    }

    // Anda bisa menambahkan metode ringkasan lainnya sesuai kebutuhan dashboard
}
