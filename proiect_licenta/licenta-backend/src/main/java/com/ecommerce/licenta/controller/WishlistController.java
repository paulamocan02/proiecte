package com.ecommerce.licenta.controller;

import com.ecommerce.licenta.common.ApiResponse;
import com.ecommerce.licenta.dto.ProductDto;
import com.ecommerce.licenta.model.Product;
import com.ecommerce.licenta.model.User;
import com.ecommerce.licenta.model.Wishlist;
import com.ecommerce.licenta.service.AuthenticationService;
import com.ecommerce.licenta.service.WishlistService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/wishlist")
public class WishlistController {

    @Autowired
    WishlistService wishlistService;

    @Autowired
    AuthenticationService authenticationService;

    // save product as wishlist item
    @PostMapping("/add")
    public ResponseEntity<ApiResponse> addToWishlist(@RequestBody Product product, @RequestParam("token") String token) {

        // authenticate the token
        authenticationService.authenticate(token);

        // find the user
        User user = authenticationService.getUser(token);

        // save the item in wishlist
        Wishlist wishlist = new Wishlist(user, product);

        wishlistService.createWishlist(wishlist);

        ApiResponse apiResponse = new ApiResponse(true, "Added to wishlist");
        return new ResponseEntity<>(apiResponse, HttpStatus.CREATED);

    }

    // get all wishlist items for a user

    @GetMapping("/{token}")
    public ResponseEntity<List<ProductDto>> getWishlist(@PathVariable("token") String token) {

        // authenticate the token
        authenticationService.authenticate(token);

        // find the user
        User user = authenticationService.getUser(token);

        List<ProductDto> productDtos = wishlistService.getWishlistForUser(user);

        return new ResponseEntity<>(productDtos, HttpStatus.OK);
    }
}
