require 'rails_helper'

describe "Merchant API" do
  it 'sends all merchants' do
    create_list(:merchant, 4)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end
  it 'sends merchant by id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_an(String)
    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  it 'sends items for merchant' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    item0 = create :item, {merchant_id: merchant1.id}
    item1 = create :item, {merchant_id: merchant1.id}
    item2 = create :item, {merchant_id: merchant1.id}
    item3 = create :item, {merchant_id: merchant1.id}
    item4 = create :item, {merchant_id: merchant2.id}
    get "/api/v1/merchants/#{merchant1.id}/items"

    items = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(items[:data].count).to eq(4)

  end
end
