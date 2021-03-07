class DonationsController < ApplicationController
  before_action :set_donation, only: %i[ show edit update destroy ]
  
  before_action :authenticate_user!, only: %i[ index, my_donations ]

  before_action -> { require_role(:root, :admin) }, only: :index

  # GET /donations or /donations.json
  def index
    @donations = Donation.all
  end

  # GET /donations/1 or /donations/1.json
  def show
  end

  # GET /donations/new
  def new
    @donation = Donation.new
  end

  # GET /donations/1/edit
  def edit
  end

  # GET /donations/my-donations
  def my_donations
    @donations = current_user != nil ? Donation.where("email like ?", "%#{current_user.email}%") : nil  
  end 

  # POST /donations or /donations.json
  def create
    @donation = Donation.new(donation_params.except(:items_quantity, :items_category, :items_itemType, :items_sizes))
    @donation.items = "#{donation_params["items_quantity"]}x #{donation_params["items_category"]} #{donation_params["items_itemType"]} size #{donation_params["items_sizes"]}"

    respond_to do |format|
      if @donation.save
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
    respond_to do |format|
      if @donation.update(donation_params.except(:items_quantity, :items_category, :items_itemType, :items_sizes))
        @donation.items = "#{donation_params["items_quantity"]}x #{donation_params["items_category"]} #{donation_params["items_itemType"]} Size #{donation_params["items_sizes"]}"
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
      params.require(:donation).permit(:full_name, :email, :phone, :county, :meet, :address, :availability, :items, :items_quantity, :items_category, :items_itemType, :items_sizes, :comments)
    end
end
