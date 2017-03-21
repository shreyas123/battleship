require 'spec_helper'

RSpec.describe Game, type: :model do

  describe 'associations' do
    it { is_expected.to belong_to(:player1).class_name('Player') }
    it { is_expected.to belong_to(:player2).class_name('Player') }
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

  describe 'callbacks' do
    describe 'before_create' do
      describe '#add_started_at' do
        it 'adds started_at as current time' do
          game = build(:game)
          game.started_at = nil
          game.save
          expect( game.reload.started_at ).to_not be_nil
        end
      end
    end
  end
end
