class Answer < ActiveRecord::Base
	has_many :bias_points
	belongs_to :criterion
	belongs_to :user

	belongs_to :country_1, class_name: Country, foreign_key: :country_1_id
	belongs_to :country_2, class_name: Country, foreign_key: :country_2_id
	belongs_to :selected_country, class_name: Country, foreign_key: :selected_country

	def set_comparison_country(highlighted_countries)
		if user_signed_in? && current_user.country_id.present?
			current_user.country
		else
			usa unless highlighted_countries.include? usa
		end
	end

end
