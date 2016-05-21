class IndexController < ApplicationController

  def index
    @albums = Album.by_users(current_user.friend_ids << current_user.id).latest

    @pins = @albums.reduce([]) {|n, album| album.pins + n}
                .sort_by!(&:updated_at).reverse!

    @tags = current_user.owned_tags.alphabetical
    @users = User.all
    @non_friends = UserDecorator.decorate_collection current_user.non_friends
  end

  def add_friendship
    @friendship_user = User.find(params[:friend_id])
    current_user.invite @friendship_user
    FriendshipNotifications.new_invitation(current_user, @friendship_user, request.base_url).deliver_now
    flash[:notice] = "An invite was sent to #{@friendship_user.first_name} #{@friendship_user.last_name}"
    redirect_to action: "index"
  end



end
