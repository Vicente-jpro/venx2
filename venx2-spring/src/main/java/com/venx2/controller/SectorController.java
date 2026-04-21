package com.venx2.controller;

import com.venx2.entity.Profile;
import com.venx2.entity.Sector;
import com.venx2.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/sectors")
public class SectorController extends BaseController {
    private final SectorService sectorService;
    private final CartTempService cartTempService;

    public SectorController(ProfileService profileService, SectorService sectorService, CartTempService cartTempService) {
        super(profileService); this.sectorService = sectorService; this.cartTempService = cartTempService;
    }

    @GetMapping
    public String index(Model model) {
        Profile profile = getCurrentProfile();
        model.addAttribute("sectors", sectorService.findAll());
        model.addAttribute("profile", profile);
        if (profile != null) model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
        return "sectors/index";
    }

    @GetMapping("/new")
    public String newForm(Model model) {
        Profile profile = getCurrentProfile();
        if (profile == null || !profile.isAdmin()) return "redirect:/sectors";
        model.addAttribute("sector", new Sector());
        model.addAttribute("profile", profile);
        model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
        return "sectors/form";
    }

    @PostMapping
    public String create(@RequestParam String nameSector, RedirectAttributes ra) {
        Profile profile = getCurrentProfile();
        if (profile == null || !profile.isAdmin()) { ra.addFlashAttribute("error", "Access denied."); return "redirect:/sectors"; }
        sectorService.save(new Sector(nameSector));
        ra.addFlashAttribute("success", "Sector created.");
        return "redirect:/sectors";
    }

    @GetMapping("/{id}/edit")
    public String editForm(@PathVariable Long id, Model model) {
        Profile profile = getCurrentProfile();
        if (profile == null || !profile.isAdmin()) return "redirect:/sectors";
        return sectorService.findById(id).map(s -> {
            model.addAttribute("sector", s);
            model.addAttribute("profile", profile);
            model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
            return "sectors/form";
        }).orElse("redirect:/sectors");
    }

    @PostMapping("/{id}/update")
    public String update(@PathVariable Long id, @RequestParam String nameSector, RedirectAttributes ra) {
        sectorService.findById(id).ifPresent(s -> { s.setNameSector(nameSector); sectorService.save(s); });
        ra.addFlashAttribute("success", "Sector updated.");
        return "redirect:/sectors";
    }

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id, RedirectAttributes ra) {
        sectorService.delete(id);
        ra.addFlashAttribute("success", "Sector deleted.");
        return "redirect:/sectors";
    }
}
