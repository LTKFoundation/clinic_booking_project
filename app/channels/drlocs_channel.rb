# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class DrlocsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "drlocs"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def pass_loc(data)
    # Rails.log("passing: #{data}")
    Rails.logger.info("data is: #{data.inspect}")
    ActionCable.server.broadcast("drlocs",data)
  end
end
