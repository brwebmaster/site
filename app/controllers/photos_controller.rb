class PhotosController < ApplicationController
  before_filter :require_login, :only=>[:create, :destroy]
  #Get all photos for this user
  def index
    @user = User.find(params[:user_id])
    @photos = Photo.find_all_by_user_id(params[:user_id])
  end

  # return an HTML form for creating a new user
  def new
  end

  # POST: create a new photo associated with the user
  def create
    puts params
    @user = User.find_by_id(params[:user_id])
    @photo = Photo.new
    if params[:photo] then
      @photo.upload(params[:photo][:image])
      @photo.user = @user
      @photo.save
      flash[:notice] = "File uploaded!"
      redirect_to :controller => "users", :action => "edit", :id => @user.id
    else
      flash[:alert] = "Unable to upload that file. Try again."
      redirect_to :controller => "users", :action => "edit", :id => @user.id 
    end
  end

  # Show photo of specific id
  def show
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id])
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id])
  end

  # PUT: update a specific photo
  def update
    @user = User.find_by_id(params[:user_id])
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(params[:photo])
      flash[:notice] = "Updated photo!"
      redirect_to :action => :index
    else
      flash[:alert] = "Unable to update photo. Try again"
      redirect_to :action => :edit
    end
  end

end
