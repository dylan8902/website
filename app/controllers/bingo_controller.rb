class BingoController < ApplicationController
  layout "bingo"

  GAME = BingoGame.new

  # GET /bingo
  def index
    @number = GAME.current_number
  end

  # GET /bingo/call
  def call
    @numbers = GAME.numbers
    @number = GAME.current_number
  end

  # POST /bingo/call
  def next
    @numbers = GAME.numbers
    @number = GAME.next
    ActionCable.server.broadcast 'bingo', content: @number

    respond_to do |format|
      format.html { render :call }
      format.json { render json: @number, callback: params[:callback] }
      format.xml { render xml: @number }
      format.rss { render 'feed' }
    end
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


end
