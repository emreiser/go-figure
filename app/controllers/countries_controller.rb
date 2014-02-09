class CountriesController < ApplicationController

	def index
		@countries = Country.search(params[:search])
	end

	def show
		@country = Country.find(params[:id])
		@categories = Category.all

		#Count number of positive and negative points for country
		@positive_bias_points = @country.positive_bias.count
		@negative_bias_points = @country.negative_bias.count
	end


end