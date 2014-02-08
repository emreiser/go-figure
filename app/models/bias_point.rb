class BiasPoint < ActiveRecord::Base
  belongs_to :answer
  belongs_to :country
  belongs_to :user

  def set_positive_attribute(answer)
		if answer.criterion.higher_good == true
			self[:positive] = true
		else
			self[:positive] = false
		end
	end

end
