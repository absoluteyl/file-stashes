class ApplicationController < ActionController::Base

  def render_not_found
    render 'shared/not_found', status: 404
  end
end
