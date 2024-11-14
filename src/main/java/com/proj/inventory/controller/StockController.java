package com.proj.inventory.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.proj.inventory.model.Stock;
import com.proj.inventory.service.StockService;

@RestController
@RequestMapping("/api/stock")
public class StockController {

    @Autowired
    private StockService stockService;

    @GetMapping
    public List<Stock> getAllStocks() {
        return stockService.getAllStocks();
    }

    @GetMapping("/{itemCode}")
    public Optional<Stock> getStockByItemCode(@PathVariable String itemCode) {
        return stockService.getStockByItemCode(itemCode);
    }

    @PostMapping
    public Stock saveOrUpdateStock(@RequestBody Stock stock) {
        return stockService.saveOrUpdateStock(stock);
    }

    @DeleteMapping("/{itemCode}")
    public void deleteStock(@PathVariable String itemCode) {
        stockService.deleteStock(itemCode);
    }
}
