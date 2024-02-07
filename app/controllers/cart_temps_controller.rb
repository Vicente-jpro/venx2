class CartTempsController < ApplicationController
  before_action :set_cart_temp, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  include CartTempsConcerns

  #rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  # GET /cart_temps or /cart_temps.json
  def index
    @cart_temps = CartTemp.all
    @total_cost = CartTemp.total_cost
  end

  # GET /cart_temps/1 or /cart_temps/1.json
  def show
  end

  # GET /cart_temps/new
  def new
    @cart_temp = CartTemp.new
  end

  # GET /cart_temps/1/edit
  def edit
  end

  # POST /cart_temps or /cart_temps.json
  def create
    
    @cart_temp = CartTemp.new(cart_temp_params)
    item_exist = CartTemp.find_by(item_id: @cart_temp.item_id)
    item = Item.find(@cart_temp.item_id)

    respond_to do |format|
      if item_exist
        format.html { redirect_to add_cart_items_url, alert: "The item #{item.description} just exit in cart." }
      elsif @cart_temp.quantity <= 0
        format.html { redirect_to add_cart_items_url, alert: "The number of items must be greater than or equal to 1." }
      elsif  @cart_temp.quantity > item.quantity 
        format.html { redirect_to add_cart_items_url, alert: "The quantity of the chosen item must be less than the quantity saved." }
      elsif @cart_temp.save
          
        item.quantity = item.quantity - @cart_temp.quantity   
        item.update(item.as_json)
        format.html { redirect_to add_cart_items_url, notice: "Cart temp was successfully created." }
        format.json { render :show, status: :created, location: @cart_temp }
      else
        format.html { render new, status: :unprocessable_entity }
        format.json { render json: @cart_temp.errors, status: :unprocessable_entity }
      end
    end
  
  end

  # GET /cart_temps/:id/add_one_item
  def add_one_item
    item_in_cart = CartTemp.find(params[:id])
    item = Item.find(item_in_cart.item_id) 
    
    respond_to do |format|
      if item_out_of_stock?(item) # Item esgotado do stock
        format.html { redirect_to cart_temps_url, alert: "Item out of stock" }
      else
        item_in_cart.quantity += 1
        item_in_cart.update(item_in_cart.as_json)
        item.quantity = item.quantity - 1  
        item.update(item.as_json)

        format.html { redirect_to cart_temps_url, notice: "Cart temp was successfully created." }
        format.json { render :show, status: :created, location: @cart_temp } 
      end
    end
  end


  # GET /cart_temps/:id/add_one_item
  def remove_one_item
    item_in_cart = CartTemp.find(params[:id])
    item = Item.find(item_in_cart.item_id) 
    
    respond_to do |format|
      if item_out_of_stock?(item) # Item esgotado do stock
        format.html { redirect_to cart_temps_url, alert: "Item out of stock" }
      else
        item_in_cart.quantity -= 1
        item_in_cart.update(item_in_cart.as_json)
        item.quantity = item.quantity + 1  
        item.update(item.as_json)

        format.html { redirect_to cart_temps_url, notice: "Cart temp was successfully created." }
        format.json { render :show, status: :created, location: @cart_temp } 
      end
    end
  end

  def cart_abandoned
    @cart_temps = CartTemp.where(abandoned: true)
  end
  # PATCH/PUT /cart_temps/1 or /cart_temps/1.json
  def update
    respond_to do |format|
      if @cart_temp.update(cart_temp_params)
        format.html { redirect_to cart_temp_url(@cart_temp), notice: "Cart temp was successfully updated." }
        format.json { render :show, status: :ok, location: @cart_temp }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart_temp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_temps/1 or /cart_temps/1.json
  def destroy
    item = Item.find(@cart_temp.item_id)

    item.quantity = item.quantity + @cart_temp.quantity   

    item.update(item.as_json)
    @cart_temp.destroy

    respond_to do |format|
      format.html { redirect_to cart_temps_url, notice: "Cart temp was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_temp
      @cart_temp = CartTemp.find(params[:id])
    end

    def invalid_cart
      logger.error "Invalid cart #{params[:id]}"
      redirect_to cart_temps_url, info: "Invalid cart."
    end

    # Only allow a list of trusted parameters through.
    def cart_temp_params
      params.require(:cart_temp).permit(:quantity, :abandoned, :item_id)
    end
end
