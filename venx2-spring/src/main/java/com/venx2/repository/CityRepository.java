package com.venx2.repository;
import com.venx2.entity.City;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface CityRepository extends JpaRepository<City, Long> {
    List<City> findByProvinceId(Long provinceId);
}
