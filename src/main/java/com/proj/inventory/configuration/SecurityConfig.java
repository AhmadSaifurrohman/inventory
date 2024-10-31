package com.proj.inventory.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.proj.inventory.service.UserDetailsServiceImpl;

@Configuration
@EnableWebSecurity
@EnableJpaRepositories(basePackages = "com.proj.inventory.repository")
public class SecurityConfig {
    
    private final UserDetailsServiceImpl userDetailService;
    
    public SecurityConfig(UserDetailsServiceImpl userDetailsService){
        this.userDetailService = userDetailsService;
    }

    @Bean
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();        
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(authz -> authz
                .requestMatchers("/login", "/resources/**").permitAll()  // Allow access to login and static resources
                .requestMatchers("/admin/**").hasRole("ADMIN") // Only ADMIN role can access /admin
                .anyRequest().authenticated()  // All other requests require authentication
            )
            .formLogin(form -> form
                .loginPage("/login")  // Custom login page
                .defaultSuccessUrl("/admin", true)  // Redirect to /admin after successful login
                .permitAll()
            )
            .logout(logout -> logout
                .permitAll()
            );

        return http.build();
    }

    @Bean
    public UserDetailsService userDetailsService() {
        return userDetailService;
    }
}