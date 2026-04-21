package com.venx2.service;

import com.venx2.entity.Supplier;
import com.venx2.repository.SupplierRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
public class SupplierService {
    private final SupplierRepository supplierRepository;
    public SupplierService(SupplierRepository r) { this.supplierRepository = r; }
    public List<Supplier> findAll() { return supplierRepository.findAll(); }
    public Optional<Supplier> findById(Long id) { return supplierRepository.findById(id); }
    @Transactional public Supplier save(Supplier s) { return supplierRepository.save(s); }
    @Transactional public void delete(Long id) { supplierRepository.deleteById(id); }
}
