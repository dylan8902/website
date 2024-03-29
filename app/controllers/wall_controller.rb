class WallController < ApplicationController


  # GET /wall
  def index 
    Project.hit 38
  end


  # POST /wall/highscores
  def submit_score 

    @wall_score = WallScore.new(wall_score_params)

    respond_to do |format|
      if @wall_score.save
        high_scores = WallScore.limit(10)
        format.html { redirect_to wall_high_scores_path, notice: "You scored #{@wall_score.score}" }
        format.json { render json: high_scores, status: :created }
        format.xml  { render xml: high_scores, status: :created }
      else
        format.html { render action: "index" }
        format.json { render json: high_scores, status: :unprocessable_entity }
        format.xml  { render xml: high_scores, status: :unprocessable_entity }
      end
    end

  end
  
  
  # GET /wall/highscores
  def high_scores
    @high_scores = WallScore.limit(10)

    respond_to do |format|
      format.html
      format.json { render json: @high_scores }
      format.xml  { render xml: @high_scores }
    end
  end


  private
    def wall_score_params
      params.permit(:name, :score, :facebook_id)
    end

end