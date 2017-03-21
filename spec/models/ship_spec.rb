require 'spec_helper'

RSpec.describe Ship, type: :model do
  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:length) }
    it { is_expected.to validate_numericality_of(:length).only_integer
                                                     .is_less_than_or_equal_to(10)
                                                     .is_greater_than(0) }
  end
end