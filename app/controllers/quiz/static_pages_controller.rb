class Quiz::StaticPagesController < ApplicationController
  layout "team_quiz"


  # GET /team-quiz
  def index
    @user = Quiz::User.new

    respond_to do |format|
      format.html
    end
  end

  # GET /team-quiz/scores
  def scores

    respond_to do |format|
      format.html
    end
  end

end
