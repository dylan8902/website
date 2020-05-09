class BingoChannel < ApplicationCable::Channel
  def subscribed
     stream_from "bingo"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
