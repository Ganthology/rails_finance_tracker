class FriendshipsController < ApplicationController
  def create
  end

  def destroy
    # find the corresponding friend object in the relation
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "Unfriend successfully"
    redirect_to my_friends_path
  end
end
