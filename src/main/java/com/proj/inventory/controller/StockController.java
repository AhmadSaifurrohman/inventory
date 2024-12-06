package com.proj.inventory.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
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


    // Endpoint untuk mengunduh Excel dengan filter
    @GetMapping("/export-excel")
    public ResponseEntity<byte[]> exportToExcel(
            @RequestParam(value = "itemCode", required = false) String itemCode,
            @RequestParam(value = "location", required = false) String locationCode) throws IOException {

        // Mengambil data stok berdasarkan filter
        List<Stock> stocks = stockService.getFilteredStocks(itemCode, locationCode);

        // Mapping ke StockDTO
        List<StockDTO> stockDTOs = stocks.stream()
                .map(this::mapToDTO) // Memanggil method mapToDTO untuk konversi
                .toList();

        byte[] excelData;
        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Stock Data");

            // Header Kolom
            String[] columns = {
                "Item Code", "Item Name", "Part Number", "Description",
                "Quantity", "Unit", "Location", "Safety Stock"
            };

            // Membuat font untuk header
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerFont.setFontHeightInPoints((short) 12);

            // Membuat style untuk header
            CellStyle headerStyle = workbook.createCellStyle();
            headerStyle.setFont(headerFont);
            headerStyle.setBorderTop(BorderStyle.THIN);
            headerStyle.setBorderBottom(BorderStyle.THIN);
            headerStyle.setBorderLeft(BorderStyle.THIN);
            headerStyle.setBorderRight(BorderStyle.THIN);

            // Membuat header row
            Row headerRow = sheet.createRow(0);
            for (int i = 0; i < columns.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(columns[i]);
                cell.setCellStyle(headerStyle);

                // Mengatur lebar kolom secara otomatis
                sheet.setColumnWidth(i, columns[i].length() * 500); // Panjang kolom
            }

            // Membuat style untuk data
            CellStyle dataStyle = workbook.createCellStyle();
            dataStyle.setBorderTop(BorderStyle.THIN);
            dataStyle.setBorderBottom(BorderStyle.THIN);
            dataStyle.setBorderLeft(BorderStyle.THIN);
            dataStyle.setBorderRight(BorderStyle.THIN);

            // Mengisi data dari StockDTO ke dalam sheet
            int rowNum = 1;
            for (StockDTO stockDTO : stockDTOs) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(stockDTO.getItemCode());
                row.createCell(1).setCellValue(stockDTO.getItemName());
                row.createCell(2).setCellValue(stockDTO.getPartNum());
                row.createCell(3).setCellValue(stockDTO.getItemDescription());
                row.createCell(4).setCellValue(stockDTO.getQuantity());
                row.createCell(5).setCellValue(stockDTO.getUnitCd());
                row.createCell(6).setCellValue(stockDTO.getLocationName());
                row.createCell(7).setCellValue(stockDTO.getSafetyStock());

                // Terapkan style ke semua sel data
                for (int i = 0; i < columns.length; i++) {
                    row.getCell(i).setCellStyle(dataStyle);
                }
            }

            // Mengubah data Excel ke byte array
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            workbook.write(byteArrayOutputStream);
            excelData = byteArrayOutputStream.toByteArray();
        }

        // Membuat header untuk file Excel
        HttpHeaders headers = new HttpHeaders();
        headers.setContentDisposition(ContentDisposition.builder("attachment").filename("stock_data.xlsx").build());
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);

        return new ResponseEntity<>(excelData, headers, HttpStatus.OK);
    }


}