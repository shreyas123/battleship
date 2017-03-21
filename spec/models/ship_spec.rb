require 'spec_helper'

RSpec.describe Ship, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:length) }
  end
end