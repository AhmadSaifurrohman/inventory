package com.proj.inventory.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.proj.inventory.model.Stock;

public interface StockRepository extends JpaRepository<Stock, String> {
    // Repository ini sudah menyediakan operasi CRUD untuk Stock (TB_INVSTOCK)

    @Query("SELECT s FROM Stock s WHERE s.itemCode = :itemCode AND s.location.locCd = :locationCode")
    Optional<Stock> findByItemCodeAndLocation(@Param("itemCode") String itemCode, @Param("locationCode") String locationCode);

}