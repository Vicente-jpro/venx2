package com.venx2.repository;
import com.venx2.entity.CartHistoric;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface CartHistoricRepository extends JpaRepository<CartHistoric, Long> {
    List<CartHistoric> findByProfileId(Long profileId);
    List<CartHistoric> findByCodeCart(String codeCart);
}
