json.extract! invoice_temp, :id, :cliente_name, :total, :value_delivered_customer, :customer_change, :payment_method, :code_cart, :profile_id, :created_at, :updated_at
json.url invoice_temp_url(invoice_temp, format: :json)
