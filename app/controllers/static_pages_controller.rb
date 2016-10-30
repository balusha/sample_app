class StaticPagesController < ApplicationController

  include SessionsHelper

  def home
    if signed_in?
      @micropost = current_user.microposts.build
      @feed = current_user.feed.paginate(page: params[:page])
    end
  end

  def help

  end

  def about
  end

  def contacts

  end

end
