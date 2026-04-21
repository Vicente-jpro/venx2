package com.venx2.controller;

import com.venx2.entity.Company;
import com.venx2.entity.Profile;
import com.venx2.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/companies")
public class CompanyController extends BaseController {
    private final CompanyService companyService;
    private final CartTempService cartTempService;

    public CompanyController(ProfileService profileService, CompanyService companyService, CartTempService cartTempService) {
        super(profileService); this.companyService = companyService; this.cartTempService = cartTempService;
    }

    @GetMapping
    public String index(Model model) {
        Profile profile = getCurrentProfile();
        model.addAttribute("companies", companyService.findAll());
        model.addAttribute("profile", profile);
        if (profile != null) model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
        return "companies/index";
    }

    @GetMapping("/new")
    public String newForm(Model model) {
        Profile profile = getCurrentProfile();
        if (profile == null || !profile.isAdmin()) return "redirect:/companies";
        model.addAttribute("company", new Company());
        model.addAttribute("profile", profile);
        model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
        return "companies/form";
    }

    @PostMapping
    public String create(@RequestParam String name, @RequestParam(required=false) String whatsapp,
                          @RequestParam(required=false) String telephone, @RequestParam(required=false) String email,
                          @RequestParam(required=false) String nif, RedirectAttributes ra) {
        Profile profile = getCurrentProfile();
        if (profile == null || !profile.isAdmin()) { ra.addFlashAttribute("error", "Access denied."); return "redirect:/companies"; }
        Company c = new Company(); c.setName(name); c.setWhatsapp(whatsapp); c.setTelephone(telephone); c.setEmail(email); c.setNif(nif);
        companyService.save(c);
        ra.addFlashAttribute("success", "Company created.");
        return "redirect:/companies";
    }

    @GetMapping("/{id}/edit")
    public String editForm(@PathVariable Long id, Model model) {
        Profile profile = getCurrentProfile();
        if (profile == null || !profile.isAdmin()) return "redirect:/companies";
        return companyService.findById(id).map(c -> {
            model.addAttribute("company", c);
            model.addAttribute("profile", profile);
            model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
            return "companies/form";
        }).orElse("redirect:/companies");
    }

    @PostMapping("/{id}/update")
    public String update(@PathVariable Long id, @RequestParam String name, @RequestParam(required=false) String whatsapp,
                          @RequestParam(required=false) String telephone, @RequestParam(required=false) String email,
                          @RequestParam(required=false) String nif, RedirectAttributes ra) {
        companyService.findById(id).ifPresent(c -> {
            c.setName(name); c.setWhatsapp(whatsapp); c.setTelephone(telephone); c.setEmail(email); c.setNif(nif);
            companyService.save(c);
        });
        ra.addFlashAttribute("success", "Company updated.");
        return "redirect:/companies";
    }

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id, RedirectAttributes ra) {
        companyService.delete(id);
        ra.addFlashAttribute("success", "Company deleted.");
        return "redirect:/companies";
    }
}
