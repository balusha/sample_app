class RelationshipsController < ApplicationController

	include SessionsHelper

	before_action :signed_in_user

	def create
		@user = User.find(params[:relationship][:followed_id])
		current_user.follow! @user
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end

	def destroy
		@user = Relationship.find(params[:id]).followed
		current_user.unfollow! @user
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end

	private 

	def relation_params
      params.require(:relationship).permit(:followed_id)
	end

	def signed_in_user
     unless signed_in?
      store_location
      redirect_to signin_url, notice: 'Please sign in'
     end
  	end

end
