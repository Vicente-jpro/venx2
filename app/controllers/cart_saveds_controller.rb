class CartSavedsController < ApplicationController
  before_action :set_cart_saved, only: %i[ show edit update destroy ]

  # GET /cart_saveds or /cart_saveds.json
  def index
    @cart_saveds = CartSaved.all
  end

  # GET /cart_saveds/1 or /cart_saveds/1.json
  def show
  end

  # GET /cart_saveds/new
  def new
    @cart_saved = CartSaved.new
  end

  # GET /cart_saveds/1/edit
  def edit
  end

  # POST /cart_saveds or /cart_saveds.json
  def create
    @cart_saved = CartSaved.new(cart_saved_params)

    respond_to do |format|
      if @cart_saved.save
        format.html { redirect_to cart_saved_url(@cart_saved), notice: "Cart saved was successfully created." }
        format.json { render :show, status: :created, location: @cart_saved }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cart_saved.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cart_saveds/1 or /cart_saveds/1.json
  def update
    respond_to do |format|
      if @cart_saved.update(cart_saved_params)
        format.html { redirect_to cart_saved_url(@cart_saved), notice: "Cart saved was successfully updated." }
        format.json { render :show, status: :ok, location: @cart_saved }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart_saved.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_saveds/1 or /cart_saveds/1.json
  def destroy
    @cart_saved.destroy!

    respond_to do |format|
      format.html { redirect_to cart_saveds_url, notice: "Cart saved was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_saved
      @cart_saved = CartSaved.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_saved_params
      params.require(:cart_saved).permit(:quantity, :abandoned, :item_id, :profile_id)
    end
end
