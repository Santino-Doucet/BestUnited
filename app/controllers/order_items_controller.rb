class OrderItemsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @company = @item.company
    @cart = current_user.carts.where(active: true).first

    @cart = Cart.create(user: current_user) unless @cart.present?

    @order = Order.where(company: @company, cart: @cart).first

    @order = Order.create(company: @company, cart: @cart) unless @order.present?

    items_in_company = @item.same_in_stock
    items_in_cart = @order.same_item(@item)
    if @order.company == @company && items_in_company.size >= items_in_cart.size + 1
      @item = (items_in_company - items_in_cart).first
      @order_item = OrderItem.create(order: @order, item: @item)
      redirect_to cart_path(@cart)
    else
      flash[:notice] = "La quantité en stock n'est pas suffisante"
      redirect_to cart_path(@cart)
    end
  end

  def destroy
    @order_item = OrderItem.find(params[:order_item_id])
    @company = @item.company
    @order_item.destroy
    redirect_to cart_path(@cart)
  end
end
