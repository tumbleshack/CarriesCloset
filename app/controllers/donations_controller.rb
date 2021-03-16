class DonationsController < ApplicationController
  before_action :set_donation, only: %i[ show edit update destroy ]
  
  before_action :authenticate_user!, only: %i[ index, my_donations ]

  before_action -> { require_role(:root, :admin) }, only: :index

  # GET /donations or /donations.json
  def index
    @donations = Donation.all
    @allCategories = Category.all
    @allItems = Item.all
  end

  # GET /donations/1 or /donations/1.json
  def show
    @allCategories = Category.all
    @allItems = Item.all
  end

  # GET /donations/new
  def new
    @donation = Donation.new
    @allCategories = Category.all
    @allItems = Item.all
    1.times { @donation.item_changes.build }
  end

  # GET /donations/1/edit
  def edit
    @allCategories = Category.all
    @allItems = Item.all
  end

  # GET /donations/my-donations
  def my_donations
    @allCategories = Category.all
    @allItems = Item.all
    @donations = current_user != nil ? Donation.where("email like ?", "%#{current_user.email}%") : nil  
  end 

  # POST /donations or /donations.json
  def create
    @allCategories = Category.all
    @allItems = Item.all
    @donation = Donation.new(donation_params)
  
    respond_to do |format|
      if @donation.save

        UserMailer.with(donation: @donation).new_donor_email.deliver_later

        format.html { redirect_to @donation, notice: "Donation was successfully created." }
        format.json { render :show, status: :created, location: @donation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /donations/1 or /donations/1.json
  def update
    @allCategories = Category.all
    @allItems = Item.all
    respond_to do |format|
      if @donation.update(donation_params)
        @donation.save

        format.html { redirect_to @donation, notice: "Donation was successfully updated." }
        format.json { render :show, status: :ok, location: @donation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /donations/1 or /donations/1.json
  def destroy
    @allCategories = Category.all
    @allItems = Item.all
    @donation.destroy
    respond_to do |format|
      format.html { redirect_to donations_url, notice: "Donation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donation
      @donation = Donation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def donation_params
      params.require(:donation).permit(:full_name, :email, :phone, :county, :meet, :address, :availability, :comments, item_changes_attributes: [:id, :category_id, :quantity, :itemType, :size, :change_type, :_destroy])
    end
end
