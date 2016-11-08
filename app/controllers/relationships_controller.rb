class RelationshipsController < ApplicationController

	include SessionsHelper

	before_action :signed_in_user

	def create
		rel = Relationship.create(relation_params)
		rel.follower_id = current_user.id

		rel.save

		redirect_to user_path(rel.followed_id)
	end

	def destroy

		rel = Relationship.find(params[:id])
		unfollowed_id = rel.followed_id

		rel.destroy
		redirect_to user_path(unfollowed_id)

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
