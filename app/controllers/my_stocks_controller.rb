class MyStocksController < ApplicationController

  def show
    @items = current_stock
  end

  def show_item
    @item = current_stock.find(params[:id])
  end

  def add_item
    @user = current_user
    @company = Company.find_by(user_id: @user.id)
    @item = @company.items.new
  end

  def create_item
    @user = current_user
    @company = Company.find_by(user_id: @user.id)
    @item = @company.items.new(item_params)
    @item.save
  end

  def edit_item
    @item = current_stock.find(params[:id])
  end

  def update_item
    @item = current_stock.find(params[:id])
    @item.update(item_params)
    redirect_to show_item_path(@item)
  end

  def destroy_item
    @item = current_stock.find(params[:id])
    items = @item.same_in_stock
    @item.destroy
    if items.size == 0
      redirect_to :my_stock
      flash[:alert] = "Il n'y en a plus"
    else
      flash[:notice] = "Item supprimé"
      redirect_to show_item_in_stock_path(items.first)
    end
  end

  def duplicate_item
    @item = current_stock.find(params[:id])
    @new_item = @item.dup
    @new_item.save
    redirect_to show_item_in_stock_path(@new_item)
  end

  private

  def item_params
    params.require(:item).permit(:reference, :brand, :model, :color, :price, :size, :company_id)
  end
end
