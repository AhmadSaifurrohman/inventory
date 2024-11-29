package com.proj.inventory.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.proj.inventory.service.DashboardService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class DashboardController {

    @Autowired
    private DashboardService dashboardService;

    // Endpoint untuk menampilkan halaman dashboard
    @GetMapping("/")
    public String home(Model model, HttpServletRequest request) {
        // Setel judul halaman
        model.addAttribute("title", "Dashboard");
        model.addAttribute("currentUrl", request.getRequestURI());
        // Tentukan konten yang akan dimuat ke dalam layout.jsp
        model.addAttribute("content", "dashboard.jsp");

        // Kembalikan layout.jsp sebagai view utama
        return "layout";
    }

    // Endpoint REST API untuk data ringkasan dashboard
    @GetMapping("/api/dashboard")
    @ResponseBody
    public Map<String, Long> getDashboardSummary() {
        Map<String, Long> summary = new HashMap<>();
        summary.put("totalStock", dashboardService.getTotalStock());
        summary.put("totalInboundTransactions", dashboardService.getTotalInboundTransactions());
        summary.put("totalOutboundTransactions", dashboardService.getTotalOutboundTransactions());
        return summary;
    }
}