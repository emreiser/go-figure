class QuestionsController < ApplicationController

	def index
		@countries = Country.all.shuffle
		@country_1 = @countries.first
		@country_2 = @countries.last

		@answer = Answer.new

		@criterion = Criterion.all.shuffle.sample
		@question = "Which country do you think had higher #{@criterion.name}?"
	end

	def show
	end

end

