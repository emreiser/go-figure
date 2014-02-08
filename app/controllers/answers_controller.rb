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

	def show
		@answer = Answer.find(params[:id])
		@highlighted_countries = [@answer.country_1, @answer.country_2]
		usa = Country.find_by(name: 'United States')

		@ordered_scores = @answer.criterion.scores.valid_scores.order(score: :desc)

		@ordered_countries = @answer.criterion.scores.valid_scores.order(score: :desc).map {|score| score.country}
		@ordered_countries.unshift('zero')

		@answer_countries_rank = @ordered_countries.map {|country| country if @highlighted_countries.include? country}

		@answer_countries = @answer_countries_rank.each_with_index.map do |country,i|
			if country.present?
			 [i, country]
			end
		end
		@answer_countries.compact!

		@comparison_country = ''
		if user_signed_in?
			if current_user.country_id.present?
				@comparison_country = current_user.country
			else
				@comparison_country = usa unless @highlighted_countries.include? usa
			end
		else
			@comparison_country = usa unless @highlighted_countries.include? usa
		end
		@comparison_country_rank = @ordered_countries.index(@comparison_country)

		if @comparison_country.present?
			@highlighted_countries << @comparison_country
			@compared_countries_rank = @ordered_countries.map {|country| country if @highlighted_countries.include? country}
			@compared_countries = @compared_countries_rank.each_with_index.map do |country,i|
				if country.present?
			 		[i, country]
				end
			end
			@compared_countries.compact!
		else
			@compared_countries = @answer_countries
		end
	end


	private
	def answer_params
		params.require(:answer).permit(:user_id, :country_1_id, :country_2_id, :criterion_id, :selected_country_id, :positive)
	end

	def add_bias_points(answer)

		#Pull first country from answer and assign positive attribute
		first_country_point = BiasPoint.new(answer_id: answer.id, country_id: answer.selected_country_id)
		if answer.criterion.higher_good == true
			first_country_point[:positive] = true
		else
			first_country_point[:positive] = false
		end

		#Pull second country from answer and assign positive attribute
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

		#If user signed in, record user id for answer
		if user_signed_in?
			first_country_point[:user_id] = current_user.id
			second_country_point[:user_id] = current_user.id
		end

		first_country_point.save!
		second_country_point.save!
	end

end