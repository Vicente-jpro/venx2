package com.venx2.service;

import com.venx2.entity.*;
import com.venx2.repository.*;
import com.venx2.util.CodeGenerator;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Service
public class InvoiceService {

    private final CartTempRepository cartTempRepository;
    private final CartHistoricRepository cartHistoricRepository;
    private final InvoiceTempRepository invoiceTempRepository;
    private final InvoiceHistoricRepository invoiceHistoricRepository;
    private final PlanRepository planRepository;
    private final ItemRepository itemRepository;
    private final MostSaleRepository mostSaleRepository;
    private final CartTempService cartTempService;

    public InvoiceService(CartTempRepository cartTempRepository,
                          CartHistoricRepository cartHistoricRepository,
                          InvoiceTempRepository invoiceTempRepository,
                          InvoiceHistoricRepository invoiceHistoricRepository,
                          PlanRepository planRepository,
                          ItemRepository itemRepository,
                          MostSaleRepository mostSaleRepository,
                          CartTempService cartTempService) {
        this.cartTempRepository = cartTempRepository;
        this.cartHistoricRepository = cartHistoricRepository;
        this.invoiceTempRepository = invoiceTempRepository;
        this.invoiceHistoricRepository = invoiceHistoricRepository;
        this.planRepository = planRepository;
        this.itemRepository = itemRepository;
        this.mostSaleRepository = mostSaleRepository;
        this.cartTempService = cartTempService;
    }

    @Transactional
    public void createInvoice(String clienteName, String paymentMethod,
                               BigDecimal valueDelivered, Profile profile) {
        // Validate plan
        if (profile.getCompany() != null) {
            List<Plan> plans = planRepository.findByCompanyId(profile.getCompany().getId());
            if (!plans.isEmpty()) {
                Plan latestPlan = plans.get(plans.size() - 1);
                if (latestPlan.isExpired()) {
                    throw new IllegalStateException("Company plan has expired. Please renew.");
                }
            }
        }

        BigDecimal totalCost = cartTempService.getTotalCost(profile.getId());

        if (valueDelivered.compareTo(totalCost) < 0) {
            throw new IllegalStateException("Value delivered is less than total cost.");
        }

        BigDecimal customerChange = valueDelivered.subtract(totalCost);
        String codeCart = CodeGenerator.generateCode();

        List<CartTemp> cartTemps = cartTempRepository.findByProfileId(profile.getId());

        for (CartTemp ct : cartTemps) {
            CartHistoric ch = new CartHistoric();
            ch.setQuantity(ct.getQuantity());
            ch.setAbandoned(false);
            ch.setCodeCart(codeCart);
            ch.setProfile(profile);
            ch.setItem(ct.getItem());
            cartHistoricRepository.save(ch);

            InvoiceTemp it = new InvoiceTemp();
            it.setClienteName(clienteName);
            it.setTotal(totalCost);
            it.setSubTotal(totalCost);
            it.setValueDeliveredCustomer(valueDelivered);
            it.setCustomerChange(customerChange);
            it.setPaymentMethod(paymentMethod);
            it.setProfile(profile);
            it.setCartHistoric(ch);
            invoiceTempRepository.save(it);

            InvoiceHistoric ih = new InvoiceHistoric();
            ih.setClienteName(clienteName);
            ih.setTotal(totalCost);
            ih.setSubTotal(totalCost);
            ih.setValueDeliveredCustomer(valueDelivered);
            ih.setCustomerChange(customerChange);
            ih.setPaymentMethod(paymentMethod);
            ih.setProfile(profile);
            ih.setCartHistoric(ch);
            invoiceHistoricRepository.save(ih);

            // Update most sales
            MostSale ms = mostSaleRepository.findByItemId(ct.getItem().getId())
                .orElseGet(() -> {
                    MostSale newMs = new MostSale();
                    newMs.setItem(ct.getItem());
                    newMs.setQuantity(0);
                    return newMs;
                });
            ms.setQuantity(ms.getQuantity() + ct.getQuantity());
            mostSaleRepository.save(ms);
        }

        cartTempRepository.deleteByProfileId(profile.getId());
    }
}
