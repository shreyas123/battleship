require 'spec_helper'

RSpec.describe GamesController do
  def app
    described_class
  end

  describe 'GET /games/' do
    let!(:game) { create :game }
    subject(:request) { get '/' }

    it 'returns all games' do
      get "/"

      expect(last_response.body).to eq("[#{game.to_json}]")
      expect(last_response.status).to eq 200
    end
  end
end
