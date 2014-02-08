class CountriesController < ApplicationController

	def index
		@answer = Answer.new
		@countries = Country.all
	end

	def show
		@country = Country.find(params[:id])
		@categories = Category.all

		#Count number of positive and negative points for country
		@positive_bias_points = @country.bias_points.where(positive: true).count
		@negative_bias_points = @country.bias_points.where(positive: false).count

	end


end