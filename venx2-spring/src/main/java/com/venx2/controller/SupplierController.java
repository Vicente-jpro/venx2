package com.venx2.controller;

import com.venx2.entity.Profile;
import com.venx2.entity.Supplier;
import com.venx2.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/suppliers")
public class SupplierController extends BaseController {
    private final SupplierService supplierService;
    private final CartTempService cartTempService;
    private final AddressService addressService;

    public SupplierController(ProfileService profileService, SupplierService supplierService,
                               CartTempService cartTempService, AddressService addressService) {
        super(profileService);
        this.supplierService = supplierService;
        this.cartTempService = cartTempService;
        this.addressService = addressService;
    }

    @GetMapping
    public String index(Model model) {
        Profile profile = getCurrentProfile();
        model.addAttribute("suppliers", supplierService.findAll());
        model.addAttribute("profile", profile);
        if (profile != null) model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
        return "suppliers/index";
    }

    @GetMapping("/new")
    public String newForm(Model model) {
        Profile profile = getCurrentProfile();
        if (profile == null || !profile.isAdmin()) return "redirect:/suppliers";
        model.addAttribute("supplier", new Supplier());
        model.addAttribute("addresses", addressService.findAll());
        model.addAttribute("profile", profile);
        model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
        return "suppliers/form";
    }

    @PostMapping
    public String create(@RequestParam String nameSupplier,
                          @RequestParam(required=false) String whatsapp,
                          @RequestParam(required=false) String telephone,
                          @RequestParam(required=false) String email,
                          RedirectAttributes ra) {
        Profile profile = getCurrentProfile();
        if (profile == null || !profile.isAdmin()) { ra.addFlashAttribute("error", "Access denied."); return "redirect:/suppliers"; }
        Supplier s = new Supplier();
        s.setNameSupplier(nameSupplier);
        s.setWhatsapp(whatsapp);
        s.setTelephone(telephone);
        s.setEmail(email);
        s.setProfile(profile);
        supplierService.save(s);
        ra.addFlashAttribute("success", "Supplier created.");
        return "redirect:/suppliers";
    }

    @GetMapping("/{id}/edit")
    public String editForm(@PathVariable Long id, Model model) {
        Profile profile = getCurrentProfile();
        if (profile == null || !profile.isAdmin()) return "redirect:/suppliers";
        return supplierService.findById(id).map(s -> {
            model.addAttribute("supplier", s);
            model.addAttribute("addresses", addressService.findAll());
            model.addAttribute("profile", profile);
            model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
            return "suppliers/form";
        }).orElse("redirect:/suppliers");
    }

    @PostMapping("/{id}/update")
    public String update(@PathVariable Long id, @RequestParam String nameSupplier,
                          @RequestParam(required=false) String whatsapp,
                          @RequestParam(required=false) String telephone,
                          @RequestParam(required=false) String email, RedirectAttributes ra) {
        supplierService.findById(id).ifPresent(s -> {
            s.setNameSupplier(nameSupplier); s.setWhatsapp(whatsapp); s.setTelephone(telephone); s.setEmail(email);
            supplierService.save(s);
        });
        ra.addFlashAttribute("success", "Supplier updated.");
        return "redirect:/suppliers";
    }

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id, RedirectAttributes ra) {
        Profile profile = getCurrentProfile();
        if (profile == null || !profile.isAdmin()) { ra.addFlashAttribute("error", "Access denied."); return "redirect:/suppliers"; }
        supplierService.delete(id);
        ra.addFlashAttribute("success", "Supplier deleted.");
        return "redirect:/suppliers";
    }
}
