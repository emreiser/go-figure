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

	describe 'validations' do
		it 'should be invalid without a criterion id' do
			@answer = Answer.create(country_1_id: 23, country_2_id: 4, selected_country_id: 23)
			expect(@answer).to_not be_valid
		end

		it 'should be invalid without a country_1 id' do
			@answer = Answer.create(criterion_id: 1, country_2_id: 4, selected_country_id: 23)
			expect(@answer).to_not be_valid
		end

		it 'should be invalid without a country_2 id' do
			@answer = Answer.create(criterion_id: 1, country_1_id: 4, selected_country_id: 23)
			expect(@answer).to_not be_valid
		end

		it 'should be invalid without a selected_country id' do
			@answer = Answer.create(criterion_id: 1, country_1_id: 4, country_2_id: 23)
			expect(@answer).to_not be_valid
		end

		it 'should assign selected_country_id equal to country_1_id or country_2_id' do
			@answer = Answer.create(criterion_id: 1, country_1_id: 4, country_2_id: 23)
			expect(@answer).to_not be_valid
		end
	end

	describe 'get_rank_order' do

		it "should return a string of 'highest to lowest' if answer criterion higher_good true" do
			criterion = Criterion.create!(name: '_2010_fixed_and_mobile_telephone_subscribers', display_name: 'ratio of telephone subscribers in 2010', higher_good: true)
			@answer = Answer.create!(criterion_id: criterion.id, country_1_id: 23, country_2_id: 4, selected_country_id: 23)

			expect(@answer.get_rank_order).to eq 'highest to lowest'
		end
	end

end