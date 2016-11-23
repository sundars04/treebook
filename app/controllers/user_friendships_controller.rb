class UserFriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_friendships = friendship_association.all
  end

  def new
    if params[:friend_id]
      @friend =User.where(profile_name: params[:friend_id]).first      
      raise ActiveRecord::RecordNotFound if @friend.nil?
      @user_friendship = current_user.user_friendships.new(friend: @friend)
    else
      flash[:error] = "Friend required"
    end
  rescue ActiveRecord::RecordNotFound
    render file: 'public/404', status: :not_found
  end

  def create
    if params[:user_friendship] && params[:user_friendship].has_key?(:friend_id)
      @friend = User.where(profile_name: params[:user_friendship][:friend_id]).first
      @user_friendship = UserFriendship.request(current_user, @friend)
      if @user_friendship.new_record?
        flash[:error] = "There was a problem creating that friend request."
      else
        flash[:success] = "Friend request sent."
      end
      redirect_to profile_path(@friend)
    else
      flash[:error] = "Friend required"
      redirect_to root_path
    end    
  end

  
  def accept
    @user_friendship = current_user.user_friendships.find(params[:id])
    if @user_friendship.accept!
      flash[:success] = "You are now friends with #{@user_friendship.friend.first_name}"
    else
      flash[:error] = "That friendship could not be accepted."
    end
    redirect_to user_friendships_path
  end

  def block
    @user_friendship = current_user.user_friendships.find(params[:id])
    if @user_friendship.block!
      flash[:success] = "You have blocked #{@user_friendship.friend.first_name}"
    else
      flash[:error] = "That friendship could not be blocked"
    end
    redirect_to user_friendships_path
  end

  def edit
    @friend = User.where(profile_name: params[:id]).first
    @user_friendship = current_user.user_friendships.where(friend_id: @friend.id).first
  end

  def destroy
    @user_friendship = current_user.user_friendships.find(params[:id])
    if @user_friendship.destroy
      flash[:warning] = "Friendship destroyed"
    end
    redirect_to user_friendships_path    
  end

  private

    def friends_params
      # params.require(:user_friendship).permit(:user, :friend, :user_id, :friend_id, :state)
      params.require(:friendship).permit(:user, :friend, :user_id, :friend_id, :state)
    end

    def friendship_association
      case params[:list]
      when nil
        current_user.user_friendships.all
      when 'blocked'
        current_user.blocked_user_friendships.all
      when 'pending'
        current_user.pending_user_friendships.all
      when 'accepted'
        current_user.accepted_user_friendships.all
      when 'requested'
        current_user.requested_user_friendships.all
      end
    end
end
