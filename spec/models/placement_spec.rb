require 'spec_helper'

RSpec.describe Placement, type: :model do
  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:ship_id).scoped_to(:game_id) }
    it { is_expected.to validate_presence_of(:game_id) }
    it { is_expected.to validate_presence_of(:ship_id) }
    it { is_expected.to validate_presence_of(:horizontal_placement) }
    it { is_expected.to validate_presence_of(:vertical_placement) }
    it { is_expected.to validate_inclusion_of(:player_number).in_array([1, 2]) }
    it { is_expected.to validate_uniqueness_of(:player_number).scoped_to([:vertical_placement, :horizontal_placement, :game_id]) }

    it { is_expected.to validate_inclusion_of(:vertical_placement).in_array(Placement::VERTICAL_NAMES) }
    it { is_expected.to validate_inclusion_of(:horizontal_placement).in_array(Placement::HORIZONTAL_NAMES) }
  end
end
