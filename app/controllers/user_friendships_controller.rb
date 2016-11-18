class UserFriendshipsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def new
    if params[:friend_id]
      @friend = User.where(profile_name: params[:friend_id]).first
      @user_friendship = current_user.user_friendships.new(friend: @friend)
      raise ActiveRecord::RecordNotFound if @friend.nil?
    else
      flash[:error] = "Friend required"
    end
  rescue ActiveRecord::RecordNotFound
    render file: 'public/404', status: :not_found
  end

  def create
    if params[:user_friendship] && params[:user_friendship].has_key?(:friend_id)
      @friend = User.where(profile_name: params[:user_friendship][:friend_id]).first
      @user_friendship = current_user.user_friendships.new(friend: @friend)
      @user_friendship.save
      flash[:success] = "You are now friends with #{@friend.full_name}"
      redirect_to profile_path(@friend)
    else
      flash[:error] = "Friend required"
      redirect_to root_path
    end
  end

  def friends_params
    params.require(:user_friendship).permit(:user, :friend, :user_id, :friend_id)
  end
end
