class Score < ActiveRecord::Base
  belongs_to :criterion
  belongs_to :country

  scope :valid_scores, -> { includes(:country).where.not(score: nil) }
end
