class StaticPagesController < ApplicationController
  def home
    return unless logged_in?
    @micropost  = current_user.microposts.build
    @feed_items = current_user.feed.create_at_desc.page(params[:page])
                              .per Settings.feed_pagenate
  end

  def help; end

  def about; end

  def contact; end
end
