package com.venx2.service;

import com.venx2.entity.Company;
import com.venx2.repository.CompanyRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
public class CompanyService {
    private final CompanyRepository companyRepository;
    public CompanyService(CompanyRepository r) { this.companyRepository = r; }
    public List<Company> findAll() { return companyRepository.findAll(); }
    public Optional<Company> findById(Long id) { return companyRepository.findById(id); }
    @Transactional public Company save(Company c) { return companyRepository.save(c); }
    @Transactional public void delete(Long id) { companyRepository.deleteById(id); }
}
