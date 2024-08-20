class MyStocksController < ApplicationController

  def show
    @items = current_stock
  end

  def show_item
    @item = Item.find(params[:id])
  end

  def add_item
    @item = Item.new
  end

  def create_item

  end


  def edit_item

  end

  def update_item

  end

  def destroy_item

  end
end
