require 'spec_helper'

describe BiasPoint do

	describe 'associations' do
		it { should belong_to :country }
		it { should belong_to :user }
		it { should belong_to :answer }
	end

end