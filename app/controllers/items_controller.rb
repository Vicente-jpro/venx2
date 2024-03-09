class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :redirect_if_is_not_admin!,  only: [ :edit, :update, :destroy, :new ]

  include ItemsConcerns
  # GET /items or /items.json
  def index
    @items = items_searched(params[:query]).page(params[:page])
    if @items.empty?
      @items = Item.all.page(params[:page])
      redirect_to items_url, info: "No items found."
    end
  end

  def add_cart
    @items = items_searched(params[:query])
    if @items.empty?
      @items = Item.all
      redirect_to add_cart_items_url, info: "No items found."
    end
  end
  # GET /items/1 or /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items or /items.json
  def create
    @item = Item.new(item_params)
    @item.profile ||= Profile.find_by_user(current_user)
    @item.price = @item.price + (@item.price * 0.14) + @item.profite_value #Teaxa do iva

    respond_to do |format|
      if @item.save
        format.html { redirect_to item_url(@item), notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    @item.profile ||= Profile.find_by_user(current_user)

    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to item_url(@item), notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    def redirect_if_is_not_admin!
      if !current_user.profile.adminstrador?
        redirect_to items_url, info: "Authorized only for adminstrator."
      end
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(
        :description, 
        :manufacturing_date, 
        :expiration_date, 
        :quantity, 
        :price, 
        :tax, 
        :item_code, 
        :profite_value, 
        :supplier_id, 
        :category_id, 
        :sector_id
      )
    end
end
