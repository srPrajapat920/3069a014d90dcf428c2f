class Api::Robot::V1::OrdersController < ApplicationController

  def index

    respond_to :json ,{return: Simulater.new().execute(params[:commands])}


  end

end
