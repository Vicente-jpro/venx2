class MostSalesController < ApplicationController
  def index
    @most_sales = MostSale.find_most_sales
  end
end
