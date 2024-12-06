package com.proj.inventory.service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proj.inventory.model.Item;
import com.proj.inventory.model.Location;
import com.proj.inventory.model.Stock;
import com.proj.inventory.repository.StockRepository;

@Service
public class StockService {

    @Autowired
    private StockRepository stockRepository;

    public List<Stock> getAllStocks() {
        return stockRepository.findAll();
    }

    public List<Stock> getFilteredStocks(String itemCode, String locationCode) {
        System.out.println("Filter LocationCode : " + locationCode);
        System.out.println("Filter itemCode : " + itemCode);
    
        // Jika kedua filter (itemCode dan locationCode) diberikan
        if (itemCode != null && !itemCode.isEmpty() && locationCode != null && !locationCode.isEmpty()) {
            System.out.println("Masuk Filter Keduanya");
            Optional<Stock> stock = stockRepository.findByItemCodeAndLocation(itemCode, locationCode);
            return stock.map(List::of).orElseGet(List::of); // Konversi Optional ke List
        } 
        // Jika hanya itemCode diberikan
        else if (itemCode != null && !itemCode.isEmpty()) {
            System.out.println("Masuk Filter itemCode");
            // Konversi String itemCode ke Item jika diperlukan
            Item item = new Item(); 
            item.setItemCode(itemCode); // Pastikan ada setter itemCode di model Item
            return stockRepository.findByItemCode(item);
        } 
        // Jika hanya locationCode diberikan
        else if (locationCode != null && !locationCode.isEmpty()) {
            System.out.println("Masuk Filter Location");
            // Konversi String locationCode ke Location jika diperlukan
            Location location = new Location(); 
            location.setLocCd(locationCode); // Pastikan ada setter locCd di model Location
            return stockRepository.findByLocation(location);
        } 
        // Jika tidak ada filter diberikan
        else {
            System.out.println("Masuk Else");
            return stockRepository.findAll();
        }
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

    public List<Map<String, Object>> findStockApproachSafetyQty() {
        return stockRepository.findStockApproachSafetyQty();
    }

    public List<Map<String, Object>> findStockUnderSafetyQty() {
        return stockRepository.findStockUnderSafetyQty();
    }
}