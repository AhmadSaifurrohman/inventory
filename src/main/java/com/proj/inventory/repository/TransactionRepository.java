package com.proj.inventory.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.proj.inventory.model.Transaction;

public interface TransactionRepository extends JpaRepository<Transaction, Long> {
    // Menyediakan operasi CRUD untuk Transaction (TB_INVSTOCK_TRANS)

    // Tambahkan query untuk menghitung jumlah transaksi berdasarkan tipe transaksi
    long countByTransactionType(String transactionType);

    // Menemukan transaksi berdasarkan itemCode dan transDate
    List<Transaction> findByItemCodeAndTransDate(String itemCode, Date transDate);

    // Menemukan transaksi berdasarkan itemCode
    List<Transaction> findByItemCode(String itemCode);

    // Menemukan transaksi berdasarkan transDate
    List<Transaction> findByTransDate(Date transDate);
}