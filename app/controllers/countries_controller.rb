class CountriesController < ApplicationController

	def index
		@answer = Answer.new
		@countries = Country.all
	end

	def show
		@country = Country.find(params[:id])
		@categories = Category.all

		@positive_bias_points = BiasPoint.where(country_id: @country.id).where(positive: true).count
		@negative_bias_points = BiasPoint.where(country_id: @country.id).where(positive: false).count

	end


end