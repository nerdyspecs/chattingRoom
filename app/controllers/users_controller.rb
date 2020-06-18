class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user]=@user.id
			redirect_to :controller => 'rooms', :action => 'index'
		end
	end

	private
	def user_params
		params.require(:user).permit(:name)
	end
end
