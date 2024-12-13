package com.proj.inventory.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.proj.inventory.model.Item;
import com.proj.inventory.model.Location;
import com.proj.inventory.model.Unit;
import com.proj.inventory.service.MasterDataService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/master")
public class MasterDataController {

    @Autowired
    private MasterDataService masterDataService;

    // Endpoint untuk menampilkan halaman Master Data
    @GetMapping
    public String index(Model model, HttpServletRequest request) {
        model.addAttribute("title", "Master Data");
        model.addAttribute("currentUrl", request.getRequestURI());
        model.addAttribute("content", "master-data.jsp");
        return "layout";
    }

    // REST API untuk Item
    @GetMapping("/api/items")
    @ResponseBody
    public List<Item> getAllItems() {
        return masterDataService.getAllItems();
    }

    @GetMapping(value = "/api/get-item-details", produces = "application/json")
    @ResponseBody
    public ResponseEntity<?> getItemDetails(@RequestParam String itemCode) {
        Item item = masterDataService.findItemByCode(itemCode);
        if (item != null) {
            return ResponseEntity.ok(new ResponseData(item.getDescription(), item.getPartNumber(), item.getUnitCd()));
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Item not found");
        }
    }

    // Response Data
    public class ResponseData {
        private String description;
        private String partNumber;
        private String unitCd;

        public ResponseData(String description, String partNumber, String unitCd) {
            this.description = description;
            this.partNumber = partNumber;
            this.unitCd = unitCd;
        }

        // Getters and Setters
        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }

        public String getPartNumber() {
            return partNumber;
        }

        public void setPartNumber(String partNumber) {
            this.partNumber = partNumber;
        }

        public String getUnitCd() {
            return unitCd;
        }

        public void setUnitCd(String unitCd) {
            this.unitCd = unitCd;
        }
    }

    @PostMapping("/api/items")
    @ResponseBody
    public Item saveOrUpdateItem(@RequestBody Item item) {
        return masterDataService.saveOrUpdateItem(item);
    }

    @DeleteMapping("/api/items/{itemCode}")
    @ResponseBody
    public void deleteItem(@PathVariable String itemCode) {
        masterDataService.deleteItem(itemCode);
    }

    // REST API untuk Location
    @GetMapping("/api/locations")
    @ResponseBody
    public List<Location> getAllLocations() {
        return masterDataService.getAllLocations();
    }

    @PostMapping("/api/locations")
    @ResponseBody
    public Location saveOrUpdateLocation(@RequestBody Location location) {
        return masterDataService.saveOrUpdateLocation(location);
    }

    @DeleteMapping("/api/locations/{locCd}")
    @ResponseBody
    public void deleteLocation(@PathVariable String locCd) {
        masterDataService.deleteLocation(locCd);
    }

    // REST API untuk Unit
    @GetMapping("/api/units")
    @ResponseBody
    public List<Unit> getAllUnits() {
        return masterDataService.getAllUnits();
    }

    @PostMapping("/api/units")
    @ResponseBody
	public Unit saveOrUpdateUnit(@RequestBody Unit unit) {
        return masterDataService.saveOrUpdateUnit(unit);
    }

    @DeleteMapping("/api/units/{unitCd}")
    @ResponseBody
    public void deleteUnit(@PathVariable String unitCd) {
        masterDataService.deleteUnit(unitCd);
    }
}