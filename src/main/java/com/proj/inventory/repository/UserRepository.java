package com.proj.inventory.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.proj.inventory.model.User;

public interface UserRepository extends JpaRepository<User, Long> {
    // Repository ini sudah menyediakan operasi CRUD untuk User (TB_USERS)

    // Tambahkan query untuk mencari user berdasarkan username (opsional, jika diperlukan untuk autentikasi)
    User findByUsername(String username);
}
