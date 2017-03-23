require 'spec_helper'

RSpec.describe Move, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:game) }
    it { is_expected.to belong_to(:ship_sunk).class_name('Ship') }
  end
end