package com.venx2.service;

import com.venx2.entity.Sector;
import com.venx2.repository.SectorRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
public class SectorService {
    private final SectorRepository sectorRepository;
    public SectorService(SectorRepository r) { this.sectorRepository = r; }
    public List<Sector> findAll() { return sectorRepository.findAll(); }
    public Optional<Sector> findById(Long id) { return sectorRepository.findById(id); }
    @Transactional public Sector save(Sector s) { return sectorRepository.save(s); }
    @Transactional public void delete(Long id) { sectorRepository.deleteById(id); }
}
