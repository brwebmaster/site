class PerformancesController < ApplicationController
  before_filter :require_login, :only=>[:new, :create]


def index
	@performances = Performance
    .where("time > ?", Time.now)
    .order('time ASC')
	@years = {"2012-2013" => {"videoID" => "xDUMIMu7Ojg", "awards" => ["2nd Place - ATown Showdown"]}, 
			"2011-2012" => {"videoID" => "fA0PSrRdbPk", "awards" => ["1st Place - Raas Rodeo", "3rd Place - Garba with Attitude", "Invitation to Raas All-Stars"]}, 
			"2010-2011" => {"videoID" => "dJV0-jp77P0", "awards" => ["3rd Place - Garba with Attitude"]},
			"2009-2010" => {"videoID" => false, "awards" => ["1st Place - Garbafest", "3rd Place = Garba with Attitude", "Invitation to Raas All-Stars"], "photo" => "20092010.jpg"},
			"2008-2009" => {"videoID" => "4D4YxO7sumI", "awards" => ["3rd Place - Rangeelo Raas"]},
			"2007-2008" => {"videoID" => "C5lE62C_BCo", "awards" => ["1st Place - Garba with Attitude", "2nd Place - Rangeelo Raas", "Invitation to Best of the Best 4"]},
			"2006-2007" => {"videoID" => "IwT96UxCpJY", "awards" => ["1st Place - Rangeelo Raas", "2nd Place - Garden State Garba", "Hype Award - Rangeelo Raas"]},
			"2005-2006" => {"videoID" => "13MWKWX_Wsg", "awards" => ["1st Place - Garba with Attitude", "Invitation to Best of the Best 2"]},
			"2004-2005" => {"videoID" => "HxRG2yTNKuM", "awards" => ["1st Place - Garba with Attitude", "Invitation to Best of the Best 1"]},
			"2003-2004" => {"videoID" => false, "awards" => ["2nd Place - Garba with Attitude"], "photo" => "2003-2004.jpg"}
			}
	respond_to do |format|
    format.html
    format.json { render json: @performances }
  end 
end

def new

end

def create
	@performance = Performance.new(params[:performance])
    if @performance.valid?
      @performance.save
      respond_to do |format|
  			format.html
  			format.json{ render :json => @performance}
  		end
    else
    	render :status => 403, :layout => false
      # flash[:alert] = "There was an error in creating the new event"
      # render :action => :new
    end
  end
end


