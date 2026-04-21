package com.venx2.entity;

import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "invoice_historics")
public class InvoiceHistoric {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "cliente_name")
    private String clienteName;

    @Column(name = "total", precision = 10, scale = 2)
    private BigDecimal total;

    @Column(name = "sub_total", precision = 10, scale = 2)
    private BigDecimal subTotal;

    @Column(name = "value_delivered_customer", precision = 10, scale = 2)
    private BigDecimal valueDeliveredCustomer;

    @Column(name = "customer_change", precision = 10, scale = 2)
    private BigDecimal customerChange;

    @Column(name = "payment_method")
    private String paymentMethod;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "profile_id")
    private Profile profile;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cart_historic_id")
    private CartHistoric cartHistoric;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    public InvoiceHistoric() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getClienteName() { return clienteName; }
    public void setClienteName(String clienteName) { this.clienteName = clienteName; }
    public BigDecimal getTotal() { return total; }
    public void setTotal(BigDecimal total) { this.total = total; }
    public BigDecimal getSubTotal() { return subTotal; }
    public void setSubTotal(BigDecimal subTotal) { this.subTotal = subTotal; }
    public BigDecimal getValueDeliveredCustomer() { return valueDeliveredCustomer; }
    public void setValueDeliveredCustomer(BigDecimal valueDeliveredCustomer) { this.valueDeliveredCustomer = valueDeliveredCustomer; }
    public BigDecimal getCustomerChange() { return customerChange; }
    public void setCustomerChange(BigDecimal customerChange) { this.customerChange = customerChange; }
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    public Profile getProfile() { return profile; }
    public void setProfile(Profile profile) { this.profile = profile; }
    public CartHistoric getCartHistoric() { return cartHistoric; }
    public void setCartHistoric(CartHistoric cartHistoric) { this.cartHistoric = cartHistoric; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
}
