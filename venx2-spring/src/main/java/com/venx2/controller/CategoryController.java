package com.venx2.controller;

import com.venx2.entity.Category;
import com.venx2.entity.Profile;
import com.venx2.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/categories")
public class CategoryController extends BaseController {
    private final CategoryService categoryService;
    private final CartTempService cartTempService;

    public CategoryController(ProfileService profileService, CategoryService categoryService, CartTempService cartTempService) {
        super(profileService);
        this.categoryService = categoryService;
        this.cartTempService = cartTempService;
    }

    @GetMapping
    public String index(Model model) {
        Profile profile = getCurrentProfile();
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("profile", profile);
        if (profile != null) model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
        return "categories/index";
    }

    @GetMapping("/new")
    public String newForm(Model model) {
        Profile profile = getCurrentProfile();
        if (profile == null || !profile.isAdmin()) return "redirect:/categories";
        model.addAttribute("category", new Category());
        model.addAttribute("profile", profile);
        model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
        return "categories/form";
    }

    @PostMapping
    public String create(@RequestParam String nameCategory, RedirectAttributes ra) {
        Profile profile = getCurrentProfile();
        if (profile == null || !profile.isAdmin()) { ra.addFlashAttribute("error", "Access denied."); return "redirect:/categories"; }
        categoryService.save(new Category(nameCategory));
        ra.addFlashAttribute("success", "Category created.");
        return "redirect:/categories";
    }

    @GetMapping("/{id}/edit")
    public String editForm(@PathVariable Long id, Model model) {
        Profile profile = getCurrentProfile();
        if (profile == null || !profile.isAdmin()) return "redirect:/categories";
        return categoryService.findById(id).map(c -> {
            model.addAttribute("category", c);
            model.addAttribute("profile", profile);
            model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
            return "categories/form";
        }).orElse("redirect:/categories");
    }

    @PostMapping("/{id}/update")
    public String update(@PathVariable Long id, @RequestParam String nameCategory, RedirectAttributes ra) {
        categoryService.findById(id).ifPresent(c -> { c.setNameCategory(nameCategory); categoryService.save(c); });
        ra.addFlashAttribute("success", "Category updated.");
        return "redirect:/categories";
    }

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id, RedirectAttributes ra) {
        categoryService.delete(id);
        ra.addFlashAttribute("success", "Category deleted.");
        return "redirect:/categories";
    }
}
