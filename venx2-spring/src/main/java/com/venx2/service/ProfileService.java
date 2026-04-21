package com.venx2.service;

import com.venx2.entity.Profile;
import com.venx2.repository.ProfileRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class ProfileService {

    private final ProfileRepository profileRepository;

    public ProfileService(ProfileRepository profileRepository) {
        this.profileRepository = profileRepository;
    }

    public Optional<Profile> findByUserEmail(String email) {
        return profileRepository.findByUserEmail(email);
    }

    public Optional<Profile> findByUserId(Long userId) {
        return profileRepository.findByUserId(userId);
    }

    public Optional<Profile> findById(Long id) {
        return profileRepository.findById(id);
    }

    public List<Profile> findAll() {
        return profileRepository.findAll();
    }

    @Transactional
    public Profile save(Profile profile) {
        return profileRepository.save(profile);
    }

    @Transactional
    public void delete(Long id) {
        profileRepository.deleteById(id);
    }
}
