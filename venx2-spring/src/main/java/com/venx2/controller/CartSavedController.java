package com.venx2.controller;

import com.venx2.entity.Profile;
import com.venx2.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/cart-saveds")
public class CartSavedController extends BaseController {
    private final CartSavedService cartSavedService;
    private final CartTempService cartTempService;

    public CartSavedController(ProfileService profileService, CartSavedService cartSavedService, CartTempService cartTempService) {
        super(profileService); this.cartSavedService = cartSavedService; this.cartTempService = cartTempService;
    }

    @GetMapping
    public String index(Model model) {
        Profile profile = getCurrentProfile();
        if (profile == null) return "redirect:/login";
        model.addAttribute("savedCodes", cartSavedService.findDistinctCodes(profile.getId()));
        model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
        model.addAttribute("profile", profile);
        return "cart-saveds/index";
    }

    @PostMapping("/save")
    public String saveCart(RedirectAttributes ra) {
        Profile profile = getCurrentProfile();
        if (profile == null) return "redirect:/login";
        try {
            String code = cartSavedService.saveCart(profile.getId());
            ra.addFlashAttribute("success", "Cart saved with code: " + code);
        } catch (Exception e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/cart-saveds";
    }

    @PostMapping("/restore/{code}")
    public String restoreCart(@PathVariable String code, RedirectAttributes ra) {
        Profile profile = getCurrentProfile();
        if (profile == null) return "redirect:/login";
        try {
            cartSavedService.restoreCart(profile.getId(), code);
            ra.addFlashAttribute("success", "Cart restored.");
        } catch (Exception e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/cart-temps";
    }
}
