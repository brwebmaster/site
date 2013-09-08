class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :require_login, :only=>[:destroy, :create, :new, :edit]
  include ApplicationHelper
  
  # show all users
  def index
    @users = []
    if params[:is_alumni] == '0'
      puts "not alumni"
      @users = User.where("is_alumni = false")
    elsif params[:is_alumni] == '1'
      @users = User.where("is_alumni = true")
    else
      @users = User.all
    end
    respond_to do |format|
      format.html
      format.json { render json: @users.to_json(:methods => [:avatar_url]) }
    end
  end

  # return an HTML form for creating a new user
  def new
  end

  # Hit this endpoint as soon as user logs in
  # If user is already in the database, redirect to team page,
  # otherwise go to edit page
  def login_check
    if not is_logged_in session
      # should never get in here
      redirect_to :action => :index
    end
    sunet = session[:user_hash]["username"]
    if User.find_by_sunet(sunet)
      redirect_to :action => :index
    else
      # create new user
      gn = session[:user_hash]["gn"] || ""
      sn = session[:user_hash]["sn"] || ""
      phone = session[:user_hash]["phone_number"] || ""
      major = session[:user_hash]["org"] || ""
      @user = User.new(:sunet => sunet, :first_name => gn.titlecase, :last_name => sn.titlecase, :bio => "I dance for Basmati Raas!", :is_alumni => false, :is_undergrad => true, :phone => phone, :major => major)
      @user.save
      flash[:notice] = "Welcome! We started filling out your profile. Please upload a picture and update your information."
      redirect_to "/users/#{@user.id}/edit"
    end
  end

  # POST: create a new user
  def create
    @user = User.new(params[:user])
    if @user.valid?
      @user.save
      flash[:notice] = "Successfully created new member!"
      redirect_to :action => :show, :id => @user.id
    else
      flash[:alert] = "There was an error in validating the new member"
      render :action => :new
    end
  end

  # Show member of specific id
  def show 
    @user = User.find_by_id(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @user.to_json(:methods => [:avatar_url]) }
    end
  end

  def sunet
    @user = User.find_by_sunet(params[:sunet])
    # do error checking here
    # TODO: ensure this is safe
    redirect_to "/users#/users/#{@user.id}"
  end

  # return an HTML form for editing a user
  def edit
    @user = User.find_by_id(params[:id])
    logged_in_user = session[:user_hash]["username"]
    if logged_in_user != @user.sunet and not 
      User.is_power_user(logged_in_user)
      # permission denied
      flash[:error] = "Your privileges don't allow you to edit  profiles other than your own."
      redirect_to "/users#/users/"
    end
    @photos = Photo.find_all_by_user_id(params[:id])
  end

  # PUT: update a specific user
  def update
    @user = User.find_by_id(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Updated member!"
    else
      flash[:alert] = "Unable to update member."
    end
    redirect_to "/users#/users/#{@user.id}"
  end

  # DELETE: delete a specific user
  def destroy
    User.destroy(params[:id])
    flash[:notice] = "Deleted member!"
    redirect_to :action => :index
  end

  # If user is logged in, returns them as json object
  # else returns null
  # TODO: (performance) don't need to return full user object
  def get_cur_user
    @user = nil
    if is_logged_in session
      @user = User.find_by_sunet(session[:user_hash]["username"])
    end
    render json: @user
  end

  def can_edit
    editable = false
    if is_logged_in session
      # if looking at own profile, you have permission
      # if you are admin, you have permission
      logged_in_user = session[:user_hash]["username"]
      if logged_in_user == params[:sunet] or 
        User.is_power_user(logged_in_user)
        editable = true
      end
    end
    render json: {"can_edit" => editable}
  end

  def raaster
    @users = User.where("is_alumni = false").order(sort_column + " " + sort_direction)
  end

  private
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "first_name"
  end
  
  # must be either asc or desc
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end
end