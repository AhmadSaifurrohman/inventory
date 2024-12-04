package com.proj.inventory.service;

import com.proj.inventory.model.Item;
import com.proj.inventory.model.Location;
import com.proj.inventory.model.Unit;
import com.proj.inventory.repository.ItemRepository;
import com.proj.inventory.repository.LocationRepository;
import com.proj.inventory.repository.UnitRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MasterDataService {

    @Autowired
    private ItemRepository itemRepository;

    @Autowired
    private LocationRepository locationRepository;

    @Autowired
    private UnitRepository unitRepository;

    // CRUD untuk Item
    public List<Item> getAllItems() {
        return itemRepository.findAll();
    }

    public Item saveOrUpdateItem(Item item) {
        return itemRepository.save(item);
    }

    public void deleteItem(String itemCode) {
        itemRepository.deleteById(itemCode);
    }

    public Item findItemByCode(String itemCode) {
        return itemRepository.findByItemCode(itemCode); 
    }

    // CRUD untuk Location
    public List<Location> getAllLocations() {
        return locationRepository.findAll();
    }

    public Location saveOrUpdateLocation(Location location) {
        return locationRepository.save(location);
    }

    public void deleteLocation(String locCd) {
        locationRepository.deleteById(locCd);
    }

    // CRUD untuk Unit
    public List<Unit> getAllUnits() {
        return unitRepository.findAll();
    }

    public Unit saveOrUpdateUnit(Unit unit) {
        return unitRepository.save(unit);
    }

    public void deleteUnit(String unitCd) {
        unitRepository.deleteById(unitCd);
    }
}
