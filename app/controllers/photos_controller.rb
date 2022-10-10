class PhotosController < ApplicationController
  require "flickr"
  def index
    begin
      flickr = Flickr.new ENV["flickr_api_key"], ENV["flickr_secret"]

      unless params[:user_id].blank?
        @photos = flickr.photos.search(user_id: params[:user_id])
      else
        @photos = flickr.photos.getRecent
      end
    rescue StandardError => e
      flash[:alert] = "#{e.class}: #{e.message}. Please try again..."
      redirect_to root_path
    end
  end
end