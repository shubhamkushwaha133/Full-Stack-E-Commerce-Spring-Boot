package com.ecom.controller;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import com.ecom.model.Cart;
import com.ecom.model.OrderRequest;
import com.ecom.model.UserDtls;
import com.ecom.model.Wishlist;
import com.ecom.service.CartService;
import com.ecom.service.OrderService;
import com.ecom.service.UserService;
import com.ecom.service.WishlistService;

public class UserControllerTest {

    private MockMvc mockMvc;

    @Mock
    private UserService userService;

    @Mock
    private CartService cartService;
    
    @Mock
    private OrderService orderService;

    @Mock
    private WishlistService wishlistService;

    @InjectMocks
    private UserController userController;
    
    

    @BeforeEach
    public void setup() {
        MockitoAnnotations.openMocks(this);
        mockMvc = MockMvcBuilders.standaloneSetup(userController).build();
    }

    @Test
    public void testHome() throws Exception {
        mockMvc.perform(get("/user/"))
               .andExpect(status().isOk())
               .andExpect(view().name("user/home"));
    }
    
    // Example Principal Mock
    private Principal getMockPrincipal(String email) {
        return () -> email;
    }

    // Mocked session
    private MockHttpSession getSession() {
        return new MockHttpSession();
    }

    // Helper method to get a User object
    private UserDtls getUserDtls() {
        UserDtls user = new UserDtls();
        user.setId(1);
        user.setEmail("test@example.com");
        return user;
    }

    // Helper method to mock Cart list
    private List<Cart> getMockCartList() {
        List<Cart> carts = new ArrayList<>();
        Cart cart = new Cart();
        cart.setId(1);
        cart.setTotalPrice(100.0);
        carts.add(cart);
        return carts;
    }

    // Helper method to mock Wishlist
    private List<Wishlist> getMockWishlistList() {
        List<Wishlist> wishlist = new ArrayList<>();
        Wishlist wl = new Wishlist();
        wl.setId((long) 1);
        wishlist.add(wl);
        return wishlist;
    }
    
    @Test
    public void testAddToWishlist_Success() throws Exception {
        Principal principal = getMockPrincipal("test@example.com");
        UserDtls user = getUserDtls();
        
        when(userService.getUserByEmail("test@example.com")).thenReturn(user);
        when(wishlistService.addToWishlist(user, 1)).thenReturn(new Wishlist());

        mockMvc.perform(get("/user/addWishlist").param("productId", "1").principal(principal))
               .andExpect(status().is3xxRedirection())
               .andExpect(redirectedUrl("/product/1"));
        
        verify(wishlistService, times(1)).addToWishlist(user, 1);
    }

    @Test
    public void testAddToWishlist_Failure() throws Exception {
        Principal principal = getMockPrincipal("test@example.com");
        UserDtls user = getUserDtls();
        
        when(userService.getUserByEmail("test@example.com")).thenReturn(user);
        when(wishlistService.addToWishlist(user, 1)).thenReturn(null);

        mockMvc.perform(get("/user/addWishlist").param("productId", "1").principal(principal))
               .andExpect(status().is3xxRedirection())
               .andExpect(redirectedUrl("/product/1"));
        
        verify(wishlistService, times(1)).addToWishlist(user, 1);
    }

    @Test
    public void testRemoveFromWishlist_Success() throws Exception {
        Principal principal = getMockPrincipal("test@example.com");
        UserDtls user = getUserDtls();
        MockHttpSession session = getSession();

        when(userService.getUserByEmail("test@example.com")).thenReturn(user);

        mockMvc.perform(get("/user/removeWishlist").param("productId", "1").session(session).principal(principal))
               .andExpect(status().is3xxRedirection())
               .andExpect(redirectedUrl("/user/wishlist"));
        
        verify(wishlistService, times(1)).removeFromWishlist(user, 1);
        assertEquals("Product removed from wishlist", session.getAttribute("succMsg"));
    }

    @Test
    public void testViewWishlist_Success() throws Exception {
        Principal principal = getMockPrincipal("test@example.com");
        UserDtls user = getUserDtls();
        
        when(userService.getUserByEmail("test@example.com")).thenReturn(user);
        when(wishlistService.getWishlistByUser(user)).thenReturn(getMockWishlistList());

        mockMvc.perform(get("/user/wishlist").principal(principal))
               .andExpect(status().isOk())
               .andExpect(model().attributeExists("wishlist"))
               .andExpect(view().name("user/wishlist"));
        
        verify(wishlistService, times(1)).getWishlistByUser(user);
    }

    @Test
    public void testAddToCart_Success() throws Exception {
        MockHttpSession session = getSession();
        Cart cart = new Cart();
        
        when(cartService.saveCart(1, 1)).thenReturn(cart);
        
        mockMvc.perform(get("/user/addCart")
                        .param("pid", "1")
                        .param("uid", "1")
                        .session(session))
               .andExpect(status().is3xxRedirection())
               .andExpect(redirectedUrl("/product/1"));
        
        assertEquals("Product added to cart", session.getAttribute("succMsg"));
        verify(cartService, times(1)).saveCart(1, 1);
    }

    @Test
    public void testAddToCart_Failure() throws Exception {
        MockHttpSession session = getSession();
        
        when(cartService.saveCart(1, 1)).thenReturn(null);

        mockMvc.perform(get("/user/addCart")
                        .param("pid", "1")
                        .param("uid", "1")
                        .session(session))
               .andExpect(status().is3xxRedirection())
               .andExpect(redirectedUrl("/product/1"));
        
        assertEquals("Product add to cart failed", session.getAttribute("errorMsg"));
        verify(cartService, times(1)).saveCart(1, 1);
    }

    @Test
    public void testLoadCartPage_Success() throws Exception {
        Principal principal = getMockPrincipal("test@example.com");
        UserDtls user = getUserDtls();
        
        when(userService.getUserByEmail("test@example.com")).thenReturn(user);
        when(cartService.getCartsByUser(user.getId())).thenReturn(getMockCartList());

        mockMvc.perform(get("/user/cart").principal(principal))
               .andExpect(status().isOk())
               .andExpect(model().attributeExists("carts"))
               .andExpect(view().name("user/cart"));
        
        verify(cartService, times(1)).getCartsByUser(user.getId());
    }

    @Test
    public void testUpdateCartQuantity_Success() throws Exception {
        mockMvc.perform(get("/user/cartQuantityUpdate")
                        .param("sy", "in")
                        .param("cid", "1"))
               .andExpect(status().is3xxRedirection())
               .andExpect(redirectedUrl("/user/cart"));
        
        verify(cartService, times(1)).updateQuantity("in", 1);
    }

    @Test
    public void testSaveOrder_Success() throws Exception {
        Principal principal = getMockPrincipal("test@example.com");
        UserDtls user = getUserDtls();

        when(userService.getUserByEmail("test@example.com")).thenReturn(user);

        mockMvc.perform(post("/user/save-order")
                        .param("address", "Test Address")
                        .param("paymentMethod", "Cash")
                        .principal(principal))
               .andExpect(status().is3xxRedirection())
               .andExpect(redirectedUrl("/user/success"));
        
		verify(orderService, times(1)).saveOrder(user.getId(), any(OrderRequest.class));
        verify(cartService, times(1)).clearCartByUser(user.getId());
    }

}
