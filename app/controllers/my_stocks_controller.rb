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
    # @item = Item.new(item_params)
    # if @item.save
    #   redirect_to my_stocks_path, notice: "Item created successfully."
    # else
    #   render :add_item
    # end
  end

  def edit_item

  end

  def update_item

  end

  def destroy_item

  end
end
