require 'rails_helper'

describe "Items API" do
  it 'sends all Items' do
    id = create(:merchant).id

    @item0 = create :item, {merchant_id: id}
    @item1 = create :item, {merchant_id: id}
    @item2 = create :item, {merchant_id: id}
    @item3 = create :item, {merchant_id: id}

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(Integer)
      expect(item).to have_key(:name)
      expect(item[:name]).to be_a(String)
      expect(item).to have_key(:description)
      expect(item[:description]).to be_a(String)
      expect(item).to have_key(:unit_price)
      expect(item[:unit_price]).to be_a(Float)
    end
  end
end
