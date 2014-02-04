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
				flash[:notice] = "That's right!"
			else
				flash[:warning] = "Not so much."
				add_bias_points(@answer)
			end
			redirect_to @answer
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
		@highlighted_countries << @answer.country_1 << @answer.country_2
		if @highlighted_countries.include? Country.find_by(name: 'United States')
			@highlighted_countries << Country.find_by(name: 'Canada')
		else
			@highlighted_countries << Country.find_by(name: 'United States')
		end

		@ordered_scores = @answer.criterion.scores.valid_scores.order(score: :desc)

		@ordered_countries = @highlighted_countries.map do |country|
			{
				rank: @ordered_scores.index {|x| x.country_id == country.id } + 1,
				country_name: country.name
			}
		end

		@ordered_countries.sort! {|x, y| x[:rank] <=> y[:rank] }
	end


	private
	def answer_params
		params.require(:answer).permit(:user_id, :country_1_id, :country_2_id, :criterion_id, :selected_country_id, :positive)
	end

	def add_bias_points(answer)

		first_country_point = BiasPoint.new(answer_id: answer.id, country_id: answer.selected_country_id)
		if answer.criterion.higher_good == true
			first_country_point[:positive] = true
		else
			first_country_point[:positive] = false
		end

		second_country_point = BiasPoint.new(answer_id: answer.id)
		if answer.selected_country_id == answer.country_1_id
			second_country_point[:country_id] = answer.country_2_id
		else
			second_country_point[:country_id] = answer.country_1_id
		end
		if answer.criterion.higher_good == true
			second_country_point[:positive] = false
		else
			second_country_point[:positive] = true
		end

		first_country_point.save!
		second_country_point.save!
	end

end