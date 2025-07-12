package com.ecommerce.licenta.service;

import com.ecommerce.licenta.dto.ResponseDto;
import com.ecommerce.licenta.dto.user.SignInDto;
import com.ecommerce.licenta.dto.user.SignInResponseDto;
import com.ecommerce.licenta.dto.user.SignupDto;
import com.ecommerce.licenta.exceptions.AuthenticationFailException;
import com.ecommerce.licenta.exceptions.CustomException;
import com.ecommerce.licenta.model.AuthenticationToken;
import com.ecommerce.licenta.model.User;
import com.ecommerce.licenta.repository.UserRepo;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HexFormat;
import java.util.Objects;

@Service
public class UserService {

    @Autowired
    UserRepo userRepo;

    @Autowired
    AuthenticationService authenticationService;

    @Transactional

    public ResponseDto signUp(SignupDto signupDto) {
        // check if user is already present
        if (Objects.nonNull(userRepo.findByEmail(signupDto.getEmail()))) {
            // we have a user
            throw new CustomException("user is already present");
        }


        // hash the password

        String encryptedpassword = signupDto.getPassword();
        try {
            encryptedpassword = hashPassword(signupDto.getPassword());
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        User user = new User(signupDto.getFirstName(), signupDto.getLastName(), signupDto.getEmail(), encryptedpassword);
        userRepo.save(user);

        // save the user
        // create the token

        final AuthenticationToken authenticationToken = new AuthenticationToken(user);
        authenticationService.saveConfirmationToken(authenticationToken);

        ResponseDto responseDto = new ResponseDto("success", "user created successfully");
        return responseDto;
    }

    private String hashPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(password.getBytes());
        byte[] digest = md.digest();
        return HexFormat.of().formatHex(digest).toUpperCase();
    }

    public SignInResponseDto signIn(SignInDto signInDto) {
        // find user by email

        User user = userRepo.findByEmail(signInDto.getEmail());

        if (Objects.isNull(user)) {
            throw new AuthenticationFailException("user is not registered");
        }

        // hash the password

        try {
            if (!user.getPassword().equals(hashPassword(signInDto.getPassword()))) {
                throw new AuthenticationFailException("wrong password");
            }
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        // compare the password in DB

        // if password match

        AuthenticationToken token = authenticationService.getToken(user);

        // retrieve the token

        if (Objects.isNull(token)) {
            throw new CustomException("token is not present");
        }
        return new SignInResponseDto("success", token.getToken());

        // return response
    }
}
