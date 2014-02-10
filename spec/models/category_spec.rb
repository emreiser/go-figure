require 'spec_helper'

describe Category do

	describe 'associations' do
		it { should have_many :criteria}
	end

end