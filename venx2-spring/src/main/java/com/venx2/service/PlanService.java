package com.venx2.service;

import com.venx2.entity.Plan;
import com.venx2.repository.PlanRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
public class PlanService {
    private final PlanRepository planRepository;
    public PlanService(PlanRepository r) { this.planRepository = r; }
    public List<Plan> findAll() { return planRepository.findAll(); }
    public Optional<Plan> findById(Long id) { return planRepository.findById(id); }
    public List<Plan> findByCompany(Long companyId) { return planRepository.findByCompanyId(companyId); }
    @Transactional public Plan save(Plan p) { return planRepository.save(p); }
    @Transactional public void delete(Long id) { planRepository.deleteById(id); }
}
