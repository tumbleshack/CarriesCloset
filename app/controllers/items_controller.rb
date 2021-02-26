class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]
  before_action -> { require_role(:root, :admin) }, only: %i[ show edit update destroy index ]

  # GET /items or /items.json
  def index
    @items = Item.all
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
    Category.where(id: item_params["category_id"]).each do |category|
      item_params["size"].split(",").each do |size|
        puts "Creating #{item_params["itemType"]} with category #{category.name} with size #{size}"
        @item = Item.new(quantity: 0,
                         itemType: item_params["itemType"],
                         size: size,
                         category_id: category.id)
        puts @item, @item.save!
      end
    end

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully created." }
      format.json { render :show, status: :created, location: @item }
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(size: item_params["size"], itemType: item_params["itemType"], quantity: item_params["quantity"])
        format.html { redirect_to @item, notice: "Item was successfully updated." }
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

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:quantity, :itemType, :size, :category_id => [])
    end
end
