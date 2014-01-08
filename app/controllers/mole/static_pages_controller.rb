class Mole::StaticPagesController < ApplicationController


  # GET /mole
  def index
    Project.hit 51
    @high_scores = Mole::HighScore.limit(3)

    respond_to do |format|
      format.html # index.html.erb
    end
  end


  # GET /mole/privacy
  def privacy

    respond_to do |format|
      format.html # privacy.html.erb
    end
  end


  # GET /mole/facebook
  def facebook
    Project.hit 51
    render layout: '../mole/static_pages/facebook'
  end

end