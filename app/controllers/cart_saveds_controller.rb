class CartSavedsController < ApplicationController
  before_action :set_cart_saved, only: %i[ show destroy recover_sale]
  before_action :authenticate_user!
  include CartSavedsConcerns

  # GET /cart_saveds or /cart_saveds.json
  def index
    @cart_saveds = CartSaved.all.page(params[:page])
  end

  # GET /cart_saveds/1 or /cart_saveds/1.json
  def show
    @cart_saveds =  CartSaved.find_by_cart_saved(@cart_saved)
    @total_cost = CartSaved.total_cost(@cart_saved)
  end

  def recover_sale
    profile ||= Profile.find_by_user(current_user)
    cart_saveds ||= CartSaved.find_by_cart_saved(@cart_saved)
  
    respond_to do |format|
      cart_saveds.each do |cart|
        cart_temp = cart_recovered_build(cart, profile) 
        cart_temp.save
      end

      format.html { redirect_to cart_temps_url, notice: "Cart was successfully recovered." }
      CartSaved.destroy_by_code_cart(@cart_saved)
    end
  

  end

  # POST /cart_saveds or /cart_saveds.json
  def create
    profile ||= Profile.find_by_user(current_user)
    cart_temps ||= CartTemp.find_by_profile(profile)

    respond_to do |format|
      code = GenerateCode.generate
      if cart_temps.empty?
        format.html { redirect_to cart_temps_url, info: "Do not exist item to save." }
      else
        
        cart_temps.each do |cart|
          @cart_saved = cart_saved_build(cart, profile, code) 
          @cart_saved.save
        end

        format.html { redirect_to cart_temps_url, notice: "Cart saved was successfully created." }
        CartTemp.destroy_by_user(current_user)
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
