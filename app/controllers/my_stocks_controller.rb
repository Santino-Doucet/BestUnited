require 'open-uri'


class MyStocksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create_item]

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
    # Assuming you are expecting 'data' in params sent from the frontend
    data = params[:data]

    item = Item.new(
      reference: data['styleId'],
      brand: data['brand'],
      model: data['name'],
      color: data['colorway'],
      price: 10,
      company: current_user.companies.first,
      size: 40,
      released_on: Date.new(data['year'].to_i)
    )
    unless data['media']['imageUrl'].nil?
      file = URI.open(data['media']['imageUrl'])
      item.photo.attach(io: file, filename: 'shoe.png' , content_type: 'image/png')
    end
    item.save!
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

    unique_items = {}

    items.each do |item|
      key = [item.reference, item.brand, item.model, item.color, item.price, item.size]

      if unique_items[key]
        unique_items[key][:count] += 1
      else
        unique_items[key] = { item: item, count: 1 }
      end
    end

    sorted_unique_items = unique_items.values.sort_by { |entry| -entry[:count] }

    sorted_unique_items.map { |entry| entry[:item] }
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
