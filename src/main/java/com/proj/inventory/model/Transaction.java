package com.proj.inventory.model;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

@Entity
@Table(name = "TB_INVSTOCK_TRANS")
public class Transaction {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "TRANSNO", nullable = false)
    private Long transNo;

    @Column(name = "TRANSACTION_TYPE")
    private String transactionType;

    @Column(name = "ITEMCODE")
    private String itemCode;

    @Column(name = "UNITCD")
    private String unitCd;

    @Column(name = "TRANS_QTY")
    private int transQty;

    @Column(name = "QTY_BEFORE")
    private int qtyBefore;

    @Column(name = "QTY_AFTER")
    private int qtyAfter;

    @Column(name = "TRANS_DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date transDate;

    @Column(name = "USERID")
    private String userId;

    @Column(name = "PIC_PICKUP")
    private String picPickup;

    @Column(name = "DEPT_PICKUP")
    private String deptPickup;

    // Ubah type 'String' menjadi 'Location'
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "LOCATION", referencedColumnName = "LOCCD")
    private Location location;

    // Getters and Setters
    public Long getTransNo() {
        return transNo;
    }

    public void setTransNo(Long transNo) {
        this.transNo = transNo;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public String getItemCode() {
        return itemCode;
    }

    public void setItemCode(String itemCode) {
        this.itemCode = itemCode;
    }

    public String getUnitCd() {
        return unitCd;
    }

    public void setUnitCd(String unitCd) {
        this.unitCd = unitCd;
    }

    public int getTransQty() {
        return transQty;
    }

    public void setTransQty(int transQty) {
        this.transQty = transQty;
    }

    public int getQtyBefore() {
        return qtyBefore;
    }

    public void setQtyBefore(int qtyBefore) {
        this.qtyBefore = qtyBefore;
    }

    public int getQtyAfter() {
        return qtyAfter;
    }

    public void setQtyAfter(int qtyAfter) {
        this.qtyAfter = qtyAfter;
    }

    public Date getTransDate() {
        return transDate;
    }

    public void setTransDate(Date transDate) {
        this.transDate = transDate;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPicPickup() {
        return picPickup;
    }

    public void setPicPickup(String picPickup) {
        this.picPickup = picPickup;
    }

    public String getDeptPickup() {
        return deptPickup;
    }

    public void setDeptPickup(String deptPickup) {
        this.deptPickup = deptPickup;
    }

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }
}