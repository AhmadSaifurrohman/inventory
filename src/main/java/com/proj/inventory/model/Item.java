package com.proj.inventory.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "TB_MAS_ITEMCD")
public class Item {

    @Id
    @Column(name = "ITEMCODE", nullable = false)
    private String itemCode;

    @Column(name = "ITEMNAME")
    private String itemName;

    @Column(name = "DESCRIPTION")
    private String description;

    // Getters and Setters
    public String getItemCode() {
        return itemCode;
    }

    public void setItemCode(String itemCode) {
        this.itemCode = itemCode;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
