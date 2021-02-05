class FriendshipsController < ApplicationController
  # add new friend action
  def create
    friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save
      flash[:notice] = "Following user"
    else
      flash[:alert] = "There was something wrong with the request"
    end
    redirect_to my_friends_path
  end

  # unfriend action
  def destroy
    # find the corresponding friend object in the relation
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "Unfriend successfully"
    redirect_to my_friends_path
  end
end
