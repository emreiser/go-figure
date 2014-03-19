class QuestionsController < ApplicationController
	layout "landing", :only => :landing

	def landing
	end

	def about
	end

	def index

		@criterion = Criterion.includes(:category).shuffle.sample

		valid_countries = @criterion.get_valid_countries.shuffle

		@country_1 = valid_countries.first
		@country_2 = valid_countries.last

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

