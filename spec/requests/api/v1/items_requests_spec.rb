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

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end
  it 'sends Item by id' do
    id = create(:merchant).id
    item0 = create :item, {merchant_id: id}

    get "/api/v1/items/#{item0.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

      expect(item[:data]).to have_key(:id)
      expect(item[:data][:id]).to be_an(String)
      expect(item[:data][:attributes]).to have_key(:name)
      expect(item[:data][:attributes][:name]).to be_a(String)
      expect(item[:data][:attributes]).to have_key(:description)
      expect(item[:data][:attributes][:description]).to be_a(String)
      expect(item[:data][:attributes]).to have_key(:unit_price)
      expect(item[:data][:attributes][:unit_price]).to be_a(Float)
      expect(item[:data][:attributes]).to have_key(:merchant_id)
      expect(item[:data][:attributes][:merchant_id]).to be_an(Integer)
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

  it 'updates Item' do
    merch_id = create(:merchant).id
    item0 = create :item, {merchant_id: merch_id}
    id = item0.id
    previous_name = Item.last.name
    item_params = {name: 'New Name'}
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item: item_params)
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item0.name).to_not eq(previous_name)
    expect(item0.name).to eq("New Name")
  end

  it 'destroys Item' do
    merch_id = create(:merchant).id
    item0 = create :item, {merchant_id: merch_id}

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item0.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item0.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

end
