class UsersController < ApplicationController

	def show
		@user = current_user
		@answers = @user.answers
	end

end