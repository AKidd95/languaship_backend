require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'assosiations' do 
    it { is_expected.to belong_to :user }
    
  end
end

