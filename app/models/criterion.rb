class Criterion < ActiveRecord::Base
  belongs_to :category
  has_many :answers
  has_many :scores
end
