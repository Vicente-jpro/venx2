module InvoiceHistoricsConcerns 
  extend ActiveSupport::Concern
  
  def search_by_date(data_inicio, data_fim)
    if data_inicio.present? && data_fim.present?
      data_inicio = Time.parse(data_inicio) 
      data_fim = Time.parse(data_fim) 
      
      @invoice_historics = InvoiceHistoric.search_by_date(data_inicio, data_fim)
    else
      @invoice_historics = InvoiceHistoric.all
    end
    @invoice_historics
  end

end