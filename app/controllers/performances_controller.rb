class PerformancesController < ApplicationController
  before_filter :require_login, :only=>[:new, :create]


def index
	@performances = Performance.all
end

def new

end

def create
	@performance = Performance.new(params[:performance])
    if @performance.valid?
      @performance.save
      flash[:notice] = "Your event has been added!"
      redirect_to :action => :index
    else
      flash[:alert] = "There was an error in creating the new event"
      render :action => :new
    end
  end
end


