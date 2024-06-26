class CartTempsController < ApplicationController
  before_action :set_cart_temp, only: %i[ show update destroy ]
  before_action :authenticate_user!
  
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  include CartTempsConcerns

  # GET /cart_temps or /cart_temps.json
  def index
    @cart_temps = CartTemp.find_by_current_user(current_user)
    @total_cost = CartTemp.total_cost(current_user)
  end

  def add_with_sanner 
    item = Item.find_by(item_code: params[:query])
    
    respond_to do |format|
      if item.nil?
        format.html { redirect_to cart_temps_url, 
          alert: "This item do not exist." }
      elsif item_out_of_stock?(item)
        format.html { redirect_to cart_temps_url, 
          alert: "The #{item.description} item is no longer available in stock" }
      elsif item 
        profile ||= Profile.find_by_user(current_user)
        item_on_cart_temp = CartTemp.find_by(item_id: item.id, profile_id: profile.id)

        if item_on_cart_temp
          item_on_cart_temp.quantity += 1
          item_on_cart_temp.update(item_on_cart_temp.as_json)
          item.quantity = item.quantity - 1  
          item.update(item.as_json)
  
          format.html { redirect_to cart_temps_url, notice: "Cart temp was successfully created." }      
        else  
          @cart_temp = CartTemp.new 
          @cart_temp.quantity = 1
          @cart_temp.abandoned = true 
          @cart_temp.item = item
          @cart_temp.profile = profile
          @cart_temp.save
          
          item.quantity = item.quantity - @cart_temp.quantity   
          item.update(item.as_json)
          format.html { redirect_to cart_temps_url, notice: "Cart temp was successfully created." }

          @invoice ||= InvoiceTemp.find_by_current_user(current_user)
          if !@invoice.empty?
            InvoiceTemp.destroy_by_user(current_user)
          end
        end
      end

    end
  end

  def cancel 
    @cart_temps = CartTemp.find_by_current_user(current_user)
    
    respond_to do |format|
      if @cart_temps.empty?
        format.html { redirect_to cart_temps_url, info: "There is no purchase to be cancelled." }
      else
        @cart_temps.each do |cart| 

          item = cart.item
          item.quantity += cart.quantity
          item.update(item.as_json)
        end
    
        format.html { redirect_to cart_temps_url, notice: "Purchase canceled successfully." }
        CartTemp.where(profile_id: current_user.profile.id).destroy_all

      end
    end  
  end
  # GET /cart_temps/1 or /cart_temps/1.json
  def show
  end

  def new_sale
    respond_to do |format|
      CartTemp.destroy_by_user(current_user)
      InvoiceTemp.destroy_by_user(current_user)
      format.html { redirect_to cart_temps_url, info: "Ready to make sales :)" }
    end
  end

  # GET /cart_temps/new
  def new
    @cart_temp = CartTemp.new
  end


  # POST /cart_temps or /cart_temps.json
  def create
    
    @cart_temp = CartTemp.new(cart_temp_params)
    item = Item.find(@cart_temp.item_id)
    @cart_temp.profile ||= Profile.find_by_user(current_user)
    item_exist = CartTemp.find_by(item_id: @cart_temp.item_id, profile_id: @cart_temp.profile.id)

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
        
        @invoice ||= InvoiceTemp.find_by_current_user(current_user)
        if !@invoice.empty?
          InvoiceTemp.destroy_by_user(current_user)
        end
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
      elsif item_in_cart.quantity == 1
        format.html { redirect_to cart_temps_url, alert: "Impossible to remove the item." }
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
