require 'rails_helper'

describe "Merchant API" do
  it 'sends all merchants' do
    create_list(:merchant, 4)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(Integer)
      expect(merchant).to have_key(:name)
      expect(merchant[:name]).to be_a(String)
    end
  end
  it 'sends merchant by id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_an(Integer)
    expect(merchant).to have_key(:name)
    expect(merchant[:name]).to be_a(String)
  end
  #it 'sends items for merchant' do
  #  id = create(:merchant).id
  #  get "/api/v1/merchants/#{id}/items"

  #  items = JSON.parse(response.body, symbolize_names: true)

#  end
end
