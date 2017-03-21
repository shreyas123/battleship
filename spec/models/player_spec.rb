require 'spec_helper'

RSpec.describe Player, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:games1).class_name('Game').dependent(:destroy) }
    it { is_expected.to have_many(:games2).class_name('Game').dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
