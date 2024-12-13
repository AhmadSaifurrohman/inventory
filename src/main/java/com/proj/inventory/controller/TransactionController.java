package com.proj.inventory.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.proj.inventory.model.Transaction;
import com.proj.inventory.service.TransactionService;
import com.proj.inventory.util.DateUtils;
import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/transactions")
public class TransactionController {

    @Autowired
    private TransactionService transactionService;

    // Endpoint untuk menampilkan halaman Stock Transactions
    @GetMapping
    public String showStockTransactionsPage(Model model, HttpServletRequest request) {
        model.addAttribute("title", "Stock Transactions");
        model.addAttribute("currentUrl", request.getRequestURI());
        model.addAttribute("content", "stock-trans.jsp");
        return "layout";
    }

    // Endpoint untuk mendapatkan semua transaksi
    // @GetMapping("/all")
    // @ResponseBody
    // public ResponseEntity<List<Transaction>> getAllTransactions() {
    //     List<Transaction> transactions = transactionService.getAllTransactions();
    //     return ResponseEntity.ok(transactions);
    // }

    @GetMapping("/all")
    @ResponseBody
    public ResponseEntity<List<Transaction>> getTransactions(
    @RequestParam(value = "startDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
    @RequestParam(value = "endDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDate,
    @RequestParam(value = "itemCode", required = false) String itemCode
    ) {
        List<Transaction> transactions;
        System.out.println("Hasil startDate" + startDate);     
        System.out.println("Hasil endDate" + endDate);     
        System.out.println("Hasil itemCode" + itemCode); 
        // Jika semua parameter diberikan
        if (startDate != null && endDate != null && itemCode != null) {
            transactions = transactionService.findTransactionsByDateAndItemCode(
                DateUtils.setTimeToStartOfDay(startDate), DateUtils.setTimeToEndOfDay(endDate), itemCode
            );
        } 
        // Jika hanya startDate dan endDate diberikan
        else if (startDate != null && endDate != null) {
            transactions = transactionService.findTransactionsByDate(
                DateUtils.setTimeToStartOfDay(startDate), DateUtils.setTimeToEndOfDay(endDate)
            );
        } 
        // Jika hanya itemCode diberikan
        else if (itemCode != null) {
            transactions = transactionService.findTransactionsByItemCode(itemCode);
        } 
        // Jika tidak ada parameter
        else {
            transactions = transactionService.getAllTransactions();
        }

        return ResponseEntity.ok(transactions);
    }

    // Endpoint untuk mendapatkan transaksi dengan tipe 'adjustment'
    @GetMapping("/adjust")
    @ResponseBody
    public ResponseEntity<List<Transaction>> getAdjustmentTransactions() {
        // Mengambil transaksi yang bertipe 'adjustment'
        List<Transaction> adjustmentTransactions = transactionService.getTransactionsByType("adjustment");
        return ResponseEntity.ok(adjustmentTransactions);
    }

    // Endpoint untuk mencatat transaksi inbound
    @PostMapping("/inbound")
    @ResponseBody
    public ResponseEntity<Transaction> recordInboundTransaction(@RequestBody Transaction transaction) {
        Transaction savedTransaction = transactionService.recordInboundTransaction(transaction);
        System.out.println("Data JSON yang diterima: " + transaction.toString());  // Debug semua properti
        System.out.println("Quantity yang diterima: " + transaction.getTransQty());
        return ResponseEntity.ok(savedTransaction);
    }

    @PostMapping("/outbound")
    @ResponseBody
    public ResponseEntity<Transaction> recordTransaction(@RequestBody Transaction transaction) {
        // Mencetak transaksi yang diterima dari frontend
        System.out.println("Received Transaction: " + transaction);
        System.out.println("Transaction Type: " + transaction.getTransactionType());

        // Menambahkan pengecekan berdasarkan transactionType
        if ("outbound".equalsIgnoreCase(transaction.getTransactionType())) {
            System.out.println("Processing Outbound Transaction...");
            return ResponseEntity.ok(transactionService.recordOutboundTransaction(transaction));
        } else if ("adjustment".equalsIgnoreCase(transaction.getTransactionType())) {
            System.out.println("Processing Adjustment Transaction...");
            return ResponseEntity.ok(transactionService.recordAdjustmentTransaction(transaction));
        } else {
            // Jika transactionType tidak valid
            System.out.println("Invalid Transaction Type: " + transaction.getTransactionType());
            return ResponseEntity.badRequest().body(null);
        }
    }

    // Endpoint untuk mendapatkan transaksi berdasarkan itemCode
    @GetMapping("/api/{itemCode}")
    public ResponseEntity<List<Transaction>> getTransactionsByItemCode(@PathVariable String itemCode) {
        List<Transaction> transactions = transactionService.findTransactionsByItemCode(itemCode);
        return ResponseEntity.ok(transactions);
    }

    @GetMapping("/api/export-excel")
    public ResponseEntity<byte[]> exportTransactionToExcel(
            @RequestParam(value = "startDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
            @RequestParam(value = "endDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDate,
            @RequestParam(value = "itemCode", required = false) String itemCode) throws IOException {

        System.out.println("Hasil startDate" + startDate);     
        System.out.println("Hasil endDate" + endDate);     
        System.out.println("Hasil itemCode" + itemCode);     
        List<Transaction> transactions;
        if (startDate != null && endDate != null && itemCode != null) {
            transactions = transactionService.findTransactionsByDateAndItemCode(startDate, endDate, itemCode);
        } else if (startDate != null && endDate != null) {
            transactions = transactionService.findTransactionsByDate(startDate, endDate);
        } else if (itemCode != null && !itemCode.isEmpty()) {
            transactions = transactionService.findTransactionsByItemCode(itemCode);
        } else {
            transactions = transactionService.getAllTransactions();
        }

        System.out.println("Hasil Transaksi" + transactions); 
        System.out.println("Hasil Transaksi to string" + transactions.toString()); 

        byte[] excelData;
        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Transaction Data");

            String[] columns = {
                "Transaction No", "Item Code", "Transaction Type", "Quality", "Qty Before", "Qty After", "Transaction Date", 
                "User", "PIC Pickup", "Dept Pickup"
            };

            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerFont.setFontHeightInPoints((short) 12);

            CellStyle headerStyle = workbook.createCellStyle();
            headerStyle.setFont(headerFont);
            headerStyle.setBorderTop(BorderStyle.THIN);
            headerStyle.setBorderBottom(BorderStyle.THIN);
            headerStyle.setBorderLeft(BorderStyle.THIN);
            headerStyle.setBorderRight(BorderStyle.THIN);

            Row headerRow = sheet.createRow(0);
            for (int i = 0; i < columns.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(columns[i]);
                cell.setCellStyle(headerStyle);

                sheet.setColumnWidth(i, columns[i].length() * 500);
            }

            CellStyle dataStyle = workbook.createCellStyle();
            dataStyle.setBorderTop(BorderStyle.THIN);
            dataStyle.setBorderBottom(BorderStyle.THIN);
            dataStyle.setBorderLeft(BorderStyle.THIN);
            dataStyle.setBorderRight(BorderStyle.THIN);

            int rowNum = 1;
            for (Transaction transaction : transactions) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(transaction.getTransNo());
                row.createCell(1).setCellValue(transaction.getItemCode());
                row.createCell(2).setCellValue(transaction.getTransactionType());
                row.createCell(3).setCellValue(transaction.getTransQty());
                row.createCell(4).setCellValue(transaction.getQtyBefore());
                row.createCell(5).setCellValue(transaction.getQtyAfter());
                row.createCell(6).setCellValue(transaction.getTransDate());
                row.createCell(7).setCellValue(transaction.getUserId());
                row.createCell(8).setCellValue(transaction.getPicPickup());
                row.createCell(9).setCellValue(transaction.getDeptPickup());
    

                for (int i = 0; i < columns.length; i++) {
                    row.getCell(i).setCellStyle(dataStyle);
                }
            }

            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            workbook.write(byteArrayOutputStream);
            excelData = byteArrayOutputStream.toByteArray();
        }

        HttpHeaders headers = new HttpHeaders();
        headers.setContentDisposition(ContentDisposition.builder("attachment").filename("transaction_data.xlsx").build());
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);

        
        return new ResponseEntity<>(excelData, headers, HttpStatus.OK);
    }



}