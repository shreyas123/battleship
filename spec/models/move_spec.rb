require 'spec_helper'

RSpec.describe Move, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:game) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:game_id) }
    it { is_expected.to validate_presence_of(:horizontal_move) }
    it { is_expected.to validate_presence_of(:vertical_move) }
    it { is_expected.to validate_presence_of(:player_number) }
    it { is_expected.to validate_inclusion_of(:vertical_move).in_array(Placement::VERTICAL_NAMES) }
    it { is_expected.to validate_inclusion_of(:horizontal_move).in_array(Placement::HORIZONTAL_NAMES) }
    it { is_expected.to validate_inclusion_of(:player_number).in_array([1, 2]) }

    describe 'check_placements' do
      let(:game) { create :game }
      let!(:ship) { create :ship }
      it 'throw error if placement is not complete' do
        move = build(:move, game: game, player_number: 2, vertical_move: 'A', horizontal_move: 1)
        expect(move.valid?).to be_falsy
        expect(move.errors.messages).to eql({player_number: ["Game cannot start as player 1 and player 2 has not placed all the ships."]})

        create(:placement, ship: ship, game: game, player_number: 1, horizontal_placement: '1', vertical_placement: "A")
        expect(move.valid?).to be_falsy
        expect(move.errors.messages).to eql({player_number: ["Game cannot start as player 2 has not placed all the ships."]})

        create(:placement, ship: ship, game: game, player_number: 2, horizontal_placement: '1', vertical_placement: "A")
        expect(move.valid?).to be_truthy
      end
    end
  end

  describe 'callbacks' do
    describe "before_save" do
      describe "check_hit" do
        let(:game) { create :game }
        let(:ship) { create :ship }
        let!(:placement) { create :placement, ship: ship, game: game, player_number: 1,
                                             horizontal_placement: '1', vertical_placement: "A" }
        let!(:placement_not_needed) { create :placement, ship: ship, game: game, player_number: 2,
                                             horizontal_placement: '1', vertical_placement: "A" }
        it 'sets hit if it hits' do
          move = build(:move, game: game, player_number: 2, vertical_move: 'A', horizontal_move: 1)
          expect{ move.save }.to change{ move.hit }.to true
          move.destroy

          move = build(:move, game: game, player_number: 2, vertical_move: 'A', horizontal_move: 2)
          expect{ move.save }.to change{ move.hit }.to true

          move = build(:move, game: game, player_number: 2, vertical_move: 'A', horizontal_move: 6)
          expect{ move.save }.to_not change{ move.hit }
        end
      end
    end

    describe "after_commit" do
      describe "game_won" do
        let(:game) { create :game }
        let(:ship) { create :ship }
        let!(:placement) { create :placement, ship: ship, game: game, player_number: 1,
                                             horizontal_placement: '1', vertical_placement: "A" }
        let!(:placement_not_needed) { create :placement, ship: ship, game: game, player_number: 2,
                                             horizontal_placement: '1', vertical_placement: "A" }
        it 'sets hit if it hits' do
          move = build(:move, game: game, player_number: 2, vertical_move: 'A', horizontal_move: 1)
          expect{ move.save }.to_not change{ game.reload.won_by }

          move = build(:move, game: game, player_number: 2, vertical_move: 'A', horizontal_move: 2)
          expect{ move.save }.to_not change{ game.reload.won_by }

          move = build(:move, game: game, player_number: 2, vertical_move: 'A', horizontal_move: 3)
          expect{ move.save }.to_not change{ game.reload.won_by }

          move = build(:move, game: game, player_number: 2, vertical_move: 'A', horizontal_move: 4)
          expect{ move.save }.to_not change{ game.reload.won_by }

          move = build(:move, game: game, player_number: 2, vertical_move: 'A', horizontal_move: 5)
          expect{ move.save }.to change{ game.reload.won_by }.to 2
        end
      end

      describe "set_started_at" do
        let(:game) { create :game }
        let(:ship) { create :ship }
        let!(:placement) { create :placement, ship: ship, game: game, player_number: 1,
                                             horizontal_placement: '1', vertical_placement: "A" }
        let!(:placement_not_needed) { create :placement, ship: ship, game: game, player_number: 2,
                                             horizontal_placement: '1', vertical_placement: "A" }
        it 'sets hit if it hits' do
          move = build(:move, game: game, player_number: 2, vertical_move: 'A', horizontal_move: 1)
          expect{ move.save }.to change{ game.reload.started_at }
        end
      end
    end
  end
end
