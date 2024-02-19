json.extract! invoice_historic, :id, :cliente_name, :total, :sub_total, :value_delivered_customer, :customer_change, :payment_method, :profile_id, :cart_historic_id, :created_at, :updated_at
json.url invoice_historic_url(invoice_historic, format: :json)
