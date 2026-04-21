package com.venx2.controller;

import com.venx2.entity.Profile;
import com.venx2.service.ProfileService;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

public abstract class BaseController {

    protected final ProfileService profileService;

    protected BaseController(ProfileService profileService) {
        this.profileService = profileService;
    }

    protected Profile getCurrentProfile() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated()) return null;
        String email = auth.getName();
        return profileService.findByUserEmail(email).orElse(null);
    }
}
