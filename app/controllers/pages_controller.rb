class PagesController < ApplicationController
  def index
    @user = current_user
    @items = Item.all
  end
end
