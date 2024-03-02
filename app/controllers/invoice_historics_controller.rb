class InvoiceHistoricsController < ApplicationController
  before_action :set_invoice_historic, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  include InvoiceHistoricsConcerns
  # GET /invoice_historics or /invoice_historics.json
  def index
    @invoice_historics = InvoiceHistoric.all
  end

  # GET /invoice_historics/1 or /invoice_historics/1.json
  def show
    @invoice_historics = InvoiceHistoric.find_by_cart_historic(@invoice_historic)
    @total_cost = CartHistoric.total_cost(@invoice_historic.cart_historic)
  end

  # GET /invoice_historics/new
  def new
    @invoice_historic = InvoiceHistoric.new
  end

  # GET /invoice_historics/1/edit
  def edit
  end

  # POST /invoice_historics or /invoice_historics.json
  def create
    @invoice_historic = InvoiceHistoric.new(invoice_historic_params)

    respond_to do |format|
      if @invoice_historic.save
        format.html { redirect_to invoice_historic_url(@invoice_historic), notice: "Invoice historic was successfully created." }
        format.json { render :show, status: :created, location: @invoice_historic }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invoice_historic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoice_historics/1 or /invoice_historics/1.json
  def update
    respond_to do |format|
      if @invoice_historic.update(invoice_historic_params)
        format.html { redirect_to invoice_historic_url(@invoice_historic), notice: "Invoice historic was successfully updated." }
        format.json { render :show, status: :ok, location: @invoice_historic }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invoice_historic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoice_historics/1 or /invoice_historics/1.json
  def destroy
    @invoice_historic.destroy!

    respond_to do |format|
      format.html { redirect_to invoice_historics_url, notice: "Invoice historic was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice_historic
      @invoice_historic = InvoiceHistoric.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def invoice_historic_params
      params.require(:invoice_historic).permit(:cliente_name, :total, :sub_total, :value_delivered_customer, :customer_change, :payment_method, :profile_id, :cart_historic_id)
    end
end
