package com.venx2.repository;
import com.venx2.entity.Plan;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface PlanRepository extends JpaRepository<Plan, Long> {
    List<Plan> findByCompanyId(Long companyId);
}
