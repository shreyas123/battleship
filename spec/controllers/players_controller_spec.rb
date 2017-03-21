require 'spec_helper'

RSpec.describe PlayersController do
  def app
    described_class
  end

  describe 'GET /players/' do
    let!(:player) { create :player }
    subject(:request) { get '/' }

    it 'returns all players' do
      request

      expect(last_response.body).to eq("[#{player.to_json}]")
      expect(last_response.status).to eq 200
    end
  end

  describe 'POST /players/' do
    subject(:request) { post '/', player: player  }
    let(:player) { { name: name } }
    let(:name) { 'Shreyas' }

    it 'creates a player' do
      expect{ request }.to change{ Player.count }.by 1
    end

    context 'when player cannot be created' do
      let(:name) { '' }
      it 'returns all players' do
        request

        expect(JSON.parse(last_response.body)).to eq({"name" => ["can't be blank"]})
        expect(last_response.status).to eq 422
      end
    end
  end
end
