class CountriesController < ApplicationController

	def index
		@countries = Country.all.shuffle
		@first = @countries.pop
		@second = @countries.pop
	end

	def show
		@country = Country.find(params[:id])
		@categories = Category.all
	end


end