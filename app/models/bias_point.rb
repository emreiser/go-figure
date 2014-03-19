class BiasPoint < ActiveRecord::Base
  belongs_to :answer
  belongs_to :country
  belongs_to :user

  def self.add_bias_points(answer, current_user)

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
		if current_user
			first_country_point[:user_id] = current_user.id
			second_country_point[:user_id] = current_user.id
		end

		first_country_point.save!
		second_country_point.save!
	end

  def set_positive_attribute(answer)
		if answer.criterion.higher_good == true
			self[:positive] = true
		else
			self[:positive] = false
		end
	end

end
