class QuestionsController < ApplicationController

	def index
		@criterion = Criterion.all.shuffle.sample

		@valid_scores = Score.where(criterion_id: @criterion.id).where.not(score: nil).shuffle
		@valid_countries = []

		@valid_scores.each do |score|
			if score.country.select == true
				@valid_countries << score.country
			end
		end

		@country_1 = @valid_countries.first
		@country_2 = @valid_countries.last

		@answer = Answer.new
		@question = "Which country do you think had higher #{@criterion.display_name}?"
	end

	def show
	end

end

