package com.venx2.controller;

import com.venx2.entity.User;
import com.venx2.entity.Profile;
import com.venx2.service.ProfileService;
import com.venx2.service.UserService;
import com.venx2.service.CompanyService;
import com.venx2.service.AddressService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AuthController extends BaseController {

    private final UserService userService;
    private final CompanyService companyService;
    private final AddressService addressService;

    public AuthController(ProfileService profileService,
                          UserService userService,
                          CompanyService companyService,
                          AddressService addressService) {
        super(profileService);
        this.userService = userService;
        this.companyService = companyService;
        this.addressService = addressService;
    }

    @GetMapping("/login")
    public String loginPage(@RequestParam(required = false) String error,
                            @RequestParam(required = false) String logout,
                            Model model) {
        if (error != null) model.addAttribute("error", "Invalid email or password.");
        if (logout != null) model.addAttribute("message", "You have been logged out.");
        return "auth/login";
    }

    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("companies", companyService.findAll());
        model.addAttribute("addresses", addressService.findAll());
        return "auth/register";
    }

    @PostMapping("/register")
    public String register(@RequestParam String email,
                           @RequestParam String password,
                           @RequestParam String nameProfile,
                           @RequestParam(required = false) Long companyId,
                           RedirectAttributes ra) {
        try {
            User user = userService.register(email, password);
            Profile profile = new Profile();
            profile.setNameProfile(nameProfile);
            profile.setProfileType("FUNCIONARIO");
            profile.setUser(user);
            if (companyId != null) {
                companyService.findById(companyId).ifPresent(profile::setCompany);
            }
            profileService.save(profile);
            ra.addFlashAttribute("success", "Registration successful! Please login.");
            return "redirect:/login";
        } catch (Exception e) {
            ra.addFlashAttribute("error", e.getMessage());
            return "redirect:/register";
        }
    }
}
