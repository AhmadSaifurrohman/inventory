package com.proj.inventory.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.proj.inventory.model.Item;
import com.proj.inventory.model.Location;
import com.proj.inventory.model.Unit;
import com.proj.inventory.service.MasterDataService;

@RestController
@RequestMapping("/api/master")
public class MasterDataController {

    @Autowired
    private MasterDataService masterDataService;

    // Item Endpoints
    @GetMapping("/items")
    public List<Item> getAllItems() {
        return masterDataService.getAllItems();
    }

    @PostMapping("/items")
    public Item saveOrUpdateItem(@RequestBody Item item) {
        return masterDataService.saveOrUpdateItem(item);
    }

    @DeleteMapping("/items/{itemCode}")
    public void deleteItem(@PathVariable String itemCode) {
        masterDataService.deleteItem(itemCode);
    }

    // Location Endpoints
    @GetMapping("/locations")
    public List<Location> getAllLocations() {
        return masterDataService.getAllLocations();
    }

    @PostMapping("/locations")
    public Location saveOrUpdateLocation(@RequestBody Location location) {
        return masterDataService.saveOrUpdateLocation(location);
    }

    @DeleteMapping("/locations/{locCd}")
    public void deleteLocation(@PathVariable String locCd) {
        masterDataService.deleteLocation(locCd);
    }

    // Unit Endpoints
    @GetMapping("/units")
    public List<Unit> getAllUnits() {
        return masterDataService.getAllUnits();
    }

    @PostMapping("/units")
    public Unit saveOrUpdateUnit(@RequestBody Unit unit) {
        return masterDataService.saveOrUpdateUnit(unit);
    }

    @DeleteMapping("/units/{unitCd}")
    public void deleteUnit(@PathVariable String unitCd) {
        masterDataService.deleteUnit(unitCd);
    }
}
