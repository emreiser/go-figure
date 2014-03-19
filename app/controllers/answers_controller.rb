class AnswersController < ApplicationController

	def new
		@answer = Answer.new
	end

	def create
		@answer = Answer.new(answer_params)
		@answer.selected_country_id = Country.find_by(name: params[:commit]).id

		@answer.correct = @answer.assign_correct_answer

		if @answer.save
			if @answer[:correct] == true
				flash[:notice] = "That's right."
			else
				flash[:warning] = "Go figure."
				BiasPoint.add_bias_points(@answer, current_user)
			end
			redirect_to @answer
		end
	end

	def get_comparison_country(answer)
		usa = Country.find_by(name: 'United States')

		if [answer.country_1_id, answer.country_2_id].include? usa.id
			''
		elsif user_signed_in? && current_user.country_id.present?
			current_user.country
		else
			usa
		end
	end

	def show
		@answer = Answer.find(params[:id])

		@answer_country_scores = @answer.country_scores

		@highlighted_country_scores = @answer_country_scores.dup

		@comparison_country = get_comparison_country(@answer)

		if @comparison_country.present?
			@comparison_country_score = Score.get_country_score(@comparison_country.id, @answer.criterion_id)
			@highlighted_country_scores << @comparison_country_score
		end

		@rank_order = @answer.get_rank_order
		@prompt_word = @answer.get_prompt_word

		@highlighted_country_scores.sort! {|x, y| x.rank <=> y.rank }
		@ordered_scores = @answer.criterion.all_scores
	end


	private
	def answer_params
		params.require(:answer).permit(:user_id, :country_1_id, :country_2_id, :criterion_id, :selected_country_id, :positive)
	end

end