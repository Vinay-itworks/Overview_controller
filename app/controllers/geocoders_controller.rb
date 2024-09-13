class GeocodersController < ApplicationController
  def new
    Rails.logger.info "In rails logger"
    Rails.logger.debug "In rails logger"
    Rails.logger.error "In rails logger"

    puts "In new method"
  end

  def edit
    puts "In edit action"
  end

  def show
    puts "In show action"
  end
end