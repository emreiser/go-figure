require 'spec_helper'

describe Country do

	describe 'associations' do
		it { should have_many :scores }
		it { should have_many :bias_points }
		it { should have_many :country_1_ids}
		it { should have_many :country_2_ids}
		it { should have_many :selected_countries}
	end

end