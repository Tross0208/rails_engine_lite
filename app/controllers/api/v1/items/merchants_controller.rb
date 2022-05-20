class Api::V1::Items::MerchantsController < ApplicationController
  def show
    @item = Item.find(params[:id])
    render json: MerchantSerializer.new(Merchant.where(id: @item.merchant_id).first).serializable_hash.to_json
  end
end
