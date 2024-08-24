class CartsController < ApplicationController

  def index
    @carts = Cart.where(user: current_user)
  end

  def show
    @cart = Cart.find(params[:id])
    @orders = @cart.orders
  end

  def send_order_to_merchant
    @cart = Cart.find(params[:id])
    @cart.update(active: false)
    @cart.orders.each do |order|
      order.update(ordered_on: Date.today, status: 'Pending')
    end
    redirect_to root_path
  end

  private

  def cart_params
    params.require(:cart).permit(:user_id, :validated_on)
  end
end
