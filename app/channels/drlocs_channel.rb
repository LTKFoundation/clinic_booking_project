# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class DrlocsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "drlocs"
    Rails.logger.info("subscribed to drlocs......")
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def pass_loc(data)
    # Rails.log("passing: #{data}")
    Rails.logger.info("data is: #{data.inspect}")
    ActionCable.server.broadcast("drlocs",data)
  end

  def request_uber(data)
    # Rails.log("passing: #{data}")
    Rails.logger.info("requesting doctor: #{data.inspect}")
    ActionCable.server.broadcast("drlocs",data)
  end

  def confirm_booking(data)
    Rails.logger.info("confirming booking: #{data.inspect}")
    ActionCable.server.broadcast("drlocs",data)
  end

  def raise_request_uber(data)
    Rails.logger.info("user raising request #{data.inspect}")
    ActionCable.server.broadcast("drlocs",data)
  end

  def take_request(data)
    Rails.logger.info("a doctor is taking a request #{data.inspect}")
    ActionCable.server.broadcast("drlocs",data)
  end

  def response_dr_confirm(data)
    Rails.logger.info("User responsed to doctor confirmation #{data.inspect}")
    ActionCable.server.broadcast("drlocs",data)
  end

end
