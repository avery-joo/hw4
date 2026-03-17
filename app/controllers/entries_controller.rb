class EntriesController < ApplicationController

  def new
    if session["user_id"] == nil
      redirect_to "/login"
    end
  end

  def create
    @entry = Entry.new
    @entry["title"] = params["title"]
    @entry["description"] = params["description"]
    @entry["occurred_on"] = params["occurred_on"]
    @entry["place_id"] = params["place_id"]
    
    @entry["user_id"] = session["user_id"]

    @entry.uploaded_image.attach(params["uploaded_image"])
    
    @entry.save
    redirect_to "/places/#{@entry["place_id"]}"
  end

end
