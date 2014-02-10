require 'spec_helper'

describe Country do

	describe 'associations' do
		it { should have_many :scores }
		it { should have_many :bias_points }
	end

end