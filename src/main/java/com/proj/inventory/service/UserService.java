package com.proj.inventory.service;

import com.proj.inventory.model.User;

public interface UserService {
    User findByUsername(String username);
}
