class Api::V1::MunchiesController < ApplicationController
  def index
    munchies = MunchiesFacade.expedition_to_munchies(params[:start], params[:destination], params[:food])
  end
end
