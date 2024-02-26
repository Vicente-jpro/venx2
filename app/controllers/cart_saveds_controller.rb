class CartSavedsController < ApplicationController
  before_action :set_cart_saved, only: %i[ show destroy ]
  before_action :authenticate_user!
  include CartSavedsConcerns

  # GET /cart_saveds or /cart_saveds.json
  def index
    @cart_saveds = CartSaved.all
  end

  # GET /cart_saveds/1 or /cart_saveds/1.json
  def show
  end

  # POST /cart_saveds or /cart_saveds.json
  def create
    profile ||= Profile.find_by_user(current_user)
    cart_temps ||= CartTemp.find_by_profile(profile)
    debugger

    code = GenerateCode.generate
    respond_to do |format|
      cart_temps.each do |cart|
        @cart_saved = cart_saved_build(cart, profile, code) 
        @cart_saved.save
      end

      format.html { redirect_to cart_temps_url, notice: "Cart saved was successfully created." }
      CartTemp.destroy_by_user(current_user)
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
