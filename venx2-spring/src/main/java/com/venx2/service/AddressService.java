package com.venx2.service;

import com.venx2.entity.Address;
import com.venx2.entity.City;
import com.venx2.entity.Province;
import com.venx2.repository.AddressRepository;
import com.venx2.repository.CityRepository;
import com.venx2.repository.ProvinceRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
public class AddressService {
    private final AddressRepository addressRepository;
    private final CityRepository cityRepository;
    private final ProvinceRepository provinceRepository;
    public AddressService(AddressRepository a, CityRepository c, ProvinceRepository p) {
        this.addressRepository = a; this.cityRepository = c; this.provinceRepository = p;
    }
    public List<Province> findAllProvinces() { return provinceRepository.findAll(); }
    public List<City> findAllCities() { return cityRepository.findAll(); }
    public List<City> findCitiesByProvince(Long provinceId) { return cityRepository.findByProvinceId(provinceId); }
    public List<Address> findAll() { return addressRepository.findAll(); }
    public Optional<Address> findById(Long id) { return addressRepository.findById(id); }
    @Transactional public Address save(Address a) { return addressRepository.save(a); }
}
