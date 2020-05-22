class BingoGamesController < ApplicationController
  include ErrorHelper
  before_action :authenticate_user!
  before_action :authenticate_admin!
  layout "bingo"


  # GET /bingo/games
  # GET /bingo/games.json
  # GET /bingo/games.xml
  def index
    limit = params[:limit] || 10
    @page = { page: params[:page], per_page: limit.to_i }
    @order = params[:order] || "created_at DESC"

    @bingo_games = BingoGame.order(@order).paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bingo_games, callback: params[:callback] }
      format.xml { render xml: @bingo_games }
      format.rss { render 'feed' }
    end
  end


  # POST /bingo/games
  # POST /bingo/games.json
  def create
    @bingo_game = BingoGame.create(numbers: BingoNumber.all.shuffle.to_json, index: -1, current_number: nil)
    content = { 'id': '', 'instruction': 'Waiting to start'}
    ActionCable.server.broadcast 'bingo', content: content

    respond_to do |format|
      if @bingo_game.save
        format.html { redirect_to @bingo_game, notice: 'bingo game was successfully created.' }
        format.json { render json: @bingo_game, status: :created, location: @bingo_game }
      else
        format.html { render action: "index" }
        format.json { render json: @bingo_game.errors, status: :unprocessable_entity }
      end
    end
  end


  # GET /bingo/games/1
  # GET /bingo/games/1.json
  def show
    @bingo_game = BingoGame.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bingo_game, callback: params[:callback] }
      format.xml { render xml: @bingo_game }
      format.rss { render 'feed' }
    end
  end


  # POST /bingo/call
  # POST /bingo/call.json
  def call
    @game = BingoGame.last
    content = @game.next
    ActionCable.server.broadcast 'bingo', content: content

    respond_to do |format|
      format.json { render json: @game, callback: params[:callback] }
      format.html { render :call }
    end
  end


  # POST /bingo/command
  # POST /bingo/command.jsoon
  def command
    content = { id: params[:id], instruction: params[:instruction] }
    ActionCable.server.broadcast 'bingo', content: content

    respond_to do |format|
      format.json { render json: content, callback: params[:callback] }
      format.html { render :call }
    end
  end


end
