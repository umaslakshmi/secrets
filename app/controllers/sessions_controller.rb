class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.where(email: params[:email]).first
		# render json: user
		if user && user.authenticate(params[:password])
			session[:id] = user.id
			redirect_to "/users/#{user.id}"
		else
			flash[:errors] = "Invalid email or password"
			# render text: session[:errors]
			redirect_to "/sessions/new"
		end
	end

	def destroy
		session[:id] = nil
		redirect_to '/sessions/new'
	end
end
