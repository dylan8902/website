class Mole::HighScoresController < ApplicationController
  skip_before_filter :verify_authenticity_token


  # GET /mole/high-scores
  # GET /mole/high-scores.json
  # GET /mole/high-scores.xml
  def index
    @page[:per_page] = 20
    @high_scores = Mole::HighScore.order("score DESC").paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @high_scores, callback: params[:callback] }
      format.xml { render xml: @high_scores }
    end
  end


  # GET /mole/high-scores/all
  # GET /mole/high-scores/all.json
  # GET /mole/high-scores/all.xml
  def all

    @page[:per_page] = Mole::HighScore.count
    @high_scores = Mole::HighScore.order("score DESC").paginate(@page)

    respond_to do |format|
      format.html { render 'index.html.erb' }
      format.json { render json: @high_scores, callback: params[:callback] }
      format.xml { render xml: @high_scores }
    end
  end


  # POST /mole/high-scores
  # POST /mole/high-scores.json
  def create
    @page[:limit] = 20
    @high_score = Mole::HighScore.new(high_score_params)

    respond_to do |format|
      if @high_score.save
        @high_scores = Mole::HighScore.order("score DESC").paginate(@page)
        format.html { redirect_to mole_high_scores_path, notice: 'High Score was successfully added.' }
        format.json { render json: @high_scores, status: :created }
      else
        @high_scores = Mole::HighScore.order("score DESC").paginate(@page)
        format.html { redirect_to mole_high_scores_path }
        format.json { render json: @high_scores, status: :unprocessable_entity }
      end
    end
  end


  private
    def high_score_params
      params.permit(:name, :facebook_id, :score)
    end

end
