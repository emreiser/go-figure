class AnswersController < ApplicationController

	def new
		@answer = Answer.new
	end

	def create
		@answer = Answer.create(answer_params)
		@answer[:selected_country_id] = Country.find_by(name: params[:commit]).id

		if @answer[:selected_country_id] == get_correct_country(@answer)
			@answer[:correct] = true
		else
			@answer[:correct] = false
		end

		if @answer.save
			redirect_to @answer
		else
		end
	end

	def get_correct_country(answer)
		score_country_1 = Score.find_by(criterion_id: answer.criterion_id, country_id: answer.country_1_id).score
		score_country_2 = Score.find_by(criterion_id: answer.criterion_id, country_id: answer.country_2_id).score

		if score_country_1 > score_country_2
			answer[:country_1_id]
		else
			answer[:country_2_id]
		end
	end

	def get_positive_field(answer)
		if answer[:correct] == false
			if answer.criterion.higher_good == true
				false
			else
				true
			end
		end
	end

	def show
		@answer = Answer.find(params[:id])
		@highlighted_countries = []
		@highlighted_countries << @answer.country_1_id << @answer.country_2_id << Country.find_by(name: 'United States').id

		@ordered_scores = Score.where(criterion_id: @answer.criterion.id).where.not(score: nil)

		if @answer.criterion.higher_good == true
			@ordered_scores.order!(score: :desc)
		else
			@ordered_scores.order!(score: :asc)
		end
	end


	private
	def answer_params
		params.require(:answer).permit(:user_id, :country_1_id, :country_2_id, :criterion_id, :selected_country_id, :positive)
	end

end