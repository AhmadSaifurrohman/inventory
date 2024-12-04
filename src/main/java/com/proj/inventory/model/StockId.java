package com.proj.inventory.model;

import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class StockId implements Serializable {

    private String itemCode;
    private String location;

    public StockId() {}

    public StockId(String itemCode, String location) {
        this.itemCode = itemCode;
        this.location = location;
    }

    public String getItemCode() {
        return itemCode;
    }

    public void setItemCode(String itemCode) {
        this.itemCode = itemCode;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        StockId stockId = (StockId) o;
        return Objects.equals(itemCode, stockId.itemCode) && Objects.equals(location, stockId.location);
    }

    @Override
    public int hashCode() {
        return Objects.hash(itemCode, location);
    }
}
