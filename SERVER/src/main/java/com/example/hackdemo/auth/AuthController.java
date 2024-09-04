package com.example.hackdemo.auth;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @GetMapping("/google")
    public ResponseEntity<String> googleLogin() {
        return ResponseEntity.ok("구글 로그인을 시작하려면 이 URL로 리다이렉트하세요: /oauth2/authorization/google");
    }

    @GetMapping("/login/success")
    public ResponseEntity<String> loginSuccess(Authentication authentication) {
        OAuth2User oAuth2User = (OAuth2User) authentication.getPrincipal();
        String email = oAuth2User.getAttribute("email");
        String name = oAuth2User.getAttribute("name");

        return ResponseEntity.ok("로그인 성공! 이메일: " + email + ", 이름: " + name);
    }

    @GetMapping("/login/failure")
    public ResponseEntity<String> loginFailure() {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인 실패");
    }
}