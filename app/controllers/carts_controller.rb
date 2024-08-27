class CartsController < ApplicationController

  def index
    @carts = Cart.where(user: current_user)
    @pending_carts = Cart.where(user_id: current_user.id).select { |cart| cart.orders.exists?(status: 'En attente') }

    @validated_carts = Cart.joins(:orders).where(user_id: current_user.id).group('carts.id').having(
      'COUNT(orders.id) = COUNT(CASE WHEN orders.status = \'Validée\' THEN 1 END)'
    )

    @old_carts = Cart.joins(:orders).where(user_id: current_user.id).group('carts.id').having(
      'COUNT(orders.id) = COUNT(CASE WHEN orders.status = \'Effectuée\' THEN 1 END)'
    )
  end

  def show
    @cart = Cart.find(params[:id])
    @orders = @cart.orders
    @nb_items_orders = 0
    @total_price = 0
    @orders.each do |order|
      @nb_items_orders += order.items.size
      order.items.each do |item|
        @total_price += item.price
      end
    end
  end

  def send_order_to_merchant
    @cart = Cart.find(params[:id])
    @cart.update(active: false)
    @cart.orders.each do |order|
      order.update(ordered_on: Date.today, status: 'En attente')
    end
    redirect_to root_path
  end

  private

  def cart_params
    params.require(:cart).permit(:user_id, :validated_on)
  end
end
