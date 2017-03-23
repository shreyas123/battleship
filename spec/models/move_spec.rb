require 'spec_helper'

RSpec.describe Move, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:game) }
    it { is_expected.to belong_to(:ship_sunk).class_name('Ship') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:game_id) }
    it { is_expected.to validate_presence_of(:horizontal_move) }
    it { is_expected.to validate_presence_of(:vertical_move) }
    it { is_expected.to validate_presence_of(:player_number) }
    it { is_expected.to validate_uniqueness_of(:horizontal_move).scoped_to([:vertical_move, :game_id]) }
    it { is_expected.to validate_uniqueness_of(:vertical_move).scoped_to([:horizontal_move, :game_id]) }
    it { is_expected.to validate_inclusion_of(:vertical_move).in_array(Placement::VERTICAL_NAMES) }
    it { is_expected.to validate_inclusion_of(:horizontal_move).in_array(Placement::HORIZONTAL_NAMES) }
    it { is_expected.to validate_inclusion_of(:player_number).in_array([1, 2]) }
  end

  describe 'callbacks' do

  end
end