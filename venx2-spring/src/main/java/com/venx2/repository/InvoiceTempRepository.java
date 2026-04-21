package com.venx2.repository;
import com.venx2.entity.InvoiceTemp;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface InvoiceTempRepository extends JpaRepository<InvoiceTemp, Long> {
    List<InvoiceTemp> findByProfileId(Long profileId);
}
