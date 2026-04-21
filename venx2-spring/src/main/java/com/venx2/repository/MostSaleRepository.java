package com.venx2.repository;
import com.venx2.entity.MostSale;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;
public interface MostSaleRepository extends JpaRepository<MostSale, Long> {
    Optional<MostSale> findByItemId(Long itemId);
}
