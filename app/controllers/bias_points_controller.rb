class BiasPointsController < ApplicationController

	def index
		featured_countries = Country.where(select: true)
		@countries_by_bias = featured_countries.map{ |c| [c, (c.positive_bias.count - c.negative_bias.count)]}
		@countries_by_bias.sort!{ |x,y| y[1] <=> x[1] }
	end

end