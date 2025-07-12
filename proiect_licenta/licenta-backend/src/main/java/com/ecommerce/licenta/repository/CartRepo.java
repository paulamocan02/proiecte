package com.ecommerce.licenta.repository;

import com.ecommerce.licenta.model.Cart;
import com.ecommerce.licenta.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CartRepo extends JpaRepository<Cart, Integer> {
    List<Cart> findAllByUserOrderByCreatedDateDesc(User user);
}
