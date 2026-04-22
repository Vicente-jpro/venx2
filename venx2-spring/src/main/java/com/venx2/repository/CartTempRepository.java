package com.venx2.repository;
import com.venx2.entity.CartTemp;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;
public interface CartTempRepository extends JpaRepository<CartTemp, Long> {
    List<CartTemp> findByProfileId(Long profileId);
    Optional<CartTemp> findByProfileIdAndItemId(Long profileId, Long itemId);
    void deleteByProfileId(Long profileId);
}
