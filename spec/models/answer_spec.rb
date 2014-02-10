require 'spec_helper'

describe Answer do

	describe 'associations' do
		it { should belong_to :criterion }
		it { should belong_to :user }
		it { should have_many :bias_points }

		it { should belong_to :country_1 }
		it { should belong_to :country_2 }
		it { should belong_to :selected_country }
	end

end