class RequestsController < ApplicationController
  before_action :set_request, only: %i[ show edit update destroy ]

  before_action :authenticate_user!, only: %i[ index, my_requests ]

  before_action -> { require_role(:root, :admin) }, only: :index

  # GET /requests or /requests.json
  def index
    @requests = Request.all
  end

  # GET /requests/1 or /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    @request = Request.new
    @allCategories = Category.all
    @allItems = Item.all
  end

  # GET /requests/1/edit
  def edit
    @allCategories = Category.all
    @allItems = Item.all
  end

  # GET /requests/my-requests
  def my_requests
    @requests = current_user != nil ? Request.where("email like ?", "%#{current_user.email}%") : nil  
  end 

  # POST /requests or /requests.json
  def create
    @request = Request.new(request_params.except(:items_quantity, :items_category, :items_itemType, :items_sizes))
    @request.items = "#{request_params["items_quantity"]}x #{request_params["items_category"]} #{request_params["items_itemType"]} size #{request_params["items_sizes"]}"

    respond_to do |format|
      if @request.save


        # ActionMailer should send email immediately after new request creation is saved
        UserMailer.with(request: @request).new_email.deliver_later # to DONEE who submitted request

        if @request.urgency == 1
          UserMailer.with(request: @request).new_admin_urgent_email.deliver_later # to ADMIN if URGENT
        end

        format.html { redirect_to @request, notice: "Request was successfully created." }
        format.json { render :show, status: :created, location: @request }
      else
        
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1 or /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params.except(:items_quantity, :items_category, :items_itemType, :items_sizes))
        @request.items = "#{request_params["items_quantity"]}x #{request_params["items_category"]} #{request_params["items_itemType"]} Size #{request_params["items_sizes"]}"
        @request.save

        format.html { redirect_to @request, notice: "Request was successfully updated." }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1 or /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: "Request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = Request.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def request_params
    params.require(:request).permit(:urgency, :full_name, :email, :phone, :relationship, :county, :meet, :address, :availability, :items, :items_quantity, :items_category, :items_itemType, :items_sizes, :comments)
  end
end
