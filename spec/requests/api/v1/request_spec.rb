require 'rails_helper'

RSpec.describe 'Destinations API' do
  it 'can GET a list of destination' do
    destinations = create_list(:destination, 5)

    get '/api/v1/destinations'

    expect(response).to be_success
    expect(response.status).to eq(200)

    response_destination = JSON.parse(response.body, symbolize_names: true)

    expect(response_destination.count).to eq(5)
    expect(response_destination.first[:id]).to eq(destination.first.id)
    expect(response_destination.first[:name]).to eq(destination.first.name)
    expect(response_destination.first[:zip]).to eq(destination.first.zip)
    expect(response_destination.first[:description]).to eq(destination.first.description)
    expect(response_destination.first[:image_url]).to eq(destination.first.image_url)
  end

  it 'can SHOW a single destination' do
    destination = create(:destination)

    get "/api/v1/destination/#{destination.id}"

    expect(response).to be_success
    expect(response.status).to eq(200)

    response_destination = JSON.parse(response.body)

    expect(response_destination[:id]).to eq(destination.id)
    expect(response_destination[:name]).to eq(destination.name)
    expect(response_destination[:description]).to eq(destination.description)
    expect(response_destination[:image_url]).to eq(destination.image_url)
  end

  it 'can CREATE an destination' do
    destination_params = attributes_for(:destination)

    expect{ post "/api/v1/destination/", destination: destination_params }.to change(Destination, :count).by(1)

    expect(response).to be_success
    expect(response.status).to eq(200)
    expect(destination_params[:name]).to eq(Destination.last.name)
    expect(destination_params[:description]).to eq(Destination.last.description)
    expect(destination_params[:image_url]).to eq(Destination.last.image_url)
  end

  it 'can UPDATE an destination' do
    destination = create(:destination)
    description = Faker::Lorem.sentence

    put "/api/v1/destination/#{destination.id}", destination: {description: description}

    response_destination = JSON.parse(response.body)

    expect(response).to be_success
    expect(response.status).to eq(200)
    expect(response_destination[:id]).to eq(destination.id)
    expect(response_destination[:description]).to eq(description)
  end

  it 'can DESTROY an destination' do
    destination = create(:destination)
    id = destination.id

    expect{ delete "/api/v1/destination/#{id}" }.to change(Destination, :count).by(-1)

    expect(response).to be_success
    expect(response.status).to eq(204)
    # expect id to not be present
  end
end















#
