require 'spec_helper'

describe Answer do

	describe 'associations' do
		it { should belong_to :criterion }
		it { should belong_to :user }
		it { should have_many :bias_points }
	end

end