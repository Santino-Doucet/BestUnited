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

  def validate_order
    # le commercant peut accepter une commande émise par le client.
    # status est à nil par défault.
    # Quand le commercant accepte,status devient 'validée'
    @user = current_user
    @order = @user.companies.first.orders.find(params[:id])
    @order.update(status: 'Validée')
    @client_id = @order.cart.user.id
    cart = Cart.where(user_id: @client_id)
    cart.update(validated_on: Date.today)
    redirect_to orders_path
  end

  def refuse_order
    # le commercant peut refuser une commande émise par le client.
    # status est à nil par défault.
    # Quand le commercant accepte,status devient 'Refusée'
    @user = current_user
    @order = @user.companies.first.orders.find(params[:id])
    @order.update(status: 'Refusée')
    redirect_to orders_path
  end

  def deliver_order
    @user = current_user
    @order = @user.companies.first.orders.find(params[:id])
    @order.update(status: 'Effectuée')
    redirect_to orders_path
  end
end
