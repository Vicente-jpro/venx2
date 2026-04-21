package com.venx2.repository;
import com.venx2.entity.InvoiceHistoric;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface InvoiceHistoricRepository extends JpaRepository<InvoiceHistoric, Long> {
    List<InvoiceHistoric> findByProfileId(Long profileId);
    List<InvoiceHistoric> findByCartHistoricCodeCart(String codeCart);
}
