class PlansController < ApplicationController
  before_action :set_plan, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  # GET /plans or /plans.json
  def index
    profile ||= current_user.profile

    if profile.super_adminstrador?
      @plans ||= Plan.all
    else
      @plans ||= Plan.find_by_company(profile.company)
    end
  end

  # GET /plans/1 or /plans/1.json
  def show
  end

  # GET /plans/1/edit
  def edit
  end

  # POST /plans or /plans.json
  def create
    @plan = Plan.new(plan_params)

    respond_to do |format|
      if @plan.save
        format.html { redirect_to plan_url(@plan), notice: "Plan was successfully created." }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1 or /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to plan_url(@plan), notice: "Plan was successfully updated." }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1 or /plans/1.json
  def destroy
    @plan.destroy!

    respond_to do |format|
      format.html { redirect_to plans_url, notice: "Plan was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    def invalid_cart
      logger.error "Invalid cart #{params[:id]}"
      redirect_to plans_url, info: "Invalid cart."
    end
    
    # Only allow a list of trusted parameters through.
    def plan_params
      params.require(:plan).permit(:sign_date, :expiration_date, :company_id)
    end
end
