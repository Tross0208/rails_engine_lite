class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemsSerializer.format_items(Item.all), status: :ok
  end

  def show
    render json: ItemsSerializer.format_items(Item.find(params[:id])), status: :ok
  end

  def create
    render json: ItemsSerializer.format_items(Item.create(item_params)), status: :ok
  end

private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
