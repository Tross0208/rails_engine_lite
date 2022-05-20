class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    render json: ItemSerializer.new(Item.where(merchant_id: @merchant.id)).serializable_hash.to_json
  end
end
