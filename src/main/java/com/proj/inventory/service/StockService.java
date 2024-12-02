package com.proj.inventory.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proj.inventory.model.Stock;
import com.proj.inventory.repository.StockRepository;

@Service
public class StockService {

    @Autowired
    private StockRepository stockRepository;

    public List<Stock> getAllStocks() {
        return stockRepository.findAll();
    }

    public Optional<Stock> getStockByItemCode(String itemCode) {
        return stockRepository.findById(itemCode);
    }

    // Mengubah method ini untuk mencari stok berdasarkan ITEMCODE dan LOCATION
    public Optional<Stock> getStockByItemCodeAndLocation(String itemCode, String locationCode) {
        return stockRepository.findByItemCodeAndLocation(itemCode, locationCode); // Menggunakan locationCode sebagai String
    }

    public Stock saveOrUpdateStock(Stock stock) {
        return stockRepository.save(stock);
    }

    public void deleteStock(String itemCode) {
        stockRepository.deleteById(itemCode);
    }
}