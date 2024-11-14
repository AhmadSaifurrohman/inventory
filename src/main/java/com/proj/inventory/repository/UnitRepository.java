package com.proj.inventory.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.proj.inventory.model.Unit;

public interface UnitRepository extends JpaRepository<Unit, String> {
    // Repository ini sudah menyediakan operasi CRUD untuk Unit (TB_MAS_UNIT)
}
