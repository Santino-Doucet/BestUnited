class PagesController < ApplicationController
  def index
    @user = current_user
    @items = Item.all
    @cart = current_user.carts.where(active: true).first

    @cart = Cart.create(user: current_user) unless @cart.present?
  end
end
