package com.proj.inventory.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "TB_MAS_LOC")
public class Location {

    @Id
    @Column(name = "LOCCD", nullable = false)
    private String locCd;

    @Column(name = "LOCATION")
    private String location;

    // Getters and Setters
    public String getLocCd() {
        return locCd;
    }

    public void setLocCd(String locCd) {
        this.locCd = locCd;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
}
