package com.proj.inventory.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "tb_user")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    // @Column(unique = true)
    private String username;
    private String password;
    private String role;

    // Getters and Setters
    // Constructor
    public User() {

    }

    public User(Integer id, String username, String password, String role) {
        super();
        this.username = username;
        this.password = password;
        this.role = role;
    }

    // Getter dan setter
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
     return "User [id=" + id + ", username=" + username + ", password=" + password + ", role=" + role + "]";
    }
}
