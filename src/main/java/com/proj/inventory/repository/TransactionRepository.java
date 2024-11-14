package com.proj.inventory.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.proj.inventory.model.Transaction;

public interface TransactionRepository extends JpaRepository<Transaction, Long> {
    // Menyediakan operasi CRUD untuk Transaction (TB_INVSTOCK_TRANS)

    // Tambahkan query untuk menghitung jumlah transaksi berdasarkan tipe transaksi
    long countByTransactionType(String transactionType);

    // Ambil daftar transaksi berdasarkan ITEMCODE (opsional, jika diperlukan)
    List<Transaction> findByItemCode(String itemCode);
}
