class Criterion < ActiveRecord::Base
  belongs_to :category
  has_many :answers
  has_many :scores

  def get_rank_order(criterion)
		if criterion.higher_good == true
			'highest to lowest'
		else
			'lowest to highest'
		end
	end

end
