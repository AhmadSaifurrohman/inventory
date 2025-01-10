package com.proj.inventory;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class LoginInterceptor implements HandlerInterceptor{
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // Periksa sesi login
        if (request.getSession().getAttribute("user") == null) {
            // Redirect ke halaman login jika user belum login
            response.sendRedirect("/login");
            return false;
        }
        return true; // Lanjutkan request jika sudah login
    }
}
