package com.proj.inventory.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.proj.inventory.model.Location;

public interface LocationRepository extends JpaRepository<Location, String> {
    // Repository ini sudah menyediakan operasi CRUD untuk Location (TB_MAS_LOC)
}
