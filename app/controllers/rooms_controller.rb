class RoomsController < ApplicationController
	def index
		if session[:user].nil?
			redirect_to new_user_path
		else
			@rooms = Room.all
			@room = Room.new
			@user = User.new
		end
	end

	def show
		@room = Room.find(params[:id])
		@messages = Message.where(:room_id => params[:id])
		@message = Message.new
	end

	def new
		@room = Room.new
	end

	def create
		@room = Room.new(room_params)
		if @room.save
			redirect_to :controller => 'rooms', :action => 'show', :id=>@room.id
		end
	end

	private
	def room_params
		params.require(:room).permit(:name,:user_id)
	end
end
