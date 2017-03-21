require 'spec_helper'

RSpec.describe ShipsController do
  def app
    described_class
  end

  describe 'GET /ships' do
    let!(:ship) { create :ship }
    subject(:request) { get '/' }

    it 'returns all games' do
      request

      expect(last_response.body).to eq("[#{ship.to_json}]")
      expect(last_response.status).to eq 200
    end
  end
end
