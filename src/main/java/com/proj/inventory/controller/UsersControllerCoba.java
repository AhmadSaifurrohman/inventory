package com.proj.inventory.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.proj.inventory.model.Transaction;
import com.proj.inventory.model.User;
import com.proj.inventory.service.UserService;

import java.util.Date;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/users")
public class UsersControllerCoba {

    @Autowired
    private UserService userService;

    @GetMapping
    public String showUserListPage(Model model, HttpServletRequest request) {
        model.addAttribute("title", "Users List");
        model.addAttribute("currentUrl", request.getRequestURI());
        model.addAttribute("content", "users.jsp");
        return "layout";
    }

    @GetMapping("/all")
    @ResponseBody
    public ResponseEntity<List<User>> getUsers(
    @RequestParam(value = "id", required = false) String id
    ) {
        List<User> user;

        user = userService.getAllUsers();

        return ResponseEntity.ok(user);
    }
}
