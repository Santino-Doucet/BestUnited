class ItemsController < ApplicationController
  before_action :set_item, only: [:show]

  def index
    @items = Item.with_attached_photo.all
    if params[:search][:address].present? && params[:search][:query].present?
      temp_items = @items.search_by_brand_model_reference_and_color(params[:search][:query]).with_attached_photo
      comp_items = []
      Company.near(params[:search][:address], 10).each do |company|
        company.items.each do |item|
          comp_items << item
        end
      end
      @items = temp_items & comp_items
    elsif params[:search][:query].present?
      @items = @items.search_by_brand_model_reference_and_color(params[:search][:query]).with_attached_photo
    elsif params[:search][:address].present?
      @items = []
      Company.near(params[:search][:address], 10).each do |company|
        company.items.each do |item|
          @items << item
        end
      end
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
