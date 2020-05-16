class BingoChannel < ApplicationCable::Channel
  def subscribed
     stream_from "bingo"
  end

  def receive(data)
    ActionCable.server.broadcast("bingo", data)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
