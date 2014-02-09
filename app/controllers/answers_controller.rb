class AnswersController < ApplicationController

	def new
		@answer = Answer.new
	end

	def create
		@answer = Answer.new(answer_params)
		@answer[:selected_country_id] = Country.find_by(name: params[:commit]).id

		if @answer[:selected_country_id] == get_correct_country(@answer)
			@answer[:correct] = true
		else
			@answer[:correct] = false
		end

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

	def get_correct_country(answer)
		score_country_1 = Score.find_country_score(answer.country_1_id, answer.criterion_id)
		score_country_2 = Score.find_country_score(answer.country_2_id, answer.criterion_id)

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

	def set_comparison_country(answer_countries)
		usa = Country.find_by(name: 'United States')

		if answer_countries.include? usa
			''
		elsif user_signed_in? && current_user.country_id.present?
			current_user.country
		else
			usa
		end
	end

	def show
		@answer = Answer.find(params[:id])
		@answer_country_scores = [
			Score.where(criterion_id: @answer.criterion.id).where(country_id: @answer.country_1),
			Score.where(criterion_id: @answer.criterion.id).where(country_id: @answer.country_2)].flatten!

		@highlighted_country_scores = [
			Score.where(criterion_id: @answer.criterion.id).where(country_id: @answer.country_1),
			Score.where(criterion_id: @answer.criterion.id).where(country_id: @answer.country_2)].flatten!

		@comparison_country = set_comparison_country([@answer.country_1, @answer.country_1])

		if @comparison_country.present?
			@comparison_country_score = @comparison_country.scores.find_by(criterion_id: @answer.criterion.id)
			@highlighted_country_scores << @comparison_country_score
		end

		@answer_country_scores.sort_by!{ |x| x.rank }
		@highlighted_country_scores.sort_by!{ |x| x.rank }
		@ordered_scores = Score.valid_scores.where(criterion_id: @answer.criterion.id).sort_by { |x| x.rank }
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