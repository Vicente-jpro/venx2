package com.venx2.controller;

import com.venx2.entity.Profile;
import com.venx2.service.CartTempService;
import com.venx2.service.InvoiceService;
import com.venx2.service.ProfileService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;

@Controller
@RequestMapping("/invoice-temps")
public class InvoiceTempController extends BaseController {

    private final InvoiceService invoiceService;
    private final CartTempService cartTempService;

    public InvoiceTempController(ProfileService profileService,
                                  InvoiceService invoiceService,
                                  CartTempService cartTempService) {
        super(profileService);
        this.invoiceService = invoiceService;
        this.cartTempService = cartTempService;
    }

    @GetMapping("/new")
    public String newInvoice(Model model) {
        Profile profile = getCurrentProfile();
        if (profile == null) return "redirect:/login";
        BigDecimal total = cartTempService.getTotalCost(profile.getId());
        if (total.compareTo(BigDecimal.ZERO) == 0) {
            return "redirect:/cart-temps";
        }
        model.addAttribute("total", total);
        model.addAttribute("cartItems", cartTempService.findByProfile(profile.getId()));
        model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
        model.addAttribute("profile", profile);
        return "invoice-temps/new";
    }

    @PostMapping
    public String create(@RequestParam String clienteName,
                         @RequestParam String paymentMethod,
                         @RequestParam BigDecimal valueDelivered,
                         RedirectAttributes ra) {
        Profile profile = getCurrentProfile();
        if (profile == null) return "redirect:/login";
        try {
            invoiceService.createInvoice(clienteName, paymentMethod, valueDelivered, profile);
            ra.addFlashAttribute("success", "Invoice created successfully!");
            return "redirect:/invoice-historics";
        } catch (Exception e) {
            ra.addFlashAttribute("error", e.getMessage());
            return "redirect:/invoice-temps/new";
        }
    }
}
