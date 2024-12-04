package com.proj.inventory.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.proj.inventory.model.Item;

public interface ItemRepository extends JpaRepository<Item, String> {

    Item findByItemCode(String itemCode);
    // Repository ini sudah menyediakan operasi CRUD untuk Item (TB_MAS_ITEMCD)
}
