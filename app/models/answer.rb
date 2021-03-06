class Answer < ActiveRecord::Base
	has_many :bias_points
	belongs_to :criterion
	belongs_to :user

	belongs_to :country_1, class_name: Country, foreign_key: :country_1_id
	belongs_to :country_2, class_name: Country, foreign_key: :country_2_id
	belongs_to :selected_country, class_name: Country, foreign_key: :selected_country_id

	validates :country_1_id, presence: true
	validates :country_2_id, presence: true
	validates :selected_country_id, presence: true
	validates :criterion_id, presence: true


	def get_rank_order
		if self.criterion.higher_good == true
			'highest to lowest'
		else
			'lowest to highest'
		end
	end

	def correct_country
		score_country_1 = self.criterion.scores.find_by(country_id: country_1_id)
		score_country_2 = self.criterion.scores.find_by(country_id: country_2_id)

		if score_country_1.rank < score_country_2.rank
			self.country_1_id
		else
			self.country_2_id
		end
	end

	def assign_correct_answer
		if self.selected_country_id == self.correct_country
			true
		else
			false
		end
	end

	def get_positive_field
		if self.correct == false
			if self.criterion.higher_good == true
				false
			else
				true
			end
		end
	end

	def get_prompt_word
		if self.criterion.higher_good == true
			'Highest'
		else
			'Lowest'
		end
	end

	def country_scores
		scores = [
			Score.get_country_score(self.country_1_id, self.criterion_id),
			Score.get_country_score(self.country_2_id, self.criterion_id)
			]

		return scores.sort! {|x, y| x.rank <=> y.rank }
	end

end
