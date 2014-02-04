class QuestionsController < ApplicationController

	def index
		@countries = Country.all.shuffle
		@country_1 = @countries.sample
		@country_2 = @countries.sample

		@answer = Answer.new

		@criterion = Criterion.all.shuffle.sample
		@question = "Which country do you think had higher #{@criterion.name} ?"
	end

	def show
	end

	def new_question
	end


end

