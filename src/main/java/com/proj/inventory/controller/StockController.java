package com.proj.inventory.controller;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.proj.inventory.model.Stock;
import com.proj.inventory.model.Transaction;
import com.proj.inventory.service.StockService;
import com.proj.inventory.service.TransactionService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/stock")
public class StockController {

    @Autowired
    private StockService stockService;

    @Autowired
    private TransactionService transactionService;

    // Endpoint untuk menampilkan halaman Stock
    @GetMapping
    public String showStockPage(Model model, HttpServletRequest request) {
        // Setel judul halaman
        model.addAttribute("title", "Stock");
        model.addAttribute("currentUrl", request.getRequestURI());
        // Tentukan konten untuk halaman stok
        model.addAttribute("content", "stock.jsp");

        // Kembalikan layout.jsp sebagai template utama
        return "layout";
    }

    // Endpoint untuk menambah stok
    @PostMapping("/api")
    public ResponseEntity<Stock> addStock(@RequestBody Stock stock) {
        // Mencatat transaksi inbound
        Transaction transaction = new Transaction();
        transaction.setItemCode(stock.getItemCode());
        transaction.setTransQty(stock.getQuantity());
        transaction.setUnitCd(stock.getUnitCd());
        transaction.setTransDate(new Date()); // Set tanggal transaksi
        transaction.setTransactionType("inbound"); // Set tipe transaksi

        // Mencatat transaksi dan memperbarui stok
        transactionService.recordInboundTransaction(transaction);

        // Mengembalikan response dengan status sukses
        return ResponseEntity.ok(stock);
    }

    // Endpoint lainnya (misalnya, untuk mendapatkan semua stok)
    @GetMapping("/api")
    public ResponseEntity<List<Stock>> getAllStocks() {
        List<Stock> stocks = stockService.getAllStocks();
        return ResponseEntity.ok(stocks);
    }

    // Endpoint untuk menghapus stok
    @DeleteMapping("/api/{itemCode}")
    public ResponseEntity<Void> deleteStock(@PathVariable String itemCode) {
        stockService.deleteStock(itemCode);
        return ResponseEntity.noContent().build();
    }

    // Endpoint untuk mendapatkan stok berdasarkan itemCode
    @GetMapping("/api/{itemCode}")
    public ResponseEntity<Stock> getStockByItemCode(@PathVariable String itemCode) {
        Optional<Stock> stock = stockService.getStockByItemCode(itemCode);
        return stock.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }
}