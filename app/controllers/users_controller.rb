class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def search
    # if user input exists
    if params[:friend].present? 
      @friends = User.search(params[:friend])
      # excluse current_user from the list retrieved
      @friends = current_user.except_current_user(@friends)
      # if users are found
      if @friends
        respond_to do |format|
          format.js { render partial: 'users/friend_result' }
        end
      # if couldn't find users
      else
        respond_to do |format|
          flash.now[:alert] = "The user does not exist"
          format.js {render partial: 'users/friend_result'}
        end
      end
    # if user input does not exist
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a name or email to search"
        format.js {render partial: 'users/friend_result'}
      end
    end
  end
end
