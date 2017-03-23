require 'spec_helper'

RSpec.describe Game, type: :model do

  describe 'associations' do
    it { is_expected.to belong_to(:player1).class_name('Player') }
    it { is_expected.to belong_to(:player2).class_name('Player') }
    it { is_expected.to have_many(:placements).dependent(:destroy) }
    it { is_expected.to have_many(:moves).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:player1_id) }
    it { is_expected.to validate_presence_of(:player2_id) }
  end

  describe '#as_json' do
    let(:game) { create(:game) }
    it 'constains extra data' do
      expect(game.as_json.keys).to include('player1')
      expect(game.as_json.keys).to include('player2')
    end
  end

  describe '#set_started_at' do
    it 'adds started_at as current time' do
      game = create(:game)
      expect{ game.set_started_at }.to change{ game.started_at }
    end
  end
end
