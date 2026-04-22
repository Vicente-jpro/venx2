package com.venx2.service;

import com.venx2.entity.Category;
import com.venx2.repository.CategoryRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
public class CategoryService {
    private final CategoryRepository categoryRepository;
    public CategoryService(CategoryRepository r) { this.categoryRepository = r; }
    public List<Category> findAll() { return categoryRepository.findAll(); }
    public Optional<Category> findById(Long id) { return categoryRepository.findById(id); }
    @Transactional public Category save(Category c) { return categoryRepository.save(c); }
    @Transactional public void delete(Long id) { categoryRepository.deleteById(id); }
}
