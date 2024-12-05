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

    @Column(name = "PARTNUM")
    private String partNum;

    @Column(name = "SAFETYSTOCK")
    private String safetyStock;

    @Column(name = "UNITCD")
    private String unitCd;

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

    public String getPartNumber() {
        return partNum;
    }

    public void setPartNumber(String partNum) {
        this.partNum = partNum;
    }

    public String getPartNum() {
        return partNum;
    }

    public void setPartNum(String partNum) {
        this.partNum = partNum;
    }

    public String getSafetyStock() {
        return safetyStock;
    }

    public void setSafetyStock(String safetyStock) {
        this.safetyStock = safetyStock;
    }

    public String getUnitCd() {
        return unitCd;
    }

    public void setUnitCd(String unitCd) {
        this.unitCd = unitCd;
    }
}
