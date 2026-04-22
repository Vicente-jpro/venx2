package com.venx2.service;

import com.venx2.entity.InvoiceHistoric;
import com.venx2.repository.InvoiceHistoricRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class InvoiceHistoricService {
    private final InvoiceHistoricRepository invoiceHistoricRepository;
    public InvoiceHistoricService(InvoiceHistoricRepository r) { this.invoiceHistoricRepository = r; }
    public List<InvoiceHistoric> findByProfile(Long profileId) { return invoiceHistoricRepository.findByProfileId(profileId); }
    public Optional<InvoiceHistoric> findById(Long id) { return invoiceHistoricRepository.findById(id); }
    public List<InvoiceHistoric> findAll() { return invoiceHistoricRepository.findAll(); }
}
