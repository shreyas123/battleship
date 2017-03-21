require 'spec_helper'

RSpec.describe GamesController do
  def app
    described_class
  end

  describe 'GET /games/' do
    let!(:game) { create :game }
    subject(:request) { get '/' }

    it 'returns all games' do
      request

      expect(last_response.body).to eq("[#{game.to_json}]")
      expect(last_response.status).to eq 200
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
