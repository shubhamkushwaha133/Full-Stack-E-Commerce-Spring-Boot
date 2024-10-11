package com.ecom.dao;

import com.ecom.model.Wishlist;
import com.ecom.model.Product;

import java.util.List;

public interface WishlistDAO {
    void add(Wishlist wishlist);
    List<Product> findProductsByUserId(Integer userId);
}
