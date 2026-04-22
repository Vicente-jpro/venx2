package com.venx2.service;

import com.venx2.entity.MostSale;
import com.venx2.repository.MostSaleRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class MostSaleService {
    private final MostSaleRepository mostSaleRepository;
    public MostSaleService(MostSaleRepository r) { this.mostSaleRepository = r; }
    public List<MostSale> findAll() { return mostSaleRepository.findAll(); }
}
