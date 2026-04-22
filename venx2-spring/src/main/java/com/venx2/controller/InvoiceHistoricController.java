package com.venx2.controller;

import com.venx2.entity.Profile;
import com.venx2.service.CartTempService;
import com.venx2.service.InvoiceHistoricService;
import com.venx2.service.ProfileService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/invoice-historics")
public class InvoiceHistoricController extends BaseController {

    private final InvoiceHistoricService invoiceHistoricService;
    private final CartTempService cartTempService;

    public InvoiceHistoricController(ProfileService profileService,
                                      InvoiceHistoricService invoiceHistoricService,
                                      CartTempService cartTempService) {
        super(profileService);
        this.invoiceHistoricService = invoiceHistoricService;
        this.cartTempService = cartTempService;
    }

    @GetMapping
    public String index(Model model) {
        Profile profile = getCurrentProfile();
        if (profile == null) return "redirect:/login";
        model.addAttribute("invoices", invoiceHistoricService.findByProfile(profile.getId()));
        model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
        model.addAttribute("profile", profile);
        return "invoice-historics/index";
    }

    @GetMapping("/{id}")
    public String show(@PathVariable Long id, Model model) {
        Profile profile = getCurrentProfile();
        if (profile == null) return "redirect:/login";
        return invoiceHistoricService.findById(id).map(invoice -> {
            model.addAttribute("invoice", invoice);
            model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
            model.addAttribute("profile", profile);
            return "invoice-historics/show";
        }).orElse("redirect:/invoice-historics");
    }
}
