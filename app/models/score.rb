class Score < ActiveRecord::Base
  belongs_to :criterion
  belongs_to :country
end
