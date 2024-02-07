class InvoiceTempsController < ApplicationController
  before_action :set_invoice_temp, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /invoice_temps or /invoice_temps.json
  def index
    @invoice_temps = InvoiceTemp.find_by_cart_historic(CartHistoric.last)
  end

  # GET /invoice_temps/1 or /invoice_temps/1.json
  def show
  end

  # GET /invoice_temps/new
  def new
    @invoice_temp = InvoiceTemp.new
    @cart_temps = CartTemp.all
    @total_cost = CartTemp.total_cost 
  end

  # GET /invoice_temps/1/edit
  def edit
  end

  # POST /invoice_temps or /invoice_temps.json
  def create
    invoice_temp = InvoiceTemp.new(invoice_temp_params)
    @total_cost = CartTemp.total_cost 
    value_delivered_customer = invoice_temp.value_delivered_customer


    respond_to do |format|
      if value_delivered_customer < @total_cost
        format.html { redirect_to new_invoice_temp_path(invoice_temp), alert: "The value entered must be equal to or greater than: #{@total_cost}" }
      else 
        @cart_temps = CartTemp.all

     
        code = GenerateCode.generate
        @cart_temps.each do |cart| 
          cart_historic = CartHistoric.new
          cart_historic.item = cart.item
          cart_historic.quantity = cart.quantity
          cart_historic.abandoned = false
          cart_historic.code_cart = code
          cart_historic.save

          @invoice_temp = InvoiceTemp.new
          @invoice_temp.cliente_name = invoice_temp.cliente_name
          @invoice_temp.value_delivered_customer = invoice_temp.value_delivered_customer
          @invoice_temp.payment_method = invoice_temp.payment_method 
          @invoice_temp.profile ||= Profile.find_by_user(current_user)
          @invoice_temp.total = @total_cost
          @invoice_temp.customer_change = value_delivered_customer - @total_cost
          

          @invoice_temp.cart_historic = CartHistoric.where(item_id: cart_historic.item_id).take
          @invoice_temp.sub_total = cart.quantity * cart.item.price
          @invoice_temp.save
        end
       
        format.html { redirect_to invoice_temps_path, notice: "Invoice temp was successfully created." }

       # CartTemp.destroy_all
      end
    end

  end

  # PATCH/PUT /invoice_temps/1 or /invoice_temps/1.json
  def update
    respond_to do |format|
      if @invoice_temp.update(invoice_temp_params)
        format.html { redirect_to invoice_temp_url(@invoice_temp), notice: "Invoice temp was successfully updated." }
        format.json { render :show, status: :ok, location: @invoice_temp }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invoice_temp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoice_temps/1 or /invoice_temps/1.json
  def destroy
    @invoice_temp.destroy

    respond_to do |format|
      format.html { redirect_to invoice_temps_url, notice: "Invoice temp was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice_temp
      @invoice_temp = InvoiceTemp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def invoice_temp_params
      params.require(:invoice_temp).permit(:cliente_name, 
        :total, 
        :value_delivered_customer, 
        :customer_change, 
        :payment_method, 
        :code_cart, 
        :profile_id
      )
    end
end
