require 'rails_helper'

describe Api::V1::LaunchersController, type: :request do
  include ApiAsJsonHelper
  include_context 'api data'

  let!(:launch) { create(:launch) }

  # before do
  #   authenticate_token
  # end

  describe 'GET api/v1/' do
    context 'when called' do
      it 'return a message' do
        get '/api/v1/'

        expect(JSON.parse(response.body)).to eq({"message" => "REST Back-end Challenge 20201209 Running"})
      end
    end
  end

  describe 'GET api/v1/import_launchers' do
    context 'when called' do
      it 'return paginated launchers' do
        get '/api/v1/import_launchers'

        expect(JSON.parse(response.body)).to eq({"message"=>"Running launchers import asyncronously"})
      end
    end
  end

  describe 'GET api/v1/launchers' do
    context 'when called' do
      it 'return paginated launchers' do
        get '/api/v1/launchers'

        expect(response.status).to eq 200
        expect(JSON.parse(response.body).except('meta')).to include(
          {'launchers' => Launch.all.map { |launch| launch_as_json(launch) }}
        )
      end
    end
  end

  describe 'POST api/v1/launchers' do
    context 'when corret params was send' do
      it 'creates a launcher' do
        expect {
          post(
            '/api/v1/launchers',
            params: {
              launch: {
                name: 'Launcher Test',
                slug: 'Super Launcher Test',
                url: 'http://localhost:3000.com',
              }
            }
          )
        }.to change(Launch, :count).by(1)
      end
    end

    context 'when incorrect params was send' do
      let(:invalid_params) { { launch: { invalid_params: "invalid" } } }

      it 'doesn\'t creates a launch' do
        post '/api/v1/launchers', params: invalid_params

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)).to eq({"error" => ["Name can't be blank"]})
      end
    end
  end

  describe 'POST api/v1/launchers/:launch_id' do
    context 'when corret params was send' do
      let(:update_params) do
        {
          launch: {
            name: 'Launch Update',
            slug: 'Super Launch Update',
            phone: 'http://update.com',
          }
        }
      end

      it 'update customer data' do
        put "/api/v1/launchers/#{launch.id}", params: update_params

        expect(response.status).to eq 200
        expect(JSON.parse(response.body)).to eq(launch_as_json(launch.reload))
      end
    end

    context 'when incorrect params was send' do
      let(:invalid_update_params) do
        {
          launch: {
            id: launch.id.to_s,
            name: "",
          }
        }
      end

      it 'doesn\'t update customer data' do
        put  "/api/v1/launchers/#{launch.id}", params: invalid_update_params

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)).to eq({"error" => ["Name can't be blank"]})
      end
    end
  end

  describe 'DELETE api/v1/launchers/:launch_id' do
    context 'when correct params is send' do
      it 'delete launch' do
        delete  "/api/v1/launchers/#{launch.id}"

        expect(response.status).to eq(204)
      end
    end
  end
end
