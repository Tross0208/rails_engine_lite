class Api::V1::MerchantsController < ApplicationController
  def index
    #binding.pry
    render json: MerchantSerializer.new(Merchant.all).serializable_hash.to_json
  end

  def show
    render json: MerchantsSerializer.format_merchants(Merchant.find(params[:id])), status: :ok
  end
end
