class GamesController < ApplicationController

	def index
	end

	def show
		@countries = Country.all.shuffle
		@first = @countries.pop
		@second = @countries.pop
	end


end

