class Score < ActiveRecord::Base
  belongs_to :criterion
  belongs_to :country

  scope :valid_scores, -> { includes(:country).where.not(score: nil) }

  def self.get_country_score(country_id, criterion_id)
  	self.find_by(country_id: country_id, criterion_id: criterion_id)
  end

end
