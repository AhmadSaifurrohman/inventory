package com.proj.inventory.repository;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.proj.inventory.model.Item;
import com.proj.inventory.model.Location;
import com.proj.inventory.model.Stock;

public interface StockRepository extends JpaRepository<Stock, String> {
    // Repository ini sudah menyediakan operasi CRUD untuk Stock (TB_INVSTOCK)

    @Query("SELECT s FROM Stock s WHERE s.itemCode = :itemCode AND s.location.locCd = :locationCode")
    Optional<Stock> findByItemCodeAndLocation(@Param("itemCode") String itemCode, @Param("locationCode") String locationCode);

    List<Stock> findByItemCode(Item item); // Mengambil berdasarkan itemCode
    List<Stock> findByLocation(Location location); // Mengambil berdasarkan location
    
    @Query(value = """
        SELECT 
            inv.itemcode AS itemCode,
            mas.partnum AS partNum,
            inv.quantity AS stock,
            mas.safetystock AS safetyStock,
            inv.location AS location,
            CASE
                WHEN inv.quantity > mas.safetystock THEN 'Aman'
                WHEN inv.quantity BETWEEN (mas.safetystock * 0.8) AND mas.safetystock THEN 'Mendekati Tidak Aman'
                WHEN inv.quantity < mas.safetystock THEN 'Perlu Re-Stock'
            END AS stockStatus
        FROM 
            tb_invstock inv
        JOIN 
            tb_mas_itemcd mas ON inv.itemcode = mas.itemcode
        WHERE inv.quantity BETWEEN (mas.safetystock * 0.8) AND mas.safetystock
        ORDER BY 
            mas.safetystock ASC,
            inv.quantity ASC,
            inv.location ASC;
        """, nativeQuery = true)
    List<Map<String, Object>> findStockApproachSafetyQty();

    @Query(value = """
        SELECT 
             inv.itemcode AS itemCode,
            mas.partnum AS partNum,
            inv.quantity AS stock,
            mas.safetystock AS safetyStock,
            inv.location AS location,
            CASE
                WHEN inv.quantity > mas.safetystock THEN 'Aman'
                WHEN inv.quantity BETWEEN (mas.safetystock * 0.8) AND mas.safetystock THEN 'Mendekati Tidak Aman'
                WHEN inv.quantity < mas.safetystock THEN 'Perlu Re-Stock'
            END AS stockStatus
        FROM 
            tb_invstock inv
        JOIN 
            tb_mas_itemcd mas ON inv.itemcode = mas.itemcode
        WHERE inv.quantity < mas.safetystock
        ORDER BY 
            mas.safetystock ASC,
            inv.quantity ASC,
            inv.location ASC;
                """, nativeQuery = true)
            List<Map<String, Object>> findStockUnderSafetyQty();
    }