class Criterion < ActiveRecord::Base
  belongs_to :category
  has_many :answers
  has_many :scores

  def get_rank_order
		if criterion.higher_good == true
			'highest to lowest'
		else
			'lowest to highest'
		end
	end

	def get_valid_countries
		valid_scores = Score.where(criterion_id: self.id).where.not(score: nil).includes(:country)
		valid_countries = []

		valid_scores.each do |score|
			if score.country.select == true
				valid_countries << score.country
			end
		end

		return valid_countries
	end

	def all_scores
		return self.scores.includes(:country).sort!{|x, y| x.rank <=> y.rank }
	end

end
