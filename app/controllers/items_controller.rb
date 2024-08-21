class ItemsController < ApplicationController
  def index
    @items = Item.all
    if params[:query].present?
      @items = @items.search_by_brand_model_reference_and_color(params[:query])
    end
  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def show
  end
end
