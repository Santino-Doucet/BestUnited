class ItemsController < ApplicationController
  before_action :set_item, only: [:show]
  
  def index
    @items = Item.with_attached_photo.all
    if params[:query].present?
      @items = @items.search_by_brand_model_reference_and_color(params[:query])
    end
  end

  def show
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:reference, :brand, :model, :color, :price, :size)
  end
end
