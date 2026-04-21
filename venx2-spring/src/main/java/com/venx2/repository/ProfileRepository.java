package com.venx2.repository;
import com.venx2.entity.Profile;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;
public interface ProfileRepository extends JpaRepository<Profile, Long> {
    Optional<Profile> findByUserId(Long userId);
    Optional<Profile> findByUserEmail(String email);
}
