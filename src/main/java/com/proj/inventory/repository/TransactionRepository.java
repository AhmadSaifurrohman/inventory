package com.proj.inventory.repository;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.proj.inventory.model.Transaction;

public interface TransactionRepository extends JpaRepository<Transaction, Long> {
    // Menyediakan operasi CRUD untuk Transaction (TB_INVSTOCK_TRANS)

    // Tambahkan query untuk menghitung jumlah transaksi berdasarkan tipe transaksi
    long countByTransactionType(String transactionType);
    List<Transaction> findByItemCodeAndTransDate(String itemCode, Date transDate);
    List<Transaction> findByItemCode(String itemCode);
    List<Transaction> findByTransDate(Date transDate);

    // Menemukan transaksi dengan tipe transaksi
    List<Transaction> findByTransactionType(String transactionType);
    List<Transaction> findByTransDateBetween(Date startDate, Date endDate);
    List<Transaction> findByTransDateBetweenAndItemCode(Date startDate, Date endDate, String itemCode);

    List<Transaction> findByTransDateBetweenAndTransactionType(Date startDate, Date endDate, String transactionType);

    // Query untuk mengambil Top 10 barang yang paling banyak dikeluarkan (outbound)
    @Query("SELECT t.itemCode AS itemCode, SUM(t.transQty) AS totalQty FROM Transaction t WHERE t.transactionType = 'outbound' GROUP BY t.itemCode ORDER BY totalQty DESC")
    List<Map<String, Object>> findTop10MostRequestedItems();

}