require 'spec_helper'

describe Criterion do

	describe 'associations' do
		it { should belong_to :category }
		it { should have_many :scores }
		it { should have_many :answers }
	end

end