class Country < ActiveRecord::Base
	has_many :scores
	has_many :bias_points

	has_many :country_1_ids, class_name: Answer, foreign_key: :country_1_id
	has_many :country_2_ids, class_name: Answer, foreign_key: :country_2_id
	has_many :selected_countries, class_name: Answer, foreign_key: :selected_country_id

	def self.search(search)
		if search
			Country.where(name: "#{search}")
		else
			Country.all.order(:hdi_rank)
		end
	end

	def positive_bias
		self.bias_points.where(positive: true)
	end

	def negative_bias
		self.bias_points.where(positive: false)
	end

end
