class BingoController < ApplicationController
  layout "bingo"


  # GET /bingo
  def index
    @number = BingoGame.last.current_number
  end


  # GET /bingo/ticket
  def ticket
    @ticket = BingoTicket.new

    respond_to do |format|
      format.html # ticket.html.erb
      format.json { render json: @ticket, callback: params[:callback] }
    end
  end


end
