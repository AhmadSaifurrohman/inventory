package com.proj.inventory.service;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proj.inventory.model.Location;
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
        } catch (ParseException e) {
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
        } catch (ParseException e) {
            return List.of(); // Mengembalikan list kosong jika ada kesalahan parsing
        }
    }
	
    // Fungsi untuk record inbound transaction
    public Transaction recordInboundTransaction(Transaction transaction) {
        // Set transaksi dengan tipe inbound dan tanggal transaksi
        transaction.setTransactionType("inbound");
        transaction.setTransDate(new Date());  // Set tanggal transaksi
        transaction.setUserId("USER123");  // UserID (misal hardcoded, sesuaikan dengan sistem login)
    
        System.out.println("Transaksi Quantity: " + transaction.getTransQty());

        // Mengambil lokasi dari transaksi dan mencari objek Location berdasarkan locCd
        Location location = transaction.getLocation();
        if (location == null) {
            throw new RuntimeException("Location tidak ditemukan!");
        }
    
        // Cari stok berdasarkan itemCode dan location
        Optional<Stock> existingStockOpt = stockRepository.findByItemCodeAndLocation(transaction.getItemCode(), location.getLocCd());
        Stock stock;
        int qtyBefore = 0;
        
        // Jika stok ada, ambil qtyBefore, jika tidak ada, set qtyBefore menjadi 0
        if (existingStockOpt.isPresent()) {
            stock = existingStockOpt.get();
            qtyBefore = stock.getQuantity();
        } else {
            stock = new Stock();
            stock.setItemCode(transaction.getItemCode());
            stock.setPartNum(transaction.getItemCode());  // Asumsi PartNum berdasarkan ItemCode
            stock.setQuantity(0);  // Karena stok awal belum ada, set quantity menjadi 0
        }
    
        // Set QTY_BEFORE dan QTY_AFTER
        int qtyAfter = qtyBefore + transaction.getTransQty();  // Tambah quantity stok berdasarkan transaksi inbound
        transaction.setQtyBefore(qtyBefore);
        transaction.setQtyAfter(qtyAfter);
    
        // Update atau simpan stok
        stock.setQuantity(qtyAfter);  // Set stok dengan qtyAfter
        stock.setUnitCd(transaction.getUnitCd());
        stock.setLocation(location);
        stock.setUpdateDate(new Date());  // Set tanggal update stok
        stock.setUserUpdate(transaction.getUserId());  // Set user update stok
        stock.setDescription(stock.getDescription());
    
        // Simpan stok yang sudah diperbarui atau baru
        stockRepository.save(stock);
    
        // Simpan transaksi inbound
        return transactionRepository.save(transaction);
    }        

    // Fungsi untuk record outbound transaction
    public Transaction recordOutboundTransaction(Transaction transaction) {
        // Set transaksi dengan tipe outbound dan tanggal transaksi
        transaction.setTransactionType("outbound");
        transaction.setTransDate(new Date());  // Set tanggal transaksi
        transaction.setUserId("USER123");  // UserID (misal hardcoded, sesuaikan dengan sistem login)
    
        // Mengambil lokasi dari transaksi dan mencari objek Location berdasarkan locCd
        Location location = transaction.getLocation();
        if (location == null) {
            throw new RuntimeException("Location tidak ditemukan!");
        }
    
        // Cari stok berdasarkan itemCode dan location
        Optional<Stock> existingStockOpt = stockRepository.findByItemCodeAndLocation(transaction.getItemCode(), location.getLocCd());
        if (!existingStockOpt.isPresent()) {
            throw new RuntimeException("Stok tidak tersedia untuk item " + transaction.getItemCode() + " di lokasi " + location.getLocCd());
        }
    
        Stock stock = existingStockOpt.get();
        int qtyBefore = stock.getQuantity();  // Ambil qtyBefore dari stok yang ada
        int qtyAfter = qtyBefore - transaction.getTransQty();  // Kurangi stok berdasarkan transaksi outbound
    
        // Pastikan stok cukup untuk transaksi outbound
        if (qtyAfter < 0) {
            throw new RuntimeException("Stok tidak mencukupi untuk transaksi outbound");
        }
    
        // Set QTY_BEFORE dan QTY_AFTER
        transaction.setQtyBefore(qtyBefore);
        transaction.setQtyAfter(qtyAfter);
    
        // Update stok
        stock.setQuantity(qtyAfter);  // Update quantity stok
        stock.setUpdateDate(new Date());  // Set tanggal update stok
        stock.setUserUpdate(transaction.getUserId());  // Set user update stok
    
        // Simpan stok yang telah diperbarui
        stockRepository.save(stock);
    
        // Simpan transaksi outbound
        return transactionRepository.save(transaction);
    }    

    // Memperbaiki metode updateStock agar menerima objek Location dan Date
    // private void updateStock(String itemCode, int quantity, Location location, boolean isInbound, Date transactionDate) {
    //     // Mencari stok berdasarkan itemCode dan location
    //     Optional<Stock> stockOpt = stockRepository.findByItemCodeAndLocation(itemCode, location.getLocCd());
    //     Stock stock;
    
    //     if (stockOpt.isEmpty()) {
    //         stock = new Stock();
    //         stock.setItemCode(itemCode);
    //         stock.setQuantity(0);  // Set quantity menjadi 0 jika stok belum ada
    //     } else {
    //         stock = stockOpt.get();
    //     }
    
    //     // Logika untuk memperbarui stok berdasarkan inbound atau outbound
    //     if (isInbound) {
    //         stock.setQuantity(stock.getQuantity() + quantity);  // Tambah quantity untuk inbound
    //     } else {
    //         stock.setQuantity(stock.getQuantity() - quantity);  // Kurangi quantity untuk outbound
    //     }
    
    //     // Set lokasi dan tanggal update
    //     stock.setLocation(location);
    //     stock.setUpdateDate(transactionDate);  // Gunakan tanggal transaksi
    //     stock.setUserUpdate("USER123");  // Default user update (sesuaikan dengan pengguna yang sedang login)
    
    //     // Simpan stok yang telah diperbarui
    //     stockRepository.save(stock);
    // }    
}