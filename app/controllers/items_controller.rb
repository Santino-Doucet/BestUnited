require "json"
require 'rest-client'
require 'open-uri'

class ItemsController < ApplicationController
  before_action :set_item, only: [:show]
  skip_before_action :verify_authenticity_token, only: [:create_from_scan]

  def index
    @items = Item.with_attached_photo.in_stock
    @user = current_user
    unless @user.nil?
      @cart = current_user.carts.where(active: true).first

      @cart = Cart.create(user: current_user) unless @cart.present?
    end
    if params[:search][:address].present? && params[:search][:query].present?
      temp_items = @items.search_by_brand_model_reference_and_color(params[:search][:query]).with_attached_photo
      comp_items = []
      Company.near(params[:search][:address], 10).each do |company|
        company.items.each do |item|
          comp_items << item
        end
      end
      @items = temp_items & comp_items
    elsif params[:search][:query].present?
      @items = @items.search_by_brand_model_reference_and_color(params[:search][:query]).with_attached_photo
    elsif params[:search][:address].present?
      @items = []
      Company.near(params[:search][:address], 10).each do |company|
        company.items.in_stock.each do |item|
          @items << item
        end
      end
    end
  end

  def show
    @user = current_user
    unless @user.nil?
      @cart = current_user.carts.where(active: true).first
      @cart = Cart.create(user: current_user) unless @cart.present?
    end
    lat1 = @item.company.latitude
    lng1 = @item.company.longitude
    lat2 = Geocoder.search(params[:address]).first.latitude
    lng2 = Geocoder.search(params[:address]).first.longitude
    if valid_coordinates?(lat1, lng1) && valid_coordinates?(lat2, lng2)
      @distance = (Geocoder::Calculations.distance_between([lat1, lng1], [lat2, lng2])*1000).round
    else
      @distance = nil
    end
  end

  def create_from_scan
    response = RestClient.get("https://api.upcitemdb.com/prod/trial/lookup?upc=#{params[:barcode]}",{})
    response_body = JSON.parse(response.body)
    render json: response_body
  end

  def create
    params[:quantity].to_i.times do
      item = Item.new(item_params)
      item.company = current_user.companies.first
      # file = URI.open(response_body["items"][0]["images"][0])
      # item.photo.attach(io: file, filename: "shoe.jpg" , content_type: "image/jpg")
      item.save!
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:reference, :brand, :model, :color, :price, :size, :barcode)
  end

  def valid_coordinates?(lat, lng)
    lat.is_a?(Numeric) && lng.is_a?(Numeric) &&
    lat.between?(-90, 90) && lng.between?(-180, 180)
  end
end
