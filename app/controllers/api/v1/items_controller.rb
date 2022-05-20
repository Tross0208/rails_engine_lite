class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all).serializable_hash.to_json
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id])).serializable_hash.to_json
  end

  def create
    render json: ItemSerializer.new(Item.create(item_params)).serializable_hash.to_json, status: :created
  end

  def update
    if Merchant.find(params[:merchant_id]) #|| !item_params[:merchant_id]
      render json: ItemSerializer.new(Item.update(params[:id], item_params)).serializable_hash.to_json, status: 202
    else
      render status: 404
    end
  end

  def destroy
    render json: ItemSerializer.new(Item.delete(params[:id]))
  end

private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
