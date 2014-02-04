class QuestionsController < ApplicationController

	def index
		@criterion = Criterion.all.shuffle.sample
		@valid_scores = Score.where(criterion_id: @criterion.id).where.not(score: nil).shuffle

		@country_1 = Country.find(@valid_scores.first.country_id)
		@country_2 = Country.find(@valid_scores.last.country_id)

		@answer = Answer.new
		@question = "Which country do you think had higher #{@criterion.name}?"
	end

	def show
	end

end

