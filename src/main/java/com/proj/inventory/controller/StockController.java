package com.proj.inventory.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.proj.inventory.dto.StockDTO;
import com.proj.inventory.model.Stock;
import com.proj.inventory.service.StockService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/stock")
public class StockController {

    @Autowired
    private StockService stockService;

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

    // REST API: Mengambil semua data stok
    @GetMapping("/api")
    @ResponseBody
    public List<StockDTO> getAllStocks() {
        List<Stock> stocks = stockService.getAllStocks();
        List<StockDTO> stockDTOs = new ArrayList<>();

        for (Stock stock : stocks) {
            StockDTO dto = new StockDTO();
            dto.setItemCode(stock.getItemCode());
            dto.setQuantity(stock.getQuantity());
            dto.setPortNum(stock.getPortNum());
            dto.setUnitCd(stock.getUnitCd());
            dto.setQuantity(stock.getQuantity());
            
            System.out.println("Location for stock with itemCode " + stock.getItemCode() + ": " + stock.getLocation().getLocation());

            // Dapatkan nama lokasi terkait
            if (stock.getLocation() != null) {
                dto.setLocationName(stock.getLocation().getLocation());
            }
            
            stockDTOs.add(dto);
        }

        return stockDTOs;
    }

    // REST API: Mengambil data stok berdasarkan itemCode
    @GetMapping("/api/{itemCode}")
    @ResponseBody
    public Optional<Stock> getStockByItemCode(@PathVariable String itemCode) {
        return stockService.getStockByItemCode(itemCode);
    }

    // REST API: Menyimpan atau memperbarui data stok
    @PostMapping("/api")
    @ResponseBody
    public Stock saveOrUpdateStock(@RequestBody Stock stock) {

        // Console output menggunakan System.out.println
        System.out.println("Material Code: " + stock.getItemCode());
        // System.out.println("Description: " + stock.getDescription());
        System.out.println("Port Number: " + stock.getPortNum());
        System.out.println("Unit: " + stock.getUnitCd());
        System.out.println("Rack Location: " + stock.getLocation());
        System.out.println("Quantity: " + stock.getQuantity());

        return stockService.saveOrUpdateStock(stock);
    }

    // REST API: Menghapus data stok berdasarkan itemCode
    @DeleteMapping("/api/{itemCode}")
    @ResponseBody
    public void deleteStock(@PathVariable String itemCode) {
        stockService.deleteStock(itemCode);
    }
}