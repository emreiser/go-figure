class Answer < ActiveRecord::Base
	has_many :bias_points
	belongs_to :criterion
	belongs_to :user

	belongs_to :country_1, class_name: Country, foreign_key: :country_1_id
	belongs_to :country_2, class_name: Country, foreign_key: :country_2_id
	belongs_to :selected_country, class_name: Country, foreign_key: :selected_country

end
