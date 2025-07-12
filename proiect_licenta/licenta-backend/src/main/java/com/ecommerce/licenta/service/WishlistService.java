package com.ecommerce.licenta.service;

import com.ecommerce.licenta.dto.ProductDto;
import com.ecommerce.licenta.model.User;
import com.ecommerce.licenta.model.Wishlist;
import com.ecommerce.licenta.repository.WishlistRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class WishlistService {

    @Autowired
    WishlistRepo wishlistRepo;

    @Autowired
    ProductService productService;

    public void createWishlist(Wishlist wishlist) {
        wishlistRepo.save(wishlist);
    }

    public List<ProductDto> getWishlistForUser(User user) {
        final List<Wishlist> wishlists = wishlistRepo.findAllByUserOrderByCreatedDateDesc(user);
        List<ProductDto> productDtos = new ArrayList<>();
        for (Wishlist wishlist: wishlists) {
            productDtos.add(productService.getProductDto(wishlist.getProduct()));
        }

        return productDtos;
    }
}
