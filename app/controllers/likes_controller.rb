class LikesController < ApplicationController
	before_action :require_login

	def create
		Like.create(user: current_user, secret: Secret.find(params[:secret_id]))
		redirect_to "/secrets"
	end

	def destroy
		Like.where(user: current_user, secret: Secret.find(params[:secret_id])).first.destroy
		redirect_to "/secrets"
	end
end
