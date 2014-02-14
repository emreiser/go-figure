class CountriesController < ApplicationController

	def index
		@countries = Country.search(params[:search])
	end

	def show
		@country = Country.find(params[:id])
		@categories = Category.includes(:criteria)

		#Count number of positive and negative points for country
		@positive_bias_points = @country.count_positive_bias
		@negative_bias_points = @country.count_negative_bias
	end


end