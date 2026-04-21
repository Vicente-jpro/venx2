package com.venx2.controller;

import com.venx2.entity.Item;
import com.venx2.entity.Profile;
import com.venx2.service.*;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.time.LocalDate;

@Controller
@RequestMapping("/items")
public class ItemController extends BaseController {

    private final ItemService itemService;
    private final CartTempService cartTempService;
    private final CategoryService categoryService;
    private final SectorService sectorService;
    private final SupplierService supplierService;

    public ItemController(ProfileService profileService,
                          ItemService itemService,
                          CartTempService cartTempService,
                          CategoryService categoryService,
                          SectorService sectorService,
                          SupplierService supplierService) {
        super(profileService);
        this.itemService = itemService;
        this.cartTempService = cartTempService;
        this.categoryService = categoryService;
        this.sectorService = sectorService;
        this.supplierService = supplierService;
    }

    @GetMapping
    public String index(@RequestParam(defaultValue = "0") int page,
                        @RequestParam(defaultValue = "10") int size,
                        @RequestParam(required = false) String search,
                        Model model) {
        Profile profile = getCurrentProfile();
        Pageable pageable = PageRequest.of(page, size, Sort.by("id").descending());
        Page<Item> items;
        if (search != null && !search.isBlank()) {
            items = itemService.search(search, pageable);
            model.addAttribute("search", search);
        } else {
            items = itemService.findAll(pageable);
        }
        model.addAttribute("items", items);
        model.addAttribute("profile", profile);
        if (profile != null) model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
        return "items/index";
    }

    @GetMapping("/new")
    public String newForm(Model model) {
        Profile profile = getCurrentProfile();
        if (profile == null || !profile.isAdmin()) return "redirect:/items";
        model.addAttribute("item", new Item());
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("sectors", sectorService.findAll());
        model.addAttribute("suppliers", supplierService.findAll());
        model.addAttribute("profile", profile);
        if (profile != null) model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
        return "items/form";
    }

    @PostMapping
    public String create(@RequestParam String description,
                         @RequestParam BigDecimal price,
                         @RequestParam BigDecimal profiteValue,
                         @RequestParam Integer quantity,
                         @RequestParam String itemCode,
                         @RequestParam(required = false) String manufacturingDate,
                         @RequestParam(required = false) String expirationDate,
                         @RequestParam(required = false) Long categoryId,
                         @RequestParam(required = false) Long sectorId,
                         @RequestParam(required = false) Long supplierId,
                         RedirectAttributes ra) {
        Profile profile = getCurrentProfile();
        if (profile == null || !profile.isAdmin()) {
            ra.addFlashAttribute("error", "Access denied.");
            return "redirect:/items";
        }
        Item item = new Item();
        item.setDescription(description);
        item.setPrice(price);
        item.setProfiteValue(profiteValue);
        item.setQuantity(quantity);
        item.setItemCode(itemCode);
        if (manufacturingDate != null && !manufacturingDate.isBlank())
            item.setManufacturingDate(LocalDate.parse(manufacturingDate));
        if (expirationDate != null && !expirationDate.isBlank())
            item.setExpirationDate(LocalDate.parse(expirationDate));
        if (categoryId != null) categoryService.findById(categoryId).ifPresent(item::setCategory);
        if (sectorId != null) sectorService.findById(sectorId).ifPresent(item::setSector);
        if (supplierId != null) supplierService.findById(supplierId).ifPresent(item::setSupplier);
        item.setProfile(profile);
        itemService.save(item);
        ra.addFlashAttribute("success", "Item created successfully.");
        return "redirect:/items";
    }

    @GetMapping("/{id}")
    public String show(@PathVariable Long id, Model model) {
        Profile profile = getCurrentProfile();
        return itemService.findById(id).map(item -> {
            model.addAttribute("item", item);
            model.addAttribute("profile", profile);
            if (profile != null) model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
            return "items/show";
        }).orElse("redirect:/items");
    }

    @GetMapping("/{id}/edit")
    public String editForm(@PathVariable Long id, Model model) {
        Profile profile = getCurrentProfile();
        if (profile == null || !profile.isAdmin()) return "redirect:/items";
        return itemService.findById(id).map(item -> {
            model.addAttribute("item", item);
            model.addAttribute("categories", categoryService.findAll());
            model.addAttribute("sectors", sectorService.findAll());
            model.addAttribute("suppliers", supplierService.findAll());
            model.addAttribute("profile", profile);
            model.addAttribute("cartCount", cartTempService.countByProfile(profile.getId()));
            return "items/form";
        }).orElse("redirect:/items");
    }

    @PostMapping("/{id}/update")
    public String update(@PathVariable Long id,
                         @RequestParam String description,
                         @RequestParam BigDecimal price,
                         @RequestParam BigDecimal profiteValue,
                         @RequestParam Integer quantity,
                         @RequestParam String itemCode,
                         @RequestParam(required = false) String manufacturingDate,
                         @RequestParam(required = false) String expirationDate,
                         @RequestParam(required = false) Long categoryId,
                         @RequestParam(required = false) Long sectorId,
                         @RequestParam(required = false) Long supplierId,
                         RedirectAttributes ra) {
        Profile profile = getCurrentProfile();
        if (profile == null || !profile.isAdmin()) {
            ra.addFlashAttribute("error", "Access denied.");
            return "redirect:/items";
        }
        itemService.findById(id).ifPresent(item -> {
            item.setDescription(description);
            item.setPrice(price);
            item.setProfiteValue(profiteValue);
            item.setQuantity(quantity);
            item.setItemCode(itemCode);
            if (manufacturingDate != null && !manufacturingDate.isBlank())
                item.setManufacturingDate(LocalDate.parse(manufacturingDate));
            if (expirationDate != null && !expirationDate.isBlank())
                item.setExpirationDate(LocalDate.parse(expirationDate));
            if (categoryId != null) categoryService.findById(categoryId).ifPresent(item::setCategory);
            if (sectorId != null) sectorService.findById(sectorId).ifPresent(item::setSector);
            if (supplierId != null) supplierService.findById(supplierId).ifPresent(item::setSupplier);
            itemService.update(item);
        });
        ra.addFlashAttribute("success", "Item updated.");
        return "redirect:/items";
    }

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id, RedirectAttributes ra) {
        Profile profile = getCurrentProfile();
        if (profile == null || !profile.isAdmin()) {
            ra.addFlashAttribute("error", "Access denied.");
            return "redirect:/items";
        }
        itemService.delete(id);
        ra.addFlashAttribute("success", "Item deleted.");
        return "redirect:/items";
    }
}
