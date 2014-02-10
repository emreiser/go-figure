require 'spec_helper'

describe Score do

	describe 'associations' do
		it { should belong_to :country }
		it { should belong_to :criterion }
	end

	describe '.find_country_score' do
		it 'returns a single Score when passed country ID and criterion ID' do
			@score = Score.create(criterion_id: 9, country_id: 3, score: 99)
			expect(Score.find_country_score(3, 9)).to eq @score.score
		end
	end

end