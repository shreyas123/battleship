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

  describe 'PUT /placements/games/:game_id/:placement_id' do
    let!(:game) { create :game }
    let!(:ship) { create(:ship) }
    let!(:placement) { create(:placement, game: game, ship: ship, vertical_placement: 'A') }

    subject(:request) { put "/games/#{game.id}/#{placement.id}", placement: placement_params }
    let(:placement_params) { { player_number: 1, vertical_placement: 'B', horizontal_placement: '2' } }

    it 'creates a placement' do
      expect{ request }.to change{ placement.reload.vertical_placement }.to 'B'
    end

    context 'when placement id does not exist' do
      subject(:request) { put "/games/#{game.id}/-1", placement: placement_params }
      it 'returns error' do
        request

        expect(JSON.parse(last_response.body)).to eq({"error" => 'Placement does not exist'})
        expect(last_response.status).to eq 400
      end
    end
  end

  describe 'DELETE /placements/games/:game_id/:placement_id' do
    let!(:game) { create :game }
    let!(:ship) { create(:ship) }
    let!(:placement) { create(:placement, game: game, ship: ship, vertical_placement: 'A') }

    subject(:request) { delete "/games/#{game.id}/#{placement.id}", placement: placement_params }
    let(:placement_params) { { player_number: 1, vertical_placement: 'B', horizontal_placement: '2' } }

    it 'creates a placement' do
      expect{ request }.to change{ game.placements.count }.by -1
    end
  end
end
