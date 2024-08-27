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
      redirect_to cart_path(@cart), notice: "La quantité en stock n'est pas suffisante"
    end
  end

  def add_duplicate_item_to_cart
    @company = @item.company

    @cart = current_user.carts.where(active: true).first
    @cart = Cart.create(user: current_user) unless @cart.present?

    @order = Order.where(company: @company, cart: @cart).first
    @order = Order.create(company: @company, cart: @cart) unless @order.present?

    @items = Item.with_attached_photo.in_stock

    @item = Item.find(params[:id])
    if @item.is_duplicate?(item1, item2)
      @order_item = OrderItem.create(order: @order, item: @item)
      redirect_to cart_path(@cart)
    else
      flash[:notice] = "La quantité en stock n'est pas suffisante"
      redirect_to cart_path(@cart)
    end
  end

  def destroy
    @cart = current_user.carts.where(active: true).first
    @cart = Cart.create(user: current_user) unless @cart.present?
    order_id = params[:item_id]
    item_id = params[:id]
    OrderItem.find_by(order_id: order_id, item_id: item_id).destroy
    redirect_to(cart_path(@cart))
  end

  def is_duplicate?(item1, item2)
    item1.reference == item2.reference &&
    item1.brand == item2.brand &&
    item1.model == item2.model &&
    item1.color == item2.color &&
    item1.price == item2.price
  end
end
