class Quiz::QuestionsController < ApplicationController
  layout "team_quiz"
  include ErrorHelper
  before_action :authenticate_user!, except: [:show]
  before_action :authenticate_admin!, except: [:show]


  # GET /team-quiz/questions
  # GET /team-quiz/questions.json
  # GET /team-quiz/questions.xml
  def index
    @questions = Quiz::Question.order(@order).paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questions, callback: params[:callback] }
      format.xml { render xml: @questions }
      format.rss { render 'feed' }
    end
  end


  # GET /team-quiz/questions/all
  # GET /team-quiz/questions/all.json
  # GET /team-quiz/questions/all.xml
  def all
    @page[:per_page] = Quiz::Question.count
    @questions = Quiz::Question.order(@order).paginate(@page)

    respond_to do |format|
      format.html { render 'index.html.erb' }
      format.json { render json: @questions, callback: params[:callback] }
      format.xml { render xml: @questions }
      format.rss { render 'feed' }
    end
  end


  # GET /team-quiz/questions/1
  # GET /team-quiz/questions/1.json
  # GET /team-quiz/questions/1.xml
  def show
    @question = Quiz::Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question, callback: params[:callback] }
      format.xml { render xml: @question }
    end
  end


  # GET /team-quiz/questions/new
  # GET /team-quiz/questions/new.json
  # GET /team-quiz/questions/new.xml
  def new
    @question = Quiz::Question.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @question, callback: params[:callback] }
      format.xml { render xml: @question }
    end
  end


  # GET /team-quiz/questions/1/edit
  def edit
    @question = Quiz::Question.find(params[:id])
  end


  # POST /team-quiz/questions
  # POST /team-quiz/questions.json
  def create
    @question = Quiz::Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render json: @question, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /team-quiz/questions/1
  # PUT /team-quiz/questions/1.json
  def update
    @question = Quiz::Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /team-quiz/questions/1
  # DELETE /team-quiz/questions/1.json
  # DELETE /team-quiz/questions/1.xml
  def destroy
    @question = Quiz::Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to securty_vulnerabilities_url }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end


  private
    def question_params
      params.require(:quiz_question).permit(:title, :correct_answer, :answer_2, :answer_3, :answer_4)
    end

end
