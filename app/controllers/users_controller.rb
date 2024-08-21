class UsersController < ApplicationController
  def show
    @user = current_user
    @orders = @user.companies.first.orders
    @items = current_stock
  end
end
