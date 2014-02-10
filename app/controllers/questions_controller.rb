class QuestionsController < ApplicationController
	layout "landing", :only => :landing

	def landing
	end

	def about
	end

	def index

		if user_signed_in?
			@user = current_user
		end
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

		if @criterion.higher_good == true
			prompt_word = 'a higher'
		else
			prompt_word = 'lower'
		end

		@answer = Answer.new
		@question = "Which country do you think had #{prompt_word} #{@criterion.display_name}?"
	end

	def show
	end

end

