package com.proj.inventory.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "TB_MAS_UNIT")
public class Unit {

    @Id
    @Column(name = "UNITCD", nullable = false)
    private String unitCd;

    @Column(name = "DESCRIPTION")
    private String description;

    // Getters and Setters
    public String getUnitCd() {
        return unitCd;
    }

    public void setUnitCd(String unitCd) {
        this.unitCd = unitCd;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
