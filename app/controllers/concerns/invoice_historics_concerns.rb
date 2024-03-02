module InvoiceHistoricsConcerns 
  extend ActiveSupport::Concern
  
  def items_searched(data_inicio, data_fim)
    if query.present?
      @invoice_historics = InvoiceHistoric.search_by_date(data_inicio, data_fim)
    else
      @invoice_historics = InvoiceHistoric.all
    end
    @invoice_historics
  end

end