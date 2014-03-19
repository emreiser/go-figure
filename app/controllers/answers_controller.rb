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
				add_bias_points(@answer)
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

	def get_score_from_country(answer, country)
		answer.criterion.scores.find_by(country_id: country.id)
	end

	def show
		@answer = Answer.find(params[:id])

		@answer_country_scores = [
			@answer.criterion.scores.find_by(country_id: @answer.country_1_id),
			@answer.criterion.scores.find_by(country_id: @answer.country_2_id)
		]

		@highlighted_country_scores = @answer_country_scores.dup

		@comparison_country = get_comparison_country(@answer)
		if @comparison_country.present?
			@comparison_country_score = get_score_from_country(@answer, @comparison_country)
			@highlighted_country_scores << @comparison_country_score
		end

		@rank_order = @answer.get_rank_order
		@prompt_word = @answer.get_prompt_word

		@answer_country_scores.sort! {|x, y| x.rank <=> y.rank }
		@highlighted_country_scores.sort! {|x, y| x.rank <=> y.rank }
		@ordered_scores = @answer.criterion.scores.includes(:country).sort!{|x, y| x.rank <=> y.rank }
	end


	private
	def answer_params
		params.require(:answer).permit(:user_id, :country_1_id, :country_2_id, :criterion_id, :selected_country_id, :positive)
	end

	def add_bias_points(answer)

		#Pull first country from answer and assign positive attribute
		first_country_point = BiasPoint.new(answer_id: answer.id, country_id: answer.selected_country_id)
		first_country_point.set_positive_attribute(answer)

		#Pull second country from answer and assign positive attribute
		second_country_point = BiasPoint.new(answer_id: answer.id)
		if answer.selected_country_id == answer.country_1_id
			second_country_point[:country_id] = answer.country_2_id
		else
			second_country_point[:country_id] = answer.country_1_id
		end
		second_country_point.set_positive_attribute(answer)

		#If user signed in, record user id for answer
		if user_signed_in?
			first_country_point[:user_id] = current_user.id
			second_country_point[:user_id] = current_user.id
		end

		first_country_point.save!
		second_country_point.save!
	end

end