package com.venx2.controller;

import com.venx2.entity.Profile;
import com.venx2.service.CartTempService;
import com.venx2.service.MostSaleService;
import com.venx2.service.ProfileService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController extends BaseController {

    private final CartTempService cartTempService;
    private final MostSaleService mostSaleService;

    public HomeController(ProfileService profileService,
                          CartTempService cartTempService,
                          MostSaleService mostSaleService) {
        super(profileService);
        this.cartTempService = cartTempService;
        this.mostSaleService = mostSaleService;
    }

    @GetMapping("/")
    public String index(Model model) {
        Profile profile = getCurrentProfile();
        if (profile != null) {
            model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
            model.addAttribute("mostSales", mostSaleService.findAll());
        }
        model.addAttribute("profile", profile);
        return "home/index";
    }
}
