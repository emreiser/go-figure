class CountriesController < ApplicationController

	def index
		@answer = Answer.new
	end

	def show
		@country = Country.find(params[:id])
		@categories = Category.all
	end


end