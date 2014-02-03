class CountriesController < ApplicationController

	def index
		@countries = Country.all.shuffle
		@first = @countries.pop
		@second = @countries.pop
	end

	def select_random_pair
	end

end