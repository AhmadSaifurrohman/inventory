package com.proj.inventory.controller;

import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.proj.inventory.model.User;
import com.proj.inventory.repository.UserRepository;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/login")
public class LoginController {

    // @Autowired
    // private UserRepository userRepository;

    private final UserRepository userRepository;

    public LoginController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    // Endpoint untuk menampilkan halaman login
    @GetMapping
    public String showLoginPage(Model model) {
        model.addAttribute("title", "Login");
        return "login_1";
    }

    // Memproses autentikasi login
    @PostMapping("/auth")
    public String authenticateUser(@RequestParam("username") String username,
                                   @RequestParam("password") String hashedPassword, //String password,
                                   HttpSession session,
                                   Model model) {

        Optional<User> userOpt = Optional.ofNullable(userRepository.findByUsername(username));
        
        if (userOpt.isPresent()) {
            User user = userOpt.get();

            // Enkripsi password yang dimasukkan dengan SHA-256
            // String hashedPassword = hashPassword(password);
            
            if (user.getPassword().equals(hashedPassword)) { 
                session.setAttribute("user", user);
                session.setAttribute("username", user.getUsername());
                session.setMaxInactiveInterval(30 * 60);
                return "redirect:/";
            } else {
                model.addAttribute("error", "Username atau Password salah!");
            }
        } else {
            model.addAttribute("error", "Username atau Password salah!");
        }
        return "login_1";
    }

    // private String hashPassword(String password) {
    //     try {
    //         MessageDigest digest = MessageDigest.getInstance("SHA-256");
    //         byte[] hashedBytes = digest.digest(password.getBytes());
    //         StringBuilder hexString = new StringBuilder();
    //         for (byte b : hashedBytes) {
    //             hexString.append(String.format("%02x", b));
    //         }
    //         return hexString.toString();
    //     } catch (NoSuchAlgorithmException e) {
    //         throw new RuntimeException("Error hashing password", e);
    //     }
    // }

    @GetMapping("/out")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

}
