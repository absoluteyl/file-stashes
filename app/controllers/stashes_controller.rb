class StashesController < ApplicationController
  before_action :get_stash, only: [:show, :share, :destroy]

  def index
    @stashes = Stash.all
  end

  def show
    render_not_found unless @stash
  end

  def share
    @stash.generate_uniq_token
    redirect_to stash_path(@stash.uuid)
  end

  def new
    @stash = Stash.new
  end

  def create
    @stash = Stash.create!(stash_params)
    redirect_to stash_path(@stash.uuid)
  end

  def destroy
    if @stash
      @stash.destroy
      redirect_to stashes_path
    else
      render_not_found
    end
  end

  private

  def get_stash
    key   = params[:token].present? ? 'token' : 'uuid'
    value = params[key]
    @stash = eval("Stash.find_by_#{key}('#{value}')")
  end

  def stash_params
    params.require(:stash).permit(:attachment)
  end
end
