require 'rails_helper'

RSpec.describe 'Destinations API' do
  it 'can GET a list of items' do
    destinations = create_list(:destination, 5)

    get '/api/v1/destinations'

    expect(response).to be_success
    expect(response.status).to eq(200)

    response_items = JSON.parse(response.body)

    expect(response_items.count).to eq(5)
    expect(response_items.first["id"]).to eq(items.first.id)
    expect(response_items.first["name"]).to eq(items.first.name)
    expect(response_items.first["description"]).to eq(items.first.description)
    expect(response_items.first["image_url"]).to eq(items.first.image_url)
    expect(response_items.first["created_at"]).to eq(nil)
    expect(response_items.first["updated_at"]).to eq(nil)
  end

  it 'can SHOW a single item' do
    item = create(:item)

    get "/api/v1/items/#{item.id}"

    expect(response).to be_success
    expect(response.status).to eq(200)

    response_item = JSON.parse(response.body)

    expect(response_item["id"]).to eq(item.id)
    expect(response_item["name"]).to eq(item.name)
    expect(response_item["description"]).to eq(item.description)
    expect(response_item["image_url"]).to eq(item.image_url)
    expect(response_item["created_at"]).to eq(nil)
    expect(response_item["updated_at"]).to eq(nil)
  end

  it 'can CREATE an item' do
    item_params = attributes_for(:item)

    expect{ post "/api/v1/items/", item: item_params }.to change(Item, :count).by(1)

    expect(response).to be_success
    expect(response.status).to eq(200)
    expect(item_params[:name]).to eq(Item.last.name)
    expect(item_params[:description]).to eq(Item.last.description)
    expect(item_params[:image_url]).to eq(Item.last.image_url)
  end

  it 'can UPDATE an item' do
    item = create(:item)
    description = Faker::Lorem.sentence

    put "/api/v1/items/#{item.id}", item: {description: description}

    response_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(response.status).to eq(200)
    expect(response_item["id"]).to eq(item.id)
    expect(response_item["description"]).to eq(description)
  end

  it 'can DESTROY an item' do
    item = create(:item)
    id = item.id

    expect{ delete "/api/v1/items/#{id}" }.to change(Item, :count).by(-1)

    expect(response).to be_success
    expect(response.status).to eq(204)
    expect{ Item.find(id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end















#
