class InvoiceTempsController < ApplicationController
  before_action :set_invoice_temp, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  include InvoiceTempsConcerns
  include CompanyConcerns

  # GET /invoice_temps or /invoice_temps.json
  def index
    @profile ||= Profile.find_by_user(current_user)
    
    cart_historic = CartHistoric.find_last_by_profile(@profile)
    @invoice_temps = InvoiceTemp.find_by_cart_historic(cart_historic) 

    if @invoice_temps.empty?
      redirect_to cart_temps_path, info: "Do not exist invoice_temp."
    elsif cart_historic.present? 
      @invoice_temps = InvoiceTemp.find_by_cart_historic(cart_historic) 
    else 
      redirect_to cart_temps_path, info: "Do not exist invoice_temp."
    end
  end

  # GET /invoice_temps/1 or /invoice_temps/1.json
  def show
  end

  # GET /invoice_temps/new
  def new
    @invoice_temp = InvoiceTemp.new
    @cart_temps = CartTemp.find_by_current_user(current_user)
    @total_cost = CartTemp.total_cost(current_user)
  end

  # GET /invoice_temps/1/edit
  def edit
  end


  # POST /invoice_temps or /invoice_temps.json
  def create
    invoice_temp = InvoiceTemp.new(invoice_temp_params)
    @total_cost = CartTemp.total_cost(current_user)
    value_delivered_customer = invoice_temp.value_delivered_customer
    profile ||= Profile.find_by_user(current_user)

    if profile.nil?
      return profile_new_path 
    end

    plan = Plan.find_by_company(profile.company)
    
    respond_to do |format|
      if is_expired?(plan)
        logger.error ("####### Select a plan after use this funcionaty. #######")
        format.html { redirect_to cart_temps_url, alert: "Select a plan after use this funcionaty." }
      
      elsif value_delivered_customer < @total_cost
          logger.error ("####### The value entered must be equal to or greater than: #{@total_cost} #######")
          format.html { redirect_to cart_temps_url, alert: "The value entered must be equal to or greater than: #{@total_cost}" }
      else 
        @cart_temps = CartTemp.find_by_current_user(current_user)

        code = GenerateCode.generate
        date = Time.now
        @cart_temps.each do |cart| 

          cart_historic = cart_historic_build(cart, code, profile, date)
          cart_historic.save
          
          @invoice_temp = invoice_temp_build(
            invoice_temp, 
            profile, 
            value_delivered_customer,
            @total_cost,
            cart_historic,
            cart,
            date
          )
          @invoice_temp.save

          @invoice_historic = invoice_historic_build(
            invoice_temp,
            profile,
            @total_cost, date
          ) 
          @invoice_historic.save
        end
        format.html { redirect_to invoice_temps_path, notice: "Invoice temp was successfully created." }
        
        CartTemp.destroy_by_user(current_user)
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
