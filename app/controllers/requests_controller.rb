class RequestsController < ApplicationController
  before_action :set_request, only: %i[ show edit update destroy ]

  before_action :authenticate_user!, only: %i[ index, my_requests ]

  before_action -> { require_role(:root, :admin) }, only: :index

  before_action :check_timeout, only: :show

  # GET /requests or /requests.json
  def index
    @requests = Request.all
    @allCategories = Category.all
    @allItems = Item.all
  end

  # GET /requests/1 or /requests/1.json
  def show
    @allCategories = Category.all
    @allItems = Item.all
  end

  def volunteer
  end

  # GET /requests/new
  def new
    @request = Request.new
    @allCategories = Category.all
    @allItems = Item.all
    1.times { @request.item_changes.build }
  end

  # GET /requests/1/edit
  def edit
    @allCategories = Category.all
    @allItems = Item.all
  end

  # GET /requests/my-requests
  def my_requests
    @allCategories = Category.all
    @allItems = Item.all
    @requests = current_user != nil ? Request.where("email like ?", "%#{current_user.email}%") : nil  
  end

  # GET /requests/popup
  def popup
    @request = Request.new
  end

  # POST /requests or /requests.json
  def create
    @allCategories = Category.all
    @allItems = Item.all
    @request = Request.new(request_params)


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
    @allCategories = Category.all
    @allItems = Item.all

    respond_to do |format|
      if @request.update(request_params)
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
    @allCategories = Category.all
    @allItems = Item.all
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
    params.require(:request).permit(:urgency, :full_name, :email, :phone, :relationship, :county, :meet, :address, :availability, :comments, item_changes_attributes: [:id, :category_id, :quantity, :itemType, :size, :change_type, :_destroy])
  end

  # Redirects to :root if accessed by non-volunteer after 30 minutes to
  # protect information contained in request.
  def check_timeout
    require_role(:root, :volunteer) if @request.nil? || (Time.current.utc - @request.created_at.utc) / 1.minute > 30
  end
end
