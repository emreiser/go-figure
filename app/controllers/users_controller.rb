class UsersController < ApplicationController

	def show
		@user = current_user
		@featured_countries = Country.where(select: true)
		@answers = @user.answers
		@positive_bias_points = @user.bias_points.where(positive: true)
		@negative_bias_points = @user.bias_points.where(positive: false)
	end

	def update
		@user = User.find(params[:id])
		@user.update!(user_params)
		redirect_to questions_path
	end

	def user_params
		params.require(:user).permit(:country_id)
	end

end