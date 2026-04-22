package com.venx2;

import com.venx2.entity.*;
import com.venx2.repository.*;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.time.LocalDate;

@Component
public class DataInitializer implements CommandLineRunner {

    private final ProvinceRepository provinceRepository;
    private final CityRepository cityRepository;
    private final AddressRepository addressRepository;
    private final CompanyRepository companyRepository;
    private final SectorRepository sectorRepository;
    private final CategoryRepository categoryRepository;
    private final UserRepository userRepository;
    private final ProfileRepository profileRepository;
    private final SupplierRepository supplierRepository;
    private final ItemRepository itemRepository;
    private final PlanRepository planRepository;
    private final PasswordEncoder passwordEncoder;

    public DataInitializer(ProvinceRepository provinceRepository,
                           CityRepository cityRepository,
                           AddressRepository addressRepository,
                           CompanyRepository companyRepository,
                           SectorRepository sectorRepository,
                           CategoryRepository categoryRepository,
                           UserRepository userRepository,
                           ProfileRepository profileRepository,
                           SupplierRepository supplierRepository,
                           ItemRepository itemRepository,
                           PlanRepository planRepository,
                           PasswordEncoder passwordEncoder) {
        this.provinceRepository = provinceRepository;
        this.cityRepository = cityRepository;
        this.addressRepository = addressRepository;
        this.companyRepository = companyRepository;
        this.sectorRepository = sectorRepository;
        this.categoryRepository = categoryRepository;
        this.userRepository = userRepository;
        this.profileRepository = profileRepository;
        this.supplierRepository = supplierRepository;
        this.itemRepository = itemRepository;
        this.planRepository = planRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void run(String... args) {
        if (provinceRepository.count() > 0) return;

        // Provinces
        Province luanda = provinceRepository.save(new Province("Luanda"));
        Province uige = provinceRepository.save(new Province("Úige"));
        Province uila = provinceRepository.save(new Province("Uila"));
        Province kuanzaSul = provinceRepository.save(new Province("Kuanza Sul"));

        // Cities
        City belas = cityRepository.save(new City("Belas", luanda));
        City gabela = cityRepository.save(new City("Gabela", kuanzaSul));
        City sumbe = cityRepository.save(new City("Sumbe", kuanzaSul));
        City viana = cityRepository.save(new City("Viana", luanda));

        // Addresses
        Address addr1 = addressRepository.save(new Address("Rua da Missão, 123", belas));
        Address addr2 = addressRepository.save(new Address("Av. Deolinda Rodrigues, 45", viana));
        Address addr3 = addressRepository.save(new Address("Rua Amilcar Cabral, 10", gabela));
        Address addr4 = addressRepository.save(new Address("Rua Principal, 5", sumbe));

        // Companies
        Company adicionatec = new Company();
        adicionatec.setName("Adicionatec");
        adicionatec.setWhatsapp("244923000001");
        adicionatec.setTelephone("244222000001");
        adicionatec.setEmail("info@adicionatec.ao");
        adicionatec.setNif("50000001AO");
        adicionatec.setAddress(addr1);
        adicionatec = companyRepository.save(adicionatec);

        Company luisaTech = new Company();
        luisaTech.setName("Luisa Tech");
        luisaTech.setWhatsapp("244923000002");
        luisaTech.setTelephone("244222000002");
        luisaTech.setEmail("info@luisatech.ao");
        luisaTech.setNif("50000002AO");
        luisaTech.setAddress(addr2);
        luisaTech = companyRepository.save(luisaTech);

        // Plans
        Plan plan1 = new Plan();
        plan1.setSignDate(LocalDate.now());
        plan1.setExpirationDate(LocalDate.now().plusYears(1));
        plan1.setCompany(adicionatec);
        planRepository.save(plan1);

        Plan plan2 = new Plan();
        plan2.setSignDate(LocalDate.now());
        plan2.setExpirationDate(LocalDate.now().plusYears(1));
        plan2.setCompany(luisaTech);
        planRepository.save(plan2);

        // Sectors
        Sector alimentos = sectorRepository.save(new Sector("Alimentos"));
        Sector frutos = sectorRepository.save(new Sector("Frutos"));

        // Categories
        Category alimentacao = categoryRepository.save(new Category("Alimentação"));
        Category desporto = categoryRepository.save(new Category("Desporto"));

        // Users
        User user1 = userRepository.save(new User("vicenteviciii@gmail.com", passwordEncoder.encode("12345678")));
        User user2 = userRepository.save(new User("vicenteviciii@outlook.com", passwordEncoder.encode("12345678")));

        // Profiles
        Profile profile1 = new Profile();
        profile1.setNameProfile("Vicente");
        profile1.setProfileType("SUPER_ADMIN24");
        profile1.setGender("MASCULINO");
        profile1.setWhatsapp("244923111111");
        profile1.setTelephone("244222111111");
        profile1.setIdentityCard("001234567LA042");
        profile1.setUser(user1);
        profile1.setAddress(addr1);
        profile1.setCompany(adicionatec);
        profile1 = profileRepository.save(profile1);

        Profile profile2 = new Profile();
        profile2.setNameProfile("Luisa");
        profile2.setProfileType("FUNCIONARIO");
        profile2.setGender("FEMININO");
        profile2.setWhatsapp("244923222222");
        profile2.setTelephone("244222222222");
        profile2.setIdentityCard("002345678LA042");
        profile2.setUser(user2);
        profile2.setAddress(addr2);
        profile2.setCompany(luisaTech);
        profile2 = profileRepository.save(profile2);

        // Suppliers
        Supplier supplier1 = new Supplier();
        supplier1.setNameSupplier("Distribuidora Angola");
        supplier1.setWhatsapp("244923333333");
        supplier1.setTelephone("244222333333");
        supplier1.setEmail("distribuidora@angola.ao");
        supplier1.setAddress(addr3);
        supplier1.setProfile(profile1);
        supplier1 = supplierRepository.save(supplier1);

        Supplier supplier2 = new Supplier();
        supplier2.setNameSupplier("Importadora Sul");
        supplier2.setWhatsapp("244923444444");
        supplier2.setTelephone("244222444444");
        supplier2.setEmail("importadora@sul.ao");
        supplier2.setAddress(addr4);
        supplier2.setProfile(profile1);
        supplier2 = supplierRepository.save(supplier2);

        // Items (price will be calculated: price + price*0.14 + profiteValue)
        Item item1 = new Item();
        item1.setDescription("Arroz branco");
        item1.setQuantity(100);
        item1.setItemCode("ARR001");
        item1.setManufacturingDate(LocalDate.now().minusMonths(2));
        item1.setExpirationDate(LocalDate.now().plusYears(1));
        item1.setPrice(new BigDecimal("500.00"));
        item1.setProfiteValue(new BigDecimal("50.00"));
        item1.setSupplier(supplier1);
        item1.setCategory(alimentacao);
        item1.setProfile(profile1);
        item1.setSector(alimentos);
        // Calculate price: 500 + 500*0.14 + 50 = 620
        BigDecimal base1 = new BigDecimal("500.00");
        item1.setPrice(base1.add(base1.multiply(new BigDecimal("0.14"))).add(new BigDecimal("50.00")));
        itemRepository.save(item1);

        Item item2 = new Item();
        item2.setDescription("Massa xepa");
        item2.setQuantity(50);
        item2.setItemCode("MAS001");
        item2.setManufacturingDate(LocalDate.now().minusMonths(1));
        item2.setExpirationDate(LocalDate.now().plusMonths(8));
        item2.setPrice(new BigDecimal("200.00"));
        item2.setProfiteValue(new BigDecimal("20.00"));
        item2.setSupplier(supplier2);
        item2.setCategory(alimentacao);
        item2.setProfile(profile1);
        item2.setSector(alimentos);
        // Calculate price: 200 + 200*0.14 + 20 = 248
        BigDecimal base2 = new BigDecimal("200.00");
        item2.setPrice(base2.add(base2.multiply(new BigDecimal("0.14"))).add(new BigDecimal("20.00")));
        itemRepository.save(item2);
    }
}
