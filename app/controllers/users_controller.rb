class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create]
	before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

	def show
		@user = User.find(params[:id])
		@secrets = @user.secrets
	end

	def new
	end

	def create
		# render text: 'ok'
		user = User.create(user_params)
		# render text: user.errors.full_messages
		# render json: user
		if user.valid?
			session[:id] = user.id
			redirect_to "/users/#{user.id}"
		else
			flash[:errors] = []
			flash[:errors].append("Invalid form fields")
			user.errors.full_messages.each do |error|
				flash[:errors].append(error)
			end
			redirect_to "/users/new"
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.update_attributes(update_params)
		# @user = User.find(params[:id])
		# render json: @user
		redirect_to "/users/#{@user.id}"
		# @user = User.find(params[:id])
	 #    if @user.update(user_params)
	 #      flash[:success] = "User successfully updated"
	 #      redirect_to @user
	 #    else
	 #      flash[:errors] = @user.errors.full_messages
	 #      redirect_to :back
	 #    end
	end

	def destroy
		User.find(params[:id]).destroy
		session[:id] = nil
		redirect_to '/sessions/new'
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	def update_params
		params.require(:user).permit(:email, :name)
	end
end
