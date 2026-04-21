package com.venx2.controller;

import com.venx2.entity.Plan;
import com.venx2.entity.Profile;
import com.venx2.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.time.LocalDate;

@Controller
@RequestMapping("/plans")
public class PlanController extends BaseController {
    private final PlanService planService;
    private final CompanyService companyService;
    private final CartTempService cartTempService;

    public PlanController(ProfileService profileService, PlanService planService, CompanyService companyService, CartTempService cartTempService) {
        super(profileService); this.planService = planService; this.companyService = companyService; this.cartTempService = cartTempService;
    }

    @GetMapping
    public String index(Model model) {
        Profile profile = getCurrentProfile();
        model.addAttribute("plans", planService.findAll());
        model.addAttribute("profile", profile);
        if (profile != null) model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
        return "plans/index";
    }

    @GetMapping("/new")
    public String newForm(Model model) {
        Profile profile = getCurrentProfile();
        if (profile == null || !profile.isAdmin()) return "redirect:/plans";
        model.addAttribute("plan", new Plan());
        model.addAttribute("companies", companyService.findAll());
        model.addAttribute("profile", profile);
        model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
        return "plans/form";
    }

    @PostMapping
    public String create(@RequestParam String signDate, @RequestParam String expirationDate,
                          @RequestParam Long companyId, RedirectAttributes ra) {
        Profile profile = getCurrentProfile();
        if (profile == null || !profile.isAdmin()) { ra.addFlashAttribute("error", "Access denied."); return "redirect:/plans"; }
        Plan p = new Plan();
        p.setSignDate(LocalDate.parse(signDate));
        p.setExpirationDate(LocalDate.parse(expirationDate));
        companyService.findById(companyId).ifPresent(p::setCompany);
        planService.save(p);
        ra.addFlashAttribute("success", "Plan created.");
        return "redirect:/plans";
    }

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id, RedirectAttributes ra) {
        planService.delete(id);
        ra.addFlashAttribute("success", "Plan deleted.");
        return "redirect:/plans";
    }
}
