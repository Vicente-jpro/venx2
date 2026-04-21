package com.venx2.service;

import com.venx2.entity.CartHistoric;
import com.venx2.repository.CartHistoricRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class CartHistoricService {
    private final CartHistoricRepository cartHistoricRepository;
    public CartHistoricService(CartHistoricRepository r) { this.cartHistoricRepository = r; }
    public List<CartHistoric> findByProfile(Long profileId) { return cartHistoricRepository.findByProfileId(profileId); }
    public Optional<CartHistoric> findById(Long id) { return cartHistoricRepository.findById(id); }
}
