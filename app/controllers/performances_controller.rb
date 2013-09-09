class PerformancesController < ApplicationController
  before_filter :require_login, :only=>[:new, :create]

  def index
  	@performances = Performance
      .where("time > ?", Time.now)
      .order('time ASC')
  	@years = {"2012-2013" => {"videoID" => "xDUMIMu7Ojg", "awards" => ["2nd Place - ATown Showdown"]}, 
  			"2011-2012" => {"videoID" => "fA0PSrRdbPk", "awards" => ["1st Place - Raas Rodeo", "3rd Place - Garba with Attitude", "Invitation to Raas All-Stars"]}, 
  			"2010-2011" => {"videoID" => "dJV0-jp77P0", "awards" => ["3rd Place - Garba with Attitude"]},
  			"2009-2010" => {"videoID" => false, "awards" => ["1st Place - Garbafest", "3rd Place - Garba with Attitude", "Invitation to Raas All-Stars"], "photo" => "20092010.jpg"},
  			"2008-2009" => {"videoID" => "4D4YxO7sumI", "awards" => ["3rd Place - Rangeelo Raas"]},
  			"2007-2008" => {"videoID" => false, "awards" => ["1st Place - Garba with Attitude", "2nd Place - Rangeelo Raas", "Invitation to Best of the Best 4"],"videos" => ["http://youtube.com/watch?v=C5lE62C_BCo"], "photo" => "2007-2008.jpg"},
  			"2006-2007" => {"videoID" => false, "awards" => ["1st Place - Rangeelo Raas", "2nd Place - Garden State Garba", "Hype Award - Rangeelo Raas"], "videos" => ["http://youtube.com/watch?v=IwT96UxCpJY"], "photo" => "2006-2007.jpg"},
  			"2005-2006" => {"videoID" => false, "awards" => ["1st Place - Garba with Attitude", "Invitation to Best of the Best 2"], "videos" => ["http://youtube.com/watch?v=13MWKWX_Wsg"], "photo" => "2005-2006.jpg"},
  			"2004-2005" => {"videoID" => false, "awards" => ["1st Place - Garba with Attitude", "Invitation to Best of the Best 1"], "videos" => ["http://youtube.com/watch?v=HxRG2yTNKuM"], "photo" => "2004-2005.jpg"},
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

  def update
    @performance = Performance.find_by_id(params[:id])
    if @performance.update_attributes(params[:performance])
      respond_to do |format|
        format.json{ render :json => @performance }
      end
    end
  end

  def destroy
    Performance.destroy(params[:id])
    render nothing: true
  end

end





