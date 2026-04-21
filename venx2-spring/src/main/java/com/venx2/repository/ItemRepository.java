package com.venx2.repository;
import com.venx2.entity.Item;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
public interface ItemRepository extends JpaRepository<Item, Long> {
    Page<Item> findByDescriptionContainingIgnoreCaseOrItemCodeContainingIgnoreCase(
        String description, String itemCode, Pageable pageable);
}
