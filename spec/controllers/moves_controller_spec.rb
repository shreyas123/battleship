require 'spec_helper'

RSpec.describe MovesController do
  def app
    described_class
  end

  describe 'GET /moves/games/:game_id' do
    let!(:game) { create :game }
    let!(:ship) { create :ship }
    let!(:placement) { create :placement, ship: ship, game: game, player_number: 2,
                                             horizontal_placement: '1', vertical_placement: "A" }
        let!(:placement_not_needed) { create :placement, ship: ship, game: game, player_number: 1,
                                             horizontal_placement: '1', vertical_placement: "A" }
    let!(:move) { create :move, game: game }

    subject(:request) { get "/games/#{game.id}" }

    it 'returns all moves' do
      request

      expect(last_response.body).to eq("[#{move.to_json}]")
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

  describe 'POST /games' do
    let(:player1) { create(:player) }
    let(:player2) { create(:player) }
    subject(:request) { post '/', game: game }
    let(:game) { { player1_id: player1, player2_id: player2 } }

    it 'creates a game' do
      expect{ request }.to change{ Game.count }.by 1
    end

    it 'returns all games' do
      request

      expect(last_response.body).to eq("#{Game.last.to_json}")
      expect(last_response.status).to eq 200
    end
  end
end
