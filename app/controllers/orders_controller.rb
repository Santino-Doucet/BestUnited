class OrdersController < ApplicationController

  def index
    # le commercant consulte toutes ses commandes
    @user = current_user
    @orders = @user.companies.first.orders
  end

  def show
    # le commercant peut consulter une commande en particulier
    @user = current_user
    @order = @user.companies.first.orders.find(params[:id])
  end

  def update
    # le commercant peut accepter une commande émise par le client.
    # status est à nil par défault.
    # Quand le commercant accepte,status devient 'validée'
    @user = current_user
    @order = @user.companies.first.orders.find(params[:id])
    @order.update(status: 'Validée')
    redirect_to orders_path
  end
end
