package com.proj.inventory.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.proj.inventory.service.DashboardService;

@RestController
@RequestMapping("/api/dashboard")
public class DashboardController {

    @Autowired
    private DashboardService dashboardService;

    @GetMapping
    public Map<String, Long> getDashboardSummary() {
        Map<String, Long> summary = new HashMap<>();
        summary.put("totalStock", dashboardService.getTotalStock());
        summary.put("totalInboundTransactions", dashboardService.getTotalInboundTransactions());
        summary.put("totalOutboundTransactions", dashboardService.getTotalOutboundTransactions());
        return summary;
    }
}
