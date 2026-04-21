package com.venx2.service;

import com.venx2.entity.CartSaved;
import com.venx2.entity.CartTemp;
import com.venx2.entity.Item;
import com.venx2.entity.Profile;
import com.venx2.repository.CartSavedRepository;
import com.venx2.repository.CartTempRepository;
import com.venx2.repository.ItemRepository;
import com.venx2.repository.ProfileRepository;
import com.venx2.util.CodeGenerator;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class CartSavedService {

    private final CartSavedRepository cartSavedRepository;
    private final CartTempRepository cartTempRepository;
    private final ItemRepository itemRepository;
    private final ProfileRepository profileRepository;

    public CartSavedService(CartSavedRepository cartSavedRepository,
                             CartTempRepository cartTempRepository,
                             ItemRepository itemRepository,
                             ProfileRepository profileRepository) {
        this.cartSavedRepository = cartSavedRepository;
        this.cartTempRepository = cartTempRepository;
        this.itemRepository = itemRepository;
        this.profileRepository = profileRepository;
    }

    public List<CartSaved> findByProfile(Long profileId) {
        return cartSavedRepository.findByProfileId(profileId);
    }

    public List<String> findDistinctCodes(Long profileId) {
        return cartSavedRepository.findByProfileId(profileId).stream()
            .map(CartSaved::getCodeCart).distinct().collect(Collectors.toList());
    }

    @Transactional
    public String saveCart(Long profileId) {
        Profile profile = profileRepository.findById(profileId)
            .orElseThrow(() -> new IllegalArgumentException("Profile not found"));
        List<CartTemp> cartTemps = cartTempRepository.findByProfileId(profileId);
        if (cartTemps.isEmpty()) {
            throw new IllegalStateException("Cart is empty");
        }
        String code = CodeGenerator.generateCode();
        for (CartTemp ct : cartTemps) {
            CartSaved cs = new CartSaved();
            cs.setQuantity(ct.getQuantity());
            cs.setAbandoned(true);
            cs.setCodeCart(code);
            cs.setItem(ct.getItem());
            cs.setProfile(profile);
            cartSavedRepository.save(cs);
        }
        cartTempRepository.deleteByProfileId(profileId);
        return code;
    }

    @Transactional
    public void restoreCart(Long profileId, String codeCart) {
        Profile profile = profileRepository.findById(profileId)
            .orElseThrow(() -> new IllegalArgumentException("Profile not found"));
        List<CartSaved> savedItems = cartSavedRepository.findByProfileIdAndCodeCart(profileId, codeCart);
        for (CartSaved cs : savedItems) {
            CartTemp ct = new CartTemp();
            ct.setQuantity(cs.getQuantity());
            ct.setAbandoned(true);
            ct.setItem(cs.getItem());
            ct.setProfile(profile);
            cartTempRepository.save(ct);
            cartSavedRepository.delete(cs);
        }
    }
}
