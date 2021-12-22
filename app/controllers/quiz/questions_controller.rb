class Quiz::QuestionsController < ApplicationController
  layout "team_quiz"
  include ErrorHelper
  before_action :authenticate_user!, except: [:index, :show, :answer]
  before_action :authenticate_admin!, except: [:index, :show, :answer]


  # GET /team-quiz/questions
  # GET /team-quiz/questions.json
  # GET /team-quiz/questions.xml
  def index
    if current_user and current_user.admin?
      @questions = Quiz::Question.order(@order).paginate(@page)
    else
      @questions = Quiz::Question.visible.order(@order).paginate(@page)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questions.visible, only: [:id, :title], methods: [:possible_answers], callback: params[:callback] }
      format.xml { render xml: @questions.visible, only: [:id, :title], methods: [:possible_answers] }
    end
  end


  # GET /team-quiz/questions/1
  # GET /team-quiz/questions/1.json
  # GET /team-quiz/questions/1.xml
  def show
    if current_user and current_user.admin?
      @question = Quiz::Question.find(params[:id])
    else
      @question = Quiz::Question.visible.find(params[:id])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question, only: [:id, :title], methods: [:possible_answers], callback: params[:callback] }
      format.xml { render xml: @question, only: [:id, :title], methods: [:possible_answers] }
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
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /team-quiz/questions/1/answer
  # PUT /team-quiz/questions/1/answer.json
  def answer
    @user = Quiz::User.find(session['quiz_user_id'])
    @question = Quiz::Question.visible.find(params[:question_id])

    if params[:answer] == @question.correct_answer
      @user.update(points: @user.points + 1)
    end

    respond_to do |format|
      format.html { render action: "show", notice: 'Question was successfully updated.' }
      format.json { render json: @user }
    end
  end


  # DELETE /team-quiz/questions/1
  # DELETE /team-quiz/questions/1.json
  # DELETE /team-quiz/questions/1.xml
  def destroy
    @question = Quiz::Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to quiz_questions_path_url }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end


  private
    def question_params
      params.require(:quiz_question).permit(:title, :correct_answer, :answer_2, :answer_3, :answer_4, :visible)
    end

end
