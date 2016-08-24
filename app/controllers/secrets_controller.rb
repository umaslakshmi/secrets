class SecretsController < ApplicationController
	before_action :require_login, only: [:show, :create, :destroy]

	def show
		@secrets = Secret.all
	end

	def create
		secret = User.find(session[:id]).secrets.create(secret_params)
		if not secret.valid?
			flash[:errors] = secret.errors.full_messages
		end
		redirect_to "/users/#{session[:id]}"
	end

	def destroy
		secret = Secret.find(params[:secret_id])
		secret.destroy if secret.user == current_user
		redirect_to "/users/#{current_user.id}"
		# Secret.find(params[:secret_id]).destroy
		# redirect_to "/users/#{session[:id]}"
	end

	private
	def secret_params
		params.require(:secret).permit(:content)
	end
end
