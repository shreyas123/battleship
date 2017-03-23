require 'spec_helper'

RSpec.describe Placement, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:game) }
    it { is_expected.to belong_to(:ship) }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:ship_id).scoped_to(:game_id) }
    it { is_expected.to validate_presence_of(:game_id) }
    it { is_expected.to validate_presence_of(:ship_id) }
    it { is_expected.to validate_presence_of(:player_number) }
    it { is_expected.to validate_presence_of(:horizontal_placement) }
    it { is_expected.to validate_presence_of(:vertical_placement) }
    it { is_expected.to validate_inclusion_of(:player_number).in_array([1, 2]) }
    it { is_expected.to validate_uniqueness_of(:player_number).scoped_to([:vertical_placement, :horizontal_placement, :game_id]) }

    it { is_expected.to validate_inclusion_of(:vertical_placement).in_array(Placement::VERTICAL_NAMES) }
    it { is_expected.to validate_inclusion_of(:horizontal_placement).in_array(Placement::HORIZONTAL_NAMES) }

    describe '#cross_over' do
      it 'validates the overlap and overbound of ships' do
        game = create(:game)
        placement = create(:placement, vertical_placement: 'D', horizontal_placement: '2', game: game)
        placement = build(:placement, vertical_placement: 'D', horizontal_placement: '4', game: game)
        expect(placement.valid?).to be_falsy

        placement = build(:placement, :is_vertical, vertical_placement: 'D', horizontal_placement: '4', game: game)
        expect(placement.valid?).to be_falsy

        placement = build(:placement, :is_vertical, vertical_placement: 'C', horizontal_placement: '5', game: game)
        expect(placement.valid?).to be_falsy

        placement = build(:placement, :is_vertical, vertical_placement: 'H', horizontal_placement: '5', game: game)
        expect(placement.valid?).to be_falsy

        placement = build(:placement, vertical_placement: 'D', horizontal_placement: '7', game: game)
        expect(placement.valid?).to be_falsy
      end
    end
  end

  describe 'scopes' do
    describe '.for_player_*' do
      let!(:placement1) { create :placement, player_number: 1 }
      let!(:placement2) { create :placement, player_number: 2}
      let!(:placement3) { create :placement, player_number: 2 }
      let!(:placement4) { create :placement, player_number: 1 }

      it 'returns all placements of player 1 or 2' do
        expect(Placement.for_player_1.to_a).to match_array([placement1, placement4])
        expect(Placement.for_player_2.to_a).to match_array([placement2, placement3])
      end
    end
  end

  describe 'placement_board' do
    it 'creates an array of board' do
      placement = build(:placement, vertical_placement: 'A', horizontal_placement: '2')
      expect(placement.placement_board).to eql([['A', 2], ['A', 3], ['A', 4], ['A', 5], ['A', 6]])

      placement = build(:placement, vertical_placement: 'A', horizontal_placement: '2', vertical: true)
      expect(placement.placement_board).to eql([['A', 2], ['B', 2], ['C', 2], ['D', 2], ['E', 2]])
    end
  end
end
