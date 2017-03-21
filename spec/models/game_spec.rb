require 'spec_helper'

RSpec.describe Game, type: :model do

  describe 'associations' do
    it { is_expected.to belong_to(:player1).class_name('Player') }
    it { is_expected.to belong_to(:player2).class_name('Player') }
  end

  describe '#as_json' do
    let(:game) { create(:game) }
    it 'constains extra data' do
      expect(game.as_json.keys).to include('player1')
      expect(game.as_json.keys).to include('player2')
    end
  end
end
