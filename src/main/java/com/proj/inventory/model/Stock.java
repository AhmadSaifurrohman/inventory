package com.proj.inventory.model;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

@Entity
@Table(name = "TB_INVSTOCK")
public class Stock {

    @Id
    @Column(name = "ITEMCODE", nullable = false)
    private String itemCode;

    @Column(name = "QUANTITY")
    private int quantity;

    @Column(name = "PORTNUM")
    private String portNum;

    @Column(name = "UNITCD")
    private String unitCd;

    @Column(name = "LOCATION")
    private String location;

    @Column(name = "UPDATEDATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updateDate;

    @Column(name = "USERUPDATE")
    private String userUpdate;

    // Getters and Setters
    public String getItemCode() {
        return itemCode;
    }

    public void setItemCode(String itemCode) {
        this.itemCode = itemCode;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getPortNum() {
        return portNum;
    }

    public void setPortNum(String portNum) {
        this.portNum = portNum;
    }

    public String getUnitCd() {
        return unitCd;
    }

    public void setUnitCd(String unitCd) {
        this.unitCd = unitCd;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public String getUserUpdate() {
        return userUpdate;
    }

    public void setUserUpdate(String userUpdate) {
        this.userUpdate = userUpdate;
    }
}
