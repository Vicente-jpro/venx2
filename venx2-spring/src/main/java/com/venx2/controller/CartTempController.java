package com.venx2.controller;

import com.venx2.entity.Profile;
import com.venx2.service.CartTempService;
import com.venx2.service.ProfileService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/cart-temps")
public class CartTempController extends BaseController {

    private final CartTempService cartTempService;

    public CartTempController(ProfileService profileService, CartTempService cartTempService) {
        super(profileService);
        this.cartTempService = cartTempService;
    }

    @GetMapping
    public String index(Model model) {
        Profile profile = getCurrentProfile();
        if (profile == null) return "redirect:/login";
        model.addAttribute("cartItems", cartTempService.findByProfile(profile.getId()));
        model.addAttribute("total", cartTempService.getTotalCost(profile.getId()));
        model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
        model.addAttribute("profile", profile);
        return "cart-temps/index";
    }

    @PostMapping("/add/{itemId}")
    public String addToCart(@PathVariable Long itemId, RedirectAttributes ra) {
        Profile profile = getCurrentProfile();
        if (profile == null) return "redirect:/login";
        try {
            cartTempService.addToCart(itemId, profile.getId());
            ra.addFlashAttribute("success", "Item added to cart.");
        } catch (Exception e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/items";
    }

    @PostMapping("/{id}/remove")
    public String removeFromCart(@PathVariable Long id, RedirectAttributes ra) {
        Profile profile = getCurrentProfile();
        if (profile == null) return "redirect:/login";
        try {
            cartTempService.removeFromCart(id);
            ra.addFlashAttribute("success", "Item removed from cart.");
        } catch (Exception e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/cart-temps";
    }

    @PostMapping("/{id}/increment")
    public String increment(@PathVariable Long id, RedirectAttributes ra) {
        try {
            cartTempService.incrementQuantity(id);
        } catch (Exception e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/cart-temps";
    }

    @PostMapping("/{id}/decrement")
    public String decrement(@PathVariable Long id, RedirectAttributes ra) {
        try {
            cartTempService.decrementQuantity(id);
        } catch (Exception e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/cart-temps";
    }

    @PostMapping("/cancel")
    public String cancelCart(RedirectAttributes ra) {
        Profile profile = getCurrentProfile();
        if (profile == null) return "redirect:/login";
        try {
            cartTempService.cancelCart(profile.getId());
            ra.addFlashAttribute("success", "Cart cancelled. Items restored.");
        } catch (Exception e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/items";
    }
}
