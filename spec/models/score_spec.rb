require 'spec_helper'

describe Score do

	describe 'associations' do
		it { should belong_to :country }
		it { should belong_to :criterion }
	end

end