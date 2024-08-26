class MyStocksController < ApplicationController

  def show
    @items = current_user.companies.first.items.in_stock
    @unique_items = remove_duplicates(@items)
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
    items = @item.same_in_stock.all
    @item.destroy
    if items.empty?
      flash[:alert] = "Il n'y en a plus"
    else
      flash[:notice] = "Item supprimé"
    end
  end

  def duplicate_item
    @item = current_stock.find(params[:id])
    @new_item = @item.dup
    if @item.photo.attached?
      @new_item.photo.attach(@item.photo.blob)
    end
    @new_item.save
  end

  private

  def remove_duplicates(items)
    unique_items = []
    items.each do |item|
      unless unique_items.any? { |unique_item| is_duplicate?(unique_item, item) }
        unique_items << item
      end
    end
    unique_items
  end

  def is_duplicate?(item1, item2)
    item1.reference == item2.reference &&
    item1.brand == item2.brand &&
    item1.model == item2.model &&
    item1.color == item2.color &&
    item1.price == item2.price
  end

  def item_params
    params.require(:item).permit(:reference, :brand, :model, :color, :price, :size, :company_id)
  end
end
