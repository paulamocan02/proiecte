package com.ecommerce.licenta.controller;

import com.ecommerce.licenta.dto.ResponseDto;
import com.ecommerce.licenta.dto.user.SignInDto;
import com.ecommerce.licenta.dto.user.SignInResponseDto;
import com.ecommerce.licenta.dto.user.SignupDto;
import com.ecommerce.licenta.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("user")
@RestController
public class UserController {

    @Autowired
    UserService userService;

    // two apis

    // sign up

    @PostMapping("/signup")
    public ResponseDto signup(@RequestBody SignupDto signupDto) {
        return userService.signUp(signupDto);
    }

    //sign in

    @PostMapping("/signin")
    public SignInResponseDto signIn(@RequestBody SignInDto signInDto) {
        return userService.signIn(signInDto);
    }

}
