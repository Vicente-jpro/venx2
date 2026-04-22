package com.venx2.controller;

import com.venx2.entity.Profile;
import com.venx2.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/profiles")
public class ProfileController extends BaseController {

    private final CartTempService cartTempService;
    private final CompanyService companyService;
    private final AddressService addressService;

    public ProfileController(ProfileService profileService,
                              CartTempService cartTempService,
                              CompanyService companyService,
                              AddressService addressService) {
        super(profileService);
        this.cartTempService = cartTempService;
        this.companyService = companyService;
        this.addressService = addressService;
    }

    @GetMapping
    public String index(Model model) {
        Profile profile = getCurrentProfile();
        if (profile == null) return "redirect:/login";
        boolean isAdmin = profile.isAdmin();
        if (isAdmin) {
            model.addAttribute("profiles", profileService.findAll());
        } else {
            model.addAttribute("profiles", java.util.List.of(profile));
        }
        model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
        model.addAttribute("profile", profile);
        return "profiles/index";
    }

    @GetMapping("/{id}")
    public String show(@PathVariable Long id, Model model) {
        Profile profile = getCurrentProfile();
        if (profile == null) return "redirect:/login";
        return profileService.findById(id).map(p -> {
            model.addAttribute("targetProfile", p);
            model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
            model.addAttribute("profile", profile);
            return "profiles/show";
        }).orElse("redirect:/profiles");
    }

    @GetMapping("/{id}/edit")
    public String editForm(@PathVariable Long id, Model model) {
        Profile profile = getCurrentProfile();
        if (profile == null) return "redirect:/login";
        return profileService.findById(id).map(p -> {
            model.addAttribute("targetProfile", p);
            model.addAttribute("companies", companyService.findAll());
            model.addAttribute("addresses", addressService.findAll());
            model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
            model.addAttribute("profile", profile);
            return "profiles/form";
        }).orElse("redirect:/profiles");
    }

    @PostMapping("/{id}/update")
    public String update(@PathVariable Long id,
                         @RequestParam String nameProfile,
                         @RequestParam(required = false) String whatsapp,
                         @RequestParam(required = false) String telephone,
                         @RequestParam(required = false) String identityCard,
                         @RequestParam(required = false) String gender,
                         @RequestParam(required = false) Long companyId,
                         RedirectAttributes ra) {
        profileService.findById(id).ifPresent(p -> {
            p.setNameProfile(nameProfile);
            if (whatsapp != null) p.setWhatsapp(whatsapp);
            if (telephone != null) p.setTelephone(telephone);
            if (identityCard != null) p.setIdentityCard(identityCard);
            if (gender != null) p.setGender(gender);
            if (companyId != null) companyService.findById(companyId).ifPresent(p::setCompany);
            profileService.save(p);
        });
        ra.addFlashAttribute("success", "Profile updated.");
        return "redirect:/profiles/" + id;
    }
}
