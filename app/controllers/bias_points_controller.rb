class BiasPointsController < ApplicationController


	def index
			selected_countries = [
				'United States',
				'Cuba',
				'Rwanda',
				'South Korea',
				'Saudi Arabia',
				'Mexico',
				'Venezuela',
				'United Arab Emirates',
				'China',
				'Brazil',
				'Kenya',
				'Russia',
				'India'
			]

		@featured_countries = selected_countries.sort.map { |country| Country.find_by(name: country)}
	end


end