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
      expect(item).to have_key(:merchant_id)
      expect(item[:merchant_id]).to be_an(Integer)
    end
  end
  it 'sends Item by id' do
    id = create(:merchant).id
    item0 = create :item, {merchant_id: id}

    get "/api/v1/items/#{item0.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(Integer)
      expect(item).to have_key(:name)
      expect(item[:name]).to be_a(String)
      expect(item).to have_key(:description)
      expect(item[:description]).to be_a(String)
      expect(item).to have_key(:unit_price)
      expect(item[:unit_price]).to be_a(Float)
      expect(item).to have_key(:merchant_id)
      expect(item[:merchant_id]).to be_an(Integer)
    end
  it 'creates new Item' do
    id = create(:merchant).id
    item_params = ({
                  name: 'Empty can of Pepsi MAX',
                  description: 'Can of Pepsi Max, opened, contents gaseous ONLY',
                  unit_price: 17,
                  merchant_id: id,
                })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])

  end
end
