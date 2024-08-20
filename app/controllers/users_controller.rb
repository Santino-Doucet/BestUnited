class UsersController < ApplicationController
  def show
    @user = current_user
    @orders = @user.companies[0].orders
    @items = current_stock
  end
end
