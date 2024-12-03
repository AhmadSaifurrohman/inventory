package com.proj.inventory.controller;

import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

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
import org.springframework.web.bind.annotation.RequestParam;

import com.proj.inventory.dto.StockDTO;
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
    public ResponseEntity<List<StockDTO>> getAllStocks() {
        List<Stock> stocks = stockService.getAllStocks();
        
        // Mapping Stock ke StockDTO
        List<StockDTO> stockDTOs = stocks.stream()
                                        .map(this::mapToDTO)
                                        .collect(Collectors.toList());

        // System.out.println("Stock DTO List : " + stockDTOs);
        return ResponseEntity.ok(stockDTOs);
    }

    

    @GetMapping("/api/filter")
    public ResponseEntity<List<StockDTO>> getFilteredStocks(
            @RequestParam(value = "itemCode", required = false) String itemCode,
            @RequestParam(value = "location", required = false) String location) {
              
        List<Stock> stocks = stockService.getFilteredStocks(itemCode, location);
        
        // Mapping Stock ke StockDTO
        List<StockDTO> stockDTOs = stocks.stream()
                .map(this::mapToDTO)
                .collect(Collectors.toList());

        return ResponseEntity.ok(stockDTOs);
    }


    private StockDTO mapToDTO(Stock stock) {
        StockDTO stockDTO = new StockDTO();
        stockDTO.setItemCode(stock.getItemCode());
        stockDTO.setQuantity(stock.getQuantity());
        stockDTO.setPartNum(stock.getPartNum());
        stockDTO.setUnitCd(stock.getUnitCd());
        stockDTO.setLocationName(stock.getLocation().getLocation());  // Menampilkan nama lokasi
        
        // Mengambil data dari relasi Item (jika ada)
        if (stock.getItem() != null) {
            stockDTO.setItemName(stock.getItem().getItemName());
            stockDTO.setItemDescription(stock.getItem().getDescription());
            stockDTO.setSafetyStock(stock.getItem().getSafetyStock());
        }
        
        return stockDTO;
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