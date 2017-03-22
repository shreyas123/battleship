require 'spec_helper'

RSpec.describe PlacementsController do
  def app
    described_class
  end

  describe 'GET /placements/games/:game_id' do
    let!(:game) { create :game }
    let!(:placement) { create :placement, game: game }
    subject(:request) { get "/games/#{game.id}" }

    it 'returns all placements' do
      request

      expect(last_response.body).to eq("[#{placement.to_json}]")
      expect(last_response.status).to eq 200
    end

    context 'when game_id is not present' do
      subject(:request) { get "/games/-1" }

      it 'returns error' do
        request

        expect(JSON.parse(last_response.body)).to eq({"error" => 'Game does not exist'})
        expect(last_response.status).to eq 400
      end
    end
  end

  describe 'POST /placements/games/:game_id' do
    let!(:game) { create :game }
    let!(:ship) { create(:ship) }

    subject(:request) { post "/games/#{game.id}", placement: placement }
    let(:placement) { { ship_id: ship, player_number: 1, vertical_placement: 'A', horizontal_placement: '2' } }

    it 'creates a placement' do
      expect{ request }.to change{ Placement.count }.by 1
    end

    it 'returns success and placement' do
      request

      expect(last_response.body).to eq(Placement.last.to_json)
      expect(last_response.status).to eq 200
    end
  end
end
