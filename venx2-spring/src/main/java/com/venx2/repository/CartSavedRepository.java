package com.venx2.repository;
import com.venx2.entity.CartSaved;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface CartSavedRepository extends JpaRepository<CartSaved, Long> {
    List<CartSaved> findByProfileId(Long profileId);
    List<CartSaved> findByProfileIdAndCodeCart(Long profileId, String codeCart);
    List<String> findDistinctCodeCartByProfileId(Long profileId);
}
