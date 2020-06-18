class MessagesController < ApplicationController
	def new
		@message = Message.new
	end

	def calculate(input)
		input.gsub!(/\s+/, '')
		input.sub!("x", "*")
		if (input.length < 0)
			return "You didn't enter anything."
		
		elsif (input.count("a-zA-Z") > 0)
			return "There is a character in the string. Please only enter numeric values."
		else
			input.sub!("*", "x")
			arr = input.split("")
			operators = ["+","-","x","/"]
			result = 0
			operator = ""
			temp = ""
			# check for single digit
			if (operators - arr).length == 4
				return "#{input} = #{input}"
			end
			for a in arr do 
			  if !operators.include?a
			    temp+=a
			  else
				if result == 0 and operator==""
					result = temp.to_i
				elsif 
					operator == ""
					result = temp.to_i

				else
					puts "#{temp} #{operator} #{result}"
					case operator
						when "x"
							result = result * temp.to_i
						when "/"
							result = result / temp.to_i
						when "+"
							result += temp.to_i
						when "-"
							result -= temp.to_i
						else
							return "Unknown operator"
					end
				end
				operator = a
			    temp=""
			  end
			end

			case operator
			  	when "+"
			    	result += temp.to_i
			  	when "-"
			    	result -= temp.to_i
			  	when "x"
					result = result * temp.to_i
			  	when "/"
					result = result / temp.to_i
			  	else
			    	return "Unknown operator"
			end
			return "#{input} = #{result}"
		end
	end

	def create
		@message = Message.new(msg_params)
		@message.content = calculate(@message.content)
		@sender = User.find(msg_params[:user_id])
		@room = Room.find(msg_params[:room_id])
		if @room.user_id == @message.user_id
			role = "Host of the room"
		else
			role ="Guest"
		end
		if @message.save
			# send both sender obj, host? and message obj to the channel
			ActionCable.server.broadcast('room_channel', message: @message, sender:@sender, role:role)
		end
	end

	private
	def msg_params
		params.require(:message).permit(:content,:user_id,:room_id)
	end
end
