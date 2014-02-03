class Country < ActiveRecord::Base

	has_many :country_1_ids, class_name: Answer, foreign_key: :country_1_id
	has_many :country_2_ids, class_name: Answer, foreign_key: :country_2_id
	has_many :selected_countries, class_name: Answer, foreign_key: :selected_country_id

end
