package com.ecom.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import com.ecom.model.Cart;
import com.ecom.model.Product;
import com.ecom.model.UserDtls;
import com.ecom.repository.CartRepository;
import com.ecom.repository.ProductRepository;
import com.ecom.repository.UserRepository;
import com.ecom.service.impl.CartServiceImpl;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class CartServiceImplTest {

    @Mock
    private CartRepository cartRepository;

    @Mock
    private UserRepository userRepository;

    @Mock
    private ProductRepository productRepository;

    @InjectMocks
    private CartServiceImpl cartService;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }
    
    @Test
    public void testSaveCart_Success() {
        UserDtls user = new UserDtls();
        user.setId(1);

        Product product = new Product();
        product.setId(1);
        product.setDiscountPrice(100.0);

        Cart cart = new Cart();
        cart.setProduct(product);
        cart.setUser(user);
        cart.setQuantity(1);
        cart.setTotalPrice(100.0);

        when(userRepository.findById(1)).thenReturn(Optional.of(user));
        when(productRepository.findById(1)).thenReturn(Optional.of(product));
        when(cartRepository.findByProductIdAndUserId(1, 1)).thenReturn(null);
        when(cartRepository.save(any(Cart.class))).thenReturn(cart);

        Cart savedCart = cartService.saveCart(1, 1);

        assertNotNull(savedCart);
        assertEquals(1, savedCart.getQuantity());
        assertEquals(100.0, savedCart.getTotalPrice());
        verify(cartRepository, times(1)).save(any(Cart.class));
    }
    
    
    @Test
    public void testSaveCart_Failure_UserNotFound() {
        when(userRepository.findById(1)).thenReturn(Optional.empty());

        // Correct usage of assertThrows
        NoSuchElementException exception = assertThrows(NoSuchElementException.class, () -> {
            cartService.saveCart(1, 1);
        });

        assertEquals("No value present", exception.getMessage());
        verify(cartRepository, times(0)).save(any(Cart.class));
    }


    @Test
    public void testSaveCart_Failure_ProductNotFound() {
        UserDtls user = new UserDtls();
        user.setId(1);

        when(userRepository.findById(1)).thenReturn(Optional.of(user));
        when(productRepository.findById(1)).thenReturn(Optional.empty());

        // Correct usage of assertThrows
        NoSuchElementException exception = assertThrows(NoSuchElementException.class, () -> {
            cartService.saveCart(1, 1);
        });

        assertEquals("No value present", exception.getMessage());
        verify(cartRepository, times(0)).save(any(Cart.class));
    }

    
    @Test
    public void testGetCartsByUser_Success() {
        UserDtls user = new UserDtls();
        user.setId(1);

        Product product = new Product();
        product.setDiscountPrice(100.0);

        Cart cart = new Cart();
        cart.setProduct(product);
        cart.setUser(user);
        cart.setQuantity(2);

        List<Cart> carts = new ArrayList<>();
        carts.add(cart);

        when(cartRepository.findByUserId(1)).thenReturn(carts);

        List<Cart> retrievedCarts = cartService.getCartsByUser(1);

        assertNotNull(retrievedCarts);
        assertEquals(2, retrievedCarts.get(0).getQuantity());
        assertEquals(200.0, retrievedCarts.get(0).getTotalPrice());
    }
    
    @Test
    public void testGetCartsByUser_NoCartsFound() {
        when(cartRepository.findByUserId(1)).thenReturn(new ArrayList<>());

        List<Cart> retrievedCarts = cartService.getCartsByUser(1);

        assertTrue(retrievedCarts.isEmpty());
    }

    @Test
    public void testGetCountCart_Success() {
        when(cartRepository.countByUserId(1)).thenReturn(5);

        Integer count = cartService.getCountCart(1);

        assertEquals(5, count);
    }

    @Test
    public void testGetCountCart_NoCarts() {
        when(cartRepository.countByUserId(1)).thenReturn(0);

        Integer count = cartService.getCountCart(1);

        assertEquals(0, count);
    }

    @Test
    public void testUpdateQuantity_Increase() {
        Cart cart = new Cart();
        cart.setQuantity(1);

        when(cartRepository.findById(1)).thenReturn(Optional.of(cart));

        cartService.updateQuantity("in", 1);

        assertEquals(2, cart.getQuantity());
        verify(cartRepository, times(1)).save(cart);
    }

    @Test
    public void testUpdateQuantity_Decrease() {
        Cart cart = new Cart();
        cart.setQuantity(2);

        when(cartRepository.findById(1)).thenReturn(Optional.of(cart));

        cartService.updateQuantity("de", 1);

        assertEquals(1, cart.getQuantity());
        verify(cartRepository, times(1)).save(cart);
    }

    @Test
    public void testClearCartByUser_Success() {
        List<Cart> carts = new ArrayList<>();
        Cart cart = new Cart();
        carts.add(cart);

        when(cartRepository.findByUserId(1)).thenReturn(carts);

        cartService.clearCartByUser(1);

        verify(cartRepository, times(1)).deleteAll(carts);
    }


}
