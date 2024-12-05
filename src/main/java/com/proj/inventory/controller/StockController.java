package com.proj.inventory.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
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

import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


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

    @GetMapping("/summary")
    public ResponseEntity<List<Map<String, Object>>> getStockSummary() {
        List<Map<String, Object>> summary = stockService.getStockSummary();
        return ResponseEntity.ok(summary);
    }

    @GetMapping("/api/export-excel")
    public ResponseEntity<byte[]> exportToExcel(
            @RequestParam(required = false) String filterItemCode,
            @RequestParam(required = false) String filterLocation) throws IOException {

        List<Stock> stocks = (filterItemCode != null || filterLocation != null)
                ? stockService.getFilteredStocks(filterItemCode, filterLocation)
                : stockService.getAllStocks();

        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Stocks");

            int rowCount = 0;
            Row headerRow = sheet.createRow(rowCount++);
            headerRow.createCell(0).setCellValue("Item Code");
            // headerRow.createCell(1).setCellValue("Description");
            headerRow.createCell(2).setCellValue("Part Number");
            headerRow.createCell(3).setCellValue("Quantity");
            headerRow.createCell(4).setCellValue("Unit");
            // headerRow.createCell(5).setCellValue("Location");

            for (Stock stock : stocks) {
                Row row = sheet.createRow(rowCount++);
                row.createCell(0).setCellValue(stock.getItemCode());
                // row.createCell(1).setCellValue(stock.getDescription());
                row.createCell(2).setCellValue(stock.getPartNum());
                row.createCell(3).setCellValue(stock.getQuantity());
                row.createCell(4).setCellValue(stock.getUnitCd());
                // row.createCell(5).setCellValue(stock.getLocation());
            }

            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            workbook.write(bos);
            byte[] bytes = bos.toByteArray();

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            headers.setContentDisposition(ContentDisposition.attachment()
                    .filename("stocks_" + System.currentTimeMillis() + ".xlsx")
                    .build());

            return ResponseEntity.ok()
                    .headers(headers)
                    .body(bytes);
        }
    }


}