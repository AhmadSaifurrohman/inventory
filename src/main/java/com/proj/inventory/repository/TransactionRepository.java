package com.proj.inventory.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.proj.inventory.model.Transaction;

public interface TransactionRepository extends JpaRepository<Transaction, Long> {
    // Menyediakan operasi CRUD untuk Transaction (TB_INVSTOCK_TRANS)

    // Tambahkan query untuk menghitung jumlah transaksi berdasarkan tipe transaksi
    long countByTransactionType(String transactionType);
    List<Transaction> findByItemCodeAndTransDate(String itemCode, Date transDate);
    List<Transaction> findByItemCode(String itemCode);
    List<Transaction> findByTransDate(Date transDate);
    List<Transaction> findByTransDateBetween(Date startDate, Date endDate);
    List<Transaction> findByTransDateBetweenAndItemCode(Date startDate, Date endDate, String itemCode);
}