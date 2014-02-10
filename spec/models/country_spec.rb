require 'spec_helper'

describe Country do

	describe 'associations' do
		it { should have_many :scores }
		it { should have_many :bias_points }
		it { should have_many :country_1_ids}
		it { should have_many :country_2_ids}
		it { should have_many :selected_countries}
	end

	describe '#count_positive_bias' do

		it 'returns a count of positive bias points when called on a country instance' do
			@usa = Country.create!(name: 'United States', code: 'USA')
			@bias_1 = BiasPoint.create(country_id: @usa.id, positive: true)

			expect(@usa.count_positive_bias).to eq 1
		end

	end

	describe '#count_negative_bias' do
		it 'returns a count of positive bias points when called on a country instance' do
			@usa = Country.create!(name: 'United States', code: 'USA')
			@bias_2 = BiasPoint.create(country_id: @usa.id, positive: false)
			@bias_3 = BiasPoint.create(country_id: @usa.id, positive: false)

			expect(@usa.count_negative_bias).to eq 2
		end
	end

end