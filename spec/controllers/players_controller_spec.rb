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
end
