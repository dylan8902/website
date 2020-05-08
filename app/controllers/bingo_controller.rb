class BingoController < ApplicationController
  layout "bingo"


  # GET /bingo
  def index
  end

  # GET /bingo/call
  def call
    @game = BingoGame.new
  end

  # GET /bingo/ticket
  def ticket
    @ticket = BingoTicket.new
  end


end
