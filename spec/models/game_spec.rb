require 'spec_helper'

RSpec.describe Game, type: :model do

  describe 'associations' do
    it { is_expected.to belong_to(:player1).class_name('Player') }
    it { is_expected.to belong_to(:player2).class_name('Player') }
  end
end