class GridUsersController < ApplicationController

  def index
    @grid = GridUsersGrid.new(params[:grid_users_grid]) do |scope|
      scope.page(params[:page])
    end
  end

end

