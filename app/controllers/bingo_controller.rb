class BingoController < ApplicationController
  layout "bingo"

  # GET /bingo
  def index
    BingoGame.prepare if BingoGame.last.nil?
    @number = BingoGame.last.current_number
  end

  # GET /bingo/call
  def call
    @game = BingoGame.last
  end

  # POST /bingo/start
  def start
    @game = BingoGame.prepare
    ActionCable.server.broadcast 'bingo', content: { 'number': '', 'instruction': 'Waiting to start'}

    respond_to do |format|
      format.html { render :call }
    end
  end

  # POST /bingo/call
  def next
    @game = BingoGame.last
    ActionCable.server.broadcast 'bingo', content: @game.next

    respond_to do |format|
      format.html { render :call }
    end
  end

  # POST /bingo/command
  def command
    content = { number: params[:number], instruction: params[:instruction] }
    ActionCable.server.broadcast 'bingo', content: content
  end

  # GET /bingo/ticket
  def ticket
    @ticket = BingoTicket.new

    respond_to do |format|
      format.html # ticket.html.erb
      format.json { render json: @ticket, callback: params[:callback] }
      format.xml { render xml: @ticket }
      format.rss { render 'feed' }
    end
  end

  private
  def create_new_game

  end


end
