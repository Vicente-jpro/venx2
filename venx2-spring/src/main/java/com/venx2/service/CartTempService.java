package com.venx2.service;

import com.venx2.entity.CartTemp;
import com.venx2.entity.Item;
import com.venx2.entity.Profile;
import com.venx2.repository.CartTempRepository;
import com.venx2.repository.ItemRepository;
import com.venx2.repository.ProfileRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
public class CartTempService {

    private final CartTempRepository cartTempRepository;
    private final ItemRepository itemRepository;
    private final ProfileRepository profileRepository;

    public CartTempService(CartTempRepository cartTempRepository,
                           ItemRepository itemRepository,
                           ProfileRepository profileRepository) {
        this.cartTempRepository = cartTempRepository;
        this.itemRepository = itemRepository;
        this.profileRepository = profileRepository;
    }

    public List<CartTemp> findByProfile(Long profileId) {
        return cartTempRepository.findByProfileId(profileId);
    }

    @Transactional
    public void addToCart(Long itemId, Long profileId) {
        Item item = itemRepository.findById(itemId)
            .orElseThrow(() -> new IllegalArgumentException("Item not found"));
        Profile profile = profileRepository.findById(profileId)
            .orElseThrow(() -> new IllegalArgumentException("Profile not found"));

        if (item.getQuantity() == null || item.getQuantity() <= 0) {
            throw new IllegalStateException("Item out of stock");
        }

        Optional<CartTemp> existing = cartTempRepository.findByProfileIdAndItemId(profileId, itemId);
        if (existing.isPresent()) {
            CartTemp ct = existing.get();
            ct.setQuantity(ct.getQuantity() + 1);
            cartTempRepository.save(ct);
        } else {
            CartTemp ct = new CartTemp();
            ct.setItem(item);
            ct.setProfile(profile);
            ct.setQuantity(1);
            ct.setAbandoned(true);
            cartTempRepository.save(ct);
        }

        item.setQuantity(item.getQuantity() - 1);
        itemRepository.save(item);
    }

    @Transactional
    public void removeFromCart(Long cartTempId) {
        CartTemp ct = cartTempRepository.findById(cartTempId)
            .orElseThrow(() -> new IllegalArgumentException("CartTemp not found"));
        Item item = ct.getItem();
        item.setQuantity(item.getQuantity() + ct.getQuantity());
        itemRepository.save(item);
        cartTempRepository.delete(ct);
    }

    @Transactional
    public void incrementQuantity(Long cartTempId) {
        CartTemp ct = cartTempRepository.findById(cartTempId)
            .orElseThrow(() -> new IllegalArgumentException("CartTemp not found"));
        Item item = ct.getItem();
        if (item.getQuantity() <= 0) {
            throw new IllegalStateException("Item out of stock");
        }
        ct.setQuantity(ct.getQuantity() + 1);
        item.setQuantity(item.getQuantity() - 1);
        cartTempRepository.save(ct);
        itemRepository.save(item);
    }

    @Transactional
    public void decrementQuantity(Long cartTempId) {
        CartTemp ct = cartTempRepository.findById(cartTempId)
            .orElseThrow(() -> new IllegalArgumentException("CartTemp not found"));
        if (ct.getQuantity() <= 1) {
            removeFromCart(cartTempId);
            return;
        }
        Item item = ct.getItem();
        ct.setQuantity(ct.getQuantity() - 1);
        item.setQuantity(item.getQuantity() + 1);
        cartTempRepository.save(ct);
        itemRepository.save(item);
    }

    @Transactional
    public void cancelCart(Long profileId) {
        List<CartTemp> cartTemps = cartTempRepository.findByProfileId(profileId);
        for (CartTemp ct : cartTemps) {
            Item item = ct.getItem();
            item.setQuantity(item.getQuantity() + ct.getQuantity());
            itemRepository.save(item);
        }
        cartTempRepository.deleteByProfileId(profileId);
    }

    public BigDecimal getTotalCost(Long profileId) {
        List<CartTemp> cartTemps = cartTempRepository.findByProfileId(profileId);
        BigDecimal total = BigDecimal.ZERO;
        for (CartTemp ct : cartTemps) {
            if (ct.getItem() != null && ct.getItem().getPrice() != null) {
                BigDecimal line = ct.getItem().getPrice()
                    .multiply(BigDecimal.valueOf(ct.getQuantity()));
                total = total.add(line);
            }
        }
        return total;
    }

    public int countByProfile(Long profileId) {
        return cartTempRepository.findByProfileId(profileId).size();
    }
}
