class RequestsController < ApplicationController
  before_action :set_request, only: %i[ show edit update destroy settle ]

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
    @itemsToStock = @request.getItemStock()

  end

  def volunteer
  end

  def settle
    @show_settled = true
  end

  def next_status
    @request = Request.find(params[:format])
    @request.status = @request.status == "pending" ? "delivery_ready" : "claimed"
    
    if @request.status == "claimed"
      # iterate through items table and update quantity 
      for item in @request.item_changes
        # match item for inventory 
        matchingItems = Item.where(:itemType => item.itemType, :size => item.size, :category_id => item.category_id)
        quantityFulfilled = item.settle

        # contiously remove from each item until the set quantity has been removed 
        for matchedItem in matchingItems
          if matchedItem.quantity >= quantityFulfilled
            # perform the update quantity 
            # ex: quantityFulfilled = 20, and amount in inventory = 15, then quantityFulfilled becomes 5 and amount in inventory should become 0
            # it will then continue to loop to see if there are any more items it can remove
            amountToRemove = quantityFulfilled
            quantityFulfilled -= matchedItem.quantity
            matchedItem.quantity -= amountToRemove 
            matchedItem.save 
          end 
        end 
      end
    end 
    @request.save 

    redirect_to settle_request_path(@request)
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
    default = ItemChange.create!(category: Category.all.sample, quantity: 1, itemType: 2, change_type: 2, size: Item.all.pluck(:size).uniq.sample)
    @request.item_changes << default
  end

  # POST /requests or /requests.json
  def create

    @allCategories = Category.all
    @allItems = Item.all
    @request = nil
    if request_params[:popup] == 'true'
      @request = Request.new(request_params.except(:item_changes_attributes, :popup))
    else
      @request = Request.new(request_params.except(:popup))
    end

    if request_params[:popup] == 'true'
      @request.full_name = "POPUP SHOP"
      @request.meet = 1
      @request.relationship = 1
      @request.email = 'carries.closets@gmail.com'
      @request.urgency = Request::URGENCIES[:'Within 24 hours']
      @request.availability = 'POPUP'
      @request.county = Request::COUNTIES[:Fulton]
      @request.phone = 678_555_5555

      items = request_params[:item_changes_attributes].values
      items = items.map{ |item| item.except(:_destroy, :id) } # Remove excess attribute
      @request.item_changes = ItemChange.create!(items)
    end


    respond_to do |format|

      if @request.save
        if request_params[:popup] != 'true'
          # ActionMailer should send email immediately after new request creation is saved
          UserMailer.with(request: @request).new_email.deliver_later # to DONEE who submitted request

          #if @request.urgency == 1 // new email settings will take care of this
          UserMailer.with(request: @request).new_admin_urgent_email.deliver_later # to ADMIN if URGENT
          # end

          UserMailer.with(request: @request).volunteer_email.deliver_later

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

      if @request.update(request_params.except(:send_to_settle))
        @request.save

        if request_params[:send_to_settle] && current_user&.volunteer?
          format.html { redirect_to settle_request_path(@request), notice: "Request was successfully updated." }
        else
          format.html { redirect_to @request, notice: "Request was successfully updated." }
          format.json { render :show, status: :ok, location: @request }
        end

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
    params.require(:request).permit(:popup, :urgency, :full_name, :email, :phone, :relationship, :county, :meet, :address,
                                    :availability, :comments, :send_to_settle,
                                    item_changes_attributes: [:id, :category_id, :quantity, :settle, :itemType, :size,
                                                              :change_type, :_destroy])
  end

  def request_changes
    request_params.require(:item_changes_attributes)
  end

  # Redirects to :root if accessed by non-volunteer after 30 minutes to
  # protect information contained in request.
  def check_timeout
    require_role(:root, :volunteer) if @request.nil? || (Time.current.utc - @request.created_at.utc) / 1.minute > 30

  end
end
