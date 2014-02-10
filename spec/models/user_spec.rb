require 'spec_helper'

describe User do

	describe 'associations' do
		it { should have_many :answers }
		it { should have_many :bias_points }
		it { should belong_to :country }
	end

end