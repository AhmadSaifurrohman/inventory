package com.proj.inventory.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.proj.inventory.model.Item;

@Repository
public interface ItemRepository extends JpaRepository<Item, Long> {
}
