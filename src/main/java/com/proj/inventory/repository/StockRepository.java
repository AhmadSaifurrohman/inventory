package com.proj.inventory.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.proj.inventory.model.Stock;

public interface StockRepository extends JpaRepository<Stock, String> {
    // Repository ini sudah menyediakan operasi CRUD untuk Stock (TB_INVSTOCK)
}
