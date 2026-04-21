package com.venx2.service;

import com.venx2.entity.Item;
import com.venx2.repository.ItemRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Optional;

@Service
public class ItemService {

    private static final BigDecimal IVA_RATE = new BigDecimal("0.14");

    private final ItemRepository itemRepository;

    public ItemService(ItemRepository itemRepository) {
        this.itemRepository = itemRepository;
    }

    public Page<Item> findAll(Pageable pageable) {
        return itemRepository.findAll(pageable);
    }

    public Page<Item> search(String query, Pageable pageable) {
        return itemRepository
            .findByDescriptionContainingIgnoreCaseOrItemCodeContainingIgnoreCase(query, query, pageable);
    }

    public Optional<Item> findById(Long id) {
        return itemRepository.findById(id);
    }

    @Transactional
    public Item save(Item item) {
        // price = price + (price * 0.14) + profiteValue
        BigDecimal base = item.getPrice() != null ? item.getPrice() : BigDecimal.ZERO;
        BigDecimal profit = item.getProfiteValue() != null ? item.getProfiteValue() : BigDecimal.ZERO;
        BigDecimal iva = base.multiply(IVA_RATE);
        BigDecimal finalPrice = base.add(iva).add(profit).setScale(2, RoundingMode.HALF_UP);
        item.setPrice(finalPrice);
        return itemRepository.save(item);
    }

    @Transactional
    public Item update(Item item) {
        return itemRepository.save(item);
    }

    @Transactional
    public void delete(Long id) {
        itemRepository.deleteById(id);
    }

    @Transactional
    public Item saveWithoutPriceCalc(Item item) {
        return itemRepository.save(item);
    }
}
